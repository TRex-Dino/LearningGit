//
//  GradientsBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 22.03.2025.
//

import SwiftUI

struct GradientsBootcamp: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(
//                LinearGradient(
//                    gradient: Gradient(colors: [.red, .blue]),
//                    startPoint: .top,
//                    endPoint: .bottom
//                )

//                RadialGradient(
//                    gradient: Gradient(colors: [.red, .blue]),
//                    center: .topLeading,
//                    startRadius: 5,
//                    endRadius: 200
//                )

                AngularGradient(
                    gradient: Gradient(colors: [.red, .blue]),
                    center: .topLeading,
                    angle: .degrees(180+45)
                )
            )
            .frame(width: 300, height: 200)
    }
}

struct GradientsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GradientsBootcamp()
    }
}
