//
//  NewServiceView.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-10.
//

import SwiftUI

struct NewServiceView: View {
    @State var newServiceName = ""
    @Environment(\.dismiss ) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30){
                    TextField("Service Name: ", text: $newServiceName)
                        .frame(height: 44)
                        .padding(.leading)
                        .background(Color(.systemGroupedBackground))
                    TextField("Service Price: ", text: $newServiceName)
                        .frame(height: 44)
                        .padding(.leading)
                        .background(Color(.systemGroupedBackground))
                    Button("Add Service") {
                        print("Add service")
                    }
                    .padding()
                }
                .padding(.top, 40)
                .padding()
                
            }
            .navigationTitle("New Service")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    NewServiceView()
}
