//
//  OptionsInAnimationsViewController.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 15.12.2024.
//

import UIKit

final class OptionsInAnimationsViewController: UIViewController {
    private let animatedView = UIView()
    private let optionsMenu = OptionsMenuView()
    private let animateButton = DefaultButton()
    private let menuButton = DefaultButton()

    private var isMenuInitialized = false // Флаг для инициализации меню один раз

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupAnimatedView()
        setupAnimateButton()
        setupShowMenuButton()
        setupMenu()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if !isMenuInitialized {
            optionsMenu.frame = CGRect(
                x: 0,
                y: view.frame.height,
                width: view.frame.width,
                height: optionsMenu.calculateSize()
            )
            isMenuInitialized = true
        }

        animatedView.frame.size = CGSize(width: 100, height: 100)
        animatedView.center = view.center
        animatedView.frame.origin.x = 0

        menuButton.frame = CGRect(
            x: (view.bounds.width - 150) / 2,
            y: view.bounds.height - 60,
            width: 150,
            height: 40
        )

        animateButton.frame = CGRect(
            x: (view.bounds.width - 150) / 2,
            y: menuButton.frame.minY - 60,
            width: 150,
            height: 40
        )
    }

    private func setupAnimatedView() {
        animatedView.backgroundColor = .blue
        view.addSubview(animatedView)
    }

    private func setupMenu() {
        optionsMenu.onDone = { [weak self] selectedOptions in
            self?.hideMenu()
        }
        optionsMenu.onCancel = { [weak self] in
            self?.hideMenu()
        }
        view.addSubview(optionsMenu)
    }

    private func setupAnimateButton() {
        animateButton.setTitle("Animate", for: .normal)
        animateButton.layer.cornerRadius = 8
        animateButton.addTarget(self, action: #selector(animateView), for: .touchUpInside)
        view.addSubview(animateButton)
    }

    private func setupShowMenuButton() {
        menuButton.setTitle("Show Options", for: .normal)
        menuButton.layer.cornerRadius = 8
        menuButton.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        view.addSubview(menuButton)
    }

    @objc private func showMenu() {
        UIView.animate(withDuration: 0.3) {
            self.optionsMenu.frame.origin.y = self.view.frame.height - self.optionsMenu.frame.height
        }
    }

    private func hideMenu() {
        UIView.animate(withDuration: 0.3) {
            self.optionsMenu.frame.origin.y = self.view.frame.height
        }
    }

    @objc private func animateView() {
        UIView.animate(
            withDuration: 2.0,
            delay: 0,
            options: optionsMenu.combinedAnimationOptions,
            animations: {
                if self.animatedView.frame.origin.x == 0 {
                    self.animatedView.frame.origin.x = self.view.frame.width - self.animatedView.frame.width
                } else {
                    self.animatedView.frame.origin.x = 0
                }
            },
            completion: nil
        )
    }

}




