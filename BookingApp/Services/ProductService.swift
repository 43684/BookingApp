//
//  ProductService.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-12.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ProductService {
    
    static let shared = ProductService()
    
    static func fetchProducts() async throws -> [Product] {
        let snapshot = try await Firestore.firestore().collection("products").getDocuments()
        let products = snapshot.documents.compactMap({try? $0.data(as: Product.self)})        
        return products
    }
    
    func createNewProduct(product:Product){
        let reference = Firestore.firestore().collection("products").document()
        guard let appointmentData = try? Firestore.Encoder().encode(product) else {return}
        reference.setData(appointmentData)
    }
    
    func deleteProduct(product:Product){
        Firestore.firestore().collection("products").document(product.id).delete()
    }
}
