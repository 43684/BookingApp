//
//  BookingViewModel.swift
//  BookingApp
//
//  Created by Dennis.Nilsson on 2024-05-23.
//

import Foundation
class BookingViewModel: ObservableObject{
     @Published var firstName: String = ""
     @Published var lastName: String = ""
     @Published var email: String = ""
     @Published var phone: String = ""
     @Published var message: String = ""
     @Published var consent: Bool = false
     @Published var isSubmitting: Bool = false

     func submit(){
         guard !isSubmitting else {
             return
         }
         isSubmitting = true


         DispatchQueue.main.asyncAfter(deadline: .now() + 2){
             self.isSubmitting = false
         }
     }
 }
