//
//  EmailVerificationViewModel.swift
//  BookingApp
//
//  Created by Jörgen Hård on 2024-05-21.
//

import Foundation
import Firebase

class EmailVerificationViewModel: ObservableObject {
    
    @Published var name: String?
    @Published var mail: String?
    @Published var pass: String = "pass"
    
    func createTemporaryUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let user = authResult?.user {
                self.sendEmailVerification(user: user)
            }
            if let error = error {
                print("Could not create user \(error)")
                return
            }
        }
    }
    
    func sendEmailVerification(user: User) {
        user.sendEmailVerification { error in
            if let error = error {
                print("Could not send verification-mail \(error)")
                return
            }
        }
    }
    
    func deleteUser() {
        guard let user = Auth.auth().currentUser else {return}
        user.delete() { error in
            if let error = error {
                print("Error when trying to delete user: \(error.localizedDescription)")
            } else {
                print("User deleted.")
            }
        }
    }
}
