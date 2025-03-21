//
//  KeyframeAnimationsViewController.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 15.01.2025.
//

import UIKit

/// - withRelativeStartTime: Время начала этапа относительно общей длительности.
/// - relativeDuration: Продолжительность этапа в процентах от общей длительности.
final class KeyframeAnimationsViewController: UIViewController {
    private let planeImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "airplane"))
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let rectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        return view
    }()

    private let planeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Plane Animation", for: .normal)
        return button
    }()

    private let rectangleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Rectangle Animation", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        [planeImage, rectangleView, planeButton, rectangleButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            planeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            planeImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            planeImage.widthAnchor.constraint(equalToConstant: 80),
            planeImage.heightAnchor.constraint(equalToConstant: 80),

            rectangleView.widthAnchor.constraint(equalToConstant: 50),
            rectangleView.heightAnchor.constraint(equalToConstant: 50),
            rectangleView.topAnchor.constraint(equalTo: planeImage.bottomAnchor, constant: 100),
            rectangleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),

            planeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            planeButton.topAnchor.constraint(equalTo: rectangleView.bottomAnchor, constant: 50),

            rectangleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rectangleButton.topAnchor.constraint(equalTo: planeButton.bottomAnchor, constant: 20)
        ])

        planeButton.addTarget(self, action: #selector(planeDepart), for: .touchUpInside)
        rectangleButton.addTarget(self, action: #selector(animateRectangle), for: .touchUpInside)
    }

    // MARK: - Keyframe Animations

    @objc private func planeDepart() {
        let originalCenter = planeImage.center

        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: [], animations: {
            // Этап 1: Ускорение на взлетной полосе
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                self.planeImage.center.x += 100
                self.planeImage.center.y -= 10
            }

            // Этап 2: Подъем и наклон
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.planeImage.transform = CGAffineTransform(rotationAngle: -.pi / 8)
                self.planeImage.center.y -= 50
            }

            // Этап 3: Исчезновение в правом верхнем углу
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                self.planeImage.alpha = 0.0
                self.planeImage.center.x += 100
                self.planeImage.center.y -= 100
            }

            // Этап 4: Появление из левого центра
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.01) {
                self.planeImage.center.x = -50
                self.planeImage.center.y = originalCenter.y
            }

            // Этап 5: Плавное появление из левого центра
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.2) {
                self.planeImage.alpha = 1.0
                self.planeImage.transform = CGAffineTransform(rotationAngle: .pi / 8)
            }

            // Этап 6: Возвращение в исходное положение
            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.1) {
                self.planeImage.center = originalCenter
                self.planeImage.transform = .identity
            }
        }, completion: nil)
    }



    @objc private func animateRectangle() {
        UIView.animateKeyframes(withDuration: 4.0, delay: 0.0, options: [.repeat], animations: {
            // Stage 1: Move right
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                self.rectangleView.center.x += 200
            }

            // Stage 2: Move down
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.rectangleView.center.y += 200
            }

            // Stage 3: Move left
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                self.rectangleView.center.x -= 200
            }

            // Stage 4: Move up
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.rectangleView.center.y -= 200
            }
        }, completion: nil)
    }
}
