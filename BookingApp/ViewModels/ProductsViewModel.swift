//
//  ProductsViewModel.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-12.
//

import Foundation
import Combine
import SwiftUI

class ProductsViewModel: ObservableObject {
    
    @Published var products = [Product]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Task{try await fetchProducts()}
    }
    
    @MainActor
    func fetchProducts() async throws  {
        let fetchedProducts = try await ProductService.fetchProducts()
        
        products = []
        products.append(contentsOf: fetchedProducts)
    }
    
    func saveSelectedProduct(_ selectedProduct: Product?){
        if let selectedProduct = selectedProduct {
            UserDefaults.standard.set(selectedProduct.name, forKey: "selectedProductName")
            UserDefaults.standard.set(selectedProduct.price, forKey: "selectedProductPrice")
            print(UserDefaults.standard.dictionaryRepresentation())
        }
        
    }

}


