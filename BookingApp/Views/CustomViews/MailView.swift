//
//  MailView.swift
//  BookingApp
//
//  Created by Dennis.Nilsson on 2024-05-23.
//

import SwiftUI
import MessageUI
struct MailView: UIViewControllerRepresentable {
    
    @ObservedObject var viewModel: PopUpEmailViewModel

     func makeUIViewController(context: Context) -> MFMailComposeViewController {
         let mailComposeVC = MFMailComposeViewController()
         //Admins mail
         mailComposeVC.setToRecipients(["nilssondennis97@gmail.com"])
         mailComposeVC.setSubject(viewModel.emailModel.subject)
         mailComposeVC.setMessageBody(viewModel.emailModel.message, isHTML: false)
         mailComposeVC.mailComposeDelegate = viewModel
         print("MailView created and configured.")
         return mailComposeVC
     }
     func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {    }
}
