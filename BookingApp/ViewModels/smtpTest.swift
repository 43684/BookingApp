//
//  smtpTest.swift
//  BookingApp
//
//  Created by Joakim.Bjärkstedt on 2024-05-27.
//

import Foundation
import SwiftSMTP

func sendMail() {
        let smtp = SMTP(
            hostname: "smtp.gmail.com",  // Exempel: smtp.gmail.com
            email: "joakim8904@gmail.com",
            password: "jodu1234"
        )

        let from = Mail.User(name: "Jocke", email: "joakim8904@gmail.com")
        let to = Mail.User(name: "Customer", email: "joakim198904@live.se")

        let mail = Mail(
            from: from,
            to: [to],
            subject: "Subject",
            text: "Mail body text"
        )

        smtp.send(mail) { (error) in
            if error != nil {
                print("Error sending email: (error)")
            } else {
                print("Email sent successfully!")
            }
        }
    }
