//
//  BookingView.swift
//  BookingApp
//
//  Created by Dennis.Nilsson on 2024-05-23.
//

import SwiftUI

struct BookingView: View {

     @ObservedObject var viewModel = BookingViewModel()
     var body: some View {
         NavigationView {
                 Form {
                     Section(header: Text("Your Information").font(.title).foregroundStyle(Color.yellow)){
                         TextField("First Name", text: $viewModel.firstName)
                             .textFieldStyle(RoundedBorderTextFieldStyle())
                             .padding(.top,5)

                         TextField("Last Name", text: $viewModel.lastName)
                             .textFieldStyle(RoundedBorderTextFieldStyle())
                             .padding(.top,5)
                         TextField("Email", text: $viewModel.email)
                             .textFieldStyle(RoundedBorderTextFieldStyle())
                             .padding(.top,5)
                         TextField("Phonenumber", text: $viewModel.phone)
                             .textFieldStyle(RoundedBorderTextFieldStyle())
                             .padding(.top,5)
                             .keyboardType(.numberPad)

                     }

                     Section(header: Text("Message to the studio").foregroundStyle(Color.yellow)) {
                         TextEditor(text: $viewModel.message)
                             .frame(height: 100)
                             .padding(5)
                     }

                     Section {
                         HStack{
                             Button(action: {
                                 viewModel.consent.toggle()
                             }) {
                                 HStack {
                                     Image(systemName: viewModel.consent ? "checkmark.square" : "square")
                                         .resizable()
                                         .frame(width: 25, height: 25)
                                     Text("Free cancellation up to 24 hours before booking.")
                                         .foregroundStyle(Color.blue)

                                 }
                             }
                             .buttonStyle(PlainButtonStyle())

                         }

                         Text("In case of cancellation, please contact us via email or by phone.")
                             .foregroundStyle(Color.red)

                     }

                     Section {
                         HStack {
                             Spacer()
                             if viewModel.isSubmitting {
                                 ProgressView()
                                     .progressViewStyle(CircularProgressViewStyle())
                             } else {
                                 Button(action: {
                                     viewModel.submit()
                                 }) {
                                     Text("Send Order")
                                         .fontWeight(.bold)
                                         .foregroundColor(Color.black)
                                         .padding()
                                         .background(Color.yellow)
                                         .cornerRadius(10)
                                 }
                             }
                             Spacer()
                         }
                     }
                 }
                 .background(Color.black)
                 .scrollContentBackground(.hidden)


         }
     }
 }


 #Preview {
     BookingView()
 }
