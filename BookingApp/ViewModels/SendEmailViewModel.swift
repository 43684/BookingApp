//
//  smtpTest.swift
//  BookingApp
//
//  Created by Joakim.Bjärkstedt on 2024-05-27.
//

import Foundation
import SwiftSMTP
class SendEmailViewModel:ObservableObject {
    
    func sendMailReceipt(to recipientEmail:String,subject:String,body:String) {
        if recipientEmail.isEmpty {
                 print("Error: recipientEmail is empty")
                 return
             }

        let smtp = SMTP(
            hostname: "smtp.gmail.com",  // Exempel: smtp.gmail.com
            email: "joakim8904@gmail.com",
            password: "zqkgblrekqgusbdu"
        )
        
        let adminEmail = Mail.User(name: "Jocke", email: "joakim8904@gmail.com")
        let customerEmail = Mail.User(name: "Customer", email:  recipientEmail)
        
        let mail = Mail(
            from: adminEmail,
            to: [customerEmail],
            subject: subject,
            text:  body
        )
        
        smtp.send(mail) { (error) in
            if error != nil {
                print("Error sending email: \(error?.localizedDescription)")
            } else {
                print("Email sent successfully!")
            }
        }
    }
    func sendMailConfirmation(to adminEmail:String,subject:String,body:String) {
       

        let smtp = SMTP(
            hostname: "smtp.gmail.com",  // Exempel: smtp.gmail.com
            email: "joakim8904@gmail.com",
            password: "zqkgblrekqgusbdu"
        )
        
        let adminEmail = Mail.User(name: "Jocke", email: "joakim8904@gmail.com")
        
        let mail = Mail(
            from: adminEmail,
            to: [adminEmail],
            subject: subject,
            text:  body
        )
        
        smtp.send(mail) { (error) in
            if error != nil {
                print("Error sending email: \(error?.localizedDescription)")
            } else {
                print("Email sent successfully!")
            }
        }
    }
}
//print(UserDefaults.standard.dictionaryRepresentation()).
