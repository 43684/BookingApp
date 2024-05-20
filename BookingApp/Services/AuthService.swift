//
//  AuthService.swift
//  MessengerApp
//
//  Created by Gentjan Manuka on 2024-04-22.
//


import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthService {
    
    static let shared = AuthService()
    
    @Published var isAdminLoggedIn: Bool
    
    init(){
        self.isAdminLoggedIn = Auth.auth().currentUser != nil
        
        loadCurrentUserData()
        
    }
    
    
    @MainActor
    func signInAdmin(withEmail email: String, password: String) async throws {
        
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            self.isAdminLoggedIn = true
            loadCurrentUserData()
        } catch {
            print("Failed to sign in user \(String(describing: error)) ")
        }
        
    }
    
    private func loadCurrentUserData(){
        Task{try await AdminService.shared.checkAdmin()}
    }
    
    func signOut() {
        do{
            try Auth.auth().signOut()
            self.isAdminLoggedIn = false
            AdminService.shared.isAdminLoggedIn = false
        } catch {
            print("failed to sign out user (\(error.localizedDescription)")
        }
    }
    
}

 
