//
//  DummyVerificationCompleteView.swift
//  BookingApp
//
//  Created by Jörgen Hård on 2024-05-21.
//

import SwiftUI

struct DummyVerificationCompleteView: View {
  @Binding var isSheetVisible: Bool
    
  @ObservedObject var viewModel = EmailVerificationViewModel()

    var body: some View {
        
        VStack {
            Text("Complete Verification.\nCheck email to verify, then click proceed")
                .padding()

            Button(action: {
                if viewModel.isEmailVerified() {
                    isSheetVisible = false
                }
               
            }) {
                Text("Proceed")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(50)
            
        }
    }
}


