//
//  BookingCompleteView.swift
//  BookingApp
//
//  Created by Joakim.Bjärkstedt on 2024-05-21.
//

import SwiftUI

struct BookingCompleteView: View {
    var body: some View {
        
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
                
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
        .background(Color.black)
    }
}


#Preview {
    BookingCompleteView()
}
