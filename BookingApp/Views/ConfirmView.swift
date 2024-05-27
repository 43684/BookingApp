//
//  ConfirmView.swift
//  BookingApp
//
//  Created by Juhee Kang Johansson on 2024-05-20.
//

import SwiftUI

struct ConfirmView: View {
    @StateObject private var viewModel = ConfirmViewModel()
    @StateObject var emailViewModel = PopUpEmailViewModel()
    @State var showPopup = false

    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color(hex:"#D3BD9C"))]
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Order details: ")
                }.padding(5)
                    .frame(minWidth: 300, alignment: .leading)
                
                HStack {
                    Text(viewModel.serviceName)
                    Spacer()
                    Text("\(viewModel.servicePrice) kr")
                }.padding(5)
                    .frame(minWidth: 300, alignment: .leading)
                
                HStack {
                    Text(viewModel.productName)
                    Spacer()
                    Text("\(viewModel.productPrice) kr")
                }.padding(5)
                    .frame(minWidth: 300, alignment: .leading)
                
                Divider()
                    .frame(minHeight: 1)
                    .overlay(Color(hex: "#131D54"))
                
                HStack {
                    Text("Total: ")
                    Spacer()
                    Text("\(viewModel.totalCost) kr")
                }.padding(5)
                    .frame(minWidth: 300, alignment: .leading)
                
                Divider()
                    .frame(minHeight: 1)
                    .overlay(Color(hex: "#131D54"))
                
                HStack {
                    Text("Date: ")
                    Spacer()
                    Text(viewModel.appointmentDate)
                }.padding(5)
                    .frame(minWidth: 300, alignment: .leading)
                
                HStack {
                    Text("Time: ")
                    Spacer()
                    Text(viewModel.appointmentTime)
                }.padding(5)
                    .frame(minWidth: 300, alignment: .leading)
                
                HStack {
                    Text("Address: \n")
                    Text("Björkgatan 3A \n234 34, Stockholm")
                }.padding(5)
                    .frame(minWidth: 300, alignment: .leading)
            }
            .padding()
            .background(Color(hex: "#D3BD9C"))
            .foregroundColor(Color(hex: "#131D54"))
            .bold()
            .cornerRadius(20)
            .frame(maxWidth: 350, maxHeight: .infinity, alignment: .center)
            
            // Buttons
            HStack(spacing: 40) {
                Button("Change Order") {
                    viewModel.clearOrderDetails()
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = UIHostingController(rootView: ServicesView())
                        window.makeKeyAndVisible()
                    }
                }.padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(hex: "#F2F0F0"), Color(hex: "#8C8B8B")]), startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(Color(hex: "#131D54"))
                    .cornerRadius(15)
                    .bold()
                
                NavigationLink(destination: BookingView()) {
                    Text("Confirm Order")
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(hex: "#D3BD9C"), Color(hex: "#6D6355")]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(Color(hex: "#131D54"))
                        .cornerRadius(15)
                        .bold()
                }
            }.padding(.horizontal)
            
            
            HStack {
                Spacer()
                ZStack {
                    Button {
                        showPopup.toggle()
                    } label: {
                        Image(systemName: "envelope")
                            .foregroundColor(.black)
                            .padding(12)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color(hex: "#D3BD9C"), Color(hex: "#6D6355")]), startPoint: .leading, endPoint: .trailing))
                            .clipShape(Circle())
                    }
                }.frame(width: 60, height: 60)
                    .offset(x: -10)
                    .sheet(isPresented: $showPopup){
                        EmailPopupView(showPopup: $showPopup)
                            .environmentObject(emailViewModel)
                    }
                    .alert(isPresented: $emailViewModel.showAlert){
                        Alert(title: Text("Message"), message: Text(emailViewModel.alertMessage ?? ""), dismissButton: .default(Text("OK")))
                    }
                    .sheet(isPresented: $emailViewModel.isShowingMailView){
                        MailView(viewModel: emailViewModel)
                    }
            }.padding()
            
        }.navigationTitle("Confirm booking")
            .background(Color.black)
            .scrollContentBackground(.hidden)
    }
}

#Preview {
    NavigationView {
        ConfirmView()
    }
}
