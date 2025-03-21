//
//  AnimationGroupAndAdvancedTimingViewController.swift
//  AnimationDemo
//
//  Created by Menkov Dmitriy on 07.03.2025.
//

import UIKit

final class AnimationGroupAndAdvancedTimingViewController: UIViewController {

    private let animatedLayer = CALayer()
    private let startButton = UIButton(type: .system)
    private let settingsButton = UIButton(type: .system)
    private let statusLabel = UILabel()

    // Настройки анимации
    private var selectedTimingFunction: CAMediaTimingFunctionName = .easeInEaseOut
    private var animationSpeed: Float = 1.0
    private var animationDelay: CFTimeInterval = 0.0
    private var repeatCount: Float = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayer()
        setupUI()
    }

    // MARK: - Настройка слоя

    private func setupLayer() {
        animatedLayer.frame = CGRect(x: 100, y: 150, width: 100, height: 100)
        animatedLayer.backgroundColor = UIColor.systemBlue.cgColor
        animatedLayer.cornerRadius = 10
        view.layer.addSublayer(animatedLayer)
    }

    // MARK: - Настройка интерфейса

    private func setupUI() {
        startButton.setTitle("Start Animation", for: .normal)
        startButton.addTarget(self, action: #selector(startGroupAnimation), for: .touchUpInside)

        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.addTarget(self, action: #selector(openSettingsMenu), for: .touchUpInside)

        statusLabel.text = "Ready to animate!"
        statusLabel.textAlignment = .center
        statusLabel.font = UIFont.systemFont(ofSize: 16)
        statusLabel.textColor = .label

        let stackView = UIStackView(arrangedSubviews: [startButton, settingsButton])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually

        stackView.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        view.addSubview(statusLabel)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            stackView.widthAnchor.constraint(equalToConstant: 350),

            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    // MARK: - Групповая Анимация

    @objc private func startGroupAnimation() {
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.toValue = CGPoint(x: 300, y: 400)

        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.toValue = UIColor.systemRed.cgColor

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.toValue = 0.5

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [positionAnimation, colorAnimation, opacityAnimation]
        animationGroup.duration = 2.0 / Double(animationSpeed)
        animationGroup.beginTime = CACurrentMediaTime() + animationDelay
        animationGroup.repeatCount = repeatCount
        animationGroup.timingFunction = CAMediaTimingFunction(name: selectedTimingFunction)

        animatedLayer.add(animationGroup, forKey: "groupAnimation")
        updateStatusLabel(with: "Animation started with settings")
    }

    // MARK: - Меню настроек анимации

    @objc private func openSettingsMenu() {
        let alert = UIAlertController(title: "Animation Settings", message: nil, preferredStyle: .actionSheet)

        // Выбор `timingFunction`
        alert.addAction(UIAlertAction(title: "Timing: Ease In", style: .default, handler: { _ in
            self.selectedTimingFunction = .easeIn
        }))
        alert.addAction(UIAlertAction(title: "Timing: Ease Out", style: .default, handler: { _ in
            self.selectedTimingFunction = .easeOut
        }))
        alert.addAction(UIAlertAction(title: "Timing: Linear", style: .default, handler: { _ in
            self.selectedTimingFunction = .linear
        }))
        alert.addAction(UIAlertAction(title: "Timing: Ease In-Out", style: .default, handler: { _ in
            self.selectedTimingFunction = .easeInEaseOut
        }))

        // Выбор `speed`
        alert.addAction(UIAlertAction(title: "Speed: 0.5x (Slower)", style: .default, handler: { _ in
            self.animationSpeed = 0.5
        }))
        alert.addAction(UIAlertAction(title: "Speed: 1.0x (Normal)", style: .default, handler: { _ in
            self.animationSpeed = 1.0
        }))
        alert.addAction(UIAlertAction(title: "Speed: 2.0x (Faster)", style: .default, handler: { _ in
            self.animationSpeed = 2.0
        }))

        // Выбор `beginTime`
        alert.addAction(UIAlertAction(title: "Delay: 0 sec", style: .default, handler: { _ in
            self.animationDelay = 0.0
        }))
        alert.addAction(UIAlertAction(title: "Delay: 1 sec", style: .default, handler: { _ in
            self.animationDelay = 1.0
        }))
        alert.addAction(UIAlertAction(title: "Delay: 2 sec", style: .default, handler: { _ in
            self.animationDelay = 2.0
        }))

        // Выбор `repeatCount`
        alert.addAction(UIAlertAction(title: "Repeat: 1x", style: .default, handler: { _ in
            self.repeatCount = 1
        }))
        alert.addAction(UIAlertAction(title: "Repeat: 3x", style: .default, handler: { _ in
            self.repeatCount = 3
        }))
        alert.addAction(UIAlertAction(title: "Repeat: 5x", style: .default, handler: { _ in
            self.repeatCount = 5
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alert, animated: true)
    }

    // MARK: - Обновление статуса

    private func updateStatusLabel(with text: String) {
        statusLabel.text = text
    }
}
