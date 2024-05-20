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
            Section{
                DatePicker("Please enter a date", selection: $viewModel.date, displayedComponents: .date)
                Button("Generate appointments for selected date") {
                    viewModel.createMonthlyAppointmentsFromDate()
                    print("done")
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
        }
        

    }
}

#Preview {
    AdminView()
}
