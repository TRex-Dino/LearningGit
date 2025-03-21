//
//  HomeView.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 21.03.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.lessons) { lesson in
                NavigationLink(destination: LessonDetailView(lesson: lesson)) {
                    VStack(alignment: .leading) {
                        Text(lesson.title).font(.headline)
                        Text(lesson.description).font(.subheadline).foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("SwiftUI Lessons")
        }
    }
}
