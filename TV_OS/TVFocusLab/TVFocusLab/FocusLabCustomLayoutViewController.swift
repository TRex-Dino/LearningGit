//
//  FocusLabCustomLayoutViewController.swift
//  TVFocusLab
//
//  Created by Menkov Dmitriy on 19.04.2025.
//

import UIKit

final class FocusLabCustomLayoutViewController: UIViewController {

    private let leftButton = makeButton(title: "Left")
    private let button1 = makeButton(title: "Button 1")
    private let button2 = makeButton(title: "Button 2")
    private let button3 = makeButton(title: "Button 3")

//    private let button4 = makeButton(title: "Button 4")
    private let button4 = PageControlFocusHandlerView()

    private let bottomButton = makeButton(title: "Bottom")

    private let pageControl = UIPageControl()
//    private let button4LeftFocus = UIFocusGuide()
//    private let button4RightFocus = UIFocusGuide()

    private let button2Focus = UIFocusGuide()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false

        [leftButton, button1, button2, button3, button4, bottomButton, pageControl].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

//        view.addLayoutGuide(button4LeftFocus)
//        view.addLayoutGuide(button4RightFocus)
//
//
//        button4LeftFocus.preferredFocusEnvironments = [button4]
//        button4RightFocus.preferredFocusEnvironments = [button4]

        view.addLayoutGuide(button2Focus)

        button2Focus.preferredFocusEnvironments = [button4.focusableView]

        button4.onLeft = {
            print(" on left")
        }

        button4.onRight = {
            print(" on right")
        }

        setupLayout()
    }

//    override func shouldUpdateFocus(in context: UIFocusUpdateContext) -> Bool {
//        print("➡️ Фокус хочет перейти от \(context.previouslyFocusedView?.debugName ?? "-") к \(context.nextFocusedView?.debugName ?? "-")")
//        print("∆ направление", context.focusHeading.debugDescription)
//        return true
//    }
//
//    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//        print("didUpdateFocus фокус перешел \(context.previouslyFocusedView?.debugName ?? "-") к \(context.nextFocusedView?.debugName ?? "-")")
//        print("didUpdateFocus направление", context.focusHeading.debugDescription)
//    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            // leftButton (от верха до bottomButton)
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftButton.topAnchor.constraint(equalTo: view.topAnchor),
            leftButton.bottomAnchor.constraint(equalTo: bottomButton.topAnchor),
            leftButton.widthAnchor.constraint(equalToConstant: 100),

            // button1
            button1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button1.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 60),
            button1.widthAnchor.constraint(equalToConstant: 180),
            button1.heightAnchor.constraint(equalToConstant: 60),

            // button2
            button2.centerYAnchor.constraint(equalTo: button1.centerYAnchor),
            button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 40),
            button2.widthAnchor.constraint(equalTo: button1.widthAnchor),
            button2.heightAnchor.constraint(equalTo: button1.heightAnchor),

            // button2
            button2Focus.centerXAnchor.constraint(equalTo: button2.centerXAnchor),
            button2Focus.bottomAnchor.constraint(equalTo: button2.topAnchor),
            button2Focus.widthAnchor.constraint(equalTo: button2.widthAnchor),
            button2Focus.heightAnchor.constraint(equalToConstant: 10),


            // pageControl
            pageControl.centerYAnchor.constraint(equalTo: button1.centerYAnchor),
            pageControl.leadingAnchor.constraint(equalTo: button2.trailingAnchor, constant: 40),
            pageControl.widthAnchor.constraint(equalToConstant: 150),
            pageControl.heightAnchor.constraint(equalToConstant: 40),

            // button3
            button3.centerYAnchor.constraint(equalTo: button1.centerYAnchor),
            button3.leadingAnchor.constraint(equalTo: pageControl.trailingAnchor, constant: 40),
            button3.widthAnchor.constraint(equalTo: button1.widthAnchor),
            button3.heightAnchor.constraint(equalTo: button1.heightAnchor),

            // button4
            button4.centerXAnchor.constraint(equalTo: pageControl.centerXAnchor),
            button4.bottomAnchor.constraint(equalTo: button3.topAnchor, constant: -20),
            button4.widthAnchor.constraint(equalTo: button1.widthAnchor),
            button4.heightAnchor.constraint(equalTo: button1.heightAnchor),

