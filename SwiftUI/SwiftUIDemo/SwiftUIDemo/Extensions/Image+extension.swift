//
//  Image+extension.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 31.03.2025.
//

import SwiftUI

extension Image {
    func applyRenderingMode(_ mode: IconsBootcamp.SymbolMode) -> Image {
        switch mode {
        case .palette:
            return self.symbolRenderingMode(.palette)
        case .monochrome:
            return self.symbolRenderingMode(.monochrome)
        case .original:
            return self.renderingMode(.original)
        }
    }
}
