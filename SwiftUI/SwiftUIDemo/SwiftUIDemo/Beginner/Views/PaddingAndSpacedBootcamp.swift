//
//  PaddingBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 27.03.2025.
//

import SwiftUI

struct PaddingBootcamp: View {
    enum PaddingSide: String, CaseIterable, Identifiable {
        case all, horizontal, vertical, leading, trailing, top, bottom
        var id: String { rawValue }
    }

    @State private var selectedSide: PaddingSide = .all
    @State private var paddingValue: CGFloat = 16
    @State private var backgroundBeforePadding = false

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Padding Playground")
                    .font(.title2)
                    .bold()

                ZStack {
                    Color.gray.opacity(0.1)

                    VStack {
                        if backgroundBeforePadding {
                            textView()
                                .background(Color.blue.opacity(0.5))
                                .applyPadding(side: selectedSide, value: paddingValue)
                        } else {
                            textView()
                                .applyPadding(side: selectedSide, value: paddingValue)
                                .background(Color.blue.opacity(0.5))
                        }
                    }
                    .border(Color.black.opacity(0.3))
                }
                .frame(height: 200)
                .cornerRadius(10)

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Picker("Сторона отступа", selection: $selectedSide) {
                        ForEach(PaddingSide.allCases) { side in
                            Text(side.rawValue.capitalized).tag(side)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Slider(value: $paddingValue, in: 0...50)
                    Text("Padding: \(Int(paddingValue)) pt")

                    Toggle("Сначала фон, потом отступ", isOn: $backgroundBeforePadding)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }

    private func textView() -> some View {
        Text("This is my text")
            .font(.title2)
            .fontWeight(.semibold)
    }
}

extension View {
    func applyPadding(side: PaddingBootcamp.PaddingSide, value: CGFloat) -> some View {
        switch side {
        case .all:
            return AnyView(self.padding(value))
        case .horizontal:
            return AnyView(self.padding(.horizontal, value))
        case .vertical:
            return AnyView(self.padding(.vertical, value))
        case .leading:
            return AnyView(self.padding(.leading, value))
        case .trailing:
            return AnyView(self.padding(.trailing, value))
        case .top:
            return AnyView(self.padding(.top, value))
        case .bottom:
            return AnyView(self.padding(.bottom, value))
        }
    }
}


struct PaddingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        PaddingBootcamp()
    }
}
