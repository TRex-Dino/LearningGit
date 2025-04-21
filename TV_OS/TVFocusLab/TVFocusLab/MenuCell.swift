//
//  MenuCell.swift
//  TVFocusLab
//
//  Created by Menkov Dmitriy on 19.04.2025.
//

import UIKit

// MARK: - MenuCell
final class MenuTableViewCell: UITableViewCell {
    static let reuseID = "MenuTableViewCell"

    private let iconView = UIImageView()
    private let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .white
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 28)

        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        let padding: CGFloat = 20
        iconView.frame = CGRect(x: padding, y: 10, width: 40, height: 40)
        titleLabel.frame = CGRect(x: iconView.frame.maxX + 20,
                                  y: 0,
                                  width: bounds.width - iconView.frame.maxX - 40,
                                  height: bounds.height)
    }

    func configure(with item: MenuItem, isCollapsed: Bool) {
        iconView.image = UIImage(systemName: item.iconName)
        titleLabel.text = isCollapsed ? nil : item.title
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        contentView.backgroundColor = isFocused ? .gray : .clear
    }
}

