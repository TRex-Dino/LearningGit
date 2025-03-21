//
//  OptionsMenuView.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 15.12.2024.
//

import UIKit

final class OptionsMenuView: UIView {
    private var selectedOptions: [AnimationOption] = []

    var combinedAnimationOptions: UIView.AnimationOptions {
        selectedOptions.reduce([], { $0.union($1.animationOption) })
    }

    private let optionsStackView = UIStackView()

    var onDone: ((UIView.AnimationOptions) -> Void)?
    var onCancel: (() -> Void)?

    init() {
        super.init(frame: .zero)
        setupMenuView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupMenuView()
    }

    func calculateSize() -> CGFloat {
        CGFloat(AnimationOption.allCases.count) * 50 + 40
    }

    private func setupMenuView() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: -2)

        optionsStackView.axis = .vertical
        optionsStackView.alignment = .fill
        optionsStackView.spacing = 10
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(optionsStackView)

        NSLayoutConstraint.activate([
            optionsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            optionsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            optionsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        for option in AnimationOption.allCases {
            let button = createOptionButton(for: option)
            optionsStackView.addArrangedSubview(button)
        }

        let buttonsStackView = UIStackView()
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 10
        buttonsStackView.distribution = .fillEqually

        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: .normal)
        doneButton.backgroundColor = .systemBlue
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.layer.cornerRadius = 8
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)

        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = .systemGray5
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.layer.cornerRadius = 8
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)

        buttonsStackView.addArrangedSubview(cancelButton)
        buttonsStackView.addArrangedSubview(doneButton)

        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonsStackView)

        NSLayoutConstraint.activate([
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 50),
            optionsStackView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -20)
        ])
    }

    private func createOptionButton(for option: AnimationOption) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(option.title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 1

        button.addAction(UIAction(handler: { _ in
            self.toggleOption(option, for: button)
        }), for: .touchUpInside)

        return button
    }

    private func toggleOption(_ option: AnimationOption, for button: UIButton) {
        if option.isCurve {
            // Убираем все остальные кривые
            selectedOptions.removeAll { $0.isCurve }
        }

        if selectedOptions.contains(option) {
            selectedOptions.removeAll { $0 == option }
            button.backgroundColor = .systemGray5
            button.setTitleColor(.black, for: .normal)
        } else {
            selectedOptions.append(option)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
        }

        updateButtonStates()
    }

    private func updateButtonStates() {
        for (index, option) in AnimationOption.allCases.enumerated() {
            if let button = optionsStackView.arrangedSubviews[index] as? UIButton {
                if selectedOptions.contains(option) {
                    button.backgroundColor = .systemBlue
                    button.setTitleColor(.white, for: .normal)
                } else {
                    button.backgroundColor = .systemGray5
                    button.setTitleColor(.black, for: .normal)
                }
            }
        }
    }

    @objc private func doneButtonTapped() {
        onDone?(combinedAnimationOptions)
    }

    @objc private func cancelButtonTapped() {
        onCancel?()
    }
}






