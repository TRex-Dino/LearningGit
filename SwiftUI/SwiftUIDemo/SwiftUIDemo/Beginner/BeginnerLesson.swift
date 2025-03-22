//
//  BeginnerLesson.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 21.03.2025.
//

import Foundation

struct BeginnerLesson: Identifiable {
    let id: UUID
    let currentLesson: CurrentLesson

    var title: String {
        switch currentLesson {
        case .text: "Text View"
        }
    }

    var description: String {
        switch currentLesson {
        case .text: "Font, formatting and modifiers"
        }
    }
    
    enum CurrentLesson {
        case text
    }
}
