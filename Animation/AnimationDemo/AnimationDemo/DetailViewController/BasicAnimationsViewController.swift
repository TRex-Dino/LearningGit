//
//  BasicAnimationsViewController.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 14.12.2024.
//

import UIKit

final class BasicAnimationsViewController: UIViewController {
    private let animatedView = UIView()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "В UIKit анимации позволяют изменять свойства представлений (например, frame, alpha, backgroundColor и другие) с плавным переходом. Основным инструментом для этого является метод UIView.animate."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    private let alphaButton = DefaultButton()
    private let sizeButton = DefaultButton()
    private let transformButton = DefaultButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        animatedView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        animatedView.backgroundColor = .blue
        animatedView.center = view.center
        view.addSubview(animatedView)

        setupDescriptionLabel()
        setupButtons()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 20
        let totalButtonWidth = 3 * buttonWidth + 2 * buttonSpacing

        let startX = (view.bounds.width - totalButtonWidth) / 2
        let startY: CGFloat = descriptionLabel.frame.maxY + 10
        alphaButton.frame = CGRect(x: startX, y: startY, width: buttonWidth, height: buttonHeight)
        sizeButton.frame =  CGRect(x: startX + buttonWidth + buttonSpacing, y: startY, width: buttonWidth, height: buttonHeight)
        transformButton.frame =  CGRect(x: startX + 2 * (buttonWidth + buttonSpacing), y: startY, width: buttonWidth, height: buttonHeight)
    }

    private func setupButtons() {
        alphaButton.setTitle("Alpha", for: .normal)
        alphaButton.addTarget(self, action: #selector(animateAlpha), for: .touchUpInside)
        view.addSubview(alphaButton)

        sizeButton.setTitle("Size", for: .normal)
        sizeButton.addTarget(self, action: #selector(animateSize), for: .touchUpInside)
        view.addSubview(sizeButton)

        transformButton.setTitle("Transform", for: .normal)
        transformButton.addTarget(self, action: #selector(animateTransform), for: .touchUpInside)
        view.addSubview(transformButton)
    }

    private func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }

    @objc func animateAlpha() {
        UIView.animate(
            withDuration: 1.0,
            animations: {
                self.animatedView.alpha = self.animatedView.alpha == 1.0 ? 0.5 : 1.0
            }
        )
    }

    @objc func animateSize() {
        animatedView.transform = .identity
        UIView.animate(
            withDuration: 1.0,
            animations: {
                let isSmall = self.animatedView.frame.size == CGSize(width: 100, height: 100)
                self.animatedView.frame.size = isSmall ? CGSize(width: 200, height: 200) : CGSize(width: 100, height: 100)
                self.animatedView.center = self.view.center
            }
        )
    }

    @objc func animateTransform() {
        UIView.animate(
            withDuration: 1.0,
            animations: {
                if self.animatedView.transform == .identity {
                    self.animatedView.transform = CGAffineTransform(rotationAngle: .pi / 4)
                        .concatenating(CGAffineTransform(scaleX: 1.5, y: 1.5))
                } else {
                    self.animatedView.transform = .identity
                }
            }
        )
    }
}

