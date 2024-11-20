//
//  NetworkService.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 16/11/24.
//

import Foundation

final class NetworkService {
    let decoder = JSONDecoder()
    var jsonTodos: JSONTodoList = JSONTodoList(todos: [], total: 0, skip: 0, limit: 0)

    func fetchTodos() {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            guard let todos = try? self.decoder.decode(JSONTodoList.self, from: data) else {
                print("Error decoding")
                return
            }

            self.jsonTodos = todos
        }

        task.resume()
    }

    func createCustomTodos() -> [CustomTodo] {
        var customTodos: [CustomTodo] = []

        for todo in jsonTodos.todos {
            let customTodo = CustomTodo(title: todo.todo, text: "", date: Date(), isCompleted: todo.completed)
            customTodos.append(customTodo)
        }

        return customTodos
    }
}
