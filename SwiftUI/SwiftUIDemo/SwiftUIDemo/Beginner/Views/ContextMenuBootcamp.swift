//
//  ContextMenuBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 09.05.2025.
//

import SwiftUI

struct Contact: Identifiable {
    let id = UUID()
    let name: String
    let phone: String
    let image: String
}

struct ContextMenuBootcamp: View {
    @State private var contacts: [Contact] = [
        Contact(name: "Иван Петров", phone: "+7 999 123 45 67", image: "person.crop.circle"),
        Contact(name: "Анна Смирнова", phone: "+7 915 000 11 22", image: "person.crop.circle.fill")
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(contacts) { contact in
                    ContactCardView(contact: contact) {
                        handleAction($0, for: contact)
                    }
                }
            }
            .navigationTitle("Контакты")
        }
    }

    enum CardAction {
        case call, message, duplicate, delete
    }

    private func handleAction(_ action: CardAction, for contact: Contact) {
        switch action {
        case .call:
            print("Звоним \(contact.phone)")
        case .message:
            print("Пишем сообщение \(contact.name)")
        case .duplicate:
            contacts.append(contact)
        case .delete:
            contacts.removeAll { $0.id == contact.id }
        }
    }
}

struct ContactCardView: View {
    let contact: Contact
    let onAction: (ContextMenuBootcamp.CardAction) -> Void

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: contact.image)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)

            VStack(alignment: .leading, spacing: 4) {
                Text(contact.name)
                    .font(.headline)
                Text(contact.phone)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
        )
        .contextMenu {
            Button {
                onAction(.call)
            } label: {
                Label("Позвонить", systemImage: "phone")
            }

            Button {
                onAction(.message)
            } label: {
                Label("Написать", systemImage: "message")
            }

            Button {
                onAction(.duplicate)
            } label: {
                Label("Дублировать", systemImage: "plus.square.on.square")
            }

            Button(role: .destructive) {
                onAction(.delete)
            } label: {
                Label("Удалить", systemImage: "trash")
            }
        }
    }
}

struct ContextMenuBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenuBootcamp()
    }
}
