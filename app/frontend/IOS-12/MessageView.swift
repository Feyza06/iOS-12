import SwiftUI

struct MessageView: View {
    var message: Message
    
    var body: some View {
        if message.received {
            ZStack {
                HStack {
                    Text(message.text)
                        .padding()
                        .frame(maxWidth: 220, alignment: .leading)
                        .background(Color(red:0.55, green:0.27, blue: 0.07))
                        .cornerRadius(25)
                    Image(systemName: "person")
                        .frame(height: 20)
                        .padding(.bottom, 10)
                        .padding(.trailing, 3)
                    }
                .frame(maxWidth: 360, alignment: .trailing)
            }
                } else {
                    ZStack {
                        HStack {
                            Image(systemName: "person")
                                .frame(height: 20)
                                .padding(.bottom, 10)
                                .padding(.trailing, 3)
                            
                            Text(message.text)
                                .padding()
                                .frame(maxWidth: 220, alignment: .leading)
                                .background(Color(red: 0.85, green: 0.70, blue: 0.50))
                                .cornerRadius(25)
                        }
                        .frame(maxWidth: 360, alignment: .leading)
                    }
                }

            }
        }
    

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message(id: "1", text: "Hello", received: false, photoURL: "", timestamp: Date()))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

