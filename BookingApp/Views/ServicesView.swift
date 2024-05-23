//
//  ServicesView.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-10.
//

import SwiftUI

struct ServicesView: View {
    
    @StateObject var viewModel = ServicesViewModel()
    @State private var selectedService: Service?
    
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color(hex:"#D3BD9C"))]
    }
    
    
    var body: some View {
        VStack {
        
            Spacer()
            List{
                ForEach(viewModel.services){ service in
                    VStack{
                        HStack{
                            Text("\(service.name)")
                                .foregroundColor(Color(hex: "#D3BD9C"))
                                .font(.title2)
                            Spacer()
                            
                            VStack{
                                Text("\(service.price) kr")
                                    .foregroundColor(Color(hex: "#D3BD9C"))
                                    .font(.title2)
                                //Text("Price")
                            }
                            .font(.caption)
                            
                        }
                        //.padding(15)
                        //Text("Estimated Time: 3h")
                        //.font(.caption)
                        //.offset(x: 5,y:5)
                    }
                    .onTapGesture {
                        selectedService = service
                        
                    }
                    .background(selectedService == service ? Color.yellow : Color.clear)
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
                viewModel.saveSelectedService(selectedService)
                
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
            
        }.navigationTitle("Choose Service")
         .background(.black)
         .scrollContentBackground(.hidden)
    }
}

#Preview {
    NavigationView {
        ServicesView()
    }
}

