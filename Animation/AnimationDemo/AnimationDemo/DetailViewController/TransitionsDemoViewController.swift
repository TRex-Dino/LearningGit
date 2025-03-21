//
//  TransitionsDemoViewController.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 07.01.2025.
//

import UIKit

final class TransitionsDemoViewController: UIViewController {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var isShowingFirstView = true
    private let optionsMenu = TransitionsOptionsMenuView()
    private let randomColorGenerator = RandomColorGenerator()
    private var isMenuVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupContainerView()
        setupInitialViews()
        setupOptionsMenu()
    }

    private func setupContainerView() {
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 200),
            containerView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func setupInitialViews() {
        containerView.addSubview(firstView)
        NSLayoutConstraint.activate([
            firstView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            firstView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            firstView.topAnchor.constraint(equalTo: containerView.topAnchor),
            firstView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        containerView.addSubview(secondView)
        NSLayoutConstraint.activate([
            secondView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            secondView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            secondView.topAnchor.constraint(equalTo: containerView.topAnchor),
            secondView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        secondView.isHidden = true
    }

    private func setupOptionsMenu() {
        let menuButton = UIButton(type: .system)
        menuButton.setTitle("Show Options", for: .normal)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.addTarget(self, action: #selector(toggleMenuVisibility), for: .touchUpInside)
        view.addSubview(menuButton)

        NSLayoutConstraint.activate([
            menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])

        optionsMenu.translatesAutoresizingMaskIntoConstraints = false
        optionsMenu.isHidden = true
        optionsMenu.onDone = { [weak self] selectedOptions in
            self?.applyTransition(with: selectedOptions)
        }
        optionsMenu.onCancel = { [weak self] in
            self?.toggleMenuVisibility()
        }
        view.addSubview(optionsMenu)

        NSLayoutConstraint.activate([
            optionsMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            optionsMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            optionsMenu.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            optionsMenu.heightAnchor.constraint(equalToConstant: 250)
        ])
    }

    @objc private func toggleMenuVisibility() {
        isMenuVisible.toggle()
        UIView.animate(withDuration: 0.3) {
            self.optionsMenu.isHidden = !self.isMenuVisible
        }
    }

    private func applyTransition(with options: UIView.AnimationOptions) {

        let fromView = isShowingFirstView ? firstView : secondView
        let toView = isShowingFirstView ? secondView : firstView

        UIView.transition(
            from: fromView,
            to: toView,
            duration: 0.8,
            options: options
        ) { _ in
            self.isShowingFirstView.toggle()
            fromView.backgroundColor = self.randomColorGenerator.getNextColor()
        }
    }
}


