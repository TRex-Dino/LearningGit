//
//  ForEachBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 30.03.2025.
//

import SwiftUI

struct ForEachBootcamp: View {
    var body: some View {
        let data: [String] = ["Hi", "Hello", "SwiftUI", "Is", "Awesome"]

//        VStack(alignment: .leading) {
//            ForEach(0..<10) { index in
//                Text("This is my text \(index)")
//                    .fontWeight(.semibold)
//            }
//        }

        VStack(alignment: .leading) {
            ForEach(data.indices) { index in
                Text("\(data[index]) \(index)")
                    .fontWeight(.semibold)
            }
        }
    }
}

struct ForEachBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ForEachBootcamp()
    }
}
