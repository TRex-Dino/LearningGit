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
            List(viewModel.modules) { module in
                NavigationLink(destination: HomeDetailView(module: module)) {
                    VStack(alignment: .leading) {
                        Text(module.currentModule.rawValue).font(.headline)
                    }
                }
            }
            .navigationTitle("SwiftUI Lessons")
        }
    }
}
