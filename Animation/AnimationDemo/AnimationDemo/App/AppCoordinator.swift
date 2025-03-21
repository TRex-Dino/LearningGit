//
//  AppCoordinator.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 14.12.2024.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private var navigationController: UINavigationController?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let viewModel = MainViewModel()
        let mainVC = MainViewController(viewModel: viewModel)
        mainVC.delegate = self
        let navController = UINavigationController(rootViewController: mainVC)
        self.navigationController = navController
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: MainViewControllerDelegate {
    func didSelect(category: Category){
        let detailVC: UIViewController

        switch category.type {
        case .basicAnimations:
            detailVC = BasicAnimationsViewController()
        case .optionsInAnimations:
            detailVC = OptionsInAnimationsViewController()
        case .springAnimations:
            detailVC = SpringAnimationsViewController()
        case .transitionDemo:
            detailVC = TransitionsDemoViewController()
        case .animationPractice:
            detailVC = AnimationsPracticeViewController()
        case .keyframeAnimations:
            detailVC = KeyframeAnimationsViewController()
        case .сonstraintsAnimations:
            detailVC = ConstraintsAnimationsViewController()
        case .layerAnimations:
            detailVC = LayerAnimationsViewController()
        case .animationKeysAndDelegates:
            detailVC = AnimationKeysAndDelegatesViewController()
        case .propertyAnimator:
            detailVC = PropertyAnimatorViewController()
        case .animationGroupAndAdvancedTiming:
            detailVC = AnimationGroupAndAdvancedTimingViewController()
        case .layerSprings:
            detailVC = LayerSpringsViewController()
        case .layerKeyframeAnimations:
            detailVC = LayerKeyframeAnimationsViewController()
        case .layerShapesAndMasks:
            detailVC = LayerShapesAndMasksViewController()
        case .gradientLayer:
            detailVC = GradientAnimationsViewController()
        }

        detailVC.title = category.title
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

