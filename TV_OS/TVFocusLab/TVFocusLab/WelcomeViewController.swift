//
//  WelcomeViewController.swift
//  TVFocusLab
//
//  Created by Menkov Dmitriy on 19.04.2025.
//

import UIKit

final class WelcomeViewController: UIViewController {

    let button1 = UIButton(type: .system)
    let button2 = UIButton(type: .system)

    var onFocusGainedInContentArea: (() -> Void)?
    var onFocusReturnedToMenu: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray

        setupButton(button1, title: "Первая кнопка")
        setupButton(button2, title: "Вторая кнопка")

        view.addSubview(button1)
        view.addSubview(button2)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let buttonWidth: CGFloat = 400
        let buttonHeight: CGFloat = 60
        let spacing: CGFloat = 40

        button1.frame = CGRect(x: 100, y: 200, width: buttonWidth, height: buttonHeight)
        button2.frame = CGRect(x: 100, y: button1.frame.maxY + spacing, width: buttonWidth, height: buttonHeight)
    }

    private func setupButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 12

        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .primaryActionTriggered)
    }

    @objc private func buttonPressed(_ sender: UIButton) {
        let title = sender.currentTitle ?? "Кнопка"
        print("Нажата: \(title)")
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)

        guard let next = context.nextFocusedView else { return }

        if next == button1 || next == button2 {
            onFocusGainedInContentArea?()
        }

        if context.nextFocusedView?.isDescendant(of: view) == false {
            onFocusReturnedToMenu?()
        }
    }
}

