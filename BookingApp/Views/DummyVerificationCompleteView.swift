//
//  DummyVerificationCompleteView.swift
//  BookingApp
//
//  Created by Jörgen Hård on 2024-05-21.
//

import SwiftUI

struct DummyVerificationCompleteView: View {
  @Binding var isSheetVisible: Bool
  @Binding var email: String
  @Binding var password: String
    
  @ObservedObject var viewModel = EmailVerificationViewModel()

    var body: some View {
        
        VStack {
            Text("Complete Verification.\nCheck email to verify, then click proceed")
                .padding()
                

            Button(action: {
                viewModel.isEmailVerified(email, password) { verified in
                    if verified {
                        print("Verified")
                        isSheetVisible = false
                        viewModel.deleteUser()
                    } else {
                        print("Not verified")
                    }
                }
             
               
            }) {
                Text("Proceed")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(50)
            
        }  .onAppear {
  
        }
    }
}

func isVerified(verified: Bool) -> Bool {
    if verified {
        return true
    } else {
        return false
    }
}


