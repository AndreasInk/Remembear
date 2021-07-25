//
//  ButtonStyle.swift
//  ButtonStyle
//
//  Created by Andreas on 7/24/21.
//

import SwiftUI

struct BlueStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.custom("Montserrat-SemiBold", size: 15, relativeTo: .subheadline))
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color("Primary"))
            //.background(configuration.isPressed ? Color.buttonPressedBlue:Color.buttonBlue)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color:Color("Primary").opacity(0.3), radius: 10)
            .shadow(color: Color("Primary").opacity(configuration.isPressed ? 0 : 0.6), radius: 3, x: 3, y: 3)
            //.animation(.default)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .animation(.easeOut(duration: 0.2))

    }
}
