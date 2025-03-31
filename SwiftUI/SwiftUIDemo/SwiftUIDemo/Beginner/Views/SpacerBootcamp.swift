//
//  SpacerBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 28.03.2025.
//

import SwiftUI

struct SpacerBootcamp: View {
    var body: some View {
        HStack {
//            Rectangle()
//                .fill(Color.red)
//                .frame(width: 100, height: 100)
//
//            Spacer()
//                .frame(height: 10)
//                .background(Color.green)
//            Rectangle()
//                .fill(Color.blue)
//                .frame(width: 100, height: 100)

//            Spacer()
//                .frame(height: 10)
//                .background(Color.green)
//            Rectangle()
//                .fill(Color.red)
//                .frame(width: 100, height: 100)
//
//
//            Rectangle()
//                .fill(Color.blue)
//                .frame(width: 100, height: 100)
//
//            Rectangle()
//                .fill(Color.orange)
//                .frame(width: 100, height: 100)

            Spacer(minLength: nil)
                .frame(height: 10)
                .background(Color.green)
            Rectangle()
                .fill(Color.red)
                .frame(width: 50, height: 50)

            Spacer()
                .frame(height: 10)
                .background(Color.green)


            Rectangle()
                .fill(Color.blue)
                .frame(width: 50, height: 50)

            Spacer()
                .frame(height: 10)
                .background(Color.green)

            Rectangle()
                .fill(Color.orange)
                .frame(width: 50, height: 50)
            Spacer()
                .frame(height: 10)
                .background(Color.green)

        }
    }
}

struct SpacerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SpacerBootcamp()
    }
}

