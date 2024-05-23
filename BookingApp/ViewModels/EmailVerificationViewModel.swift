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
    
    init() {
        self.startVerificationTimer()
        
    }
    
    deinit {
        self.stopVerificationTimer()
        
    }

    func createTemporaryUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let user = authResult?.user {
                self.sendEmailVerification(user: user)
            }
            if let error = error {
                print("Could not create user \(error.localizedDescription)")
                return
            }
        }
    }
    
    func sendEmailVerification(user: User) {
        user.sendEmailVerification { error in
            if let error = error {
                print("Could not send verification-mail \(error.localizedDescription)")
                return
            }
        }
    }
    
    func logInUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
       let auth =  Auth.auth()
            auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Could not log in user: \(error.localizedDescription)")
                completion(false)
                return
            }
                completion(true)
            print("Succeeded to log in user: \(String(describing: authResult?.user.email))")

        }
    }
    
    func verificationCheck() {
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
            self.verificationCheck()
        }
    }

    func stopVerificationTimer() {
        timerForVerification?.invalidate()
        timerForVerification = nil
        print("Timer stopped")
    }
    
    func deleteUser() {
        guard let user = Auth.auth().currentUser else {return}
        
        user.delete() { error in
            if let error = error {
                print("Error when trying to delete user: \(error.localizedDescription)")
            } else {
                print("User deleted successfully.")
            }
        }
    }
}
