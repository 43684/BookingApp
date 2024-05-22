//
//  DummyTestViewEmailVerification.swift
//  BookingApp
//
//  Created by Jörgen Hård on 2024-05-21.
//

import SwiftUI

struct DummyTestViewEmailVerification: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = "temporary"
    @State private var showSheet: Bool = false
    
    @ObservedObject var viewModel = EmailVerificationViewModel()
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .frame(width: 250, height: 40)
                .border(.gray, width: 1)
                .padding()

            Button(action: {
                viewModel.createTemporaryUser(email: email, password: password)
                showSheet = true
            }) {
                Text("Go to verification")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .sheet(isPresented: $showSheet) {
                DummyVerificationCompleteView(isSheetVisible: $showSheet, email: $email, password: $password)
            }
        }
    }
}

#Preview {
    DummyTestViewEmailVerification()
}
