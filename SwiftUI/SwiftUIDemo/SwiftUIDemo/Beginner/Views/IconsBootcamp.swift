//
//  IconsBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 23.03.2025.
//

import SwiftUI

struct IconsBootcamp: View {
    enum SymbolMode: String, CaseIterable, Identifiable {
        case monochrome, original, palette
        var id: String { rawValue }
    }

    let availableIcons = [
        "person.badge.plus",
        "star.fill",
        "heart.fill",
        "paperplane.fill",
        "flame.fill",
        "bolt.fill",
        "gear",
        "person.2.circle",
        "leaf.fill"
    ]

    @State private var selectedIcon = "person.badge.plus"
    @State private var renderingMode: SymbolMode = .palette
    @State private var useResizable = true
    @State private var iconSize: CGFloat = 150
    @State private var useGradient = true
    @State private var aspectFill = true
    @State private var useClipped = true

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("SF Symbol Preview")
                    .font(.title2)
                    .bold()

                iconView()
                    .frame(width: iconSize, height: iconSize)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .animation(.easeInOut, value: useClipped)
                    .animation(.easeInOut, value: iconSize)
                    .animation(.easeInOut, value: aspectFill)

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Picker("Иконка", selection: $selectedIcon) {
                        ForEach(availableIcons, id: \.self) { name in
                            Text(name)
                                .font(.system(size: 16, weight: .medium, design: .monospaced))
                        }
                    }

                    Picker("Режим", selection: $renderingMode) {
                        ForEach(SymbolMode.allCases) { mode in
                            Text(mode.rawValue.capitalized).tag(mode)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Toggle("Resizable + Frame", isOn: $useResizable)

                    if useResizable {
                        Slider(value: $iconSize, in: 50...300)
                        Text("Размер: \(Int(iconSize)) pt")

                        Toggle("Aspect Fill", isOn: $aspectFill)
                        Toggle("Clipped (только с Fill)", isOn: $useClipped)
                    } else {
                        Slider(value: $iconSize, in: 20...100)
                        Text("Font size: \(Int(iconSize)) pt")
                    }

                    Toggle("Градиент", isOn: $useGradient)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }

    @ViewBuilder
    private func iconView() -> some View {
        let baseImage = Image(systemName: selectedIcon)
            .applyRenderingMode(renderingMode)

        if useResizable {
            if useGradient && renderingMode == .palette {
                baseImage
                    .resizable()
                    .aspectRatio(contentMode: aspectFill ? .fill : .fit)
                    .if(useClipped && aspectFill) { $0.clipped() }
                    .foregroundStyle(
                        LinearGradient(colors: [.red, .blue], startPoint: .top, endPoint: .bottom)
                    )
            } else {
                baseImage
                    .resizable()
                    .aspectRatio(contentMode: aspectFill ? .fill : .fit)
                    .if(useClipped && aspectFill) { $0.clipped() }
                    .foregroundStyle(Color.red)
            }
        } else {
            if useGradient && renderingMode == .palette {
                baseImage
                    .font(.system(size: iconSize))
                    .foregroundStyle(
                        LinearGradient(colors: [.purple, .orange], startPoint: .top, endPoint: .bottom)
                    )
            } else {
                baseImage
                    .font(.system(size: iconSize))
                    .foregroundStyle(Color.red)
            }
        }
    }
}

struct IconsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        IconsBootcamp()
    }
}
