//
//  AnimationBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 11.04.2025.
//

import SwiftUI

struct AnimationBootcamp: View {
    @State var isAnimated = false

    var body: some View {
        VStack {
            Button("Button") {
//                withAnimation(.default) {
//
//                    isAnimated.toggle()
//                }
                isAnimated.toggle()
            }

            Spacer()

            RoundedRectangle(cornerRadius: isAnimated ? 50 : 25)
                .fill(isAnimated ? Color.red : Color.green)
                .frame(
                    width: isAnimated ? 100 : 300,
                    height: isAnimated ? 100 : 300
                )
                .offset(y: isAnimated ? 100 : 0)
                .animation(.default, value: isAnimated) // or we can use this instead

            Spacer()
        }
    }
}

struct AnimationTimingBootcamp: View {
    @State var isAnimated = false
    let timing: Double = 10

    var body: some View {
        VStack {
            Button("Button") {
                isAnimated.toggle()
            }

            RoundedRectangle(cornerRadius: 20)
                .frame(width: isAnimated ? 350 : 50, height: 100)
                .animation(
                    .spring(
                        response: 2,
                        dampingFraction: 0.2,
                        blendDuration: 1
                    ),
                    value: isAnimated
                )

//            RoundedRectangle(cornerRadius: 20)
//                .frame(width: isAnimated ? 350 : 50, height: 100)
//                .animation(.linear(duration: timing), value: isAnimated)

//            RoundedRectangle(cornerRadius: 20)
//                .frame(width: isAnimated ? 350 : 50, height: 100)
//                .animation(.easeIn(duration: timing), value: isAnimated)
//
//            RoundedRectangle(cornerRadius: 20)
//                .frame(width: isAnimated ? 350 : 50, height: 100)
//                .animation(.easeOut(duration: timing), value: isAnimated)
//
//            RoundedRectangle(cornerRadius: 20)
//                .frame(width: isAnimated ? 350 : 50, height: 100)
//                .animation(.easeInOut(duration: timing), value: isAnimated)
        }
    }
}

struct AnimationTransitionBootcamp: View {
    @State var showView = false

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Button("Button") {
                    showView.toggle()
                }
                Spacer()
            }

            if showView {
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: UIScreen.main.bounds.height * 0.5)
//                    .transition(.slide)
//                    .transition(.move(edge: .bottom))
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .leading),
                            removal: .move(edge: .bottom)
                        )
                    )
                    .animation(.easeInOut) // change this to new ios 15, but slide does not work
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct AnimationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AnimationTransitionBootcamp()
    }
}
