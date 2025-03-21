//
//  File.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 07.01.2025.
//

import UIKit

final class AnimationsPracticeViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "house.fill")
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Hello!"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()

    private let fadeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Crossfade Image", for: .normal)
        return button
    }()

    private let cubeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cube Transition", for: .normal)
        return button
    }()

    private let bounceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Fade & Bounce", for: .normal)
        return button
    }()
    private var directionCube = AnimationDirection.down

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        [imageView, label, fadeButton, cubeButton, bounceButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),

            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            fadeButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            fadeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            cubeButton.topAnchor.constraint(equalTo: fadeButton.bottomAnchor, constant: 20),
            cubeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            bounceButton.topAnchor.constraint(equalTo: cubeButton.bottomAnchor, constant: 20),
            bounceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        fadeButton.addTarget(self, action: #selector(handleFadeAnimation), for: .touchUpInside)
        cubeButton.addTarget(self, action: #selector(handleCubeTransition), for: .touchUpInside)
        bounceButton.addTarget(self, action: #selector(handleFadeAndBounce), for: .touchUpInside)
    }

    // MARK: - Animations

    @objc private func handleFadeAnimation() {
        let nextImage = UIImage(systemName: imageView.image == UIImage(systemName: "house.fill") ? "star.fill" : "house.fill")!
        UIView.transition(with: imageView, duration: 1.0, options: .transitionCrossDissolve) {
            self.imageView.image = nextImage
        }
    }

    @objc private func handleCubeTransition() {
        let newText = generateRandomTime()
        cubeTransition(label: label, text: newText, direction: directionCube)
        directionCube = directionCube == .down ? .up : .down
    }

    // Функция генерации случайного времени
    private func generateRandomTime() -> String {
        let randomHour = Int.random(in: 0...23)
        let randomMinute = Int.random(in: 0...59)
        return String(format: "%02d:%02d", randomHour, randomMinute)
    }

    @objc private func handleFadeAndBounce() {
        let newText = label.text == "Hello!" ? "Welcome Back!" : "Hello!"
        moveLabel(label: label, text: newText, offset: CGPoint(x: 0, y: -50))
    }

    // MARK: - Animation Helpers

    private func cubeTransition(label: UILabel, text: String, direction: AnimationDirection) {
        let auxLabel = UILabel()
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        auxLabel.backgroundColor = label.backgroundColor
        auxLabel.translatesAutoresizingMaskIntoConstraints = false

        // Добавляем временный лейбл в супервью
        label.superview?.addSubview(auxLabel)

        // Констрейнты временного лейбла совпадают с оригинальным
        NSLayoutConstraint.activate([
            auxLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            auxLabel.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            auxLabel.topAnchor.constraint(equalTo: label.topAnchor),
            auxLabel.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])

        // Начальное состояние для анимации
        let auxLabelOffset = CGFloat(direction.rawValue) * label.frame.size.height / 2.0
        auxLabel.transform = CGAffineTransform(translationX: 0.0, y: auxLabelOffset).scaledBy(x: 1.0, y: 0.1)

        // Анимация
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            auxLabel.transform = .identity
            label.transform = CGAffineTransform(translationX: 0.0, y: -auxLabelOffset).scaledBy(x: 1.0, y: 0.1)
        }, completion: { _ in
            // Завершаем анимацию, обновляем текст
            label.text = auxLabel.text
            label.transform = .identity
            auxLabel.removeFromSuperview()
        })
    }

    private func moveLabel(label: UILabel, text: String, offset: CGPoint) {
        let auxLabel = UILabel()
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        auxLabel.backgroundColor = .clear
        auxLabel.translatesAutoresizingMaskIntoConstraints = false

        // Добавляем временный лейбл в супервью
        label.superview?.addSubview(auxLabel)

        // Констрейнты временного лейбла совпадают с оригинальным
        NSLayoutConstraint.activate([
            auxLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            auxLabel.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            auxLabel.topAnchor.constraint(equalTo: label.topAnchor),
            auxLabel.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])

        // Начальное состояние для анимации
        auxLabel.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        auxLabel.alpha = 0

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            label.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
            label.alpha = 0.0
        }, completion: nil)

        UIView.animate(withDuration: 0.25, delay: 0.1, options: .curveEaseIn, animations: {
            auxLabel.transform = .identity
            auxLabel.alpha = 1.0
        }, completion: { _ in
            // Завершаем анимацию, обновляем текст
            auxLabel.removeFromSuperview()
            label.text = text
            label.alpha = 1.0
            label.transform = .identity
        })
    }

}

// Helper enum for cube direction
private enum AnimationDirection: Int {
    case up = -1
    case down = 1
}
