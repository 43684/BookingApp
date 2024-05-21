//
//  AppointmentViewModel.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-13.
//

import Foundation
import Firebase

class AdminViewModel: ObservableObject {
    
   
    
    //let shared = AdminViewModel()
    
    init(){
        Task{try await fetchData()}
        Task{try await fetchAppointment()}
    }
    
    @Published var appointments = [Appointment]()
    
    @Published var date: Date = Date.now
    
    @Published var serviceName = ""
    @Published var servicePrice = ""
    
    @Published var productName = ""
    @Published var productPrice = ""
    
    @Published var services = [Service]()
    @Published var products = [Product]()
    @Published var bookedAppointments = [Appointment]()
    
    @Published var expandServiceContainer = false
    @Published var expandProductContainer = false
    @Published var expandAppointmentContainer = false
    
    
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
    
    func createAppointmentFromDate(){
        
        let dayNumber = Int(date.formatted(.dateTime.day())) ?? 0
        let month = date.extractDate(to: .month)
        let monthValue = Int(date.extractDate(to: .monthValue)) ?? 0
        let year = Int(date.extractDate(to: .year)) ?? 0
        
        let appointment1 = Appointment(booked: false, time: "Post Midday", year: year, day: Day(dayOfMonth: dayNumber, month: month, monthValue: monthValue))
        let appointment2 = Appointment(booked: false, time: "After Midday", year: year, day: Day(dayOfMonth: dayNumber, month: month, monthValue: monthValue))
        
        AppointmentService.shared.createAppointments(appointment: appointment1)
        AppointmentService.shared.createAppointments(appointment: appointment2)
    }
    
    func addNewService(){
        ServicesService.shared.createNewService(service: Service(name: serviceName, price: Int(servicePrice) ?? 0))
        serviceName = ""
        servicePrice = ""
        Task{try await fetchData()}
    }
    
    func addNewProduct(){
        ProductService.shared.createNewProduct(product: Product(name: productName, price: Int(productPrice) ?? 0))
        productName = ""
        productPrice = ""
        Task{try await fetchData()}
    }
    
    
    @MainActor
    func fetchData() async throws {
        
        let fetchedServices = try await ServicesService.fetchServices()
        let fetchedProducts = try await ProductService.fetchProducts()
        services = []
        services.append(contentsOf: fetchedServices)
        products = []
        products.append(contentsOf: fetchedProducts)
                
    }
    
    @MainActor
    func fetchAppointment() async throws {
        
        var fetchedAppointments = try await AppointmentService.fetchAppointments()
            .filter({$0.booked})
            .filter({($0.year >= Int(Date.now.extractDate(to: .year))!)})
            .filter({($0.day.monthValue >= Int(Date.now.extractDate(to: .monthValue))!)})
            .filter({($0.day.dayOfMonth >= Int(Date.now.extractDate(to: .day))!)})
            .sorted(by: {$0.day.monthValue <= $1.day.monthValue})
            .sorted { $0.time < $1.time }
            .sorted(by: {$0.day.dayOfMonth <= $1.day.dayOfMonth})
            
        appointments = []
        
        appointments.append(contentsOf: fetchedAppointments)
                
    }
    
    
    
    func deleteService(service: Service){
        ServicesService.shared.deleteService(service: service)
        if let index = self.services.firstIndex(of: service) {
            self.services.remove(at: index)
        }
    }
    
    func deleteProduct(product: Product){
        ProductService.shared.deleteProduct(product: product)
        if let index = self.products.firstIndex(of: product) {
            self.products.remove(at: index)
        }
    }
    
    func cancelAppointment(appointment: Appointment){
        AppointmentService.shared.cancelAppointment(appointment: appointment)
        if let index = self.appointments.firstIndex(of: appointment) {
            self.appointments.remove(at: index)
        }
    }
}


