//
//  MainContainerViewController.swift
//  TVFocusLab
//
//  Created by Menkov Dmitriy on 01.07.2025.
//


import UIKit

class MainContainerViewController: UIViewController {
    private let menuWidth: CGFloat = 200
//    private let focusGuide = UIFocusGuide()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        // Добавим два контроллера
        let menuVC = MenuViewController2()
        let contentVC = ContentViewController()

        addChild(menuVC)
        addChild(contentVC)

        view.addSubview(menuVC.view)
        view.addSubview(contentVC.view)

        menuVC.didMove(toParent: self)
        contentVC.didMove(toParent: self)
//        contentVC.view.addLayoutGuide(focusGuide)
        // Layout
        menuVC.view.translatesAutoresizingMaskIntoConstraints = false
        contentVC.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            menuVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            menuVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuVC.view.widthAnchor.constraint(equalToConstant: menuWidth),

            contentVC.view.leadingAnchor.constraint(equalTo: menuVC.view.trailingAnchor),
            contentVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            contentVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),

//            focusGuide.topAnchor.constraint(equalTo: contentVC.view.topAnchor),
//            focusGuide.bottomAnchor.constraint(equalTo: contentVC.view.bottomAnchor),
//            focusGuide.leadingAnchor.constraint(equalTo: contentVC.view.leadingAnchor),
//            focusGuide.trailingAnchor.constraint(equalTo: contentVC.view.trailingAnchor),
        ])
    }
}

class MenuViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing

        for i in 1...10 {
            let button = UIButton(type: .system)
            button.setTitle("Кнопка \(i)", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
            stackView.addArrangedSubview(button)
        }

        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
}
class ContentViewController: UIViewController {
    private let focusGuide = UIFocusGuide()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addLayoutGuide(focusGuide)

        let button = UIButton(type: .system)
        button.setTitle("Центральная кнопка", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)

        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            focusGuide.topAnchor.constraint(equalTo: view.topAnchor),
            focusGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            focusGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            focusGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
