//
//  AppointmentService.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-12.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AppointmentService {
    
    static let shared = AppointmentService()
    
    func fetchAppointments() async throws {
        let snapshot = try await Firestore.firestore().collection("appointments").getDocuments()
        print(snapshot.query)
        
    }
    
    func createAppointments(appointment:Appointment){
        
        let reference = Firestore.firestore().collection("appointments").document()
        guard let appointmentData = try? Firestore.Encoder().encode(appointment) else {return}
        reference.setData(appointmentData)
        
    }
}
