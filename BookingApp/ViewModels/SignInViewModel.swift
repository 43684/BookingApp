//
//  SignInViewModel.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-10.
//


import SwiftUI
import Firebase
import Combine

class SignInViewModel: ObservableObject {
    
    @Published var signInViewVisible = true
    
    
    @Published var username = "admin@bjaerkstudio.com"
    @Published var email = "admin@bjaerkstudio.com"
    @Published var password = "123456"
    @Published var cPassword = "123456"
    
    
    
    func signInUser() async throws {
        try await AuthService.shared.signInAdmin(withEmail: email, password: password)
    }
    
    
    
}


