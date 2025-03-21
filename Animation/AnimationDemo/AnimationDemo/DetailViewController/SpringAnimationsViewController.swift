//
//  File.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 06.01.2025.
//

import UIKit

final class SpringAnimationsViewController: UIViewController {

    private let animatedView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 25
        return view
    }()

    private let dampingSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.1
        slider.maximumValue = 1.0
        slider.value = 0.5
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    private let velocitySlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.0
        slider.maximumValue = 2.0
        slider.value = 1.0
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    private let dampingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let velocityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let animateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Animate", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var isViewAtTop: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupNavigationBar()
        updateLabels()
    }

    private func setupUI() {
        view.addSubview(animatedView)
        view.addSubview(dampingSlider)
        view.addSubview(velocitySlider)
        view.addSubview(dampingLabel)
        view.addSubview(velocityLabel)
        view.addSubview(animateButton)

        animatedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animatedView.widthAnchor.constraint(equalToConstant: 50),
            animatedView.heightAnchor.constraint(equalToConstant: 50),
            animatedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animatedView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),

            dampingSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dampingSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dampingSlider.bottomAnchor.constraint(equalTo: dampingLabel.topAnchor, constant: -8),

            dampingLabel.bottomAnchor.constraint(equalTo: velocitySlider.topAnchor, constant: -30),
            dampingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            velocitySlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            velocitySlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            velocitySlider.bottomAnchor.constraint(equalTo: velocityLabel.topAnchor, constant: -8),

            velocityLabel.bottomAnchor.constraint(equalTo: animateButton.topAnchor, constant: -15),
            velocityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            animateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            animateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        dampingSlider.addTarget(self, action: #selector(updateLabels), for: .valueChanged)
        velocitySlider.addTarget(self, action: #selector(updateLabels), for: .valueChanged)
        animateButton.addTarget(self, action: #selector(animateView), for: .touchUpInside)
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Info",
            style: .plain,
            target: self,
            action: #selector(showInfoAlert)
        )
    }

    @objc private func updateLabels() {
        dampingLabel.text = "Damping: \(String(format: "%.2f", dampingSlider.value))"
        velocityLabel.text = "Velocity: \(String(format: "%.2f", velocitySlider.value))"
    }

    @objc private func animateView() {
        let newYPosition: CGFloat = isViewAtTop
            ? self.view.center.y + 150
            : self.view.center.y - 150

        isViewAtTop.toggle()

        UIView.animate(
            withDuration: 1.5,
            delay: 0.0,
            usingSpringWithDamping: CGFloat(dampingSlider.value),
            initialSpringVelocity: CGFloat(velocitySlider.value),
            options: [],
            animations: {
                self.animatedView.frame.origin.y = newYPosition
            },
            completion: nil
        )
    }

    @objc private func showInfoAlert() {
        let message = """
\u{2022} Damping: Указывает, насколько быстро анимация затухает. Низкие значения приводят к большему количеству колебаний.
\n\u{2022} Velocity: Определяет начальную скорость анимации. Высокие значения делают начало анимации более резким.
"""
        let alert = UIAlertController(title: "Spring Animation Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


