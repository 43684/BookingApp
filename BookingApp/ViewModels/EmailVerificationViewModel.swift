//
//  EmailVerificationViewModel.swift
//  BookingApp
//
//  Created by Jörgen Hård on 2024-05-21.
//

import Foundation
import Firebase

class EmailVerificationViewModel: ObservableObject {
    
    private var timerForVerification: Timer?
    @Published var isMailVerified = false

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
    
    func logInUser( _ email: String, _ password: String, completion: @escaping (Bool) -> Void) {
       let auth =  Auth.auth()
            auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("User login failed: \(error.localizedDescription)")
                completion(false)
                return
            }
                completion(true)
            print("User logged in: \(String(describing: authResult?.user.email))")

        }
    }
    
    func isEmailVerified() {
        guard let user = Auth.auth().currentUser else { return }
        user.reload { [self] (error) in
            if let error = error {
                print("Could not reload user \(error.localizedDescription)")
                return
            }
            self.isMailVerified = user.isEmailVerified
            
        }
 
    }
    
    func startVerificationTimer() {
        timerForVerification = Timer.scheduledTimer(withTimeInterval: 7.0, repeats: true) { _ in
            self.isEmailVerified()
        }
    }

    func stopVerificationTimer() {
        timerForVerification?.invalidate()
        timerForVerification = nil
        print("STOPPING TIMER")
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
