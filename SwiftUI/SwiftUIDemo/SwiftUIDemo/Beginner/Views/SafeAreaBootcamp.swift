//
//  SafeAreaBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 01.04.2025.
//

import SwiftUI

struct SafeAreaBootcamp: View {
    var body: some View {
        VStack {
            Text("123")
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .ignoresSafeArea(.all)
    }
}

struct SafeAreaBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SafeAreaBootcamp()
    }
}
