//
//  AlertBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 08.05.2025.
//

import SwiftUI

struct AlertBootcamp: View {
    @State var showAlert: Bool = false
    var body: some View {
        Button("Click") {
            showAlert.toggle()
        }
        .alert(isPresented: $showAlert) {
//            Alert(title: Text("Some text"))
            Alert(
                title: Text("Some text"),
                message: Text("Some message"),
                primaryButton: .cancel(),
                secondaryButton: .destructive(Text("delete"))
            )
        }
    }
}

struct AlertBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AlertBootcamp()
    }
}

