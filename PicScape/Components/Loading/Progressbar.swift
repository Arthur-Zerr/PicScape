//
//  Progressbar.swift
//  PicScape
//
//  Created by Arthur Zerr on 25.02.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import SwiftUI

struct Progressbar: View {
    private let value: Double
    private let maxValue: Double = 100
    private let width: Double
    
    init(value: Double, width: Double) {
        self.value = value
        self.width = width
    }
    
    var body: some View {
        ZStack(alignment: Alignment.leading) {
            Rectangle()
                .opacity(0.3)
            Rectangle()
                .frame(width: self.progress(value: self.value,
                                            maxValue: self.maxValue,
                                            width: CGFloat(self.width)))
                .opacity(0.6)
                .animation(.easeIn)
        }
        .cornerRadius(5)
    }
    
    private func progress(value: Double,
                          maxValue: Double,
                          width: CGFloat) -> CGFloat {
        let percentage = value / maxValue
        return width *  CGFloat(percentage)
    }
}

struct Progressbar_Previews: PreviewProvider {
    static var previews: some View {
        Progressbar(value: 20, width: 100)
            .frame(height: 10)
            .padding(30)
        
    }
}
