//
//  ServicesView.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-10.
//

import SwiftUI

struct ServicesView: View {
    
    @StateObject var viewModel = ServicesViewModel()
    @StateObject var emailViewModel = PopUpEmailViewModel()
    @State var showPopup = false
//    @State var showMailView = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(viewModel.services){ service in
                    ZStack(alignment: .bottom) {
                        HStack{
                            Text("\(service.name)")
                            Spacer()
                            VStack{
                                Text("\(service.price) kr")
                                Text("Price")
                            }
                            .font(.caption)
                            
                        }
                        .padding(15)
                        Text("Estimated Time: 3h")
                            .font(.caption)
                            .offset(x: 5,y:5)
                    }
                }
            }
        }
        .toolbar{
            
            ToolbarItem(placement: .bottomBar){
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showPopup.toggle()
                    }) {
                        Image(systemName: "envelope.circle")
                            .font(.largeTitle)
                            .foregroundStyle(Color.yellow)
                }
                }
            }
                
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
        
        
        
    }
}
#Preview {
    NavigationStack{
        ServicesView()}
}


