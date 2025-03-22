//
//  Module.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 21.03.2025.
//

import Foundation

struct Module: Identifiable {
    let id: UUID
    let currentModule: CurrentModule

    enum CurrentModule: String {
        case begginer = "Begginer"
    }
}
