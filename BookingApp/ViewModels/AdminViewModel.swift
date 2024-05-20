//
//  AppointmentViewModel.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-13.
//

import Foundation

class AdminViewModel: ObservableObject {
    
   
    
    let shared = AdminViewModel()
    
    init(){
        Task{try await fetchData()}
    }
    
    @Published var appointments = [Appointment]()
    
    @Published var date: Date = Date.now
    
    @Published var serviceName = ""
    @Published var servicePrice = ""
    
    @Published var productName = ""
    @Published var productPrice = ""
    
    @Published var services = [Service]()
    @Published var products = [Product]()
    
    
    func createMonthlyAppointmentsFromDate(){
        
        for date in self.date.calendarDays {
            let dayNumber = Int(date.formatted(.dateTime.day())) ?? 0
            let month = date.extractDate(to: .month)
            let monthValue = Int(date.extractDate(to: .monthValue)) ?? 0
            let year = Int(date.extractDate(to: .year)) ?? 0
            
            let appointment1 = Appointment(booked: false, time: "Post Midday", year: year, day: Day(dayOfMonth: dayNumber, month: month, monthValue: monthValue))
            let appointment2 = Appointment(booked: false, time: "After Midday", year: year, day: Day(dayOfMonth: dayNumber, month: month, monthValue: monthValue))
            
            AppointmentService.shared.createAppointments(appointment: appointment1)
            AppointmentService.shared.createAppointments(appointment: appointment2)
        }
    }
    
    func addNewService(){
        ServicesService.shared.createNewService(service: Service(name: serviceName, price: Int(servicePrice) ?? 0))
        serviceName = ""
        servicePrice = ""
    }
    
    func addNewProduct(){
        ProductService.shared.createNewProduct(product: Product(name: productName, price: Int(productPrice) ?? 0))
        productName = ""
        productPrice = ""
    }
    
    
    
    func fetchData() async throws {
        
        let fetchedServices = try await ServicesService.fetchServices()
        let fetchedProducts = try await ProductService.fetchProducts()
        
        services.append(contentsOf: fetchedServices)
        products.append(contentsOf: fetchedProducts)
                
    }
}


