//
//  PropertyAnimatorViewController.swift
//  AnimationDemo
//
//  Created by Menkov Dmitriy on 06.03.2025.
//

import UIKit

final class PropertyAnimatorViewController: UIViewController {

    private let animatedView = UIView()
    private let startButton = UIButton(type: .system)
    private let pauseButton = UIButton(type: .system)
    private let reverseButton = UIButton(type: .system)
    private let statusLabel = UILabel()
    private var isMovingDown = true

    private var animator: UIViewPropertyAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupAnimator()
    }

    // MARK: - Настройка интерфейса

    private func setupUI() {
        animatedView.frame = CGRect(x: 100, y: 200, width: 100, height: 100)
        animatedView.backgroundColor = .systemBlue
        animatedView.layer.cornerRadius = 10
        view.addSubview(animatedView)

        startButton.setTitle("Start", for: .normal)
        startButton.addTarget(self, action: #selector(startAnimation), for: .touchUpInside)

        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.addTarget(self, action: #selector(pauseAnimation), for: .touchUpInside)

        reverseButton.setTitle("Reverse", for: .normal)
        reverseButton.addTarget(self, action: #selector(reverseAnimation), for: .touchUpInside)

        statusLabel.text = "Ready to animate!"
        statusLabel.textAlignment = .center
        statusLabel.font = UIFont.systemFont(ofSize: 16)
        statusLabel.textColor = .label

        let stackView = UIStackView(arrangedSubviews: [startButton, pauseButton, reverseButton])
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
            stackView.widthAnchor.constraint(equalToConstant: 300),

            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        animatedView.addGestureRecognizer(panGesture)
        animatedView.isUserInteractionEnabled = true
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let progress = translation.y / 200

        switch gesture.state {
        case .began:
            animator?.startAnimation()
            animator?.pauseAnimation()
        case .changed:
            animator?.fractionComplete = min(max(progress, 0), 1)
        case .ended, .cancelled:
            animator?.continueAnimation(withTimingParameters: nil, durationFactor: 1.0)
        default:
            break
        }
    }

    // MARK: - Настройка аниматора

    private func setupAnimator() {
        let newY: CGFloat = isMovingDown ? animatedView.frame.origin.y + 200 : animatedView.frame.origin.y - 200
        let newColor: UIColor = isMovingDown ? .systemRed : .systemBlue
        let newTransform: CGAffineTransform = isMovingDown ? CGAffineTransform(scaleX: 1.2, y: 1.2) : .identity

        animator = UIViewPropertyAnimator(duration: 1.5, dampingRatio: 0.7) {
            self.animatedView.frame.origin.y = newY
            self.animatedView.backgroundColor = newColor
            self.animatedView.transform = newTransform
        }

        animator?.addCompletion { position in
            switch position {
            case .start:
                self.updateStatusLabel(with: "Animation returned to start")
            case .current:
                self.updateStatusLabel(with: "Animation stopped at current position")
            case .end:
                self.updateStatusLabel(with: "Animation finished!")
                self.isMovingDown.toggle()
                self.resetAnimator()
            @unknown default:
                break
            }
        }
    }

    // MARK: - Управление анимацией

    @objc private func startAnimation() {
        if animator == nil {
            setupAnimator()
        }
        updateStatusLabel(with: "Animation started")
        animator?.startAnimation()
    }

    @objc private func pauseAnimation() {
        guard let animator = animator else { return }

        if animator.isRunning {
            animator.pauseAnimation()
            updateStatusLabel(with: "Animation paused")
        } else {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 1.0)
            updateStatusLabel(with: "Animation continued")
        }
    }

    @objc private func reverseAnimation() {
        guard let animator = animator else { return }
        animator.isReversed.toggle()
        animator.startAnimation()
        updateStatusLabel(with: animator.isReversed ? "Animation reversed" : "Animation forward")
    }

    private func resetAnimator() {
        animator = nil
    }

    // MARK: - Обновление статуса

    private func updateStatusLabel(with text: String) {
        statusLabel.text = text
    }
}

