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
}


