//
//  HomeDetailView.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 21.03.2025.
//

import Foundation
import SwiftUI

struct HomeDetailView: View {
    let module: Module

    var body: some View {
        contentView()
            .navigationTitle(module.currentModule.rawValue)
            .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func contentView() -> some View {
        switch module.currentModule {
        case .begginer:
            BeginnerHomeView()

        }
    }
}
