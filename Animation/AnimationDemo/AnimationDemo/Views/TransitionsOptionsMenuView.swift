//
//  TransitionsOptionsMenuView.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 07.01.2025.
//

import UIKit

final class TransitionsOptionsMenuView: UIView {
    private let stackView = UIStackView()
    private let doneButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)
    private let buttonContainer = UIStackView()

    var onDone: ((UIView.AnimationOptions) -> Void)?
    var onCancel: (() -> Void)?

    private var selectedOptions: [UIView.AnimationOptions] = []

    var combinedAnimationOptions: UIView.AnimationOptions {
        selectedOptions.reduce([.showHideTransitionViews], { $0.union($1) })
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: -2)
        translatesAutoresizingMaskIntoConstraints = false

        setupStackView()
        setupButtonContainer()
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let options = [
            ("Flip From Left", UIView.AnimationOptions.transitionFlipFromLeft),
            ("Flip From Right", UIView.AnimationOptions.transitionFlipFromRight),
            ("Cross Dissolve", UIView.AnimationOptions.transitionCrossDissolve),
            ("Flip From Top", UIView.AnimationOptions.transitionFlipFromTop),
            ("Flip From Bottom", UIView.AnimationOptions.transitionFlipFromBottom),
            ("Curl up", UIView.AnimationOptions.transitionCurlUp),
            ("Curl Down", UIView.AnimationOptions.transitionCurlDown)
        ]

        for (title, option) in options {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .systemGray5
            button.layer.cornerRadius = 8
            button.addAction(UIAction { [weak self] _ in
                self?.toggleOption(option, for: button)
            }, for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }

        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    private func setupButtonContainer() {
        buttonContainer.axis = .horizontal
        buttonContainer.spacing = 16
        buttonContainer.alignment = .fill
        buttonContainer.distribution = .fillEqually
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false

        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.backgroundColor = .systemBlue
        doneButton.layer.cornerRadius = 8
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)

        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.backgroundColor = .systemRed
        cancelButton.layer.cornerRadius = 8
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)

        buttonContainer.addArrangedSubview(cancelButton)
        buttonContainer.addArrangedSubview(doneButton)

        addSubview(buttonContainer)
        NSLayoutConstraint.activate([
            buttonContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buttonContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            buttonContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            buttonContainer.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16)
        ])
    }

    private func toggleOption(_ option: UIView.AnimationOptions, for button: UIButton) {
        if selectedOptions.contains(option) {
            selectedOptions.removeAll { $0 == option }
            button.backgroundColor = .systemGray5
        } else {
            selectedOptions.append(option)
            button.backgroundColor = .systemBlue
        }
    }

    @objc private func doneButtonTapped() {
        onDone?(combinedAnimationOptions)
    }

    @objc private func cancelButtonTapped() {
        onCancel?()
    }
}

