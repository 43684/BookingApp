//
//  CustomCalendarView.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-13.
//

import SwiftUI


struct CustomCalendarView: View {
    @State var date = Date.now
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating:GridItem(.flexible()),count: 7)
    let size : CGFloat = 320
 
    @State var days: [Date] = []
    @State private var showingAlert = false
    @State var service = AppointmentService()
    @State private var appointments : [Appointment] = []
    @State private var selectedItem: Appointment?
    @State private var timeBooked = false
    @StateObject var viewModel = ConfirmViewModel()
    var body: some View {
        NavigationStack{
            VStack{
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
                      
                    Text(item.time)
                            .onTapGesture{
                            saveAppointment(appointment: item)
                        }
                        /*  NavigationLink(destination: ConfirmView(), isActive: $timeBooked){
                         EmptyView()
                         }.hidden()*/
                    }
                Button("Next"){
                   // saveAppointment(appointment: item)
                    timeBooked = true
                }
                .navigationDestination(isPresented: $timeBooked, destination: {
                            ConfirmView()
                        })
            }
        }
    }
    func saveAppointment(appointment: Appointment)
    {
        let defaults = UserDefaults.standard
        defaults.set(appointment.booked, forKey: "appointmentBooked")
        defaults.set(appointment.time, forKey: "appointmentTime")
        defaults.set(appointment.year, forKey: "appointmentYear")
        defaults.set(appointment.day.dayOfMonth, forKey: "appointmentDay")
        defaults.set(appointment.day.monthValue, forKey: "appointmentMonthValue")
        defaults.set(appointment.day.month, forKey: "appointmentMonth")
        UserDefaults.standard.synchronize()
        print("Hello")
    }
    func fetchAppointments() async throws -> [Appointment]
    {
        return try await AppointmentService.fetchAppointments()
    }
   func filterAppointments(values:[Appointment], date :Date) -> [Appointment]
    {
        let calender = Calendar.current
        let month = calender.component(.month, from: date)
        let day = calender.component(.day, from: date)
        return values.filter{$0.day.dayOfMonth == day && $0.day.monthValue == month
            && $0.booked == false}
    }
}
#Preview {
    NavigationView{
        CustomCalendarView()
    }
}
