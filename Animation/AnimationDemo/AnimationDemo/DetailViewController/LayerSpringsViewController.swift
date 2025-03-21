//
//  LayerSpringsViewController.swift
//  AnimationDemo
//
//  Created by Menkov Dmitriy on 07.03.2025.
//

import UIKit

import UIKit

final class LayerSpringsViewController: UIViewController {

    private let animatedLayer = CALayer()
    private let animateButton = UIButton(type: .system)

    private let massSlider = UISlider()
    private let stiffnessSlider = UISlider()
    private let dampingSlider = UISlider()
    private let velocitySlider = UISlider()

    private let massLabel = UILabel()
    private let stiffnessLabel = UILabel()
    private let dampingLabel = UILabel()
    private let velocityLabel = UILabel()

    private var mass: CGFloat = 1.0
    private var stiffness: CGFloat = 100.0
    private var damping: CGFloat = 10.0
    private var initialVelocity: CGFloat = 0.0
    private var isMovingDown = true // Флаг направления движения

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayer()
        setupUI()
        setupSliders()
    }

    // MARK: - Настройка слоя

    private func setupLayer() {
        animatedLayer.frame = CGRect(x: 150, y: 250, width: 100, height: 100)
        animatedLayer.backgroundColor = UIColor.systemBlue.cgColor
        animatedLayer.cornerRadius = 10
        view.layer.addSublayer(animatedLayer)
    }

    // MARK: - Настройка интерфейса

    private func setupUI() {
        animateButton.setTitle("Start Animation", for: .normal)
        animateButton.addTarget(self, action: #selector(startSpringAnimation), for: .touchUpInside)
        animateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animateButton)

        NSLayoutConstraint.activate([
            animateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }

    // MARK: - Настройка слайдеров

    private func setupSliders() {
        let stackView = UIStackView(arrangedSubviews: [
            createSliderView(slider: massSlider, label: massLabel, title: "Mass", min: 0.1, max: 5.0, value: mass),
            createSliderView(slider: stiffnessSlider, label: stiffnessLabel, title: "Stiffness", min: 10, max: 500, value: stiffness),
            createSliderView(slider: dampingSlider, label: dampingLabel, title: "Damping", min: 1, max: 50, value: damping),
            createSliderView(slider: velocitySlider, label: velocityLabel, title: "Velocity", min: 0, max: 10, value: initialVelocity)
        ])

        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: animateButton.topAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func createSliderView(slider: UISlider, label: UILabel, title: String, min: Float, max: Float, value: CGFloat) -> UIStackView {
        slider.minimumValue = min
        slider.maximumValue = max
        slider.value = Float(value)
        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)

        label.text = "\(title): \(String(format: "%.2f", value))"
        label.font = UIFont.systemFont(ofSize: 14)

        let stack = UIStackView(arrangedSubviews: [label, slider])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }

    // MARK: - Обработка изменения слайдеров

    @objc private func sliderChanged(_ sender: UISlider) {
        if sender == massSlider {
            mass = CGFloat(sender.value)
            massLabel.text = "Mass: \(String(format: "%.2f", mass))"
        } else if sender == stiffnessSlider {
            stiffness = CGFloat(sender.value)
            stiffnessLabel.text = "Stiffness: \(String(format: "%.2f", stiffness))"
        } else if sender == dampingSlider {
            damping = CGFloat(sender.value)
            dampingLabel.text = "Damping: \(String(format: "%.2f", damping))"
        } else if sender == velocitySlider {
            initialVelocity = CGFloat(sender.value)
            velocityLabel.text = "Velocity: \(String(format: "%.2f", initialVelocity))"
        }
    }

    // MARK: - Запуск пружинной анимации

    @objc private func startSpringAnimation() {
        let springAnimation = CASpringAnimation(keyPath: "position.y")
        let baseY: CGFloat = 250 // Новая базовая точка
        let newY: CGFloat = isMovingDown ? baseY + 100 : baseY - 100

        springAnimation.toValue = newY
        springAnimation.mass = mass
        springAnimation.stiffness = stiffness
        springAnimation.damping = damping
        springAnimation.initialVelocity = initialVelocity
        springAnimation.duration = springAnimation.settlingDuration

        // Фиксация конечного состояния
        springAnimation.fillMode = .forwards
        springAnimation.isRemovedOnCompletion = false

        animatedLayer.add(springAnimation, forKey: "springAnimation")
        isMovingDown.toggle() // Меняем направление
    }
}
