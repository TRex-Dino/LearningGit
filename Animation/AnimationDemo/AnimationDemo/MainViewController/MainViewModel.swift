//
//  MainViewModel.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 14.12.2024.
//

import Foundation
import Combine

final class MainViewModel {
    @Published private(set) var categories: [Category] = []

    init() {
        self.categories = [
            Category(title: "Basic Animations", type: .basicAnimations),
            Category(title: "Options in Animations", type: .optionsInAnimations),
            Category(title: "Spring Animations", type: .springAnimations),
            Category(title: "Transition Demo Animation", type: .transitionDemo),
            Category(title: "Animation Practice", type: .animationPractice),
            Category(title: "UI View Property Animator", type: .propertyAnimator),
            Category(title: "Key Frame Animations", type: .keyframeAnimations),
            Category(title: "Constraints Animations", type: .сonstraintsAnimations),
            Category(title: "Layer Animations Intro", type: .layerAnimations),
            Category(title: "Animation Keys and Delegates", type: .animationKeysAndDelegates),
            Category(title: "Animation Group And Advanced Timing", type: .animationGroupAndAdvancedTiming),
            Category(title: "Layer Springs", type: .layerSprings),
            Category(title: "Layer Keyframe Animations", type: .layerKeyframeAnimations),
            Category(title: "Layer Shapes And Masks", type: .layerShapesAndMasks),
            Category(title: "Gradient Layer", type: .gradientLayer),
        ]

        let allCases = Set(CategoryType.allCases)
        let usedCases = Set(categories.map { $0.type })

        let missingCases = allCases.subtracting(usedCases)

        assert(missingCases.isEmpty, "Not all CategoryType cases are used in categories. Missing cases: \(missingCases)")
    }
}
