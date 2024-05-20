//
//  ProductsViewModel.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-12.
//

import Foundation
import Combine

class ProductsViewModel: ObservableObject {
    
    @Published var products = [Product]()
    @Published var isAdminLoggedIn = false
    
    let service: ProductService
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.service = ProductService()
      //  Task{try await service.fetchProducts()}
        setupSubscibers()
    }
    
    private func setupSubscibers(){
        AuthService.shared.$isAdminLoggedIn.sink { [weak self] adminSessionFromAuthService in
            self?.isAdminLoggedIn = adminSessionFromAuthService
        }.store(in: &cancellables)
    }
    
    
}
