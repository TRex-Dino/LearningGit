//
//  LayerShapesAndMasksViewController.swift
//  AnimationDemo
//
//  Created by Menkov Dmitriy on 08.03.2025.
//

import UIKit

final class LayerShapesAndMasksViewController: UIViewController {

    private let shapeLayer = CAShapeLayer()
    private let maskTextLayer = CATextLayer()
    private let progressLayer = CAShapeLayer()
    private let barView = UIView()
    private let imageView = UIImageView()

    private let drawButton = UIButton(type: .system)
    private let maskButton = UIButton(type: .system)
    private let progressButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupImageView()
        setupShapeLayer()
        setupTextMask()
        setupProgressBar()
        setupUI()
    }

    // MARK: - Устанавливаем изображение (Заменяем `UIImage(named: "background")`)

    private func setupImageView() {
        imageView.image = UIImage(systemName: "star.fill") // Используем системное изображение
        imageView.tintColor = .systemYellow
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 50, y: 200, width: 300, height: 200)
        view.addSubview(imageView)
    }

    // MARK: - Настройка CAShapeLayer (Круг)

    private func setupShapeLayer() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.bounds.midX, y: 150),
                                      radius: 50,
                                      startAngle: 0,
                                      endAngle: .pi * 2,
                                      clockwise: true)

        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.systemBlue.cgColor
        shapeLayer.lineWidth = 5.0
        shapeLayer.strokeEnd = 0.0  // Линия невидима в начале

        view.layer.addSublayer(shapeLayer)
    }

    // MARK: - Настройка текстовой маски

    private func setupTextMask() {
        maskTextLayer.string = "HELLO, iOS!"
        maskTextLayer.fontSize = 50
        maskTextLayer.alignmentMode = .center
        maskTextLayer.frame = imageView.bounds
        maskTextLayer.foregroundColor = UIColor.black.cgColor
        maskTextLayer.contentsScale = UIScreen.main.scale
        maskTextLayer.opacity = 1.0 // Теперь сразу виден

        imageView.layer.mask = maskTextLayer  // Устанавливаем маску на изображение
    }

    // MARK: - Настройка анимированного прогресс-бара

    private func setupProgressBar() {
        let barFrame = CGRect(x: 50, y: 500, width: 300, height: 20)
        barView.frame = barFrame
        barView.backgroundColor = .lightGray
        view.addSubview(barView)

        progressLayer.frame = CGRect(x: 0, y: 0, width: barFrame.width, height: barFrame.height)
        progressLayer.backgroundColor = UIColor.systemBlue.cgColor
        progressLayer.transform = CATransform3DMakeScale(0, 1, 1) // Начинаем с нулевого масштаба

        barView.layer.addSublayer(progressLayer) // Добавляем прогресс в barView
    }

    // MARK: - Настройка интерфейса

    private func setupUI() {
        drawButton.setTitle("Draw Circle", for: .normal)
        drawButton.addTarget(self, action: #selector(animateStroke), for: .touchUpInside)

        maskButton.setTitle("Animate Mask", for: .normal)
        maskButton.addTarget(self, action: #selector(animateTextMask), for: .touchUpInside)

        progressButton.setTitle("Progress Animation", for: .normal)
        progressButton.addTarget(self, action: #selector(animateProgress), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [drawButton, maskButton, progressButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }

    // MARK: - Анимация рисования круга

    @objc private func animateStroke() {
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0.0
        strokeAnimation.toValue = 1.0
        strokeAnimation.duration = 2.0

        shapeLayer.add(strokeAnimation, forKey: "strokeAnimation")
    }

    // MARK: - Анимация текстовой маски (проявление текста)

    @objc private func animateTextMask() {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0.0
        fadeInAnimation.toValue = 1.0
        fadeInAnimation.duration = 2.0
        fadeInAnimation.fillMode = .forwards
        fadeInAnimation.isRemovedOnCompletion = false

        maskTextLayer.add(fadeInAnimation, forKey: "fadeInAnimation")
    }

    // MARK: - Анимация прогресс-бара (изменение ширины)

    @objc private func animateProgress() {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.duration = 2.0
        scaleAnimation.fillMode = .forwards
        scaleAnimation.isRemovedOnCompletion = false

        progressLayer.add(scaleAnimation, forKey: "progressAnimation")
    }
}
