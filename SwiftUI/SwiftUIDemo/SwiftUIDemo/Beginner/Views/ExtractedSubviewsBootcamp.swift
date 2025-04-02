//
//  ExtractedSubviewsBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 03.04.2025.
//

import SwiftUI

struct ExtractedSubviewsBootcamp: View {
    @State private var backgroundColor: Color = .blue

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea(edges: .all)
            VStack(spacing: 20) {

                ExtractedSubviewsNewElement(CircleColor: .red)


                HStack {
                    Button("Button 1") {
                        backgroundColor = .red
                    }

                    Button("Button 2") {
                        backgroundColor = .green
                    }

                }

            }
            .foregroundStyle(.white)
        }
    }
}

struct ExtractedSubviewsNewElement: View {
   let CircleColor: Color

    var body: some View {
        HStack {
            Circle()
                .fill(CircleColor)
                .frame(width: 100, height: 100)
            
            Text("Title")
                .font(.title)
            
            Text("Sub title")
        }
    }
}

struct ExtractedSubviewsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ExtractedSubviewsBootcamp()
    }
}
