//
//  LessonDetailViewModel.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 21.03.2025.
//

import SwiftUI

class LessonDetailViewModel: ObservableObject {
    @Published var lessonContent: String = ""

    func loadContent(for lesson: Lesson) {
        // Тут можно грузить из файла или API
        // можно добавить какой нибудь доп логики для экранов
        lessonContent = "This is a detailed explanation for: \(lesson.title)"
    }
}
