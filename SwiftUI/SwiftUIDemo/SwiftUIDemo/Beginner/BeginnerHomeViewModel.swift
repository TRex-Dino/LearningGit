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
            BeginnerLesson(id: UUID(), currentLesson: .text)
        ]
    }
}
