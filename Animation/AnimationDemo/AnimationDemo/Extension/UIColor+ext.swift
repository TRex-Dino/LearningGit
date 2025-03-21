//
//  File.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 07.01.2025.
//

import UIKit

final class RandomColorGenerator {
    private var lastColor: UIColor?

    func getNextColor() -> UIColor {
        var newColor: UIColor
        repeat {
            newColor = UIColor.random()
        } while newColor == lastColor
        lastColor = newColor
        return newColor
    }
}

extension UIColor {
    static func random () -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0.1...0.8),
            green: CGFloat.random(in: 0.1...0.8),
            blue: CGFloat.random(in: 0.1...0.8),
            alpha: 1.0)
    }
}


