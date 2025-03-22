//
//  BeginnerLessonDetailView.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 21.03.2025.
//

import SwiftUI

struct BeginnerLessonDetailView: View {
    let lesson: BeginnerLesson
    @StateObject private var viewModel = BeginnerLessonDetailViewModel()

    var body: some View {
        contentView()
//            .navigationTitle(lesson.title)
//            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.loadContent(for: lesson)
            }
    }

    @ViewBuilder
    private func contentView() -> some View {
        switch lesson.currentLesson {
        case .text:
            TextBootcamp()
        }
    }
}

