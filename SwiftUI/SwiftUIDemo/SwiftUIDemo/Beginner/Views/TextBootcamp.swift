//
//  TextBootcamp.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 21.03.2025.
//

import SwiftUI

struct TextBootcamp: View {
    @State private var useBold = false
    @State private var useItalic = false
    @State private var useUnderline = false
    @State private var useStrikethrough = false
    @State private var useKerning = false
    @State private var useColor = false
    @State private var fontSize: Font = .title

    var body: some View {
        VStack(spacing: 20) {
            if #available(iOS 16.0, *) {
                Text("Hello, World!")
                    .font(fontSize)
                    .fontWeight(useBold ? .bold : nil)
                    .italic(useItalic)
                    .underline(useUnderline)
                    .strikethrough(useStrikethrough)
                    .kerning(useKerning ? 10 : 0)
                    .foregroundStyle(useColor ? .blue : .primary)
                    .padding()
            } else {
                Text("Hello, World!")
                    .font(fontSize)
                    .fontWeight(useBold ? .bold : nil)
                    .italic()
                    .underline()
                    .strikethrough()
                    .kerning(10)
                    .foregroundStyle(useColor ? .blue : .primary)
                    .padding()
            }

            Divider()

            Group {
                Toggle("Bold", isOn: $useBold)
                Toggle("Italic", isOn: $useItalic)
                Toggle("Underline", isOn: $useUnderline)
                Toggle("Strikethrough", isOn: $useStrikethrough)
                Toggle("Kerning 10", isOn: $useKerning)
                Toggle("Blue Color", isOn: $useColor)

                Picker("Font Size", selection: $fontSize) {
                    Text("Title").tag(Font.title)
                    Text("Body").tag(Font.body)
                    Text("Caption").tag(Font.caption)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.horizontal)
        }
        .navigationTitle("Text")
    }
}


struct TextBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TextBootcamp()
    }
}
