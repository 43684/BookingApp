//
//  Service.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-12.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Service: Codable, Identifiable, Hashable {
    
    @DocumentID var uid: String?
    
    let name: String
    let price: Int
   
    var id : String {
        return uid ?? UUID().uuidString
    }
}

extension Service {
    static let MOCK_SERVICE = Service(name: "Klippning", price: 153)
}
