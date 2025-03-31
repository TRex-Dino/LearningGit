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
        case .shapes: "Shapes"
        case .gradients: "Gradients"
        case .icons: "Icons"
        case .frames: "Frames"
        case .overlayAndBackground: "Overlay & Background"
        }
    }

    var description: String {
        switch currentLesson {
        case .text: "Font, formatting and modifiers"
        case .shapes: "Shapes - Rectangle, Circle, Ellipse, Capsule, RoundedRectangle"
        case .gradients: "Linear Gradient, Radial Gradient"
        case .icons: "Icons - Image, Symbol"
        case .frames: "Frames leading, trailing, top, bottom, minSize, maxSize"
        case .overlayAndBackground: "Overlay & Background"
        }
    }
    
    enum CurrentLesson {
        case text
        case shapes
        case gradients
        case icons
        case frames
        case overlayAndBackground
    }
}
