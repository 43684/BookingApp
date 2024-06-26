//
//  ProductService.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-12.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

class ProductService {
    
    static let shared = ProductService()
    
    static func fetchProducts() async throws -> [Product] {
        let snapshot = try await Firestore.firestore().collection("products").getDocuments()
        let services = snapshot.documents.compactMap({try? $0.data(as: Product.self)})
        return services
    }
    
    func uploadImage(imageData: Data, completion: @escaping (Result<String, Error>) -> Void) {
        let storageRef = Storage.storage().reference().child("product_images/\(UUID().uuidString).jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                print("Error uploading image: \(error)")
                completion(.failure(error))
            } else {
                storageRef.downloadURL { (url, error) in
                    if let error = error {
                        print("Error getting download URL: \(error)")
                        completion(.failure(error))
                    } else if let url = url {
                        print("Successfully uploaded image. Download URL: \(url.absoluteString)")
                        completion(.success(url.absoluteString))
                    }
                }
            }
        }
    }
    
    func createNewProduct(product: Product, imageData: Data) {
        uploadImage(imageData: imageData) { result in
            switch result {
            case .success(let imageUrl):
                var productWithImage = product
                productWithImage.imageUrl = imageUrl
                let reference = Firestore.firestore().collection("products").document()
                do {
                    let productData = try Firestore.Encoder().encode(productWithImage)
                    reference.setData(productData) { error in
                        if let error = error {
                            print("Error adding product to Firestore: \(error)")
                        } else {
                            print("Successfully added product to Firestore")
                        }
                    }
                } catch {
                    print("Error encoding product: \(error)")
                }
            case .failure(let error):
                print("Error uploading image: \(error)")
            }
        }
    }
    
    func deleteImage(imageUrl: String, completion: @escaping (Result<Void, Error>) -> Void) {
            let storageRef = Storage.storage().reference(forURL: imageUrl)
            storageRef.delete { error in
                if let error = error {
                    print("Error deleting image: \(error)")
                    completion(.failure(error))
                } else {
                    print("Successfully deleted image.")
                    completion(.success(()))
                }
            }
        }
    
    func deleteProduct(product: Product) {
            // Check if the product has an image URL
            if let imageUrl = product.imageUrl {
                // Delete the image from Firebase Storage first
                deleteImage(imageUrl: imageUrl) { result in
                    switch result {
                    case .success:
                        // Then delete the product from Firestore
                        Firestore.firestore().collection("products").document(product.id).delete() { error in
                            if let error = error {
                                print("Error deleting product: \(error)")
                            } else {
                                print("Successfully deleted product")
                            }
                        }
                    case .failure(let error):
                        print("Error deleting image before deleting product: \(error)")
                    }
                }
            } else {
                // If there's no image, just delete the product
                Firestore.firestore().collection("products").document(product.id).delete() { error in
                    if let error = error {
                        print("Error deleting product: \(error)")
                    } else {
                        print("Successfully deleted product")
                    }
                }
            }
        }
}
