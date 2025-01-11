//
//  DistanceView.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 11.01.25.
//

import SwiftUI

struct DistanceView :View{
    @EnvironmentObject var appState: AppState
    @State private var addressString: String = ""
    
    var body: some View {
        VStack {
                   
            Text("Enter your address:")
                .font(.system(size:23, weight: .bold))
                .foregroundColor(.primaryColor)
            
            
            MapViewContainer(addressString: $addressString)
                .environmentObject(appState)
                .padding()
                    
                Spacer()
        }
        .padding()
    }
    
   
    
}


struct DistanceView_Previews: PreviewProvider {
    static var previews: some View {
        let mockAppState = AppState()
        mockAppState.userId = 3
        
        return DistanceView()
            .environmentObject(mockAppState)
        
    }
}
