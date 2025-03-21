//
//  MainViewController.swift
//  AnimationDemo
//
//  Created by Dmitry Menkov on 14.12.2024.
//

import UIKit
import Combine

typealias MainViewDataSource = UITableViewDiffableDataSource<Section, Category>
typealias MainViewSnapshot = NSDiffableDataSourceSnapshot<Section, Category>

protocol MainViewControllerDelegate: AnyObject {
    func didSelect(category: Category)
}

final class MainViewController: UIViewController {
    private let viewModel: MainViewModel
    weak var delegate: MainViewControllerDelegate?

    private var cancellables = Set<AnyCancellable>()

    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()



    private lazy var dataSource = makeDataSource()

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Categories"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        bindViewModel()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
        tableView.delegate = self
    }

    private func makeDataSource() -> MainViewDataSource {
        return MainViewDataSource(tableView: tableView) { tableView, indexPath, category in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {
                return UITableViewCell()
            }
            cell.configure(with: category)
            return cell
        }
    }

    private func applySnapshot(categories: [Category], animatingDifferences: Bool = true) {
        var snapshot = MainViewSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(categories)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func bindViewModel() {
        viewModel.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] cats in
                self?.applySnapshot(categories: cats)
            }
            .store(in: &cancellables)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = dataSource.itemIdentifier(for: indexPath) else { return }
        delegate?.didSelect(category: category)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
