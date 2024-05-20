//
//  ServicesView.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-10.
//

import SwiftUI

struct ServicesView: View {
    
    @StateObject var viewModel = ServicesViewModel()
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(0..<10, id: \.self){ i in
                    ZStack(alignment: .bottom) {
                        HStack{
                            Text("\(i+1) \(Service.MOCK_SERVICE.name)")
                            Spacer()
                            VStack{
                                Text("\(Service.MOCK_SERVICE.price)")
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
            .toolbar{
                if viewModel.isAdminLoggedIn {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("Add item to firebase")
                        } label: {
                            Text("Add Service")
                                .foregroundColor(.yellow)
                        }
                        
                    }
                }
            }
        }
    }
}
/*
#Preview {
    ServicesView()
}
*/
