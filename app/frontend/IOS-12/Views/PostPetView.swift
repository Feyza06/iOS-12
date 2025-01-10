//
//  PostPetView.swift
//  IOS-12
//
//  Created by Feyza Serin on 11.11.24.
//

// PostPetView.swift

import SwiftUI
import MapKit
import CoreLocation



struct PostPetView: View {
    @StateObject private var appState = AppState()
    
    // MARK: - Pet Details
    @State private var petName = ""
    @State private var gender = true // true = Male, false = Female
    @State private var fee = ""
    @State private var feeValue: Double = 0.0
    @State private var feeInput: String = ""
    let petTypes = ["Dog", "Cat", "Bird", "Fish", "Other"]
    @State private var selectedPetType = ""
    @State private var breed = ""
    @State private var birthday = Date()
    @State private var description = ""
    
    // MARK: - Image Handling
    @State private var picture: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var showingImageSourceActionSheet = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    
    // MARK: - Map Handling
    @State private var addressString = ""

    
    // MARK: - Message Overlay
    @State private var isOverlayVisible: Bool = false
    @State private var overlayMessage: String = ""
    @State private var overlayType: MessageOverlay.OverlayType = .success
    
    @Environment(\.dismiss) var dismiss
    

   
    // MARK: - Status Message
    @State private var statusMessage: String?
    @State private var isSuccess: Bool?
    @State private var navigateToPosts: Bool = false
    
