//
//  StacksBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 24.03.2025.
//

import SwiftUI

struct StacksBootcamp: View {
    // VStack -> Vertical
    // ZStack -> Horizontal
    // ZStack -> zIndex (back to front) 
    var body: some View {
//        VStack {
//            Rectangle()
//                .fill(Color.pink)
//                .frame(width: 100, height: 100)
//            Rectangle()
//                .fill(Color.blue)
//                .frame(width: 100, height: 100)
//        }

//        HStack {
//            Rectangle()
//                .fill(Color.pink)
//                .frame(width: 100, height: 100)
//            Rectangle()
//                .fill(Color.blue)
//                .frame(width: 100, height: 100)
//        }

        ZStack {
            Rectangle()
                .fill(Color.pink)
                .frame(width: 100, height: 100)
            Rectangle()
                .fill(Color.blue)
                .frame(width: 50, height: 100)
        }
    }
}

struct StacksBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        StacksBootcamp()
    }
}
