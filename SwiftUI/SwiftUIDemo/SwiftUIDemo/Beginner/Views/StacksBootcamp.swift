//
//  StacksBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 24.03.2025.
//

import SwiftUI

struct StacksBootcamp: View {
    enum StackType: String, CaseIterable, Identifiable {
        case vstack, hstack, zstack
        var id: String { rawValue }
    }

    @State private var stackType: StackType = .zstack
    @State private var spacing: CGFloat = 10

    @State private var showPink = true
    @State private var showBlue = true
    @State private var showOrange = true

    @State private var alignment: AlignmentOption = .center

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Stacks Playground")
                    .font(.title2)
                    .bold()

                ZStack {
                    Color.gray.opacity(0.1)

                    stackView()
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                }
                .frame(height: 300)
                .border(Color.black.opacity(0.1))

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Picker("Тип Stack-а", selection: $stackType) {
                        ForEach(StackType.allCases) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    if stackType != .zstack {
                        Slider(value: $spacing, in: 0...50)
                        Text("Spacing: \(Int(spacing))")
                    }

                    Picker("Выравнивание", selection: $alignment) {
                        ForEach(AlignmentOption.allCases) { option in
                            Text(option.label).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())

                    Toggle("Показать розовый блок", isOn: $showPink)
                    Toggle("Показать синий блок", isOn: $showBlue)
                    Toggle("Показать оранжевый блок", isOn: $showOrange)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }

    @ViewBuilder
    private func stackView() -> some View {
        switch stackType {
        case .vstack:
            VStack(alignment: horizontalAlignment(from: alignment.value), spacing: spacing) {
                stackContent()
            }
        case .hstack:
            HStack(alignment: verticalAlignment(from: alignment.value), spacing: spacing) {
                stackContent()
            }
        case .zstack:
            ZStack(alignment: alignment.value) {
                stackContent()
            }
        }
    }

    @ViewBuilder
    private func stackContent() -> some View {
        if showPink {
            Rectangle()
                .fill(Color.pink)
                .frame(width: 100, height: 100)
        }
        if showBlue {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 80, height: 80)
        }
        if showOrange {
            Rectangle()
                .fill(Color.orange)
                .frame(width: 50, height: 50)
        }
    }

    private func horizontalAlignment(from alignment: Alignment) -> HorizontalAlignment {
        switch alignment {
        case .leading, .topLeading, .bottomLeading:
            return .leading
        case .trailing, .topTrailing, .bottomTrailing:
            return .trailing
        default:
            return .center
        }
    }

    private func verticalAlignment(from alignment: Alignment) -> VerticalAlignment {
        switch alignment {
        case .top, .topLeading, .topTrailing:
            return .top
        case .bottom, .bottomLeading, .bottomTrailing:
            return .bottom
        default:
            return .center
        }
    }
}


struct StacksBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        StacksBootcamp()
    }
}
