//
//  ContentView.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-03.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack(alignment:.top){
                Color.black.edgesIgnoringSafeArea(.all)
                Image("Icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(50)
                    
                /*if viewModel.isAdminLoggedIn {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Text("Sign out")
                    }

                }*/
                ServicesView()
            }
            .onLongPressGesture(minimumDuration: 10) {
                if !viewModel.isAdminLoggedIn{
                    viewModel.showLogginPage.toggle()
                }
            }
            .toolbar{
                if viewModel.isAdminLoggedIn {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        /*Button {
                            AuthService.shared.signOut()
                        } label: {
                            Text("Sign out")
                                .foregroundColor(.yellow)
                        }*/
                        NavigationLink(destination: AdminView()) {
                            Image(systemName: "doc.badge.gearshape.fill")
                                
                        }
                        
                    }
                }
            }
            .fullScreenCover(isPresented: $viewModel.showLogginPage, content: {
                SignInView()
            })

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
