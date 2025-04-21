//
//  AnimationBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 11.04.2025.
//

import SwiftUI

struct AnimationsBootcamp: View {
    @State private var isAnimated = false
    @State private var showBox = false
    @State private var useWithAnimation = false
    @State private var selectedAnimation: AnimationType = .default

    var body: some View {
        VStack(spacing: 30) {
            Picker("Анимация", selection: $selectedAnimation) {
                ForEach(AnimationType.allCases) { anim in
                    Text(anim.rawValue).tag(anim)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            Toggle("Использовать withAnimation()", isOn: $useWithAnimation)
                .padding(.horizontal)

            Button("Toggle") {
                if useWithAnimation {
                    withAnimation(selectedAnimation.value) {
                        isAnimated.toggle()
                    }
                } else {
                    isAnimated.toggle()
                }
            }

            Spacer()

            RoundedRectangle(cornerRadius: isAnimated ? 50 : 15)
                .fill(isAnimated ? .red : .green)
                .frame(
                    width: isAnimated ? 100 : 300,
                    height: isAnimated ? 100 : 300
                )
                .scaleEffect(isAnimated ? 1.3 : 1)
                .offset(y: isAnimated ? 100 : 0)
                .rotationEffect(.degrees(isAnimated ? 180 : 0))
                .animation(selectedAnimation.value, value: isAnimated)

            Spacer()

            Button("Показать / скрыть блок с transition") {
                if useWithAnimation {
                    withAnimation(.easeInOut) {
                        showBox.toggle()
                    }
                } else {
                    showBox.toggle()
                }
            }

            if showBox {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.blue)
                    .frame(height: 200)
                    .padding(.horizontal)
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .leading),
                            removal: .opacity
                        )
                    )
                    .animation(.easeInOut, value: showBox)
            }
        }
        .padding()
        .navigationTitle("Анимации")
        .navigationBarTitleDisplayMode(.inline)
    }
}

enum AnimationType: String, CaseIterable, Identifiable {
    case `default`, easeIn, easeOut, easeInOut, linear, spring

    var id: String { rawValue }

    var value: Animation {
        switch self {
        case .default:
            return .default
        case .easeIn:
            return .easeIn(duration: 1)
        case .easeOut:
            return .easeOut(duration: 1)
        case .easeInOut:
            return .easeInOut(duration: 1)
        case .linear:
            return .linear(duration: 1)
        case .spring:
            return .spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.3)
        }
    }
}



struct AnimationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AnimationsBootcamp()
    }
}
