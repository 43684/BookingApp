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
    
    func createTemporaryUser() {
        Auth.auth().createUser(withEmail: mail!, password: pass) { authResult, error in
            if let error = error {
                print("Could not create user \(error)")
                return
            }
        }
        
    }
    
    func sendEmailVerification() {
        Auth.auth().currentUser?.sendEmailVerification { error in
            if let error = error {
                print("Could not send verification-mail \(error)")
                return
            }
        }
    }
}
