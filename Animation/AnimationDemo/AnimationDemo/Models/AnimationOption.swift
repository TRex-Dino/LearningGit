//
//  AnimationOption.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 15.12.2024.
//

import UIKit

enum AnimationOption: CaseIterable {
    case curveEaseInOut
    case curveEaseIn
    case curveEaseOut
    case curveLinear
    case repeatAnimation
    case autoreverse

    var title: String {
        switch self {
        case .curveEaseInOut: return "Curve Ease In Out"
        case .curveEaseIn: return "Curve Ease In"
        case .curveEaseOut: return "Curve Ease Out"
        case .curveLinear: return "Curve Linear"
        case .repeatAnimation: return "Repeat"
        case .autoreverse: return "Autoreverse"
        }
    }

    var animationOption: UIView.AnimationOptions {
        switch self {
        case .curveEaseInOut: return .curveEaseInOut
        case .curveEaseIn: return .curveEaseIn
        case .curveEaseOut: return .curveEaseOut
        case .curveLinear: return .curveLinear
        case .repeatAnimation: return .repeat
        case .autoreverse: return .autoreverse
        }
    }

    var isCurve: Bool {
        switch self {
        case .curveEaseInOut, .curveEaseIn, .curveEaseOut, .curveLinear:
            return true
        default:
            return false
        }
    }
}
