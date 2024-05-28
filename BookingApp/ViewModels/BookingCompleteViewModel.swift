//
//  BookingCompleteViewModel.swift
//  BookingApp
//
//  Created by Joakim.Bjärkstedt on 2024-05-22.
//

import Foundation
import MessageUI

class BookingCompleteViewModel:NSObject, ObservableObject, MFMailComposeViewControllerDelegate {
    @Published var emailModel = Email(subject: "tjenare", message: "hoppsan")
    @Published var isShowingMailView = false
    @Published var alertMessage: String?
    @Published var showAlert = false

    func sendEmail(to email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.mailComposeDelegate = self
            mailComposeViewController.setToRecipients(["joakim198904@live.se"]) // Set recipient email address
            
            // Customize email subject and message
            mailComposeViewController.setSubject(emailModel.subject)
            mailComposeViewController.setMessageBody(emailModel.message, isHTML: false)
            
            // Present the mail compose view controller
            isShowingMailView = true
        } else {
            print("This device needs to be configured to use the Mail app")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.alertMessage = "Configure the Mail app from Apple to send emails"
                self.showAlert = true
            }
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            if result == .sent {
                self.alertMessage = "Email sent successfully!"
                self.showAlert = true
            } else if let error = error {
                self.alertMessage = error.localizedDescription
                self.showAlert = true
            }
        }
    }
}
  
