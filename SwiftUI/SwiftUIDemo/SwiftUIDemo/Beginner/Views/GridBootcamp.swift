//
//  GridBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 01.04.2025.
//

import SwiftUI

struct GridBootcamp: View {
    enum GridAxis: String, CaseIterable, Identifiable {
        case vertical, horizontal
        var id: String { rawValue }
    }

    enum GridItemType: String, CaseIterable, Identifiable {
        case fixed, flexible, adaptive
        var id: String { rawValue }
    }

    @State private var axis: GridAxis = .vertical
    @State private var gridItemType: GridItemType = .flexible
    @State private var itemCount = 30
    @State private var columnOrRowCount = 3
    @State private var itemSize: CGFloat = 100
    @State private var adaptiveMin: CGFloat = 80

    var body: some View {
        VStack(spacing: 20) {
            // Настройки
            Group {
                Picker("Ось", selection: $axis) {
                    ForEach(GridAxis.allCases) { a in
                        Text(a.rawValue.capitalized).tag(a)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Picker("Тип GridItem", selection: $gridItemType) {
                    ForEach(GridItemType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                if gridItemType != .adaptive {
                    Stepper("\(axis == .vertical ? "Колонок" : "Строк"): \(columnOrRowCount)", value: $columnOrRowCount, in: 1...10)
                    Slider(value: $itemSize, in: 40...150) {
                        Text("Размер элемента")
                    }
                } else {
                    Slider(value: $adaptiveMin, in: 40...150) {
                        Text("Минимальный размер (adaptive)")
                    }
                }

                Stepper("Количество элементов: \(itemCount)", value: $itemCount, in: 1...100)
            }
            .padding(.horizontal)

            Divider()

            ScrollView(axis == .vertical ? .vertical : .horizontal) {
                if axis == .vertical {
                    LazyVGrid(columns: gridItems(), spacing: 12) {
                        content
                    }
                    .padding()
                } else {
                    LazyHGrid(rows: gridItems(), spacing: 12) {
                        content
                    }
                    .padding()
                }
            }
        }
    }

    private var content: some View {
        ForEach(0..<itemCount, id: \.self) { index in
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue.opacity(0.8))
                .frame(
                    width: axis == .vertical ? nil : itemSize,
                    height: axis == .vertical ? itemSize : nil
                )
                .overlay(Text("\(index)").foregroundColor(.white))
                .shadow(radius: 2)
        }
    }

    private func gridItems() -> [GridItem] {
        switch gridItemType {
        case .fixed:
            return Array(repeating: GridItem(.fixed(itemSize)), count: columnOrRowCount)
        case .flexible:
            return Array(repeating: GridItem(.flexible()), count: columnOrRowCount)
        case .adaptive:
            return [GridItem(.adaptive(minimum: adaptiveMin))]
        }
    }
}


struct GridBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GridBootcamp()
    }
}
