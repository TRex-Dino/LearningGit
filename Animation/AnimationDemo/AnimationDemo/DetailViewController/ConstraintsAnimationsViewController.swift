//
//  ConstraintsAnimationsViewController.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 15.01.2025.
//


import UIKit

final class ConstraintsAnimationsViewController: UIViewController {
    
    private let animatedView = UIView()
    private var heightConstraint: NSLayoutConstraint!
    private let slidingPanel = UIView()
    private var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI() {
        // Настройка анимируемого представления
        animatedView.backgroundColor = .systemBlue
        animatedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animatedView)
        
        heightConstraint = animatedView.heightAnchor.constraint(equalToConstant: 100)
        widthConstraint = animatedView.widthAnchor.constraint(equalToConstant: 200)
        NSLayoutConstraint.activate([
            animatedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animatedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            widthConstraint,
            heightConstraint
        ])
        
        // Кнопка изменения высоты
        let toggleHeightButton = UIButton(type: .system)
        toggleHeightButton.setTitle("Toggle Height", for: .normal)
        toggleHeightButton.addTarget(self, action: #selector(toggleHeight), for: .touchUpInside)
        toggleHeightButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toggleHeightButton)
        NSLayoutConstraint.activate([
            toggleHeightButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleHeightButton.topAnchor.constraint(equalTo: animatedView.bottomAnchor, constant: 20)
        ])
        
        // Настройка панели
        slidingPanel.backgroundColor = .systemGray
        slidingPanel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slidingPanel)
        
        bottomConstraint = slidingPanel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 300)
        NSLayoutConstraint.activate([
            slidingPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            slidingPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            slidingPanel.heightAnchor.constraint(equalToConstant: 300),
            bottomConstraint
        ])
        
        // Кнопка управления панелью
        let togglePanelButton = UIButton(type: .system)
        togglePanelButton.setTitle("Toggle Panel", for: .normal)
        togglePanelButton.addTarget(self, action: #selector(togglePanel), for: .touchUpInside)
        togglePanelButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(togglePanelButton)
        NSLayoutConstraint.activate([
            togglePanelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            togglePanelButton.topAnchor.constraint(equalTo: toggleHeightButton.bottomAnchor, constant: 20)
        ])
        
        // Кнопка управления несколькими ограничениями
        let animateConstraintsButton = UIButton(type: .system)
        animateConstraintsButton.setTitle("Animate Constraints", for: .normal)
        animateConstraintsButton.addTarget(self, action: #selector(animateMultipleConstraints), for: .touchUpInside)
        animateConstraintsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animateConstraintsButton)
        NSLayoutConstraint.activate([
            animateConstraintsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animateConstraintsButton.topAnchor.constraint(equalTo: togglePanelButton.bottomAnchor, constant: 20)
        ])
    }
    
    // MARK: - Анимация высоты
    
    @objc private func toggleHeight() {
        heightConstraint.constant = heightConstraint.constant == 100 ? 200 : 100
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Анимация панели
    
    @objc private func togglePanel() {
        bottomConstraint.constant = bottomConstraint.constant == 0 ? 300 : 0
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Анимация нескольких ограничений
    
    private var widthConstraint: NSLayoutConstraint!

    @objc private func animateMultipleConstraints() {
        // Деактивация текущих ограничений
        NSLayoutConstraint.deactivate([heightConstraint, widthConstraint])

        // Создаем новые ограничения
        heightConstraint = animatedView.heightAnchor.constraint(equalToConstant: heightConstraint.constant == 100 ? 150 : 100)
        widthConstraint = animatedView.widthAnchor.constraint(equalToConstant: widthConstraint.constant == 200 ? 300 : 200)

        // Активируем новые ограничения
        NSLayoutConstraint.activate([heightConstraint, widthConstraint])

        // Анимация изменения ограничений
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
