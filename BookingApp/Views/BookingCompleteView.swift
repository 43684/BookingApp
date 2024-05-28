//
//  BookingCompleteView.swift
//  BookingApp
//
//  Created by Joakim.Bjärkstedt on 2024-05-21.
//

import SwiftUI

struct BookingCompleteView: View {
    @ObservedObject var smtptest = SendEmailViewModel()
let adminEmail = "joakim8904@gmail.com"
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
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
                
                Text(UserDefaults.standard.string(forKey: "firstname") ?? "")
                        
                            .onAppear{
                                sendEmailReceipt()
                                sendBookingConfirmationEmail()
                            }
                            .background(Color.black)


            }
        }
        
    }
    //function to send confirmation to customer/user
    func sendEmailReceipt() {
        let firstName = UserDefaults.standard.string(forKey: "firstname") ?? ""
        let lastName = UserDefaults.standard.string(forKey: "lastname") ?? ""
        let recipientEmail = UserDefaults.standard.string(forKey: "email") ?? ""
        let phone = UserDefaults.standard.string(forKey: "phone") ?? ""
        let message = UserDefaults.standard.string(forKey: "message") ?? ""
        let appointmentDay = UserDefaults.standard.integer(forKey: "appointmentDay")
            let appointmentMonth = UserDefaults.standard.string(forKey: "appointmentMonth") ?? ""
            let appointmentYear = UserDefaults.standard.integer(forKey: "appointmentYear")
        let service = UserDefaults.standard.string(forKey: "selectedservicename") ?? ""
        let product = UserDefaults.standard.string(forKey: "selectedproductname") ?? ""

        let appointment = "\(appointmentDay) \(appointmentMonth) \(appointmentYear)"

        
        let subject = "Booking Confirmation"
        let body = """
            Dear \(firstName) \(lastName),
            
            Your booking has been succesfully completed.
            
            Details:
            Name: \(firstName) \(lastName)
            Phone: \(phone)
            Message: \(message)
            Your booking information:
            Appointment: \(appointment)
            Service: \(service)
            Products: \(product)
            
            Cancellation Policy:
            Appointments can be cancelled up to 24 hours before the scheduled start time without any charges.
            cancellations made within 24 hours of the scheduled appointment time will incur a cancellation fee
            equivalent to 20% of the service cost.
            To cancel an appointment contact us at \(adminEmail)
            
            Refunds:
            If you cancel an appointment more than 24 hours in advance you will not be excpected to pay anything
                            
            Rescheduling:
            Rescheduling Window: You can reschedule your appointment up to 24 hours before the original
            appointment time without any charges. Contact us at \(adminEmail)
            Changes to Cancellation Policy:
            BjaerkStudio reserves the right to modify or update this cancellation policy at any time.
            Any changes will be communicated through the app and via email to our users.
            Thank you for your understanding and cooperation.
            If you have any questions or need further assistance, please contact us at \(adminEmail)
            
            Thank you for booking with us!
            Best regards,
            The Studio Team
            """
        
        smtptest.sendMailReceipt(to: recipientEmail, subject: subject, body: body)
    }
    
    //Function to send confirmation to Admin
    func sendBookingConfirmationEmail() {
        let firstName = UserDefaults.standard.string(forKey: "firstname") ?? ""
        let lastName = UserDefaults.standard.string(forKey: "lastname") ?? ""
        let recipientEmail = UserDefaults.standard.string(forKey: "email") ?? ""
        let phone = UserDefaults.standard.string(forKey: "phone") ?? ""
        let message = UserDefaults.standard.string(forKey: "message") ?? ""
        let appointmentDay = UserDefaults.standard.integer(forKey: "appointmentDay")
            let appointmentMonth = UserDefaults.standard.string(forKey: "appointmentMonth") ?? ""
            let appointmentYear = UserDefaults.standard.integer(forKey: "appointmentYear")
        let service = UserDefaults.standard.string(forKey: "selectedservicename") ?? ""
        let product = UserDefaults.standard.string(forKey: "selectedproductname") ?? ""

        let appointment = "\(appointmentDay) \(appointmentMonth) \(appointmentYear)"
        
        let subject = "Booking Confirmation"
        let body = """
            Hello Yana,
            You have received a new Booking:
            
            Customer information:
            Name: \(firstName) \(lastName)
            Phone: \(phone)
            Email: \(recipientEmail)
            Message: \(message)
            Booking Information:
            Appointment: \(appointment)
            Service: \(service)
            Products: \(product)
            
            
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

