//
//  LayerKeyframeAnimationsViewController.swift
//  AnimationDemo
//
//  Created by Menkov Dmitriy on 08.03.2025.
//

import UIKit

final class LayerKeyframeAnimationsViewController: UIViewController {

    private let animatedLayer = CALayer()
    private let startButton = UIButton(type: .system)
    private let pathButton = UIButton(type: .system)
    private let sizeButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayer()
        setupUI()
    }

    // MARK: - Настройка слоя (круг в верхней точке по центру)

    private func setupLayer() {
        let size: CGFloat = 50
        let startX = view.bounds.midX - size / 2
        let startY: CGFloat = 100

        animatedLayer.frame = CGRect(x: startX, y: startY, width: size, height: size)
        animatedLayer.backgroundColor = UIColor.systemBlue.cgColor
        animatedLayer.cornerRadius = size / 2
        view.layer.addSublayer(animatedLayer)
    }

    // MARK: - Настройка интерфейса

    private func setupUI() {
        startButton.setTitle("Keyframe Move", for: .normal)
        startButton.addTarget(self, action: #selector(startKeyframeAnimation), for: .touchUpInside)

        pathButton.setTitle("Spiral Path", for: .normal)
        pathButton.addTarget(self, action: #selector(startSpiralPathAnimation), for: .touchUpInside)

        sizeButton.setTitle("Size Animation", for: .normal)
        sizeButton.addTarget(self, action: #selector(startSizeAnimation), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [startButton, pathButton, sizeButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }

    // MARK: - Пример 1: Ключевая анимация движения вниз зигзагом

    @objc private func startKeyframeAnimation() {
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "position")

        let midX = view.bounds.midX
        let leftX = midX - 100
        let rightX = midX + 100
        let bottomY = view.bounds.height - 150

        keyframeAnimation.values = [
            CGPoint(x: midX, y: 100),   // Начало сверху
            CGPoint(x: leftX, y: 250),  // Влево
            CGPoint(x: rightX, y: 400), // Вправо
            CGPoint(x: leftX, y: 550),  // Влево
            CGPoint(x: rightX, y: bottomY) // Вправо вниз
        ].map { NSValue(cgPoint: $0) }

        keyframeAnimation.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        keyframeAnimation.duration = 4.0
        keyframeAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        animatedLayer.add(keyframeAnimation, forKey: "moveAlongKeyframes")
    }

    // MARK: - Пример 2: Анимация изменения размера с перемещением в центр

    @objc private func startSizeAnimation() {
        let midX = view.bounds.midX
        let midY = view.bounds.midY

        // Перемещение в центр
        let moveAnimation = CABasicAnimation(keyPath: "position")
        moveAnimation.toValue = CGPoint(x: midX, y: midY)
        moveAnimation.duration = 1.0

        // Анимация изменения размера с сохранением формы круга
        let sizeAnimation = CAKeyframeAnimation(keyPath: "bounds.size")
        let sizes: [CGFloat] = [50, 200, 80, 150, 50] // Разные размеры
        sizeAnimation.values = sizes.map { NSValue(cgSize: CGSize(width: $0, height: $0)) }
        sizeAnimation.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        sizeAnimation.duration = 4.0

        // Анимация радиуса скругления
        let cornerRadiusAnimation = CAKeyframeAnimation(keyPath: "cornerRadius")
        cornerRadiusAnimation.values = sizes.map { $0 / 2 }
        cornerRadiusAnimation.keyTimes = sizeAnimation.keyTimes
        cornerRadiusAnimation.duration = sizeAnimation.duration

        // Групповая анимация
        let group = CAAnimationGroup()
        group.animations = [moveAnimation, sizeAnimation, cornerRadiusAnimation]
        group.duration = 4.0

        animatedLayer.add(group, forKey: "sizeAnimation")
        animatedLayer.position = CGPoint(x: midX, y: midY)
    }

    // MARK: - Пример 3: Увеличенная спираль

    @objc private func startSpiralPathAnimation() {
        let path = UIBezierPath()
        let center = CGPoint(x: view.bounds.midX, y: view.bounds.midY + 100)
        let rotations = 5
        let radiusIncrement: CGFloat = 25

        path.move(to: center)

        for i in 1...(rotations * 12) {
            let angle = CGFloat(i) * (.pi / 6) // Каждый шаг = 30°
            let radius = CGFloat(i) * radiusIncrement / 12 // Увеличение радиуса

            let x = center.x + radius * cos(angle)
            let y = center.y + radius * sin(angle)
            path.addLine(to: CGPoint(x: x, y: y))
        }

        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        pathAnimation.path = path.cgPath
        pathAnimation.duration = 6.0
        pathAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        animatedLayer.add(pathAnimation, forKey: "spiralPathAnimation")
    }
}
