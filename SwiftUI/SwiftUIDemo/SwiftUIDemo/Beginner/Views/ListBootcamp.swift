//
//  ListBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 29.04.2025.
//

import SwiftUI

struct Fruit: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let emoji: String
}

struct ListBootcamp: View {
    @State private var fruits: [Fruit] = [
        Fruit(name: "Apple", emoji: "🍎"),
        Fruit(name: "Banana", emoji: "🍌"),
        Fruit(name: "Orange", emoji: "🍊"),
        Fruit(name: "Mango", emoji: "🥭")
    ]

    @State private var fruitToDelete: Fruit?
    @State private var showDeleteDialog = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Fruits")) {
                    ForEach(fruits) { fruit in
                        NavigationLink(destination: FruitDetailView(fruit: fruit)) {
                            HStack {
                                Text(fruit.emoji)
                                Text(fruit.name)
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                fruitToDelete = fruit
                                showDeleteDialog = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
            }
            .navigationTitle("Fruits")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }
    }

    private func delete(at offsets: IndexSet) {
        fruits.remove(atOffsets: offsets)
    }

    private func move(from source: IndexSet, to destination: Int) {
        fruits.move(fromOffsets: source, toOffset: destination)
    }
}
struct FruitDetailView: View {
    let fruit: Fruit

    var body: some View {
        VStack(spacing: 20) {
            Text(fruit.emoji)
                .font(.system(size: 100))
            Text(fruit.name)
                .font(.largeTitle)
                .bold()
        }
        .navigationTitle(fruit.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ListBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ListBootcamp()
    }
}
