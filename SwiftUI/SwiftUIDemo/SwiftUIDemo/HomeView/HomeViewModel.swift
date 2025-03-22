//
//  HomeViewModel.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 21.03.2025.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var modules: [Module] = []

    init() {
        loadLessons()
    }

    private func loadLessons() {
        modules = [
            Module(id: UUID(), currentModule: .begginer)
        ]
    }
}
