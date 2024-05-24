//
//  BookingCompleteView.swift
//  BookingApp
//
//  Created by Joakim.Bjärkstedt on 2024-05-21.
//

import SwiftUI

struct BookingCompleteView: View {
    var body: some View {
        
        VStack{
            //First box
            ZStack{
                RoundedRectangle(cornerRadius: 25.0 )
                    .foregroundColor(.orange)
                ZStack{
                    Color.black
                        .border(Color(hex:0xD3BD9C))
                        .cornerRadius(10.0)
                    HStack {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .border(Color.white)
                            .cornerRadius(5)
                        Text("Your booking has been sent to the studio.")
                            .foregroundColor(.white)
                    }
                    
                }
            }.frame(width: 380,height: 100)
                .padding(15)
            //Second box
            ZStack{
                RoundedRectangle(cornerRadius: 25.0 )
                    .foregroundColor(.orange)
                ZStack{
                    Color.black
                        .border(Color(hex:0xD3BD9C))
                        .cornerRadius(10.0)
                    
                    HStack {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .border(Color.white)
                            .cornerRadius(5)
                        
                        Text("You can see your receipt in your e-mail.")
                            .foregroundColor(.white)
                    }
                }
            }.frame(width: 380,height: 100)
                .padding(15)
            //Third box
            ZStack{
                RoundedRectangle(cornerRadius: 25.0 )
                    .foregroundColor(.orange)
                ZStack{
                    Color.black
                        .border(Color(hex:0xD3BD9C))
                        .cornerRadius(10.0)
                    HStack {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .border(Color.white)
                            .cornerRadius(5)
                        
                        Text("if you have questions contact the studio.")
                            .foregroundColor(.white)
                    }
                }
            }.frame(width: 380,height: 100)
                .padding(15)
            
            VStack{
                                AnimationView(fileName: "congratulations")
                
            }

            Spacer()
                

        }
        .background(Color.black)
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
