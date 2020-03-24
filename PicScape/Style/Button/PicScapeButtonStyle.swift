//
//  ButtonStyle.swift
//  PicScape
//
//  Created by Arthur Zerr on 16.03.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation
import SwiftUI

struct PicScapeButtonStyle : ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(Color("ButtonFontColor"))
            .background(Color("ButtonColor"))
            .cornerRadius(8)
            .padding(.horizontal, 5)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Test",action: {
            print("")
        }).buttonStyle(PicScapeButtonStyle())
    }
}
