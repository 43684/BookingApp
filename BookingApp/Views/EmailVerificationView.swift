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
    
    @ObservedObject var viewModel = EmailVerificationViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Icon")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                
                Spacer()
                
                Text("Dear Customer,\nYour appointment has been successfully confirmed. Please check your inbox and verify your email-address to proceed.")
                    .foregroundColor(Color(hex: "#D3BD9C"))
                    .font(.title2)
                    .bold()
                    .padding(40)
                
                Spacer()
                
                Text(statusText ?? "Email is not verified...")
                    .foregroundStyle(viewModel.isMailVerified ? .green : .red)
                    .font(.title2)
                
                Spacer()
                
                Button(action: {
                    if viewModel.isMailVerified {
                        viewModel.deleteUser()
                        nextView = true
                    }
                }) {
                    Text("FINALIZE BOOKING")
                        .padding()
                        .font(.title3)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(hex: "#D3BD9C"), Color(hex: "#6D6355")]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(Color(hex: "#131D54"))
                        .cornerRadius(15)
                        .bold()
                }
                .padding()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .navigationDestination(isPresented: $nextView, destination: {
                BookingCompleteView()
            })
        }
        
        .onAppear {
            viewModel.startVerificationTimer()
        }
        .onChange(of: viewModel.isMailVerified) {
            if viewModel.isMailVerified == true {
                viewModel.stopVerificationTimer()
                statusText = "Verification OK!\nClick to finilize booking!"
            }
        }
        .onDisappear {
            viewModel.stopVerificationTimer()
        }
    }
    
}

#Preview {
    EmailVerificationView()
}
