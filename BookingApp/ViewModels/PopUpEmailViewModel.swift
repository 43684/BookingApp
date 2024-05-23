//
//  PopUpEmailViewModel.swift
//  BookingApp
//
//  Created by Dennis.Nilsson on 2024-05-23.
//

import Foundation
import SwiftUI
import MessageUI

class PopUpEmailViewModel: NSObject, ObservableObject, MFMailComposeViewControllerDelegate {
    @Published var emailModel = Email(subject: "", message: "")
    @Published var isShowingMailView = false
    @Published var alertMessage: String?
    @Published var showAlert = false

    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            isShowingMailView = true
        } else {
            alertMessage = "Cannot send email from this device"
            showAlert = true
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: (any Error)?) {
        controller.dismiss(animated: true){
            if result == .sent{
                self.alertMessage = "Email sent successfully!"
                self.showAlert = true
            } else if let error = error {
                self.alertMessage = error.localizedDescription
                self.showAlert = true
            }
        }
    }
}
