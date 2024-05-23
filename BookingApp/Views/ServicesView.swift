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
    }
}
/*
#Preview {
    ServicesView()
}
*/
