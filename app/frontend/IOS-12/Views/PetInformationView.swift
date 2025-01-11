//
//  PetInformationView.swift
//  IOS-12
//
//  Created by Feyza Serin on 09.12.24.
//

import SwiftUI

struct PetFormView: View {
    
    
    @Binding var picture: Image?
    @Binding var petName: String
    @Binding var selectedPetType: String
    @Binding var breed: String
    @Binding var showingImageSourceActionSheet: Bool
    @Binding var showingImagePicker: Bool
    @Binding var imageSource: UIImagePickerController.SourceType
    @Binding var inputImage: UIImage?
    @Binding var gender: Bool
    @Binding var feeInput: String
    @Binding var feeValue: Double
    @Binding var fee: String
    @Binding var birthday: Date
    @Binding var description: String
    
    var petTypes: [String]

    var loadImage: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Section {
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
                                    showingImageSourceActionSheet = true
                                }
                        }
                    }
                    .padding()

                    VStack {
                        TextField("Pet Name", text: $petName)
                            .padding()
                            .frame(width: 150)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)

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

                        TextField("Breed", text: $breed)
                            .padding()
                            .frame(width: 150)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                }
            }

            HStack {
                TextField("Fee", text: $feeInput)
                    .keyboardType(.decimalPad)
                    .onChange(of: feeInput) { newValue in
                        if let doubleValue = Double(newValue) {
                            feeValue = doubleValue
                            fee = String(format: "%.2f", feeValue)
                        } else {
                            feeValue = 0.0
                            fee = "0.0"
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .frame(width: 90)
                Text("€")
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)

                DatePicker("Birthday", selection: $birthday, in: ...Date(), displayedComponents: .date)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .frame(width: 240)
            }

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
        }
        .confirmationDialog("Select Image Source", isPresented: $showingImageSourceActionSheet) {
            Button("Take a photo") {
                imageSource = .camera
                showingImagePicker = true
            }
            Button("Choose from Library") {
                imageSource = .photoLibrary
                showingImagePicker = true
            }
            Button("Cancel", role: .cancel) {}
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage, sourceType: imageSource)
        }
    }
}
