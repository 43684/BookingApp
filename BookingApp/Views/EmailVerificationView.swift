//
//  DummyTestViewEmailVerification.swift
//  BookingApp
//
//  Created by Jörgen Hård on 2024-05-21.
//

import SwiftUI
import FirebaseAuth

struct EmailVerificationView: View {
    @State private var statusText: String?
    @State var nextView: Bool = false
    //    @State private var email: String = ""
    //    @State private var password: String = "temporary1234"
    
    @ObservedObject var viewModel = EmailVerificationViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                Button(action: {
                    if viewModel.isMailVerified {
                        nextView = true
                    }
                }) {
                    Text("Finalize Booking")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .navigationDestination(isPresented: $nextView, destination: {
                    BookingCompleteView()
                })
                
                .padding()
                
                Text(statusText ?? "Waiting for verification...")
                    .foregroundStyle(viewModel.isMailVerified ? .green : .red)
                    .font(.title2)
                
            }
        }
        
        .onAppear {
            viewModel.startVerificationTimer()
        }
        .onChange(of: viewModel.isMailVerified) {
            if viewModel.isMailVerified == true {
                viewModel.stopVerificationTimer()
                viewModel.deleteUser()
                statusText = "Verification OK!\nClick to finilize booking!"
            }
        }
    }
    
}

#Preview {
    EmailVerificationView()
}
