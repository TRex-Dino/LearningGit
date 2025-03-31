//
//  PaddingBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 27.03.2025.
//

import SwiftUI

struct PaddingBootcamp: View {
    var body: some View {
//        Text("This is my text")
//            .padding()
//            .padding(.all, 10)
//            .padding(.leading, 10)
//            .padding(.trailing, 10)
//            .padding(.top, 10)
//            .background(Color.blue)


//        Text("This is my text")
//            .font(.largeTitle)
//            .fontWeight(.semibold)
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .background(Color.red)
//            .padding(.leading, 10)

        VStack(alignment: .leading) {
            Text("This is my text")
                .font(.largeTitle)
                .fontWeight(.semibold)

            Text("This is my text and it is longer than the previous one, so it will wrap and take more space")
        }
        .padding(.leading, 20)
    }
}

struct PaddingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        PaddingBootcamp()
    }
}
