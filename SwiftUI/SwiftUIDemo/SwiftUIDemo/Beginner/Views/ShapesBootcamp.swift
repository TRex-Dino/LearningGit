//
//  ShapesBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 22.03.2025.
//

import SwiftUI

struct ShapesBootcamp: View {
    var body: some View {
//        Circle()
//        Ellipse()
//        Capsule()
//        Rectangle()
        RoundedRectangle(cornerRadius: 20)
//            .fill(Color.red)
//            .foregroundStyle(.black)
//            .stroke()
//            .stroke(lineWidth: 30)
//            .stroke(.red, style: StrokeStyle(lineWidth: 30, lineCap: .butt, dash: [30, 10, 20]))
//            .trim(from: 0, to: 0.7)
//            .stroke(lineWidth: 30)
            .frame(width: 300, height: 200)
    }
}

struct ShapesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ShapesBootcamp()
    }
}

