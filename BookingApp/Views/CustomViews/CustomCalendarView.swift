//
//  CustomCalendarView.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-13.
//

import SwiftUI


struct CustomCalendarView: View {
    
    var viewModel = CalenderViewModel()
    @State var date = Date.now
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating:GridItem(.flexible()),count: 7)
    let size : CGFloat = 320
    
    /**
     */
    
    
    
    
    @State var days: [Date] = []
    @State private var showingAlert = false
    
    
    var body: some View {
        VStack(alignment:.center,spacing:-0) {
            
            VStack {
                
                HStack() {
                    ForEach(daysOfWeek.indices, id: \.self) { index in
                        Text(daysOfWeek[index])
                            .fontWeight(.black)
                            .frame(maxWidth:.infinity)
                    }
                }
                
                LazyVGrid(columns: columns,spacing: 10) {
                    
                    ForEach(days, id: \.self) { day in
                        Button {
                            print("Date selected \(day)")
                         //   viewModel.showAvailableTimes()
                            self.showingAlert = true
                            print(showingAlert)
                        }
                    label: {
                            Text(day.formatted(.dateTime.day()))
                                .fontWeight(.black)
                                .frame(maxWidth:.infinity ,minHeight: 40)
                               // .opacity(day < date.startOfMonth ? 0 : 1)
                                
                                .background {
                                    if Date.now.startOfDay == day.startOfDay{
                                        Circle()
                                            .stroke(Color.black, lineWidth: 2)
                                    }
                                }
                            
                        }
                    .alert(isPresented: $showingAlert) {
                                  Alert(title: Text("Alert"), message: Text("This is a dialog"), dismissButton: .default(Text("OK")))
                              }
                          
                    .disabled(Date.now.startOfDay > day.startOfDay)
                        
                    }
                }
                
                
            }
            .padding(.horizontal)
            .frame(width: size)
            .padding()
            .onAppear(perform: {
                days = date.calendarDisplayDays
            })
            .onChange(of: date) {
                days = date.calendarDisplayDays
                
            }
            
        }
        .frame(width: size)
        .padding(.vertical, 10)
        .background{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.yellow.opacity(1))
                .stroke(Color.white.opacity(1),lineWidth: 2)
            
        }
        
        
    }
}

#Preview {
    CustomCalendarView()
}