//            // button4
//            button4LeftFocus.centerYAnchor.constraint(equalTo: button4.centerYAnchor),
//            button4LeftFocus.widthAnchor.constraint(equalToConstant: 10),
//            button4LeftFocus.heightAnchor.constraint(equalTo: button4.heightAnchor),
//            button4LeftFocus.trailingAnchor.constraint(equalTo: button4.leadingAnchor),
//
//            // button4
//            button4RightFocus.centerYAnchor.constraint(equalTo: button4.centerYAnchor),
//            button4RightFocus.widthAnchor.constraint(equalToConstant: 10),
//            button4RightFocus.heightAnchor.constraint(equalTo: button4.heightAnchor),
//            button4RightFocus.leadingAnchor.constraint(equalTo: button4.trailingAnchor),

            // bottomButton
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private static func makeButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 12
        button.accessibilityIdentifier = title
        button.addTarget(nil, action: #selector(tap), for: .primaryActionTriggered)
        return button
    }

    @objc private static func tap(_ sender: UIButton) {
        print("Tapped: \(sender.currentTitle ?? "")")
    }
}

extension UIView {
    var debugName: String {
        if let accessibilityIdentifier = self.accessibilityIdentifier {
            return "[\(accessibilityIdentifier)]"
        }
        return String(describing: type(of: self))
    }
}

extension UIFocusHeading {
    var debugDescription: String {
        var result: [String] = []
        if contains(.up) { result.append("↑") }
        if contains(.down) { result.append("↓") }
        if contains(.left) { result.append("←") }
        if contains(.right) { result.append("→") }
        if contains(.next) { result.append("→next") }
        if contains(.previous) { result.append("←prev") }
        if contains(.first) { result.append("⇤first") }
        if contains(.last) { result.append("⇥last") }
        if result.isEmpty { result.append("none") }
        return result.joined(separator: " + ")
    }
}

final class PageControlFocusHandlerView: UIView {
    var onLeft: (() -> Void)?
    var onRight: (() -> Void)?

    private(set) var focusableView = FocusableTransparentView()
    private let leftGuide = UIFocusGuide()
    private let rightGuide = UIFocusGuide()
    private let bottomGuide = UIFocusGuide()

    private var savedView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        guard
            let next = context.nextFocusedView,
            let previous = context.previouslyFocusedView
        else { return }

        guard next == focusableView && previous == focusableView else { return }

        let heading = context.focusHeading
        if heading.contains(.left) {
            onLeft?()
        } else if heading.contains(.right) {
            onRight?()
        }
    }

    private func setupView() {
        focusableView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(focusableView)
        NSLayoutConstraint.activate([
            focusableView.topAnchor.constraint(equalTo: topAnchor),
            focusableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        addLayoutGuide(leftGuide)
        addLayoutGuide(rightGuide)

        NSLayoutConstraint.activate([
            leftGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftGuide.trailingAnchor.constraint(equalTo: focusableView.leadingAnchor),
            leftGuide.heightAnchor.constraint(equalTo: focusableView.heightAnchor),
            leftGuide.widthAnchor.constraint(equalToConstant: 10)
        ])
        leftGuide.preferredFocusEnvironments = [focusableView]

        NSLayoutConstraint.activate([
            rightGuide.leadingAnchor.constraint(equalTo: focusableView.trailingAnchor),
            rightGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightGuide.heightAnchor.constraint(equalTo: focusableView.heightAnchor),
            rightGuide.widthAnchor.constraint(equalToConstant: 10)
        ])
        rightGuide.preferredFocusEnvironments = [focusableView]
    }
}

final class FocusableTransparentView: UIView {
    override var canBecomeFocused: Bool { true }
}
