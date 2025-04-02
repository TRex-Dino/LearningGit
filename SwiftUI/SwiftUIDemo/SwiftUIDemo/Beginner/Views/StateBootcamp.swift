//
//  StateBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 03.04.2025.
//

import SwiftUI

struct StateBootcamp: View {
    @State private var backgroundColor: Color = .blue

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea(edges: .all)
            VStack(spacing: 20) {

                Text("Title")
                    .font(.title)

                Text("Sub title")


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

struct StateBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        StateBootcamp()
    }
}
