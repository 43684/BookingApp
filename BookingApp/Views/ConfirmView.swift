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
    private var stringArray = ["Lemuel", "Mark", "Chris", "Chase", "Adam", "Rodrigo"]
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Section {
                    HStack {
                        Text("Order details: ")
                        Text("35435")//Text($orderNumber)
                    }.foregroundStyle(.blue)
                    HStack {
                        Text(Product.MOCK_PRODUCT.name)
                        Text("1000 kr")
                    }
                    HStack {
                        Text("Hair Removal: ") //Text("Product.MOCK_PRODUCT.name)
                        Text("1000 kr")//Text(Product.MOCK_PRODUCT.price)
                    }
                    
                    Divider()
                        .frame(maxWidth: 200)
                    
                    HStack {
                        Text("Total: ") //Text("Product.MOCK_PRODUCT.name)
                        Text("2000 kr")//Text(Product.MOCK_PRODUCT.price)
                    }
                }
            }
            VStack {
                    HStack {
                        Text("Date: ")
                        Text("27 May 2024")//Text($orderDate)
                    }
                    HStack {
                        Text("Time: ")
                        Text("10.00 am")//Text($orderDate)
                    }
                    HStack {
                        Text("Adress: ")
                        Text("Björkgatan 3A \n234 34, Stockholm")//Text($orderDate)
                    }
            }
            
        }
        HStack {
            Button("Change Order"){
                
            }.buttonStyle(.bordered)
                .padding()
            Button("Confirm Order"){
                
            }.buttonStyle(.borderedProminent)
        }
        
        Button {
        } label: {
            Image(systemName: "envelope")
                .foregroundColor(.black)
                .padding(15)
                .foregroundColor(Color(hex: "#3EB489"))
                .background(Color(hex: "#D3BD9C"))
                .cornerRadius(50)
            //.offset(x:100, y:5)
        }
    }
}
        
        
        /*
         NavigationStack{
         ZStack {
         List{
         Section("Your order") {
         HStack {
         Text("Order details: ")
         Text("35435")//Text($orderNumber)
         }.foregroundStyle(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
         HStack {
         Text(Product.MOCK_PRODUCT.name)
         Text("")
         }
         HStack {
         Text("Hair Removal: ") //Text("Product.MOCK_PRODUCT.name)
         Text("1000 kr")//Text(Product.MOCK_PRODUCT.price)
         }
         }
         
         Section("Time"){
         HStack {
         Text("Date: ")
         Text("27 May 2024")//Text($orderDate)
         }
         HStack {
         Text("Time: ")
         Text("10.00 am")//Text($orderDate)
         }
         HStack {
         Text("Adress: ")
         Text("Björkgatan 3A \n234 34, Stockholm")//Text($orderDate)
         }
         }
         }
         }
         .navigationTitle("Your Order")
         
         }.background(Color.black)
         
         HStack {
         Button("Change Order"){
         
         }.buttonStyle(.bordered)
         .padding()
         Button("Confirm Order"){
         
         }.buttonStyle(.borderedProminent)
         }
         
         Button {
         } label: {
         Image(systemName: "envelope")
         .foregroundColor(.black)
         .padding(15)
         .foregroundColor(Color(hex: "#3EB489"))
         .background(Color(hex: "#D3BD9C"))
         .cornerRadius(50)
         //.offset(x:100, y:5)
         }
         */

#Preview {
    
    ConfirmView()
    
}
