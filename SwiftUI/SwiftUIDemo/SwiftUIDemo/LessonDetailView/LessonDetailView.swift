//
//  LessonDetailView.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 21.03.2025.
//

import SwiftUI

struct LessonDetailView: View {
    let lesson: Lesson
    @StateObject private var viewModel = LessonDetailViewModel()

    var body: some View {
        contentView()
            .navigationTitle(lesson.title)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.loadContent(for: lesson)
            }
    }

    @ViewBuilder
    private func contentView() -> some View {
        switch lesson.title {
        case "Text & Modifiers":
            TestTextModifiersLessonView()
        case "State & Binding":
            Text("Lesson not implemented yet.")
                .foregroundColor(.gray)
        case "Navigation":
            Text("Lesson not implemented yet.")
                .foregroundColor(.gray)
        default:
            Text("Lesson not implemented yet.")
                .foregroundColor(.gray)
        }
    }
}

struct TestTextModifiersLessonView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, SwiftUI!")
                .font(.title)
                .foregroundColor(.blue)
                .bold()
                .underline()

            Text("This is a Text modifier example")
                .italic()
                .padding()
                .background(Color.yellow.opacity(0.3))
                .cornerRadius(8)
        }
        .padding()
    }
}

