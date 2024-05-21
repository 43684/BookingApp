//
//  AppointmentsView.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-14.
//

import SwiftUI

struct AdminView: View {
    
    @ObservedObject var viewModel = AdminViewModel()
    
    @State var expand = false
    
    var body: some View {
        List {
            
            
            Section("Uppcomming Appointments"){
                ForEach(viewModel.appointments) { appointment in
                    Text("\(appointment.day.dayOfMonth) \(appointment.day.month) \(appointment.time)")
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
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
                        Text(product.name + " \(product.price)")
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    viewModel.deleteProduct(product: product)
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                    }
                    
                    TextField(text: $viewModel.productName) {
                        Text("New Product name")
                    }
                    TextField(text: $viewModel.productPrice) {
                        Text("New Product price")
                    }
                    Button("Add Product to database") {
                        viewModel.addNewProduct()
                    }.foregroundColor(.blue)
                }
            }
            

        }.listStyle(.sidebar)
    }
}

#Preview {
    AdminView()
}
