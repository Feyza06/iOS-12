//
//  PetInformationView.swift
//  IOS-12
//
//  Created by Feyza Serin on 09.12.24.
//

import SwiftUI

struct PetInformationView: View {
    @Binding var petName: String
    @Binding var gender: Bool
    @Binding var fee: String
    let petTypes: [String]
    @Binding var selectedPetType: String
    @Binding var breed: String
    @Binding var birthday: Date

    var body: some View {
        Section(header: Text("Pet Information")
            .font(.headline)
            .foregroundColor(Color(red: 0.55, green: 0.27, blue: 0.07))) {
            // Pet Name
            TextField("Pet Name", text: $petName)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)

            // Gender Picker
            Picker("Gender", selection: $gender) {
                Text("Male").tag(true)
                Text("Female").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, 10)

            // Fee and Pet Type
            HStack(spacing: 20) {
                // Fee with € symbol
                HStack {
                    TextField("Fee", text: $fee)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .frame(width: 120) // Adjust width as needed
                    Text("€")
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                }

                // Pet Type Picker
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
                        Text(selectedPetType.isEmpty ? "Select Pet Type" : selectedPetType)
                            .foregroundColor(selectedPetType.isEmpty ? .gray : .black)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
            }

            // Breed
            TextField("Breed", text: $breed)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)

            // Birthday
            DatePicker("Birthday", selection: $birthday, in: ...Date(), displayedComponents: .date)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
    }
}

struct PetInformationView_Previews: PreviewProvider {
    static var previews: some View {
        PetInformationView(
            petName: .constant("Buddy"),
            gender: .constant(true),
            fee: .constant("100"),
            petTypes: ["Dog", "Cat", "Bird", "Fish", "Other"],
            selectedPetType: .constant("Dog"),
            breed: .constant("Golden Retriever"),
            birthday: .constant(Date())
        )
    }
}
