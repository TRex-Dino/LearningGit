//
//  FrameBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 23.03.2025.
//

import SwiftUI

struct FrameBootcamp: View {
    @State private var baseWidth: CGFloat = 100
    @State private var baseHeight: CGFloat = 50

    @State private var applySecondFrame = true
    @State private var secondHeight: CGFloat = 100

    @State private var applyThirdFrame = true
    @State private var thirdWidth: CGFloat = 300

    @State private var useMaxFrame = true
    @State private var selectedAlignmentOption: AlignmentOption = AlignmentOption(label: "Center", value: .center)


    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Frame Playground")
                    .font(.title2)
                    .bold()

                GeometryReader { geo in
                    ZStack {
                        Color.gray.opacity(0.2)

                        // Наш каскадный блок
                        Text("Frame Text")
                            .frame(width: baseWidth)
                            .background(Color.blue.opacity(0.6))

                            .if(applySecondFrame) {
                                $0.frame(height: secondHeight)
                                    .background(Color.green.opacity(0.6))
                            }

                            .if(applyThirdFrame) {
                                $0.frame(width: thirdWidth)
                                    .background(Color.white.opacity(0.8))
                            }

                            .if(useMaxFrame) {
                                $0.frame(
                                    maxWidth: .infinity,
                                    maxHeight: .infinity,
                                    alignment: selectedAlignmentOption.value
                                )
                                .background(Color.red.opacity(0.4))
                            }
                    }
                    .frame(height: 250)
                    .border(Color.black.opacity(0.2))
                    .cornerRadius(8)
                }
                .frame(height: 250)

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Group {
                        Text("Базовый frame:")
                        Slider(value: $baseWidth, in: 20...300, step: 1)
                        Text("Ширина: \(Int(baseWidth))")

                        Toggle("Включить второй frame (высота)", isOn: $applySecondFrame)
                        if applySecondFrame {
                            Slider(value: $secondHeight, in: 20...200, step: 1)
                            Text("Высота: \(Int(secondHeight))")
                        }

                        Toggle("Включить третий frame (ширина)", isOn: $applyThirdFrame)
                        if applyThirdFrame {
                            Slider(value: $thirdWidth, in: 50...350, step: 1)
                            Text("Ширина: \(Int(thirdWidth))")
                        }
                    }

                    Divider()

                    Toggle("Применить maxWidth/maxHeight (.infinity)", isOn: $useMaxFrame)
                    if useMaxFrame {
                        Picker("Выравнивание", selection: $selectedAlignmentOption) {
                            ForEach(alignmentOptions) { option in
                                Text(option.label).tag(option)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }

    private var alignmentOptions: [AlignmentOption] {
        [
            AlignmentOption(label: "Top", value: .top),
            AlignmentOption(label: "Center", value: .center),
            AlignmentOption(label: "Bottom", value: .bottom),
            AlignmentOption(label: "Leading", value: .leading),
            AlignmentOption(label: "Trailing", value: .trailing)
        ]
    }

}

struct AlignmentOption: Identifiable, Hashable, CaseIterable {
    let id = UUID()
    let label: String
    let value: Alignment

    static let defaultOverlay = AlignmentOption(label: "Top Leading", value: .topLeading)
    static let defaultBackground = AlignmentOption(label: "Bottom Trailing", value: .bottomTrailing)
    static let center = AlignmentOption(label: "Center", value: .center)

    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
    }

    static func == (lhs: AlignmentOption, rhs: AlignmentOption) -> Bool {
        lhs.label == rhs.label
    }

    static var allCases: [AlignmentOption] {
        [
            .init(label: "Top Leading", value: .topLeading),
            .init(label: "Top", value: .top),
            .init(label: "Top Trailing", value: .topTrailing),
            .init(label: "Leading", value: .leading),
            .init(label: "Center", value: .center),
            .init(label: "Trailing", value: .trailing),
            .init(label: "Bottom Leading", value: .bottomLeading),
            .init(label: "Bottom", value: .bottom),
            .init(label: "Bottom Trailing", value: .bottomTrailing)
        ]
    }
}




struct FrameBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FrameBootcamp()
    }
}
