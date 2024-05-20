//
//  AppointmentsView.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-14.
//

import SwiftUI

struct AdminView: View {
    
    @ObservedObject var viewModel = AdminViewModel()
    
    var body: some View {
        List {
            Section("Generate appointments for selected date"){
                DatePicker("Please enter a date", selection: $viewModel.date, displayedComponents: .date)
                Button("Generate monthly appointments") {
                    viewModel.createMonthlyAppointmentsFromDate()
                }
                Button("Generate one appointments") {
                    viewModel.createAppointmentFromDate()
                    
                }
            }
            
            Section("Add new Service"){
                TextField(text: $viewModel.serviceName) {
                    Text("Service name")
                }
                TextField(text: $viewModel.servicePrice) {
                    Text("Service price")
                }
                Button("Add Service to database") {
                    viewModel.addNewService()
                }
            }
            
            Section("Services"){
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
            }
            
            
            Section("Add new product"){
                TextField(text: $viewModel.productName) {
                    Text("Product name")
                }
                TextField(text: $viewModel.productPrice) {
                    Text("Product price")
                }
                Button("Add Product to database") {
                    viewModel.addNewProduct()
                }
            }
            
            Section("Products"){
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
            }
            
            Section("Appointments"){
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
        }
    }
}

#Preview {
    AdminView()
}
