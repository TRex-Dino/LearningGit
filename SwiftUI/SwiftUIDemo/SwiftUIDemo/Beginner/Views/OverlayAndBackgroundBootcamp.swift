//
//  OverlayAndBackgroundBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 24.03.2025.
//

import SwiftUI

struct OverlayAndBackgroundBootcamp: View {
    enum BaseShape: String, CaseIterable, Identifiable {
        case rectangle, circle, text
        var id: String { rawValue }
    }

    @State private var shape: BaseShape = .rectangle

    @State private var useOverlay = true
    @State private var useBackground = true

    @State private var overlaySize: CGFloat = 50
    @State private var backgroundSize: CGFloat = 150

    @State private var overlayAlignment: AlignmentOption = .defaultOverlay
    @State private var backgroundAlignment: AlignmentOption = .defaultBackground

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Overlay & Background")
                    .font(.title2)
                    .bold()

                ZStack {
                    Color.gray.opacity(0.1)

                    baseView()
                        .if(useOverlay) {
                            $0.overlay(alignment: overlayAlignment.value) {
                                Rectangle()
                                    .fill(Color.black.opacity(0.7))
                                    .frame(width: overlaySize, height: overlaySize)
                            }
                        }
                        .if(useBackground) {
                            $0.background(alignment: backgroundAlignment.value) {
                                Rectangle()
                                    .fill(Color.blue.opacity(0.5))
                                    .frame(width: backgroundSize, height: backgroundSize)
                            }
                        }
                        .animation(.easeInOut, value: useOverlay)
                        .animation(.easeInOut, value: useBackground)
                }
                .frame(width: 250, height: 250)
                .border(Color.black.opacity(0.2))
                .cornerRadius(10)

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Picker("Базовая фигура", selection: $shape) {
                        ForEach(BaseShape.allCases) { shape in
                            Text(shape.rawValue.capitalized).tag(shape)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Toggle("Показать Overlay", isOn: $useOverlay)
                    if useOverlay {
                        Slider(value: $overlaySize, in: 20...100)
                        Text("Размер Overlay: \(Int(overlaySize))")
                        Picker("Выравнивание Overlay", selection: $overlayAlignment) {
                            ForEach(AlignmentOption.allCases) { option in
                                Text(option.label).tag(option)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }

                    Toggle("Показать Background", isOn: $useBackground)
                    if useBackground {
                        Slider(value: $backgroundSize, in: 50...200)
                        Text("Размер Background: \(Int(backgroundSize))")
                        Picker("Выравнивание Background", selection: $backgroundAlignment) {
                            ForEach(AlignmentOption.allCases) { option in
                                Text(option.label).tag(option)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }

    @ViewBuilder
    private func baseView() -> some View {
        switch shape {
        case .rectangle:
            Rectangle()
                .fill(Color.pink)
                .frame(width: 100, height: 100)
        case .circle:
            Circle()
                .fill(Color.pink)
                .frame(width: 100, height: 100)
        case .text:
            Text("SwiftUI")
                .font(.title)
                .padding()
                .background(Color.pink)
        }
    }
}



struct OverlayAndBackgroundBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        OverlayAndBackgroundBootcamp()
    }
}
