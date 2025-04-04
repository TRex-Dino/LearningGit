//
//  BindingBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 04.04.2025.
//

import SwiftUI

struct BindingBootcamp: View {
    @State var backgroundColor: Color = .green
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            ButtonView(backgroundColor: $backgroundColor)
        }
    }
}

struct ButtonView: View {
    @Binding var backgroundColor: Color
    var body: some View {

            Button {
                backgroundColor = .orange
            } label: {
                Text("Tap me")
                    .foregroundStyle(.white)
                    .padding()
                    .padding(.horizontal, 10)
                    .background(.blue)
                    .cornerRadius(10)
            }
    }
}

struct BindingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BindingBootcamp()
    }
}
