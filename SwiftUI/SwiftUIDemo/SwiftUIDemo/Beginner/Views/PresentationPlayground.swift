//
//  PresentationPlayground.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 24.04.2025.
//

import SwiftUI

struct PresentationPlayground: View {
    @State private var showSheet = false
    @State private var showFullScreen = false

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Button("Открыть Sheet") {
                    showSheet = true
                }
                .buttonStyle(.borderedProminent)

                Button("Открыть FullScreenCover") {
                    showFullScreen = true
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Presented View")
            .sheet(isPresented: $showSheet) {
                PresentedScreen(title: "Sheet")
            }
            .fullScreenCover(isPresented: $showFullScreen) {
                PresentedScreen(title: "Full Screen")
            }
        }
    }
}


struct PresentedScreen: View {
    let title: String
    @Environment(\.dismiss) var dismiss // iOS 15+

    var body: some View {
        ZStack {
            Color.orange.ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Это \(title)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                Button("Закрыть") {
                    dismiss()
                }
                .padding()
                .background(Color.white)
                .foregroundColor(.orange)
                .cornerRadius(12)
            }
        }
    }
}


struct PresentationPlayground_Previews: PreviewProvider {
    static var previews: some View {
        PresentationPlayground()
    }
}
