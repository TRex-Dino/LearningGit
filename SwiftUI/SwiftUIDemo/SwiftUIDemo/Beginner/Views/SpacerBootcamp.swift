//
//  SpacerBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 28.03.2025.
//

import SwiftUI

struct SpacerBootcamp: View {
    enum StackAxis: String, CaseIterable, Identifiable {
        case horizontal, vertical
        var id: String { rawValue }
    }

    @State private var axis: StackAxis = .horizontal

    @State private var useSpacer1 = true
    @State private var useSpacer2 = true
    @State private var useSpacer3 = true

    @State private var minLength1: CGFloat = 0
    @State private var minLength2: CGFloat = 0
    @State private var minLength3: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Spacer Playground")
                    .font(.title2)
                    .bold()

                ZStack {
                    Color.gray.opacity(0.1)

                    Group {
                        if axis == .horizontal {
                            HStack {
                                if useSpacer1 {
                                    Spacer(minLength: minLength1)
                                        .frame(height: 10)
                                        .background(Color.green.opacity(0.5))
                                }

                                block(color: .red)

                                if useSpacer2 {
                                    Spacer(minLength: minLength2)
                                        .frame(height: 10)
                                        .background(Color.green.opacity(0.5))
                                }

                                block(color: .blue)

                                if useSpacer3 {
                                    Spacer(minLength: minLength3)
                                        .frame(height: 10)
                                        .background(Color.green.opacity(0.5))
                                }

                                block(color: .orange)
                            }
                        } else {
                            VStack {
                                if useSpacer1 {
                                    Spacer(minLength: minLength1)
                                        .frame(width: 10)
                                        .background(Color.green.opacity(0.5))
                                }

                                block(color: .red)

                                if useSpacer2 {
                                    Spacer(minLength: minLength2)
                                        .frame(width: 10)
                                        .background(Color.green.opacity(0.5))
                                }

                                block(color: .blue)

                                if useSpacer3 {
                                    Spacer(minLength: minLength3)
                                        .frame(width: 10)
                                        .background(Color.green.opacity(0.5))
                                }

                                block(color: .orange)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(height: 300)
                .border(Color.black.opacity(0.1))
                .cornerRadius(10)

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Picker("Ось", selection: $axis) {
                        ForEach(StackAxis.allCases) { axis in
                            Text(axis.rawValue.capitalized).tag(axis)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Group {
                        Toggle("Spacer 1", isOn: $useSpacer1)
                        if useSpacer1 {
                            Slider(value: $minLength1, in: 0...100)
                            Text("MinLength Spacer 1: \(Int(minLength1))")
                        }

                        Toggle("Spacer 2", isOn: $useSpacer2)
                        if useSpacer2 {
                            Slider(value: $minLength2, in: 0...100)
                            Text("MinLength Spacer 2: \(Int(minLength2))")
                        }

                        Toggle("Spacer 3", isOn: $useSpacer3)
                        if useSpacer3 {
                            Slider(value: $minLength3, in: 0...100)
                            Text("MinLength Spacer 3: \(Int(minLength3))")
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }

    @ViewBuilder
    private func block(color: Color) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(color)
            .frame(width: 50, height: 50)
    }
}


struct SpacerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SpacerBootcamp()
    }
}

