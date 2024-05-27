//
//  ProductsView.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-12.
//

import SwiftUI

struct ProductsView: View {
    @StateObject var viewModel = ProductsViewModel()
    @State var nextView: Bool = false
    
    var body: some View {
        NavigationStack {
            List(viewModel.products) { product in
                HStack {
                    if let imageUrl = product.imageUrl,
                       let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                            @unknown default:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                            }
                        }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(product.name)
                        Text("\(product.price) kr")
                            .font(.caption)
                    }
                    Spacer()
                }
                .padding(15)
            }
            .navigationTitle("Products")
            .onAppear {
               // viewModel.fetchProducts()
            }
            
            VStack {
                Text(UserDefaults.standard.string(forKey: "selectedServiceName") ?? "HEJ")
            }
        }
    }
}

#Preview {
    ProductsView()
}
