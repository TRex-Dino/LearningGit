//
//  MenuViewController.swift
//  TVFocusLab
//
//  Created by Menkov Dmitriy on 19.04.2025.
//

import UIKit
enum MenuItem: CaseIterable {
    case home
    case banners
    case settings

    var title: String {
        switch self {
        case .home: return "Home"
        case .banners: return "Banners"
        case .settings: return "Settings"
        }
    }

    var iconName: String {
        switch self {
        case .home: return "house"
        case .banners: return "photo"
        case .settings: return "gear"
        }
    }
}

// MARK: - MenuViewController
protocol MenuViewControllerDelegate: AnyObject {
    func menuDidSelect(_ item: MenuItem)
}

final class MenuViewController: UIViewController {
    private let tableView = UITableView()
    private var selectedIndex = 0
    var isCollapsed = false
    weak var delegate: MenuViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.backgroundColor = .black
        tableView.rowHeight = 60
        tableView.dataSource = self
        tableView.delegate = self
        tableView.remembersLastFocusedIndexPath = true
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.reuseID)
    }

    func updateCollapseState(_ collapsed: Bool) {
        isCollapsed = collapsed
        tableView.reloadData()
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { MenuItem.allCases.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = MenuItem.allCases[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseID, for: indexPath) as! MenuTableViewCell
        cell.configure(with: item, isCollapsed: isCollapsed)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = MenuItem.allCases[indexPath.row]
        delegate?.menuDidSelect(item)
    }
}



