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
    @State private var selectedProduct: Product?
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color(hex:"#D3BD9C"))]
    }
    
    @StateObject var emailViewModel = PopUpEmailViewModel()
    @State var showPopup = false
    
    var body: some View {
        NavigationStack {
        VStack {
            
            Spacer()
            List{
                ForEach(viewModel.products){ product in
                    VStack{
                        HStack{
                            
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
                                            .frame(width: 70, height: 70)
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 70, height: 70)
                                    @unknown default:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 70, height: 70)
                                    }
                                }
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 70, height: 70)
                            }
                            
                            Spacer()
                            
                            Text("\(product.name)")
                                .foregroundColor(Color(hex: "#D3BD9C"))
                                .font(.title2)
                            Spacer()
                            
                            VStack{
                                Text("\(product.price) kr")
                                    .foregroundColor(Color(hex: "#D3BD9C"))
                                    .font(.title2)
                            
                            }
                            .font(.caption)
                            
                        }
                     
                    }
                    .onTapGesture {
                        selectedProduct = product
                        
                    }
                    .background(selectedProduct == product ? Color.yellow : Color.clear)
                    .contentShape(Rectangle())
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.black)
                    Divider()
                        .frame(minHeight: 0.3)
                        .overlay(Color(hex: "#D3BD9C"))
                    
                    
                    
                }

                
                .listRowBackground(Color.black)
            }
            
            
            Button("NEXT"){
                viewModel.saveSelectedProduct(selectedProduct)
                nextView = true
                
            }.padding()
                .font(.title3)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "#D3BD9C"), Color(hex: "#6D6355")]), startPoint: .leading, endPoint: .trailing))
                .foregroundColor(Color(hex: "#131D54"))
                .cornerRadius(15)
                .bold()
            
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
            }.padding()
            
        }
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
        .navigationTitle("Choose products")
            .navigationDestination(isPresented: $nextView, destination: {
                CalenderView()
            })
            .background(.black)
            .scrollContentBackground(.hidden)
            
            
    }
}
}
#Preview {
    ProductsView()
}


