//
//  HomeViewModel.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 21.03.2025.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var lessons: [Lesson] = []

    init() {
        loadLessons()
    }

    private func loadLessons() {
        lessons = [
            Lesson(id: UUID(), title: "Text & Modifiers", description: "Learn how to style and customize Text views"),
            Lesson(id: UUID(), title: "State & Binding", description: "Understand @State and @Binding"),
            Lesson(id: UUID(), title: "Navigation", description: "Implement navigation in SwiftUI"),
        ]
    }
}
