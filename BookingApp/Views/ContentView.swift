//
//  ContentView.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-03.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @State private var navigateToServicesView = false
    @State var servicesView = ServicesView()
    @State var isChecked: Bool = true
    
    
    var body: some View {
        NavigationStack{
            ZStack(alignment:.top){
                Color.black.edgesIgnoringSafeArea(.all)
                
                Text("Welcome to\nBjaerk  Studio!")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(
                        LinearGradient(gradient: Gradient(colors: [Color(hex: "#D3BD9C"), Color(hex: "#6D6355")]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: 300, height:100, alignment: .center)
                    .font(.title)
                    .padding(150)
              
               Image("Icon")
                    .resizable()
                    //.aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(300)
                    .onTapGesture {
                     //navigateToServicesView = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                            self.navigateToServicesView = true
                        }
                        
                        withAnimation(Animation.easeInOut(duration: 1)){
                            isChecked.toggle()
                        }
                    }.rotation3DEffect(
                        Angle(degrees: (isChecked ? 360 : 0)),
                        axis: (x: 0, y: 1, z: 0))
                    /*if viewModel.isAdminLoggedIn {
                     Button {
                     AuthService.shared.signOut()
                     } label: {
                     Text("Sign out")
                     }
                     }*/
                }
                .onLongPressGesture(minimumDuration: 2) {
                    if !viewModel.isAdminLoggedIn{
                        viewModel.showLogginPage.toggle()
                    }
                }
                .toolbar{
                    if viewModel.isAdminLoggedIn {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: AdminView()) {
                                Image(systemName: "doc.badge.gearshape.fill")
                            }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                AuthService.shared.signOut()
                            } label: {
                                Text("Sign out")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                .fullScreenCover(isPresented: $viewModel.showLogginPage, content: {
                    SignInView()
                })
                .navigationDestination(isPresented: $navigateToServicesView) {
                    ServicesView()
                }
        }
    }
}


#Preview {

        ContentView()
    
}




/*
 Group {
     
     if viewModel.isAdminLoggedIn {
         Button {
             AuthService.shared.signOut()
         } label: {
             Text("Sign out")
         }

     } else {
         SignInView()
     }
 }
 */
