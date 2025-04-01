//
//  ScrollViewBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 01.04.2025.
//

import SwiftUI

struct ScrollViewBootcamp: View {
    enum ScrollDirection: String, CaseIterable, Identifiable {
        case vertical, horizontal
        var id: String { rawValue }
    }

    enum StackType: String, CaseIterable, Identifiable {
        case auto, vstack, hstack, lazyVStack, lazyHStack
        var id: String { rawValue }
    }

    @State private var direction: ScrollDirection = .vertical
    @State private var stackType: StackType = .auto
    @State private var showIndicators: Bool = true
    @State private var itemCount: Int = 20

    var body: some View {
        VStack(spacing: 20) {
            Picker("Ось", selection: $direction) {
                ForEach(ScrollDirection.allCases) { d in
                    Text(d.rawValue.capitalized).tag(d)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            Picker("Stack", selection: $stackType) {
                ForEach(StackType.allCases) { t in
                    Text(t.rawValue).tag(t)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            Stepper("Элементов: \(itemCount)", value: $itemCount, in: 1...100)
                .padding(.horizontal)

            Toggle("Показывать индикаторы", isOn: $showIndicators)
                .padding(.horizontal)

            Divider()

            ScrollView(scrollAxis, showsIndicators: showIndicators) {
                scrollContent()
                    .padding()
            }
        }
    }

    // MARK: - Helpers

    private var scrollAxis: Axis.Set {
        direction == .vertical ? .vertical : .horizontal
    }

    @ViewBuilder
    private func scrollContent() -> some View {
        switch activeStack {
        case .vstack:
            VStack(spacing: 12) {
                ForEach(0..<itemCount, id: \.self) { index in
                    itemView(index: index)
                }
            }
        case .hstack:
            HStack(spacing: 12) {
                ForEach(0..<itemCount, id: \.self) { index in
                    itemView(index: index)
                }
            }
        case .lazyVStack:
            LazyVStack(spacing: 12) {
                ForEach(0..<itemCount, id: \.self) { index in
                    itemView(index: index)
                }
            }
        case .lazyHStack:
            LazyHStack(spacing: 12) {
                ForEach(0..<itemCount, id: \.self) { index in
                    itemView(index: index)
                }
            }
        case .auto:
            if direction == .vertical {
                LazyVStack(spacing: 12) {
                    ForEach(0..<itemCount, id: \.self) { index in
                        itemView(index: index)
                    }
                }
            } else {
                LazyHStack(spacing: 12) {
                    ForEach(0..<itemCount, id: \.self) { index in
                        itemView(index: index)
                    }
                }
            }
        }
    }

    private var activeStack: StackType {
        stackType == .auto ? (direction == .vertical ? .lazyVStack : .lazyHStack) : stackType
    }

    @ViewBuilder
    private func itemView(index: Int) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue.opacity(0.8))
            .frame(
                width: direction == .vertical ? .infinity : 200,
                height: direction == .vertical ? 200 : 150
            )
            .overlay(Text("Item \(index)").foregroundColor(.white))
            .shadow(radius: 4)
    }
}


struct ScrollViewBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewBootcamp()
    }
}
