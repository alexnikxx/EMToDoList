//
//  DetailViewController.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 19/11/24.
//

import UIKit

class DetailViewController: UIViewController, DetailViewProtocol, UITextViewDelegate {
    private var configurator = DetailConfigurator()
    var presenter: DetailPresenterProtocol?

    var todo: CustomTodo
    var updatedTodo: CustomTodo = CustomTodo(title: "", text: "", date: Date(), isCompleted: false)

    init(todo: CustomTodo) {
        self.todo = todo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var titleTextView: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        text.textColor = .todoWhite
        text.tag = 1
        text.isScrollEnabled = false
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

    private var textTextView: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        text.alpha = 1
        text.textColor = .todoWhite
        text.tag = 2
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(for: self)

        setupView()
        self.updatedTodo = todo
        configure(todo: updatedTodo)

        titleTextView.delegate = self
        textTextView.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.buttonBackTapped()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        updatedTodo.title = titleTextView.text
        updatedTodo.text = textTextView.text

        if updatedTodo.text == "Описание" {
            updatedTodo.text = nil
        }

        if updatedTodo != todo {
            //
        }
    }

    private func setupView() {
        view.addSubview(titleTextView)
        view.addSubview(date)
        view.addSubview(textTextView)

        navigationController?.navigationBar.prefersLargeTitles = false

        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            date.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 8),
            date.leadingAnchor.constraint(equalTo: titleTextView.leadingAnchor),
            date.trailingAnchor.constraint(equalTo: titleTextView.trailingAnchor),

            textTextView.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 16),
            textTextView.leadingAnchor.constraint(equalTo: titleTextView.leadingAnchor),
            textTextView.trailingAnchor.constraint(equalTo: titleTextView.trailingAnchor),
            textTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configure(todo: CustomTodo) {
        if todo.title.isEmpty {
            titleTextView.text = "Заголовок"
            titleTextView.alpha = 0.5
        } else {
            titleTextView.text = todo.title
        }

        guard let description = todo.text else {
            textTextView.text = "Описание"
            textTextView.alpha = 0.5
            return
        }

        textTextView.text = description
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.tag == 1 && titleTextView.alpha == 0.5 {
            titleTextView.text = ""
            titleTextView.alpha = 1
        }

        if textView.tag == 2 && textTextView.alpha == 0.5 {
            textTextView.text = ""
            textTextView.alpha = 1
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.tag == 1 && titleTextView.text == "" {
            titleTextView.text = "Заголовок"
            titleTextView.alpha = 0.5
        }

        if textView.tag == 2 && textTextView.text == "" {
            textTextView.text = "Описание"
            textTextView.alpha = 0.5
        }
    }
}
