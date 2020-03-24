//
//  ObservableArray.swift
//  PicScape
//
//  Created by Arthur Zerr on 03.03.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation
import Combine

class ObservableArray<T>: ObservableObject {

  var cancellables = [AnyCancellable]()
  
  @Published var array:[T] = []
  
  init(array: [T])  {
    self.array = array
  }
  
  func observeChildrenChanges<T: ObservableObject>() -> ObservableArray<T> {
        let array2 = array as! [T]
        array2.forEach({
            let c = $0.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() })
            self.cancellables.append(c)
        })
        return self as! ObservableArray<T>
   }
}
