//
//  FrameBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 23.03.2025.
//

import SwiftUI

struct FrameBootcamp: View {
    var body: some View {
        Text("Frame Text")
            .frame(width: 100)
            .background(Color.blue)
            .frame(height: 100)
            .background(Color.green)
            .frame(width: 300)
            .background(Color.white)
//            .frame(minWidth: <#T##CGFloat?#>, idealWidth: <#T##CGFloat?#>, maxWidth: <#T##CGFloat?#>, minHeight: <#T##CGFloat?#>, idealHeight: <#T##CGFloat?#>, maxHeight: <#T##CGFloat?#>, alignment: <#T##Alignment#>)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//            .frame(width: 200, height: 200, alignment: .bottom)
            .background(Color.red)
    }
}

struct FrameBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FrameBootcamp()
    }
}
