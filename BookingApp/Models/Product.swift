//
//  Product.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-12.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Product: Codable, Identifiable, Hashable {
    
    @DocumentID var uid: String?
    
    let name: String
    let price: Int
    
    var id : String {
        return uid ?? UUID().uuidString
    }
}

extension Product {
    static let MOCK_PRODUCT = Product(name: "Shampoo", price: 153)
}
