//
//  ShapesBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 22.03.2025.
//

import SwiftUI

struct ShapesBootcamp: View {
    enum ShapeType: String, CaseIterable, Identifiable {
        case circle = "Circle"
        case ellipse = "Ellipse"
        case capsule = "Capsule"
        case rectangle = "Rectangle"
        case rounded = "Rounded"

        var id: String { rawValue }
    }

    @State private var shapeType: ShapeType = .rounded
    @State private var useFill = true
    @State private var useStroke = false
    @State private var strokeWidth: CGFloat = 4
    @State private var useTrim = false
    @State private var trimEnd: CGFloat = 1.0
    @State private var useDash = false
    @State private var dashLength: CGFloat = 20
    @State private var dashSpacing: CGFloat = 10
    @State private var dashPhase: CGFloat = 0
    var dashPattern: [CGFloat] {
        [dashLength, dashSpacing]
    }
    @State private var cornerRadius: CGFloat = 20

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Shape Preview")
                    .font(.title2)
                    .bold()

                shapeView()
                    .frame(width: 300, height: 200)
                    .padding()
                    .animation(.easeInOut, value: shapeType)
                    .animation(.easeInOut, value: trimEnd)
                    .animation(.easeInOut, value: useStroke)
                    .animation(.easeInOut, value: useTrim)
                    .animation(.easeInOut, value: cornerRadius)

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Picker("Фигура", selection: $shapeType) {
                        ForEach(ShapeType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Toggle("Заливка (fill)", isOn: $useFill)
                    Toggle("Обводка (stroke)", isOn: $useStroke)

                    if useStroke {
                        Slider(value: $strokeWidth, in: 1...30) {
                            Text("Толщина обводки")
                        }
                        Text("Толщина обводки: \(Int(strokeWidth))")
                    }

                    Toggle("Обрезка (trim)", isOn: $useTrim)
                    if useTrim {
                        Slider(value: $trimEnd, in: 0...1)
                        Text("Trim to: \(String(format: "%.2f", trimEnd))")
                    }

                    Toggle("Пунктир (dash)", isOn: $useDash)

                    if useDash {
                        VStack(alignment: .leading) {
                            Text("Настройки пунктирной линии:")
                                .font(.subheadline).bold()

                            Slider(value: $dashLength, in: 1...100) {
                                Text("Длина штриха")
                            }
                            Text("Длина штриха: \(Int(dashLength))")

                            Slider(value: $dashSpacing, in: 1...50) {
                                Text("Промежуток")
                            }
                            Text("Промежуток: \(Int(dashSpacing))")

                            Slider(value: $dashPhase, in: 0...100) {
                                Text("Фаза (смещение)")
                            }
                            Text("Смещение: \(Int(dashPhase))")
                        }
                    }

                    if shapeType == .rounded {
                        Text("Corner Radius: \(Int(cornerRadius))")
                        Slider(value: $cornerRadius, in: 0...100) {
                            Text("Радиус скругления")
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }

    @ViewBuilder
    private func shapeView() -> some View {
        let baseShape: any Shape = {
            switch shapeType {
            case .circle:
                return Circle()
            case .ellipse:
                return Ellipse()
            case .capsule:
                return Capsule()
            case .rectangle:
                return Rectangle()
            case .rounded:
                return RoundedRectangle(cornerRadius: cornerRadius)
            }
        }()

        let trimmed = useTrim
            ? AnyShape(baseShape.trim(from: 0, to: trimEnd))
            : AnyShape(baseShape)

        if useFill && !useStroke {
            trimmed.fill(.blue)
        } else if !useFill && useStroke {
            trimmed.stroke(
                .red,
                style: StrokeStyle(
                    lineWidth: strokeWidth,
                    lineCap: .round,
                    dash: useDash ? dashPattern : [],
                    dashPhase: useDash ? dashPhase : 0
                )
            )
        } else {
            trimmed
                .fill(.blue)
                .overlay(
                    trimmed.stroke(
                        .red,
                        style: StrokeStyle(
                            lineWidth: strokeWidth,
                            lineCap: .round,
                            dash: useDash ? dashPattern : [],
                            dashPhase: useDash ? dashPhase : 0
                        )
                    )
                )
        }
    }
}

// Обёртка для работы с обобщёнными Shape
struct AnyShape: Shape {
    private let path: (CGRect) -> Path

    init<T: Shape>(_ shape: T) {
        self.path = { rect in
            shape.path(in: rect)
        }
    }

    func path(in rect: CGRect) -> Path {
        path(rect)
    }
}


struct ShapesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ShapesBootcamp()
    }
}

