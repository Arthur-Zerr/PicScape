//
//  PicScapeTextField.swift
//  PicScape
//
//  Created by Arthur Zerr on 16.03.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import SwiftUI

struct PicScapeTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}

struct PicScapeTextField_Previews: PreviewProvider {
    @State static var text : String = ""
    static var previews: some View {
        PicScapeTextField(placeholder: Text("placeholder").foregroundColor(.red),
            text: $text
        )
    }
}
