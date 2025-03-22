//
//  BeginnerHomeView.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 21.03.2025.
//

import SwiftUI

struct BeginnerHomeView: View {
    @StateObject private var viewModel = BeginnerHomeViewModel()

    var body: some View {
        // TODO: Remove this after complete all lessons
        NavigationView {
            List(viewModel.lessons) { lesson in
                NavigationLink(destination: BeginnerLessonDetailView(lesson: lesson)) {
                    VStack(alignment: .leading) {
                        Text(lesson.title).font(.headline)
                        Text(lesson.description).font(.subheadline).foregroundColor(.gray)
                    }
                }
            }
        }
    }
}