    @StateObject private var viewModel = PostViewModel()
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        
                        // MARK: - Pet Photo Section
                        Section() {
                            HStack(alignment: .center, spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(Color(white: 0.9))
                                        .frame(height: 150)
                                    if let picture = picture {
                                        picture
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 150, height: 150)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle().stroke(Color.white, lineWidth: 4)
                                            )
                                            .shadow(radius: 5)
                                    } else {
                                        Text("Upload a picture")
                                            .foregroundColor(.gray)
                                            .onTapGesture {
                                                //showingImagePicker = true
                                                showingImageSourceActionSheet = true
                                            }
                                    }
                                }
                                .padding()
                                
                                // MARK: Pet name, type, and breed inputs
                                VStack{
                                    // Pet Name
                                    TextField("Pet Name", text: $petName)
                                        .padding()
                                        .frame(width: 150)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                    
                                    // Pet Type Dropdown
                                    Menu {
                                        ForEach(petTypes, id: \.self) { type in
                                            Button(action: {
                                                selectedPetType = type
                                            }) {
                                                Text(type)
                                            }
                                        }
                                    } label: {
                                        HStack {
                                            Text(selectedPetType.isEmpty ? "Pet Type" : selectedPetType)
                                                .foregroundColor(selectedPetType.isEmpty ? .gray : .black)
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(.gray)
                                        }
                                        .padding()
                                        .frame(width: 150)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                    }
                                    
                                    // Pet Breed
                                    TextField("Breed", text: $breed)
                                        .padding()
                                        .frame(width: 150)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                }
                            }
                            // Image picker actions
                            .confirmationDialog("Select Image Source", isPresented: $showingImageSourceActionSheet){
                                Button("Take a photo"){
                                    imageSource = .camera
                                    showingImagePicker = true
                                }
                                Button("Choose from Library") {
                                    imageSource = .photoLibrary
                                    showingImagePicker = true
                                }
                                Button("Cancel", role: .cancel) {}
                            }
                            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage ){
                                ImagePicker(image: $inputImage, sourceType: imageSource)
                            }
                        }
                       
                        // MARK: - Gender Picker
                        Picker("Gender", selection: $gender) {
                            Text("Male").tag(true) // Male option
                            Text("Female").tag(false) // Female option
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .accentColor(gender ? Color.blue : Color.pink) // Change color dynamically
                        .frame(width: 360) 
                        .padding(.bottom, 10)
                        
                        // MARK: - Fee and Birthday Inputs
                        HStack{
                            HStack {
                                // Fee input
                                TextField("Fee", text: $feeInput)
                                    .keyboardType(.decimalPad)
                                    .onChange(of: feeInput) { newValue in
                                        if let doubleValue = Double(newValue) {
                                            feeValue = doubleValue
                                            fee = String(format: "%.2f", feeValue) // Sync back to parent
                                        } else {
                                            feeValue = 0.0
                                            fee = "0.0"
                                        }
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                    .frame(width: 90) // Adjust width as needed
                                Text("€")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                            
                            // Birthday input
                            DatePicker("Birthday",selection: $birthday, in: ...Date(), displayedComponents: .date)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .frame(width: 240)
                            
                        }
                        
                        // MARK: - Description
                        Text("Describe your pet and preferred home:")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))
                            .padding(.top, 10)
                        
                        TextEditor(text: $description)
                            .padding()
                            .frame(height: 130)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
            
                        // MARK: - Map and Address
                            Text("Enter your address:")
                                .font(.headline)
                                .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))
                                .padding(.top, 10)
                            
                            MapViewContainer(addressString: $addressString)
                                .frame(width: 370, height: 300)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                .padding(.top, 0)
                                .padding(.bottom, 30)
        
                        // MARK: - Upload Button
                        Button(action: {
                            
                            validateFields()
                            if !isSuccess! {
                                // Show error message and don't proceed
                                overlayMessage = "Missing fields! Please complete all required fields."
                                overlayType = .error
                                withAnimation{
                                    isOverlayVisible = true
                                }
                                return
                            }
                            
                            // Fetch the userId from Keychain
                            guard let userIdData = KeychainHelper.standard.read(service: "userService", account: "userId"),
                                  let userId = String(data: userIdData, encoding: .utf8) else {
                                print("Error: userId not found in Keychain")
                                return
                            }
                            
                            viewModel.uploadPost(
                                postRequest: PostRequest(
                                    petName: petName,
                                    fee: Double(fee) ?? 0.0,
                                    gender: gender ? "Male" : "Female",
                                    petType: selectedPetType,
                                    petBreed: breed,
                                    birthday: birthday,
                                    description: description,
                                    location: addressString,
                                    hasPhoto: inputImage != nil,
                                    userId: userId 
                                ),
                                photo: inputImage
                                
                            ){ result in
                                switch result {
                                case .success:
                                    overlayMessage = "Post uploaded successfully!"
                                    overlayType = .success
                                    isSuccess = true
                                    print("Post uploaded successfully.")
                                case .failure(let error):
                                    overlayMessage = "Failed to upload post: \(error.localizedDescription)"
                                    overlayType = .error
                                    isSuccess = false
                                    print("Failed to upload post: \(error.localizedDescription)")
                                }
                                withAnimation {
                                    isOverlayVisible = true
                                }
                            }
                        }) {
                            Text("Upload")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.55, green: 0.27, blue: 0.07))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }
                           
                    }
                    .padding()
                    
                
                    }
                // Display status message at the top center of the screen
                if isOverlayVisible {
                    MessageOverlay(
                        isVisible: $isOverlayVisible,
                        message: overlayMessage,
                        type: overlayType,
                        onSuccess: {
                            if overlayType == .success{
                                navigateToPosts = true
                            }
                        })
                }
                
                NavigationLink(
                    destination: MainView(),
                    isActive: $navigateToPosts
                ){
                   EmptyView()
                }
                }
                .navigationTitle("Post Pet")
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: $inputImage)
                }
            }
           
        }
        
        
    
    
    // MARK: - Helper Functions
    
    /// Validates input fields before uploading
    func validateFields() {
        if petName.isEmpty || fee.isEmpty || description.isEmpty || selectedPetType.isEmpty {
                    statusMessage = "All fields must be filled!"
                    isSuccess = false
                } else {
                    isSuccess = true // Valid fields
                }
    }
    
    /// Loads the selected image
    func loadImage() {
        guard let inputImage = inputImage else { return }
        picture = Image(uiImage: inputImage)
    }
    
}

struct PostPetView_Previews: PreviewProvider {
    static var previews: some View {
        PostPetView()
    }
}
