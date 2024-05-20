//
//  AdminService.swift
//  MessageApp
//
//  Created by Gentjan Manuka on 2024-04-22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class AdminService {
    
    static let shared = AdminService()
    
    @Published var isAdminLoggedIn: Bool = false
    
    @MainActor
    func checkAdmin() async throws{
        guard Auth.auth().currentUser != nil else {return}
        self.isAdminLoggedIn = true
    }
}
