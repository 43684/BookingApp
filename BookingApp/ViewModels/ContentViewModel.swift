//
//  ContentViewModel.swift
//  MessengerApp
//
//  Created by Christofer Karlsson on 2024-04-18.
//

import Foundation
import Firebase
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var isAdminLoggedIn: Bool = false
    @Published var showLogginPage: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        setupSubscibers()
    }
    
    private func setupSubscibers(){
        AuthService.shared.$isAdminLoggedIn.sink { [weak self] adminSessionFromAuthService in
            self?.isAdminLoggedIn = adminSessionFromAuthService
        }.store(in: &cancellables)
    }
}

