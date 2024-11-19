//
//  DetailViewController.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 19/11/24.
//

import UIKit

class DetailViewController: UIViewController {
    var todo: CustomTodo

    init(todo: CustomTodo) {
        self.todo = todo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var titleTextField: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        text.textColor = .todoWhite
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    private var date: UILabel = {
        let date = UILabel()
        date.text = "10/11/24"
        date.textColor = .todoWhite
        date.alpha = 0.5
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()

    private var textTextField: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        text.textColor = .todoWhite
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configure(todo: todo)
    }

    private func setupView() {
        view.addSubview(titleTextField)
        view.addSubview(date)
        view.addSubview(textTextField)

        navigationController?.navigationBar.prefersLargeTitles = false

        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            date.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8),
            date.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            date.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),

            textTextField.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 16),
            textTextField.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            textTextField.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
        ])
    }

    private func configure(todo: CustomTodo) {
        titleTextField.text = todo.title
        textTextField.text = todo.text
    }
}
