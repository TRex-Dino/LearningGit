//
//  NavigationViewBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 27.04.2025.
//

import SwiftUI

struct NavigationViewBootcamp: View {
    var body: some View {
        NavigationView {
            ScrollView {
                NavigationLink("Hello World", destination: Text("Hello World"))

                Text("Hello, World!")
                Text("Hello, World!")
                Text("Hello, World!")
            }
            .navigationTitle("Some title")
            .navigationBarTitleDisplayMode(.automatic)
//            .toolbar(.hidden) use this in ios 16+
            .navigationBarItems(trailing: Image(systemName: "gear"))
        }
    }
}

struct NavigationViewBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewBootcamp()
    }
}
