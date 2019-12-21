//
//  PicScapeListView.swift
//  PicScape
//
//  Created by Arthur Zerr on 17.11.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI

struct PicScapeListView: View {
    var body: some View {
        ZStack{
            ScrollView{
                ForEach(PicScapeData){ picscapedata in
                    Spacer()
                    Spacer()
                    Picture_Component(pictureData: picscapedata, ShowInfo: true)
                    Spacer()
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct PicScapeListView_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeListView()
    }
}
