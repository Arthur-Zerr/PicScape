//
//  PicScapeNew_Component.swift
//  PicScape
//
//  Created by Arthur Zerr on 17.11.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI

struct PicScapeNew_Component: View {
    var pictureData: Picture_Model
    var body: some View {
        pictureData.featureImage?.resizable().aspectRatio( contentMode: .fit)
    }
}

struct PicScapeNew_Component_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeNew_Component(pictureData: PicScapeNewData[1])
    }
}
