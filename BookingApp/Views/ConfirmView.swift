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
    
    var body: some View {
        
        NavigationStack {
            //Order
            VStack (alignment: .leading) {
                HStack {
                    Text("Order details: ")
                    Text("35435")//Text($orderNumber)
                }.padding(5)
                 .frame(minWidth: 300, alignment: .leading)
                
                HStack {
                    Text(Product.MOCK_PRODUCT.name)
                    Text("1000 kr")
                }.padding(5)
                 .frame(minWidth: 300, alignment: .leading)
                
                HStack {
                    Text("Hair Removal: ") //Text("Product.MOCK_PRODUCT.name)
                     Text("1000 kr")//Text(Product.MOCK_PRODUCT.price)
                }.padding(5)
                    .frame(minWidth: 300, alignment: .leading)
                
                Divider()
                    .frame(maxWidth: 300)
                
                HStack {
                     Text("Total: ") //Text("Product.MOCK_PRODUCT.name)
                     Text("2000 kr")//Text(Product.MOCK_PRODUCT.price)
                }.padding(5)
                    .frame(minWidth: 300, alignment: .leading)
            }
            .padding()
            .background (Color(hex: "#D3BD9C"))
            .cornerRadius(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            
            //Date
            VStack (alignment: .leading) {
                 HStack {
                      Text("Date: ")
                      Text("27 May 2024")//Text($orderDate)
                 }.padding(5)
                  .frame(minWidth: 300, alignment: .leading)
                
                 HStack {
                      Text("Time: ")
                      Text("10.00 am")//Text($orderDate)
                 }.padding(10)
                  .frame(minWidth: 300, alignment: .leading)
                
                 HStack {
                      Text("Adress: ")
                      Text("Björkgatan 3A \n234 34, Stockholm")//Text($orderDate)
                 }.padding(10)
                  .frame(minWidth: 300, alignment: .leading)
                
            }
            .padding()
            .background(Color(hex: "#D3BD9C"))
            .cornerRadius(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
            
            //Button
            HStack {
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
            }
            
            //email
            Button {
            } label: {
                Image(systemName: "envelope")
                    .foregroundColor(.black)
                    .padding(15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(hex: "#D3BD9C"), Color(hex: "#6D6355")]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(50)
                
            }
        } //.navigationTitle("Your Order")
        //.background {
                   // Color.black
                   // .ignoresSafeArea()
       // }
    }
}
       

#Preview {
    
    ConfirmView()
    
}
