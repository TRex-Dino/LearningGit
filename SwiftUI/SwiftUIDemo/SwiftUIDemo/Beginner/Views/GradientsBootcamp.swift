//
//  GradientsBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 22.03.2025.
//

import SwiftUI

struct UnitPointOption: Identifiable, Hashable {
    let id = UUID()
    let label: String
    let value: UnitPoint
}

struct GradientsBootcamp: View {
    enum GradientType: String, CaseIterable, Identifiable {
        case linear = "Linear"
        case radial = "Radial"
        case angular = "Angular"

        var id: String { rawValue }
    }

    @State private var gradientType: GradientType = .angular
    @State private var startPoint: UnitPoint = .top
    @State private var endPoint: UnitPoint = .bottom
    @State private var center: UnitPoint = .center
    @State private var startRadius: CGFloat = 10
    @State private var endRadius: CGFloat = 200
    @State private var angle: Double = 180
    @State private var selectedColors: [Color] = [.red, .blue]

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Градиент")
                    .font(.title2)
                    .bold()

                gradientFill
                    .frame(width: 300, height: 200)
                    .animation(.easeInOut, value: gradientType)
                    .animation(.easeInOut, value: angle)
                    .animation(.easeInOut, value: startRadius)
                    .animation(.easeInOut, value: endRadius)

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Picker("Тип градиента", selection: $gradientType) {
                        ForEach(GradientType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    ColorPicker("Первый цвет", selection: $selectedColors[0])
                    ColorPicker("Второй цвет", selection: $selectedColors[1])

                    switch gradientType {
                    case .linear:
                        VStack(alignment: .leading) {
                            Text("Направление:")
                            Picker("Start", selection: $startPoint) {
                                ForEach(unitPoints, id: \.self) { point in
                                    Text(point.label).tag(point.value)
                                }
                            }
                            Picker("End", selection: $endPoint) {
                                ForEach(unitPoints, id: \.self) { point in
                                    Text(point.label).tag(point.value)
                                }
                            }
                        }
                    case .radial:
                        VStack(alignment: .leading) {
                            Text("Центр:")
                            Picker("Center", selection: $center) {
                                ForEach(unitPoints, id: \.self) { point in
                                    Text(point.label).tag(point.value)
                                }
                            }
                            Slider(value: $startRadius, in: 0...100)
                            Text("Start Radius: \(Int(startRadius))")

                            Slider(value: $endRadius, in: 50...300)
                            Text("End Radius: \(Int(endRadius))")
                        }
                    case .angular:
                        VStack(alignment: .leading) {
                            Text("Центр:")
                            Picker("Center", selection: $center) {
                                ForEach(unitPoints, id: \.self) { point in
                                    Text(point.label).tag(point.value)
                                }
                            }
                            Slider(value: $angle, in: 0...360)
                            Text("Угол: \(Int(angle))°")
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }

    private var unitPoints: [UnitPointOption] {
        [
            .init(label: "Top", value: .top),
            .init(label: "Bottom", value: .bottom),
            .init(label: "Leading", value: .leading),
            .init(label: "Trailing", value: .trailing),
            .init(label: "TopLeading", value: .topLeading),
            .init(label: "TopTrailing", value: .topTrailing),
            .init(label: "BottomLeading", value: .bottomLeading),
            .init(label: "BottomTrailing", value: .bottomTrailing),
            .init(label: "Center", value: .center)
        ]
    }

    @ViewBuilder
    var gradientFill: some View {
        switch gradientType {
        case .linear:
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: selectedColors),
                        startPoint: startPoint,
                        endPoint: endPoint
                    )
                )

        case .radial:
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: selectedColors),
                        center: center,
                        startRadius: startRadius,
                        endRadius: endRadius
                    )
                )

        case .angular:
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    AngularGradient(
                        gradient: Gradient(colors: selectedColors),
                        center: center,
                        angle: .degrees(angle)
                    )
                )
        }
    }

}


struct GradientsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GradientsBootcamp()
    }
}
