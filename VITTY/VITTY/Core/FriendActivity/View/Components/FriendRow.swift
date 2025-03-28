//
//  FriendRow.swift
//  VITTY
//
//  Created by Prashanna Rajbhandari on 19/06/2023.
//

import SwiftUI

@available(iOS 15.0, *)
struct FriendRow: View {
    var body: some View {
        ZStack {
            Color.theme.blueBG
            HStack{
                Circle()
                
                VStack(alignment: .leading){
                    Text("swayam")
                        .font(.custom("Poppins-Bold", size: 15))
                        .foregroundColor(.white)
                        
                    Text("@haveYouMetSam_")
                        .font(.custom("Poppins", size: 15))
                        .foregroundColor(Color.theme.secTextColor)
                }
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 78, height: 32)
                    .foregroundColor(Color.theme.tfBlue)
                    .overlay {
                        Text("View")
                            .font(.custom("Poppins-Medium", size: 14))
                            .foregroundColor(.white)
                    }
            }

        }            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .padding()
            
        
    }
}

@available(iOS 15.0, *)
struct FriendRow_Previews: PreviewProvider {
    static var previews: some View {
        FriendRow()
    }
}
