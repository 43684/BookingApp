//
//  PopupEmailView.swift
//  BookingApp
//
//  Created by Dennis.Nilsson on 2024-05-23.
//
import SwiftUI

struct EmailPopupView: View {
    @Binding var showPopup: Bool
    @EnvironmentObject var viewmodel: PopUpEmailViewModel
    
    @State var subject: String = ""
    @State var message: String = ""
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            VStack{
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Subject")
                            .font(.headline)
                            
                        TextField("", text: $subject)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Message")
                            .font(.headline)
                            
                        TextEditor(text: $message)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .frame(height: 200)
                    }
                    
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .shadow(radius: 5)
                
                    
                
                Button(action:{
                    viewmodel.emailModel = Email(subject: subject, message: message)
                    viewmodel.sendEmail()
                    showPopup = false
                    
                }){
                    HStack {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.black)
                        Text("Send")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    
                }
                    .padding()
                    .font(.title3)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(hex: "#D3BD9C"), Color(hex: "#6D6355")]), startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(Color(hex: "#131D54"))
                    .cornerRadius(15)
                    .bold()
                
            }
            .padding()
            .frame(width: 300)
            .background(Color.white.opacity(0.9))
            .cornerRadius(10)
        .shadow(radius: 10)
        .transition(.move(edge: .bottom))
        
    
        }
    }
        
    
}
#Preview {
    EmailPopupView(showPopup: .constant(true))
}

