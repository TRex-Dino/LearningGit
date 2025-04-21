//
//  MainViewController.swift
//  TVFocusLab
//
//  Created by Menkov Dmitriy on 19.04.2025.
//

import UIKit

final class MainViewController: UIViewController {

    private let menuWidthExpanded: CGFloat = 300
    private let menuWidthCollapsed: CGFloat = 100

    private let menuVC = MenuViewController()
    private var currentContentVC: UIViewController?

    private var isMenuCollapsed = false {
        didSet {
            updateLayout(animated: true)
        }
    }

    private let rightFocusGuide = UIFocusGuide()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupChildControllers()
    }

    private func setupChildControllers() {
        // Menu
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        menuVC.delegate = self

        // Focus Guide
        view.addLayoutGuide(rightFocusGuide)

        // Initial content
        setContentViewController(WelcomeViewController())
    }

    func setContentViewController(_ vc: UIViewController) {
        // Remove old VC
        currentContentVC?.willMove(toParent: nil)
        currentContentVC?.view.removeFromSuperview()
        currentContentVC?.removeFromParent()

        // Add new VC
        addChild(vc)
        view.addSubview(vc.view)
        currentContentVC = vc
        vc.didMove(toParent: self)

        if let welcome = vc as? WelcomeViewController {
            welcome.onFocusGainedInContentArea = { [weak self] in
                self?.collapseMenu()
            }
            welcome.onFocusReturnedToMenu = { [weak self] in
                self?.expandMenu()
            }

            // Update focus guide to point to button
            rightFocusGuide.preferredFocusEnvironments = [welcome.button1]
        } else {
            rightFocusGuide.preferredFocusEnvironments = []
        }

        updateLayout(animated: false)
    }

    private func collapseMenu() {
        guard !isMenuCollapsed else { return }
        isMenuCollapsed = true
    }

    private func expandMenu() {
        guard isMenuCollapsed else { return }
        isMenuCollapsed = false
    }

    private func updateLayout(animated: Bool) {
        let width = isMenuCollapsed ? menuWidthCollapsed : menuWidthExpanded

        let update = {
            self.layoutControllers(menuWidth: width)
        }

        if animated {
            UIView.animate(withDuration: 0.3, animations: update)
        } else {
            update()
        }

        menuVC.updateCollapseState(isMenuCollapsed)
    }

    private func layoutControllers(menuWidth: CGFloat) {
        // Menu
        menuVC.view.frame = CGRect(x: 0, y: 0, width: menuWidth, height: view.bounds.height)

        // Content
        if let content = currentContentVC {
            content.view.frame = CGRect(x: menuWidth,
                                        y: 0,
                                        width: view.bounds.width - menuWidth,
                                        height: view.bounds.height)
        }

        // Focus guide: справа от меню, на всю высоту
        rightFocusGuide.leadingAnchor.constraint(equalTo: menuVC.view.trailingAnchor).isActive = true
        rightFocusGuide.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        rightFocusGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        rightFocusGuide.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
}

// MARK: - MenuViewControllerDelegate

extension MainViewController: MenuViewControllerDelegate {
    func menuDidSelect(_ item: MenuItem) {
        switch item {
        case .home:
            setContentViewController(WelcomeViewController())
        case .banners, .settings:
            setContentViewController(PlaceholderViewController(title: item.title))
        }
    }
}




final class PlaceholderViewController: UIViewController {
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.titleText = title
    }

    private let label = UILabel()
    private var titleText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        label.text = titleText
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .white
        label.textAlignment = .center
        view.addSubview(label)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect(x: 40, y: 200, width: view.bounds.width - 80, height: 80)
    }

    required init?(coder: NSCoder) { fatalError() }
}
