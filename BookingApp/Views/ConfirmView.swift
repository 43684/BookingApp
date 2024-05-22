//
//  ConfirmView.swift
//  BookingApp
//
//  Created by Juhee Kang Johansson on 2024-05-20.
//

import SwiftUI

struct ConfirmView: View {
    
    @ObservedObject var viewModel = AdminViewModel()
    let orderDetails = "123456"
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color(hex:"#D3BD9C"))]
    }
    
    var body: some View {
        
            VStack {
                //Order
                VStack (alignment: .leading) {
                    HStack {
                        Text("Order details: ")
                        Text("35435")//Text($orderNumber)
                    }.padding(5)
                        .frame(minWidth: 300, alignment: .leading)
                        
                    HStack {
                        Text("Hair Extension") //Text(Product.MOCK_SERVICE.name)
                        Text("1000 kr") //Text(Product.MOCK_SERVICE.price)
                    }.padding(5)
                        .frame(minWidth: 300, alignment: .leading)
                    
                    HStack {
                        Text("Hair Removal: ") //Text("Product.MOCK_PRODUCT.name)
                        Text("1000 kr") //Text(Product.MOCK_PRODUCT.price)
                    }.padding(5)
                        .frame(minWidth: 300, alignment: .leading)
                    
                    Divider()
                        .frame(minHeight: 1)
                        .overlay(Color(hex: "#131D54"))
                    
                    HStack {
                        Text("Total: ")
                        Text("2000 kr") //Text($totalCost)
                    }.padding(5)
                        .frame(minWidth: 300, alignment: .leading)
                    
                    Divider()
                        .frame(minHeight: 1)
                        .overlay(Color(hex: "#131D54"))
                    
                    HStack {
                        Text("Date: ")
                        Text("27 May 2024") //Text($orderDate)
                    }.padding(5)
                        .frame(minWidth: 300, alignment: .leading)
                    
                    HStack {
                        Text("Time: ")
                        Text("10.00 am")//Text($orderTime)
                    }.padding(5)
                        .frame(minWidth: 300, alignment: .leading)
                    
                    HStack {
                        Text("Adress: \n")
                        Text("Björkgatan 3A \n234 34, Stockholm")//Text($Address)
                    }.padding(5)
                        .frame(minWidth: 300, alignment: .leading)
                }
                .padding()
                .background (Color(hex: "#D3BD9C"))
                .foregroundColor(Color(hex: "#131D54"))
                .bold()
                .cornerRadius(20)
                .frame(maxWidth: 350, maxHeight: .infinity, alignment: .center)
                
                //Button
                HStack (spacing: 40){
                    Button("Change Order"){
                    }.padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(hex: "#F2F0F0"), Color(hex: "#8C8B8B")]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(Color(hex: "#131D54"))
                        .cornerRadius(15)
                        .bold()
                    
                    Button("Confirm Order"){
                    }.padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(hex: "#D3BD9C"), Color(hex: "#6D6355")]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(Color(hex: "#131D54"))
                        .cornerRadius(15)
                        .bold()
                }.padding(.horizontal)
                
                //email
                HStack {
                    Spacer()
                    ZStack {
                        Button {
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
