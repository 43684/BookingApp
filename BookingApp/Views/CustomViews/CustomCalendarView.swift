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
 
    @State var days: [Date] = []
    @State private var showingAlert = false
    @State var service = AppointmentService()
    @State var appointments : [Appointment] = []
    @State private var selectedItem: Appointment?
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
                            Task{
                         do{
                             appointments = try await fetchAppointments()
                            appointments = filterAppointments(values: appointments, date: day)
                            // print(appointments)
                                showingAlert = true
                         }catch{
                             print("Fail to fetch appointments")
                         }
                     }
                            print("Date selected \(day)")
                          
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
            List(appointments, id: \.self){ item in
                Button(action: {
                    self.selectedItem = item
                    print("Selected Item \(item)")
                }){
                    Text(item.time)
                    Text("\(item.day.dayOfMonth)")
                }
                .alert(item: $selectedItem){ selectedItem in
                    Alert(title: Text("Sel Item"),
                          message: Text("???"),
                          primaryButton: .default(Text("Book time")),
                        secondaryButton: .default(Text("Cancel"))
                                        )
                }
            }
        
    }
    
    func fetchAppointments() async throws -> [Appointment]
    {
        return try await AppointmentService.fetchAppointments()
    }
   func filterAppointments(values:[Appointment], date :Date) -> [Appointment]
    {
        let calleKallender = Calendar.current
        let month = calleKallender.component(.month, from: date)
        let day = calleKallender.component(.day, from: date)
        return values.filter{$0.day.dayOfMonth == day && $0.day.monthValue == month}
    }
}
#Preview {
    CustomCalendarView()
}
