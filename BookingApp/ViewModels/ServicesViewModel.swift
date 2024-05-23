//
//  ServicesViewModel.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-12.
//

import Foundation
import Combine

class ServicesViewModel: ObservableObject {
    
    @Published var services = [Service]()
    @Published var isAdminLoggedIn = false
    
    let service: ServicesService
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.service = ServicesService()
        Task{try await fetchData()}
        setupSubscibers()
    }
    
    private func setupSubscibers(){
        AuthService.shared.$isAdminLoggedIn.sink { [weak self] adminSessionFromAuthService in
            self?.isAdminLoggedIn = adminSessionFromAuthService
        }.store(in: &cancellables)
    }
    
    
    @MainActor
    func fetchData() async throws {
        
        let fetchedServices = try await ServicesService.fetchServices()
        
        services = []
        services.append(contentsOf: fetchedServices)
       
                
    }
    
    func saveSelectedService(_ selectedService: Service?){
        if let selectedService = selectedService {
            UserDefaults.standard.set(selectedService.name, forKey: "selectedService")
        }
    }
    
    
}
