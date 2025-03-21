//
//  AnimationKeysAndDelegatesViewController.swift
//  AnimationDemo
//
//  Created by Menkov Dmitriy on 03.03.2025.
//

import UIKit

final class AnimationKeysAndDelegatesViewController: UIViewController, CAAnimationDelegate {

    private let animatedLayer = CALayer()
    private let startAnimationButton = UIButton(type: .system)
    private let statusLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayer()
        setupUI()
    }

    // MARK: - Настройка слоя

    private func setupLayer() {
        animatedLayer.frame = CGRect(x: 50, y: 150, width: 100, height: 100)
        animatedLayer.backgroundColor = UIColor.systemBlue.cgColor
        animatedLayer.cornerRadius = 10
        view.layer.addSublayer(animatedLayer)
    }

    // MARK: - Настройка интерфейса

    private func setupUI() {
        // Кнопка для запуска анимаций
        startAnimationButton.setTitle("Start Animations", for: .normal)
        startAnimationButton.addTarget(self, action: #selector(startAnimations), for: .touchUpInside)
        startAnimationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startAnimationButton)

        // Метка для отображения статуса анимации
        statusLabel.textAlignment = .center
        statusLabel.font = UIFont.systemFont(ofSize: 16)
        statusLabel.textColor = .label
        statusLabel.text = "Ready to animate!"
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)

        NSLayoutConstraint.activate([
            startAnimationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startAnimationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: startAnimationButton.topAnchor, constant: -20),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    // MARK: - Анимации

    @objc private func startAnimations() {
        startBasicAnimation()
        startColorAnimation()
    }

    // Пример 1: Анимация перемещения с ключом
    private func startBasicAnimation() {
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.fromValue = animatedLayer.position
        positionAnimation.toValue = CGPoint(x: 300, y: 300)
        positionAnimation.duration = 2.0
        positionAnimation.delegate = self

        // Добавляем анимацию с ключом
        animatedLayer.add(positionAnimation, forKey: "positionAnimation")

        // Обновляем значение слоя
        animatedLayer.position = CGPoint(x: 300, y: 300)
    }

    // Пример 2: Анимация цвета с ключом
    private func startColorAnimation() {
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.systemBlue.cgColor
        colorAnimation.toValue = UIColor.systemRed.cgColor
        colorAnimation.duration = 2.0
        colorAnimation.delegate = self

        // Добавляем анимацию с ключом
        animatedLayer.add(colorAnimation, forKey: "colorAnimation")

        // Обновляем значение слоя
        animatedLayer.backgroundColor = UIColor.systemRed.cgColor
    }

    // MARK: - CAAnimationDelegate

    func animationDidStart(_ anim: CAAnimation) {
        if anim == animatedLayer.animation(forKey: "positionAnimation") {
            updateStatusLabel(with: "Position animation started!")
        } else if anim == animatedLayer.animation(forKey: "colorAnimation") {
            updateStatusLabel(with: "Color animation started!")
        }
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            if anim == animatedLayer.animation(forKey: "positionAnimation") {
                updateStatusLabel(with: "Position animation finished!")
            } else if anim == animatedLayer.animation(forKey: "colorAnimation") {
                updateStatusLabel(with: "Color animation finished!")
            }
        }
    }

    // MARK: - Утилиты

    private func updateStatusLabel(with text: String) {
        statusLabel.text = text
    }
}
