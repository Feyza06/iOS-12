import SwiftUI

struct ProfileEdit: View {
    @Binding var profileData: UserProfileData
    @Environment(\.presentationMode) var presentationMode
    @State private var isImagePickerPresented = false
    @State private var isCameraPickerPresented = false
    @State private var sourceType: UIImagePickerController.SourceType =
        .photoLibrary
    @State private var selectedImage: UIImage? = nil
    //  @State private var username: String = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Divider()
                    //profilepicture
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                            .shadow(radius: 5)
                            .onTapGesture {
                                isImagePickerPresented = true
                                sourceType = .photoLibrary
                            }

                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .shadow(radius: 5)
                            .clipShape(Circle())
                            .onTapGesture {
                                isImagePickerPresented = true
                                sourceType = .photoLibrary
                            }
                    }

                    // Camera or Gallery Buttons
                    HStack {
                        Button(action: {
                            isImagePickerPresented = true
                            sourceType = .photoLibrary
                        }) {
                            Label("Gallery", systemImage: "photo")
                                .padding()
                                .foregroundColor(
                                    Color(red: 0.55, green: 0.27, blue: 0.07)
                                )
                        }

                        Button(action: {
                            isImagePickerPresented = true
                            sourceType = .camera
                        }) {
                            Label("Camera", systemImage: "camera")
                                .padding()
                                .foregroundColor(
                                    Color(red: 0.55, green: 0.27, blue: 0.07)
                                )
                        }
                    }

                    Divider()

                    // userinfo
                    VStack(spacing: 20) {
                        TextField("Username", text: $profileData.username)
                            .styledTextField()

                        TextField("Firstname", text: $profileData.firstname)
                            .styledTextField()
                        TextField("Lastname", text: $profileData.lastname)
                            .styledTextField()

                    }
                    .padding()

                }

            }
            .background(
                Color(red: 1.0, green: 0.95, blue: 0.9).edgesIgnoringSafeArea(
                    .all)
            )
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        if let selectedImage = selectedImage {
                            profileData.profileImage = selectedImage
                        }
                        presentationMode.wrappedValue.dismiss()  // Schließt die Ansicht und speichert die Daten
                    }
                    .foregroundColor(.blue)
                }
            }
            .sheet(isPresented: $isImagePickerPresented) {
                CustomImagePicker(
                    sourceType: sourceType, selectedImage: $selectedImage)
            }

        }

    }

}

extension View {
    func styledTextField() -> some View {
        self
            .padding()
            .frame(height: 60)
            .background(
                Color.white
                    .cornerRadius(10)
                    .shadow(radius: 5)
            )
    }
}

#Preview {
    ProfileEdit(
        profileData: .constant(
            UserProfileData(
                username: "Username", firstname: "Firstname",
                lastname: "Lastname")))
}
 
