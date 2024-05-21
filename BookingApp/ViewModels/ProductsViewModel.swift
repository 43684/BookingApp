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
        fetchProducts()
    }
    
    func fetchProducts() {
        ProductService.shared.fetchProducts { [weak self] result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self?.products = products
                }
            case .failure(let error):
                print("Error fetching products: \(error)")
            }
        }
    }
}


