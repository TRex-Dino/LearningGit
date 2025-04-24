//
//  BeginnerHomeViewModel.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 21.03.2025.
//

import Foundation
import Combine

class BeginnerHomeViewModel: ObservableObject {
    @Published var lessons: [BeginnerLesson] = []

    init() {
        loadLessons()
    }

    private func loadLessons() {
        lessons = [
            BeginnerLesson(id: UUID(), currentLesson: .text),
            BeginnerLesson(id: UUID(), currentLesson: .shapes),
            BeginnerLesson(id: UUID(), currentLesson: .gradients),
            BeginnerLesson(id: UUID(), currentLesson: .icons),
            BeginnerLesson(id: UUID(), currentLesson: .frames),
            BeginnerLesson(id: UUID(), currentLesson: .overlayAndBackground),
            BeginnerLesson(id: UUID(), currentLesson: .stacks),
            BeginnerLesson(id: UUID(), currentLesson: .padding),
            BeginnerLesson(id: UUID(), currentLesson: .spacer),
            BeginnerLesson(id: UUID(), currentLesson: .scrollView),
            BeginnerLesson(id: UUID(), currentLesson: .lazyGrid),
            BeginnerLesson(id: UUID(), currentLesson: .animations),
            BeginnerLesson(id: UUID(), currentLesson: .presentation),
        ]
    }
}
