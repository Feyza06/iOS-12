import SwiftUI

struct MessageField: View {
    @State private var message = ""
    var onSend: (String) -> Void

    var body: some View {
        HStack {
            Button {
                print("Select file")
                message = ""
            } label: {
                Image(systemName: "folder")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color(red: 0.55, green: 0.27, blue: 0.07))
                    .cornerRadius(50)
            }
            
            CustomTextField(placeholder: Text("Your message"), text: $message)
                .frame(height: 70)
                .padding(.horizontal, 10)
            
            Button {
                if !message.trimmingCharacters(in: .whitespaces).isEmpty {
                    onSend(message)
                    message = "" 
                }
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color(red: 0.55, green: 0.27, blue: 0.07))
                    .cornerRadius(50)
            }
        }
        .frame(maxWidth: 330)
        .padding(.horizontal)
        .background(Color(.gray).opacity(0.5))
        .cornerRadius(35)
        .ignoresSafeArea(edges: .bottom)
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField { _ in }
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

