//
//  GradientAnimationsViewController.swift
//  AnimationDemo
//
//  Created by Menkov Dmitriy on 08.03.2025.
//

import UIKit

final class GradientAnimationsViewController: UIViewController {

    private let gradientLayer = CAGradientLayer()
    private let shimmerLayer = CAGradientLayer()
    private let progressLayer = CAGradientLayer()
    private let buttonGradientLayer = CAGradientLayer()

    private var progressBar: UIView?
    private var shimmerLabel: UILabel?

    private let menuButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupUI()
    }

    // MARK: - Установка фона (белый если нет градиента)
    private func setupGradientLayer() {
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.white.cgColor,  // Дефолтный фон - белый
            UIColor.white.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    // MARK: - Сброс анимаций перед запуском новой
    private func resetState() {
        gradientLayer.removeAllAnimations()
        shimmerLayer.removeAllAnimations()
        progressLayer.removeAllAnimations()
        buttonGradientLayer.removeAllAnimations()

        // Удаляем прогресс-бар и шиммер-текст, если они были созданы
        progressBar?.removeFromSuperview()
        shimmerLabel?.removeFromSuperview()

        // Сбрасываем фон на белый
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor.white.cgColor
        ]
    }

    // MARK: - Настройка UI
    private func setupUI() {
        menuButton.setTitle("Show Menu", for: .normal)
        menuButton.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuButton)

        NSLayoutConstraint.activate([
            menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }

    // MARK: - Меню выбора анимации
    @objc private func showMenu() {
        let alert = UIAlertController(title: "Gradient Animations", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Color Change", style: .default, handler: { _ in
            self.resetState()
            self.animateGradientColors()
        }))
        alert.addAction(UIAlertAction(title: "Direction Change", style: .default, handler: { _ in
            self.resetState()
            self.animateGradientDirection()
        }))
        alert.addAction(UIAlertAction(title: "Shimmer Effect", style: .default, handler: { _ in
            self.resetState()
            self.setupShimmerEffect()
        }))
        alert.addAction(UIAlertAction(title: "Gradient Progress Bar", style: .default, handler: { _ in
            self.resetState()
            self.setupProgressBar()
        }))
        alert.addAction(UIAlertAction(title: "Button Gradient Effect", style: .default, handler: { _ in
            self.resetState()
            self.setupGradientButton()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alert, animated: true)
    }

    // MARK: - 1. Анимация смены цветов градиента
    private func animateGradientColors() {
        gradientLayer.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemPurple.cgColor
        ]

        let colorAnimation = CABasicAnimation(keyPath: "colors")
        colorAnimation.toValue = [
            UIColor.systemPink.cgColor,
            UIColor.systemOrange.cgColor
        ]
        colorAnimation.duration = 2.0
        colorAnimation.autoreverses = true
        colorAnimation.repeatCount = .infinity

        gradientLayer.add(colorAnimation, forKey: "colorAnimation")
    }

    // MARK: - 2. Анимация изменения направления градиента
    private func animateGradientDirection() {
        gradientLayer.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemPurple.cgColor
        ]

        let directionAnimation = CABasicAnimation(keyPath: "startPoint")
        directionAnimation.fromValue = CGPoint(x: 0, y: 0)
        directionAnimation.toValue = CGPoint(x: 1, y: 1)
        directionAnimation.duration = 3.0
        directionAnimation.repeatCount = .infinity
        directionAnimation.autoreverses = true

        gradientLayer.add(directionAnimation, forKey: "directionAnimation")
    }

    // MARK: - 3. Исправлено: Шиммер-эффект теперь работает
    private func setupShimmerEffect() {
        shimmerLabel = UILabel(frame: CGRect(x: 50, y: 300, width: 300, height: 100))
        shimmerLabel?.text = "Shimmer Effect"
        shimmerLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        view.addSubview(shimmerLabel!)

        shimmerLayer.frame = shimmerLabel!.bounds
        shimmerLayer.colors = [
            UIColor.white.withAlphaComponent(0.3).cgColor,
            UIColor.white.withAlphaComponent(1.0).cgColor,
            UIColor.white.withAlphaComponent(0.3).cgColor
        ]
        shimmerLayer.startPoint = CGPoint(x: -1, y: 0.5)
        shimmerLayer.endPoint = CGPoint(x: 1, y: 0.5)

        shimmerLabel!.layer.mask = shimmerLayer

        let shimmerAnimation = CABasicAnimation(keyPath: "locations")
        shimmerAnimation.fromValue = [-1.0, -0.5, 0.0]
        shimmerAnimation.toValue = [1.0, 1.5, 2.0]
        shimmerAnimation.duration = 2.0
        shimmerAnimation.repeatCount = .infinity

        shimmerLayer.add(shimmerAnimation, forKey: "shimmerAnimation")
    }

    // MARK: - 4. Исправлено: Прогресс-бар теперь корректно заполняется
    private func setupProgressBar() {
        progressBar = UIView(frame: CGRect(x: 50, y: 400, width: 300, height: 20))
        progressBar!.layer.cornerRadius = 10
        progressBar!.clipsToBounds = true
        view.addSubview(progressBar!)

        progressLayer.frame = CGRect(x: 0, y: 0, width: 0, height: 20)
        progressLayer.colors = [UIColor.green.cgColor, UIColor.blue.cgColor]
        progressLayer.startPoint = CGPoint(x: 0, y: 0.5)
        progressLayer.endPoint = CGPoint(x: 1, y: 0.5)

        progressBar!.layer.addSublayer(progressLayer)

        UIView.animate(withDuration: 2.0) {
            self.progressLayer.frame.size.width = 300
        }
    }

    // MARK: - 5. Градиентная кнопка с изменением цвета
    private func setupGradientButton() {
        let button = UIButton(type: .system)
        button.setTitle("Tap Me", for: .normal)
        button.frame = CGRect(x: 100, y: 500, width: 200, height: 50)
        button.addTarget(self, action: #selector(changeGradientColor), for: .touchUpInside)
        view.addSubview(button)

        buttonGradientLayer.frame = button.bounds
        buttonGradientLayer.colors = [
            UIColor.red.cgColor,
            UIColor.orange.cgColor
        ]
        button.layer.insertSublayer(buttonGradientLayer, at: 0)
    }

    @objc private func changeGradientColor() {
        let colorAnimation = CABasicAnimation(keyPath: "colors")
        colorAnimation.toValue = [
            UIColor.blue.cgColor,
            UIColor.green.cgColor
        ]
        colorAnimation.duration = 1.0
        colorAnimation.fillMode = .forwards
        colorAnimation.isRemovedOnCompletion = false

        buttonGradientLayer.add(colorAnimation, forKey: "colorChangeAnimation")
    }
}
