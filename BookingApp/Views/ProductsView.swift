//
//  ProductsView.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-12.
//

import SwiftUI

struct ProductsView: View {
    
    @StateObject var viewModel = ProductsViewModel()
    
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(0..<10, id: \.self){ i in
                    HStack{
                        
                        Text("\(i+1) \(Product.MOCK_PRODUCT.name)")
                        Spacer()
                        VStack{
                            Text("\(Product.MOCK_PRODUCT.price)")
                            Text("Price")
                        }
                        .font(.caption)
                        
                    }
                    .padding(15)
                    
                }
            }
            .toolbar{
                if viewModel.isAdminLoggedIn {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("Add item to firebase")
                        } label: {
                            Text("Add Product")
                                .foregroundColor(.yellow)
                        }
                        
                    }
                }
            }
        }
    }
}


#Preview {
    ProductsView()
}

