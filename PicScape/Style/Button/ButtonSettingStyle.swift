//
//  ButtonSettingStyle.swift
//  PicScape
//
//  Created by Arthur Zerr on 10.01.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation
import SwiftUI

struct ButtonSettingStyle : ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
          configuration
            .label
              .frame(minWidth: 0, maxWidth: .infinity)
              .padding()
              .foregroundColor(Color("ButtonFontColor"))
        .background(Color("ButtonColor"))
            .padding(.horizontal, 5)
      }
}

struct ButtonSettingStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Test",action: {
            print("")
            }).buttonStyle(ButtonSettingStyle())
    }
}

