//
//  ServicesService.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-12.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class ServicesService {
    
    static let shared = ServicesService()
    
    static func fetchServices() async throws -> [Service] {
        let snapshot = try await Firestore.firestore().collection("services").getDocuments()
        let services = snapshot.documents.compactMap({try? $0.data(as: Service.self)})
        return services
    }
    
    func createNewService(service:Service){
        
        let reference = Firestore.firestore().collection("services").document()
        guard let appointmentData = try? Firestore.Encoder().encode(service) else {return}
        reference.setData(appointmentData)
        
    }
    
    func deleteService(service:Service){
        Firestore.firestore().collection("services").document(service.id).delete()
    }
   
}
