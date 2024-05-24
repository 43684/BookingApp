//
//  Appointment.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-12.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Appointment: Codable, Identifiable, Hashable {
    
    @DocumentID var uid: String?
    
    var booked: Bool
    var time: String
    var year: Int
    var day: Day
    
    var id : String {
        return uid ?? UUID().uuidString
    }
    
    
}

struct Day: Codable, Hashable {
    let dayOfMonth: Int
    let month: String
    let monthValue: Int
}

