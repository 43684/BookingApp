//
//  ConfirmViewModel.swift
//  BookingApp
//
//  Created by Juhee Kang Johansson on 2024-05-20.
//

import Foundation

class ConfirmViewModel: ObservableObject {
    @Published var serviceName: String = ""
    @Published var servicePrice: Int = 0
    @Published var productName: String = ""
    @Published var productPrice: Int = 0
    @Published var appointmentDate: String = ""
    @Published var appointmentTime: String = ""
    @Published var totalCost: Int = 0
    
    init() {
        fetchOrderDetails()
    }
    
    func fetchOrderDetails() {
        let defaults = UserDefaults.standard
        
        if let serviceName = defaults.string(forKey: "selectedServiceName"),
           let productName = defaults.string(forKey: "selectedProductName") {
            self.serviceName = serviceName
            self.servicePrice = defaults.integer(forKey: "selectedServicePrice")
            self.productName = productName
            self.productPrice = defaults.integer(forKey: "selectedProductPrice")
            self.totalCost = self.servicePrice + self.productPrice
            
            self.appointmentDate = "\(defaults.integer(forKey: "appointmentDay")) \(defaults.string(forKey: "appointmentMonth") ?? "") \(defaults.integer(forKey: "appointmentYear"))"
            self.appointmentTime = defaults.string(forKey: "appointmentTime") ?? ""
        }
    }
    
    func clearOrderDetails() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "selectedServiceName")
        defaults.removeObject(forKey: "selectedServicePrice")
        defaults.removeObject(forKey: "selectedProductName")
        defaults.removeObject(forKey: "selectedProductPrice")
        defaults.removeObject(forKey: "appointmentBooked")
        defaults.removeObject(forKey: "appointmentTime")
        defaults.removeObject(forKey: "appointmentYear")
        defaults.removeObject(forKey: "appointmentDay")
        defaults.removeObject(forKey: "appointmentMonthValue")
        defaults.removeObject(forKey: "appointmentMonth")
    }
}
