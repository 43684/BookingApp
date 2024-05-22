//
//  AppointmentsView.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-14.
//

import SwiftUI
import SDWebImageSwiftUI // Import SDWebImageSwiftUI for loading images from URL

struct AdminView: View {
    
    @ObservedObject var viewModel = AdminViewModel()
    
    @State var expand = false
    
    var body: some View {
        List {
            
            
            Section("Uppcomming Appointments"){
                if viewModel.appointments.isEmpty {
                    Text("No uppcomming appointments")
                } else {
                    ForEach(viewModel.appointments) { appointment in
                        Text("\(appointment.day.dayOfMonth) \(appointment.day.month) \(appointment.time)")
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    viewModel.cancelAppointment(appointment: appointment)
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                    }
                }
            }
            
            Section("Update data", isExpanded: $expand) {
                Section("Generate new appointments",isExpanded: $viewModel.expandAppointmentContainer){
                    DatePicker("Please enter a date", selection: $viewModel.date, displayedComponents: .date)
                    Button("Generate monthly appointments") {
                        viewModel.createMonthlyAppointmentsFromDate()
                    }.foregroundColor(.blue)
                    Button("Generate one appointment") {
                        viewModel.createAppointmentFromDate()
                    }.foregroundColor(.blue)
                }
                
                Section("Services",isExpanded: $viewModel.expandServiceContainer) {
                    ForEach(viewModel.services) { service in
                        Text(service.name + " \(service.price)")
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    viewModel.deleteService(service: service)
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                    }
                    TextField(text: $viewModel.serviceName) {
                        Text("New service name")
                    }
                    TextField(text: $viewModel.servicePrice) {
                        Text("New service price")
                    }
                    Button("Add Service to database") {
                        viewModel.addNewService()
                    }.foregroundColor(.blue)
                    
                }
                
                Section("Products",isExpanded: $viewModel.expandProductContainer){

                                    ForEach(viewModel.products) { product in
                                        HStack {
                                            AsyncImage(url: URL(string: product.imageUrl ?? "https://hws.dev/paul2.jpg")) { image in
                                                image.resizable()
                                            } placeholder: {
                                                Color.red
                                            }
                                            .frame(width: 44, height: 44)
                                            .clipShape(.rect(cornerRadius: 5))
                                            Text(product.name + " \(product.price)")
                                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                                    Button(role: .destructive) {
                                                        viewModel.deleteProduct(product: product)
                                                    } label: {
                                                        Label("Delete", systemImage: "trash.fill")
                                                    }
                                            }
                                        }
                                    }

                    HStack{
                        Button{
                            viewModel.isImagePickerPresented.toggle()
                        } label: {
                            if viewModel.selectedImage == nil {
                                Image(systemName: "photo.badge.plus")
                                    .padding()
                                    .border(Color.black)
                            } else {
                                Image(uiImage: viewModel.selectedImage!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 64, height: 64)
                            }
                        
                        }
                        .sheet(isPresented: $viewModel.isImagePickerPresented) {
                            ImagePicker(image: $viewModel.selectedImage)
                        }.foregroundColor(.blue)
                        TextField(text: $viewModel.productName) {
                            Text("Product name")
                        }
                        .padding(10)
                        .border(Color.black)
                        TextField(text: $viewModel.productPrice) {
                            Text("Price")
                        }
                        .padding(10)
                        .border(Color.black)
                        .keyboardType(.numberPad)
        
                    }
                    
                                    Button("Add Product to database") {
                                        viewModel.addNewProduct(imageData: (viewModel.selectedImage?.jpegData(compressionQuality: 0.5) ?? UIImage(named: "Icon")?.jpegData(compressionQuality: 0.5))!)
                                            
                                        
                                    }.foregroundColor(.blue)
                                }
                
                
                
            }
        }.listStyle(.sidebar)
    }
}

        
#Preview {
    AdminView()
}
