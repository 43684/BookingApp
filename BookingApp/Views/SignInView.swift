//
//  SignInView.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-5.
//


import SwiftUI

struct SignInView: View {
    
    @ObservedObject var signInViewModel = SignInViewModel()
    @Environment(\.dismiss ) var dismiss
    var body: some View {
        
        NavigationStack{
            ScrollView{
                Spacer(minLength: 250)
                VStack(){
                    Group{
                        TextField("Email", text: $signInViewModel.email)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                        SecureField("Password", text: $signInViewModel.password)
                            .textContentType(.oneTimeCode)
                            .autocorrectionDisabled()
                    }
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white)
                    }
                }
                
                Button {
                    Task {try await signInViewModel.signInUser()}
                    dismiss()
                } label: {
                    
                    Text("Sign in as Admin")
                        .padding(.horizontal,30)
                        .padding(.vertical,10)
                        .foregroundColor(.black)
                        .background(.yellow)
                        .cornerRadius(20)
                        .padding()
                }
            }
            .padding()
            .lineSpacing(30)
            .background{
                ZStack(alignment:.top){
                    Color.black.edgesIgnoringSafeArea(.all)
                    Image("Icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(50)
                }
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.yellow)
                    
                }
            }
        }
    }
}

 
