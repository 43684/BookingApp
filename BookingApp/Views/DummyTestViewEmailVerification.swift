//
//  DummyTestViewEmailVerification.swift
//  BookingApp
//
//  Created by Jörgen Hård on 2024-05-21.
//

import SwiftUI
import FirebaseAuth

struct DummyTestViewEmailVerification: View {
    @State private var statusText: String?
    @State private var email: String = ""
    @State private var password: String = "temporary1234"
  
    @ObservedObject var viewModel = EmailVerificationViewModel()
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .frame(width: 250, height: 40)
                .border(.gray, width: 1)
                .padding()

            Button(action: {
                viewModel.createTemporaryUser(email: email, password: password)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    viewModel.logInUser(email, password) { loggedIn in
                        if loggedIn {
                            statusText = "CHECK MAIL FOR VERIFICATION"
                            print("User logged in")
                        } else {
                            print("User login failed")
                        }
                    }
                }

            }) {
                Text("Go to verification")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            Text(statusText ?? "Status...")
                .foregroundStyle(.blue)
            
            if viewModel.isMailVerified {
                Text("Email is verified!")
                    .foregroundStyle(.green)
                
            }
        }
        .onAppear {
            viewModel.startVerificationTimer()
            
        }
        .onChange(of: viewModel.isMailVerified) {
            if viewModel.isMailVerified == true {
                viewModel.stopVerificationTimer()
                viewModel.deleteUser()
            }
        }
        .onDisappear {
            viewModel.stopVerificationTimer()
        }
    }
}

#Preview {
    DummyTestViewEmailVerification()
}
