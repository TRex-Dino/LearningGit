//
//  View+extension.swift
//  SwiftUIDemo
//
//  Created by Menkov Dmitriy on 31.03.2025.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension View {
    func applyPadding(side: PaddingBootcamp.PaddingSide, value: CGFloat) -> some View {
        switch side {
        case .all:
            return AnyView(self.padding(value))
        case .horizontal:
            return AnyView(self.padding(.horizontal, value))
        case .vertical:
            return AnyView(self.padding(.vertical, value))
        case .leading:
            return AnyView(self.padding(.leading, value))
        case .trailing:
            return AnyView(self.padding(.trailing, value))
        case .top:
            return AnyView(self.padding(.top, value))
        case .bottom:
            return AnyView(self.padding(.bottom, value))
        }
    }
}
