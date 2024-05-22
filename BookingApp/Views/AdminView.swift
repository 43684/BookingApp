//
//  AppointmentsView.swift
//  BookingApp
//
//  Created by Gentjan Manuka on 2024-05-14.
//

import SwiftUI
import SDWebImageSwiftUI // Import SDWebImageSwiftUI for loading images from URL

struct AdminView: View {
    
    @ObservedObject var viewModel = AdminViewModel()
    
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    
    var body: some View {
        List {
            Section("Generate appointments for selected date"){
                DatePicker("Please enter a date", selection: $viewModel.date, displayedComponents: .date)
                Button("Generate monthly appointments") {
                    viewModel.createMonthlyAppointmentsFromDate()
                }
                Button("Generate one appointments") {
                    viewModel.createAppointmentFromDate()
                    
                }
            }
            
            Section("Add new Service"){
                TextField(text: $viewModel.serviceName) {
                    Text("Service name")
                }
                TextField(text: $viewModel.servicePrice) {
                    Text("Service price")
                }
                Button("Add Service to database") {
                    viewModel.addNewService()
                }
            }
            
            Section("Services"){
                ForEach(viewModel.services) { service in
                    Text(service.name + " \(service.price)")
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                viewModel.deleteService(service: service)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                        }
                }
            }
            
            
            Section("Add new product"){
                TextField(text: $viewModel.productName) {
                    Text("Product name")
                }
                TextField(text: $viewModel.productPrice) {
                    Text("Product price")
                }
                Button("Select Image") {
                    isImagePickerPresented.toggle()
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(image: $selectedImage)
                }
                Button("Add Product to database") {
                    if let selectedImage = selectedImage,
                       let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
                        print("Image data is valid. Proceeding to add new product.")
                        viewModel.addNewProduct(imageData: imageData)
                    } else {
                        print("Image data is invalid. Cannot add product.")
                    }
                }
            }
            
            Section("Products"){
                ForEach(viewModel.products) { product in
                    HStack {
                        if let imageUrl = product.imageUrl,
                           let url = URL(string: imageUrl) {
                            WebImage(url: url)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        }
                        Spacer()
                        Text(product.name + " \(product.price) kr")
                        Spacer()
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            viewModel.deleteProduct(product: product)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                }
            }
            
            Section("Appointments"){
                ForEach(viewModel.appointments) { appointment in
                    Text("\(appointment.day.dayOfMonth) \(appointment.day.month) \(appointment.time)")
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                        }
                }
            }
        }
    }
}

// ImagePicker is a custom view for selecting images
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
#Preview {
    AdminView()
}
