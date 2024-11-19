//
//  ListTableViewCell.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 17/11/24.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    static let identifier = "ListTableViewCell"

    private var title: UILabel = {
        let label = UILabel()
        label.textColor = .todoWhite
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var text: UILabel = {
        let label = UILabel()
        label.textColor = .todoWhite
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var date: UILabel = {
        let label = UILabel()
        label.text = "10/11/24"
        label.textColor = .todoWhite
        label.alpha = 0.5
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var checkbox: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "todoCircle")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .todoStroke
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .todoStroke
        separator.frame = CGRect(x: 0, y: 0, width: 100, height: 2)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(todo: CustomTodo) {
        if todo.isCompleted {
            setupTodoAsCompleted(todo)
        } else {
            setupTodoAsIncompleted(todo)
        }
    }

    public func update(todo: CustomTodo) {
        if todo.isCompleted {
            setupTodoAsCompleted(todo)
        } else {
            setupTodoAsIncompleted(todo)
        }
    }

    private func setupTodoAsCompleted(_ todo: CustomTodo) {
        title.attributedText = strikeText(strike: todo.title)
        title.alpha = 0.5

        text.text = todo.text
        text.alpha = 0.5

        checkbox.image = UIImage(named: "todoCheckmark")
        checkbox.tintColor = UIColor.todoYellow
    }

    private func setupTodoAsIncompleted(_ todo: CustomTodo) {
        title.attributedText = nil
        title.text = todo.title
        title.alpha = 1

        text.text = todo.text
        text.alpha = 1

        checkbox.image = UIImage(named: "todoCircle")
        checkbox.tintColor = UIColor.todoStroke
    }

    func strikeText(strike: String) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: strike)
        attributeString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }

    private func setupView() {
        contentView.backgroundColor = .todoBlack
        contentView.addSubview(title)
        contentView.addSubview(text)
        contentView.addSubview(date)
        contentView.addSubview(checkbox)
        contentView.addSubview(separator)

        NSLayoutConstraint.activate([
            checkbox.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            checkbox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            checkbox.heightAnchor.constraint(equalToConstant: 24),
            checkbox.widthAnchor.constraint(equalToConstant: 24),

            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            title.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: checkbox.centerYAnchor),

            text.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 6),
            text.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            date.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 6),
            date.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            separator.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 12),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
