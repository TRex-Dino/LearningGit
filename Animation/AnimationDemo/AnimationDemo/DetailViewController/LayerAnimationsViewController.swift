//
//  LayerAnimationsViewController.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 16.01.2025.
//


import UIKit

final class LayerAnimationsViewController: UIViewController {
    
    private let movingLayer = CALayer()
    private let animateButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayer()
        setupUI()
    }
    
    // MARK: - Настройка слоя
    
    private func setupLayer() {
        movingLayer.frame = CGRect(x: 50, y: 150, width: 100, height: 100)
        movingLayer.backgroundColor = UIColor.systemGreen.cgColor
        movingLayer.cornerRadius = 10
        view.layer.addSublayer(movingLayer)
    }
    
    // MARK: - Настройка интерфейса
    
    private func setupUI() {
        animateButton.setTitle("Start Animation", for: .normal)
        animateButton.addTarget(self, action: #selector(showAnimationMenu), for: .touchUpInside)
        animateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animateButton)
        
        NSLayoutConstraint.activate([
            animateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Анимации
    
    @objc private func showAnimationMenu() {
        let alert = UIAlertController(title: "Select Animation", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Basic Animation", style: .default, handler: { _ in
            self.basicAnimation()
        }))
        
        alert.addAction(UIAlertAction(title: "Keyframe Animation", style: .default, handler: { _ in
            self.keyframeAnimation()
        }))
        
        alert.addAction(UIAlertAction(title: "Combined Animation", style: .default, handler: { _ in
            self.combinedAnimation()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Пример 1: Basic Animation (Перемещение)
    
    private func basicAnimation() {
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.fromValue = movingLayer.position
        positionAnimation.toValue = CGPoint(x: 300, y: 400)
        positionAnimation.duration = 2.0


//        positionAnimation.fillMode = .forwards
//        positionAnimation.isRemovedOnCompletion = false
        // Обновляем значение слоя
        movingLayer.position = CGPoint(x: 300, y: 400)

        // Добавляем анимацию
        movingLayer.add(positionAnimation, forKey: "positionAnimation")
    }
    
    // MARK: Пример 2: Keyframe Animation (Ключевые кадры)
    
    private func keyframeAnimation() {
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        keyframeAnimation.values = [
            CGPoint(x: 50, y: 150),
            CGPoint(x: 150, y: 200),
            CGPoint(x: 50, y: 300),
            CGPoint(x: 300, y: 300)
        ]
        keyframeAnimation.duration = 4.0

//        keyframeAnimation.fillMode = .backwards
//        keyframeAnimation.isRemovedOnCompletion = false

        // Оставляем слой в последнем положении
        movingLayer.position = CGPoint(x: 300, y: 300)
        
        movingLayer.add(keyframeAnimation, forKey: "keyframeAnimation")
    }
    
    // MARK: Пример 3: Combined Animation (Групповая анимация)
    
    private func combinedAnimation() {
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 3.0
        
        // Анимация масштаба
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 1.5
        
        // Анимация вращения
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Double.pi * 2
        
        groupAnimation.animations = [scaleAnimation, rotationAnimation]
        
        movingLayer.add(groupAnimation, forKey: "combinedAnimation")
    }
}
