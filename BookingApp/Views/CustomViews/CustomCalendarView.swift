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
    @State private var filteredAppointments : [Appointment] = []
    @State private var selectedItem: Appointment?
    @State private var timeBooked = false
    @StateObject var viewModel = ConfirmViewModel()
    @State var i : Int = 0
    @StateObject var emailViewModel = PopUpEmailViewModel()
    @State var showPopup = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer(minLength: 30)
                VStack(alignment:.center,spacing:-0) {
                    
                    VStack {
                        
                        HStack() {
                
                            ForEach(daysOfWeek.indices, id: \.self) { index in
                                    Text(daysOfWeek[index])
                                        .fontWeight(.black)
                                        .frame(maxWidth:.infinity)
                                
                            }
                
                        }.onAppear(){
                            Task{
                                appointments = try await fetchAppointments()
                                print("got me some appointments!")
                              //  print(a)
                            //    myFunction(a: a)
                            }
                        }
                        .foregroundStyle(Color.white)
                        LazyVGrid(columns: columns,spacing: 10) {
                            ForEach(days, id: \.self) { day in
                                Button {
                                    Task{
                                        do{
                                            appointments = try await fetchAppointments()
                                            filteredAppointments = filterAppointments(values: appointments, date: day)
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
                                                .stroke(Color(hex: "#D3BD9C"),  lineWidth: 2)
                                        }
                                    }
                                    .accentColor(Color(hex:"#D3BD9C"))
                                
                            }
                        
                            .disabled(Date.now.startOfDay > day.startOfDay ||
                                      hasAvailableTimes(date: day) == false)
                        
                        
                                
                            
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
                        .fill(Color.black.opacity(1))
                        .stroke(Color.white.opacity(1),lineWidth: 2)
                    
                }
             
                
                    List(filteredAppointments, id: \.self){ item in
                          
                        
                            Text(String(item.time))
                                
                                
                                    .onTapGesture{
                                    saveAppointment(appointment: item)
                                    selectedItem = item
                                }
                                    .frame(maxWidth: .infinity, maxHeight: 70, alignment: .center)                                    .background(selectedItem == item ? Color(hex: "#9B7A46" ) : Color.clear)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .listRowInsets(EdgeInsets())
                                .listRowBackground(Color.black)
                        
                                
                        
                            /*  NavigationLink(destination: ConfirmView(), isActive: $timeBooked){
                             EmptyView()
                             }.hidden()*/
                    }
                
                   
                    
                    
                Button("NEXT"){
                              timeBooked = true

                            }.padding()
                                .font(.title3)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color(hex: "#D3BD9C"), Color(hex: "#6D6355")]), startPoint: .leading, endPoint: .trailing))
                                .foregroundColor(Color(hex: "#131D54"))
                                .cornerRadius(15)
                                .bold()

                            HStack {
                                Spacer()
                                ZStack {
                                    Button {
                                        showPopup.toggle()
                                    } label: {
                                        Image(systemName: "envelope")
                                            .foregroundColor(.black)
                                            .padding(12)
                                            .background(
                                                LinearGradient(gradient: Gradient(colors: [Color(hex: "#D3BD9C"), Color(hex: "#6D6355")]), startPoint: .leading, endPoint: .trailing))
                                            .clipShape(Circle())
                                    }
                                }.frame(width: 60, height: 60)
                                    .offset(x: -10)
                            }.padding()
//                .navigationDestination(isPresented: $timeBooked, destination: {
//                            ConfirmView()
//                        })
                
            }
            .sheet(isPresented: $showPopup){
                        EmailPopupView(showPopup: $showPopup)
                            .environmentObject(emailViewModel)
                    }
                    .alert(isPresented: $emailViewModel.showAlert){
                        Alert(title: Text("Message"), message: Text(emailViewModel.alertMessage ?? ""), dismissButton: .default(Text("OK")))
                    }
                    .sheet(isPresented: $emailViewModel.isShowingMailView){
                        MailView(viewModel: emailViewModel)
                    }
                    .navigationTitle("Vacant time")
                        .navigationDestination(isPresented: $timeBooked, destination: {
                            ConfirmView()
                        })
                        .background(.black)
                        .scrollContentBackground(.hidden)
            
        }
    }
    func hasAvailableTimes(date: Date)-> Bool{
        var result = false
        //create list of appointments on one day
        let calender = Calendar.current
        let day = calender.component(.day, from: date)
        var dayly = appointments.filter{$0.day.dayOfMonth == day}
        print(dayly)
        
        dayly.forEach(){ item in
            if(item.booked == false)
            {
                print("!")
            result = true
            }
        }
        
        return result
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
