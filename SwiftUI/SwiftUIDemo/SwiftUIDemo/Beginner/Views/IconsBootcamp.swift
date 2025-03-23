//
//  IconsBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 23.03.2025.
//

import SwiftUI

struct IconsBootcamp: View {
    var body: some View {
        Image(systemName: "person.badge.plus")
            .renderingMode(.original) // if we use multi color icons
            .resizable() // we need this if we want use frame instead font
            .aspectRatio(contentMode: .fill) // if we use resizable
//            .font(.title)
//            .font(.caption)
//            .font(.system(size: 100))
            .foregroundStyle(
//                                LinearGradient(
//                                    gradient: Gradient(colors: [.red, .blue]),
//                                    startPoint: .top,
//                                    endPoint: .bottom
//                                )
                Color.red
            )
            .frame(width: 200, height: 200)
//            .clipped() // if we use this image can cut, if it does not fit in frame
    }
}

struct IconsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        IconsBootcamp()
    }
}
