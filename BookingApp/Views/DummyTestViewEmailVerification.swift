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
    @State private var nextView: Bool = false
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .frame(width: 250, height: 40)
                .border(.gray, width: 1)
                .padding()
            

            TextField("Email", text: $email)
                .frame(width: 250, height: 40)
                .border(.gray, width: 1)
                .padding()

            Button(action: {
                nextView = true
            }) {
                Text("Go to verification")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
           
        }
    }
}

#Preview {
    DummyTestViewEmailVerification()
}
