//
//  Category.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 14.12.2024.
//

import Foundation

struct Category: Hashable {
    let id: UUID = UUID()
    let title: String
    let type: CategoryType
}

enum CategoryType: CaseIterable {
    case basicAnimations
    case optionsInAnimations
    case springAnimations
    case transitionDemo
    case animationPractice
    case propertyAnimator
    case keyframeAnimations
    case сonstraintsAnimations
    case layerAnimations
    case animationKeysAndDelegates
    case animationGroupAndAdvancedTiming
    case layerSprings
    case layerKeyframeAnimations
    case layerShapesAndMasks
    case gradientLayer
}
