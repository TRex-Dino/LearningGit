//
//  ButtonsBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 01.04.2025.
//

import SwiftUI

struct ButtonsBootcamp: View {
    enum ButtonType: String, CaseIterable, Identifiable {
        case text, icon, circle, custom
        var id: String { rawValue }
    }

    @State private var buttonType: ButtonType = .text
    @State private var tapCount = 0
    @State private var isToggled = false

    var body: some View {
        VStack(spacing: 30) {
            Text("Тапов: \(tapCount)")
                .font(.title2)
                .bold()

            buttonView()
                .padding()

            Picker("Тип кнопки", selection: $buttonType) {
                ForEach(ButtonType.allCases) { type in
                    Text(type.rawValue.capitalized).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
        .navigationTitle("Buttons")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func buttonView() -> some View {
        switch buttonType {
        case .text:
            Button("Нажми меня") {
                tapCount += 1
            }
            .font(.headline)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

        case .icon:
            Button(action: {
                tapCount += 1
                isToggled.toggle()
            }) {
                Image(systemName: isToggled ? "star.fill" : "star")
                    .font(.system(size: 40))
                    .foregroundStyle(isToggled ? .yellow : .gray)
            }

        case .circle:
            Button(action: {
                tapCount += 1
            }) {
                ZStack {
                    Circle()
                        .fill(Color.purple)
                        .frame(width: 100, height: 100)
                        .shadow(radius: 5)
                    Image(systemName: "heart.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }

        case .custom:
            Button("Кастом") {
                tapCount += 1
            }
            .buttonStyle(BounceButtonStyle())
        }
    }
}

struct BounceButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.gray : Color.green)
            .foregroundColor(.white)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ButtonsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsBootcamp()
    }
}
