//
//  OverlayAndBackgroundBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 24.03.2025.
//

import SwiftUI

struct OverlayAndBackgroundBootcamp: View {
    var body: some View {
        Rectangle()
            .fill(Color.pink)
            .frame(width: 100, height: 100)
            .overlay(alignment: .topLeading, content: {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 50, height: 50)
            })
            .background(alignment: .bottomTrailing) {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 150, height: 150)
            }
//        Circle()
//            .fill(Color.pink)
//            .frame(width: 100, height: 100)
//            .overlay(
//                Text("Overlay")
//                    .font(.title)
//            )
//            .background(
//                Circle()
//                    .fill(Color.blue)
//                    .frame(width: 120, height: 120)
//
//            )
//        Text("OverlayAndBackgroundBootcamp")
//            .background(
//                Color.red
//                                LinearGradient(
//                                    gradient: Gradient(colors: [.red, .blue]),
//                                    startPoint: .top,
//                                    endPoint: .bottom
//                                )
//                Circle()
//                    .fill(Color.red)
//                    .frame(width: 200, height: 200)
//            )
    }
}

struct OverlayAndBackgroundBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        OverlayAndBackgroundBootcamp()
    }
}
