//
//  BookingCompleteView.swift
//  BookingApp
//
//  Created by Joakim.Bjärkstedt on 2024-05-21.
//

import SwiftUI

struct BookingCompleteView: View {
    @ObservedObject var smtptest = SendEmailViewModel()

    var body: some View {
        
        VStack {
            Spacer(minLength: 100)
            
            //First box
            ZStack {
                    RoundedRectangle(cornerRadius: 15.0)
                        .stroke(Color(hex: "#D3BD9C"), lineWidth: 1)
                    
                    HStack {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                                .border(Color(hex: "#D3BD9C"))
                                
                            Text("Your booking has been sent to the studio.")
                                .foregroundColor(Color(hex: "#D3BD9C"))
                    }
                        
                }.frame(width: 360,height: 100, alignment: .leading)
                    .padding(5)
            
             
            //Second box
            ZStack{
                RoundedRectangle(cornerRadius: 15.0 )
                    .stroke(Color(hex: "#D3BD9C"), lineWidth: 1)
                
                    HStack {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .border(Color(hex: "#D3BD9C"))
                        
                        Text("You can see your receipt in your e-mail.")
                            .foregroundColor(Color(hex: "#D3BD9C"))
                    }.offset(x: -7)
                    
                
            }.frame(width: 360,height: 100, alignment: .leading)
             .padding(5)
            
            //Third box
            ZStack{
                RoundedRectangle(cornerRadius: 15.0 )
                    .stroke(Color(hex: "#D3BD9C"), lineWidth: 1)
                
                    HStack {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                                .border(Color(hex: "#D3BD9C"))
                            
                            Text("If you have questions contact the studio.")
                                .foregroundColor(Color(hex: "#D3BD9C"))
                    }.offset(x: -3)
                
            }.frame(width: 360,height: 100, alignment: .leading)
             .padding(5)
            
            
            VStack{

                AnimationView(fileName: "congratulations")
                
            }
            
            Spacer()
            

        }
        Text(UserDefaults.standard.string(forKey: "firstname") ?? "HEJ")
        
            .onAppear{
                sendEmailReceipt()
                sendBookingConfirmationEmail()
            }
            .background(Color.black)
    }
    func sendEmailReceipt() {
        let firstName = UserDefaults.standard.string(forKey: "firstname") ?? ""
        let lastName = UserDefaults.standard.string(forKey: "lastname") ?? ""
        let recipientEmail = UserDefaults.standard.string(forKey: "email") ?? ""
        let phone = UserDefaults.standard.string(forKey: "phone") ?? ""
        let message = UserDefaults.standard.string(forKey: "message") ?? ""
        
        let subject = "Booking Confirmation"
        let body = """
            Dear \(firstName) \(lastName),
            
            Your booking has been successfully received.
            
            Details:
            Name: \(firstName) \(lastName)
            Phone: \(phone)
            Message: \(message)
            
            Thank you for booking with us!
            
            Best regards,
            The Studio Team
            """
        
        smtptest.sendMailReceipt(to: recipientEmail, subject: subject, body: body)
    }
    func sendBookingConfirmationEmail() {
        let firstName = UserDefaults.standard.string(forKey: "firstname") ?? ""
        let lastName = UserDefaults.standard.string(forKey: "lastname") ?? ""
        let recipientEmail = UserDefaults.standard.string(forKey: "email") ?? ""
        let phone = UserDefaults.standard.string(forKey: "phone") ?? ""
        let message = UserDefaults.standard.string(forKey: "message") ?? ""
        
        let subject = "Booking Confirmation"
        let body = """
            Hello Yana,
            You have received a new Booking:
            
            Customer information:
            Name: \(firstName) \(lastName)
            Phone: \(phone)
            Message: \(message)
            Booking Information:
            Appointment:
            Service:
            Products:
            
            Thank you for booking with us!
            
            Best regards,
            The Studio Team
            """
        
        smtptest.sendMailConfirmation(to: recipientEmail, subject: subject, body: body)
    }
}


extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}
    
    #Preview {
        BookingCompleteView()
    }

