//
//  DefaultButton.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 15.12.2024.
//

import UIKit

final class DefaultButton: UIButton {
    private let defaultBorderColor = UIColor.systemGray.cgColor
    private let highlightedBorderColor = UIColor.systemBlue.cgColor
    private let defaultBackgroundColor = UIColor.white
    private let highlightedBackgroundColor = UIColor.systemGray5

    override var isHighlighted: Bool {
        didSet {
            updateAppearance()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        // Устанавливаем базовые настройки
        layer.borderColor = defaultBorderColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        backgroundColor = defaultBackgroundColor

        // Настройки текста
        setTitleColor(.systemBlue, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }

    private func updateAppearance() {
        // Изменяем стиль при нажатии
        layer.borderColor = isHighlighted ? highlightedBorderColor : defaultBorderColor
        backgroundColor = isHighlighted ? highlightedBackgroundColor : defaultBackgroundColor
    }
}
