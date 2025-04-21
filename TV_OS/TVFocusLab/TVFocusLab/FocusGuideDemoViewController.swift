//
//  FocusGuideDemoViewController.swift
//  TVFocusLab
//
//  Created by Menkov Dmitriy on 19.04.2025.
//

import UIKit

final class FocusGuideDemoViewController: UIViewController {

    private let buttonCenter = makeButton(title: "Center")
    private let buttonTop = makeButton(title: "⬆ Top")
    private let buttonBottom = makeButton(title: "⬇ Bottom")
    private let buttonLeft = makeButton(title: "⬅ Left")
    private let buttonRight = makeButton(title: "➡ Right")
    private let bigButton = makeButton(title: "Big button")

    // 🔁 Циклические направляющие
    private let guideLeftToRight = UIFocusGuide()
    private let guideRightToLeft = UIFocusGuide()
    private let guideTopToBottom = UIFocusGuide()
    private let guideBottomToTop = UIFocusGuide()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        [bigButton, buttonCenter, buttonTop, buttonBottom, buttonLeft, buttonRight].forEach {
            view.addSubview($0)
        }

        // Добавим гайды
        [guideLeftToRight, guideRightToLeft, guideTopToBottom, guideBottomToTop].forEach {
            view.addLayoutGuide($0)
        }

        setupLayout()
        setupFocusGuides()
    }

    private func setupLayout() {
        buttonCenter.translatesAutoresizingMaskIntoConstraints = false
        buttonTop.translatesAutoresizingMaskIntoConstraints = false
        buttonBottom.translatesAutoresizingMaskIntoConstraints = false
        buttonLeft.translatesAutoresizingMaskIntoConstraints = false
        buttonRight.translatesAutoresizingMaskIntoConstraints = false

        bigButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bigButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bigButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bigButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bigButton.widthAnchor.constraint(equalToConstant: 200),

            buttonCenter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonCenter.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonCenter.widthAnchor.constraint(equalToConstant: 200),
            buttonCenter.heightAnchor.constraint(equalToConstant: 60),

            buttonTop.centerXAnchor.constraint(equalTo: buttonCenter.centerXAnchor),
            buttonTop.bottomAnchor.constraint(equalTo: buttonCenter.topAnchor, constant: -60),
            buttonTop.widthAnchor.constraint(equalToConstant: 200),
            buttonTop.heightAnchor.constraint(equalToConstant: 60),

            buttonBottom.centerXAnchor.constraint(equalTo: buttonCenter.centerXAnchor),
            buttonBottom.topAnchor.constraint(equalTo: buttonCenter.bottomAnchor, constant: 60),
            buttonBottom.widthAnchor.constraint(equalToConstant: 200),
            buttonBottom.heightAnchor.constraint(equalToConstant: 60),

            buttonLeft.centerYAnchor.constraint(equalTo: buttonCenter.centerYAnchor),
            buttonLeft.trailingAnchor.constraint(equalTo: buttonCenter.leadingAnchor, constant: -60),
            buttonLeft.widthAnchor.constraint(equalToConstant: 200),
            buttonLeft.heightAnchor.constraint(equalToConstant: 60),

            buttonRight.centerYAnchor.constraint(equalTo: buttonCenter.centerYAnchor),
            buttonRight.leadingAnchor.constraint(equalTo: buttonCenter.trailingAnchor, constant: 60),
            buttonRight.widthAnchor.constraint(equalToConstant: 200),
            buttonRight.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    private func setupFocusGuides() {
        // 🔁 Циклический фокус: ⬅ от Left → Right
        NSLayoutConstraint.activate([
            guideLeftToRight.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            guideLeftToRight.trailingAnchor.constraint(equalTo: buttonLeft.leadingAnchor),
            guideLeftToRight.centerYAnchor.constraint(equalTo: buttonLeft.centerYAnchor),
            guideLeftToRight.heightAnchor.constraint(equalToConstant: 60)
        ])
        guideLeftToRight.preferredFocusEnvironments = [buttonLeft]

        // 🔁 ⬅ от Right → Left
        NSLayoutConstraint.activate([
            guideRightToLeft.leadingAnchor.constraint(equalTo: buttonRight.trailingAnchor),
            guideRightToLeft.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            guideRightToLeft.centerYAnchor.constraint(equalTo: buttonRight.centerYAnchor),
            guideRightToLeft.heightAnchor.constraint(equalToConstant: 60)
        ])
        guideRightToLeft.preferredFocusEnvironments = [buttonLeft]

        // 🔁 ⬆ от Top → Bottom
        NSLayoutConstraint.activate([
            guideTopToBottom.topAnchor.constraint(equalTo: view.topAnchor),
            guideTopToBottom.bottomAnchor.constraint(equalTo: buttonTop.topAnchor),
            guideTopToBottom.centerXAnchor.constraint(equalTo: buttonTop.centerXAnchor),
            guideTopToBottom.widthAnchor.constraint(equalToConstant: 200)
        ])
        guideTopToBottom.preferredFocusEnvironments = [buttonBottom]

        // 🔁 ⬇ от Bottom → Top
        NSLayoutConstraint.activate([
            guideBottomToTop.topAnchor.constraint(equalTo: buttonBottom.bottomAnchor),
            guideBottomToTop.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            guideBottomToTop.centerXAnchor.constraint(equalTo: buttonBottom.centerXAnchor),
            guideBottomToTop.widthAnchor.constraint(equalToConstant: 200)
        ])
        guideBottomToTop.preferredFocusEnvironments = [buttonTop]
    }

    private static func makeButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 28)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 12
        button.addTarget(nil, action: #selector(buttonTapped), for: .primaryActionTriggered)
        return button
    }

    @objc private static func buttonTapped(sender: UIButton) {
        print("Tapped button: \(sender.currentTitle ?? "")")
    }
}
