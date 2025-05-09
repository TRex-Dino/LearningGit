//
//  ConfirmationDialogBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 09.05.2025.
//

import SwiftUI

struct ConfirmationDialogBootcamp: View {
    enum ActionOption: String, CaseIterable {
        case copy = "Скопировать"
        case edit = "Изменить"
        case delete = "Удалить"
    }

    @State private var showDialog = false
    @State private var selectedAction: ActionOption?
    @State private var showDestructive = true

    var body: some View {
        VStack(spacing: 30) {
            Text("Последнее действие:")
                .font(.headline)
            Text(selectedAction?.rawValue ?? "Ничего")
                .font(.title2)
                .foregroundColor(.blue)

            Button("Открыть меню") {
                showDialog = true
            }
            .buttonStyle(.borderedProminent)

            Toggle("Показать опасное действие (Удалить)", isOn: $showDestructive)
                .padding(.horizontal)
        }
        .confirmationDialog("Выберите действие", isPresented: $showDialog, titleVisibility: .visible) {
            Button(ActionOption.copy.rawValue) {
                selectedAction = .copy
            }
            Button(ActionOption.edit.rawValue) {
                selectedAction = .edit
            }

            if showDestructive {
                Button(ActionOption.delete.rawValue, role: .destructive) {
                    selectedAction = .delete
                }
            }

            Button("Отмена", role: .cancel) { }
        }
    }
}


struct ConfirmationDialogBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationDialogBootcamp()
    }
}
