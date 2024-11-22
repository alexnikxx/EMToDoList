//
//  NetworkService.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 16/11/24.
//

import Foundation

final class NetworkService {
    let decoder = JSONDecoder()

    func fetchTodos(completionHandler: @escaping (Result<[CustomTodo], Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            print("Invalid URL")
            completionHandler(.failure(NetworkError.invalidURL))
            return
        }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completionHandler(.failure(NetworkError.invalidData))
                return
            }

            guard let todos = try? self.decoder.decode(JSONTodoList.self, from: data) else {
                print("Error decoding")
                completionHandler(.failure(NetworkError.decodingError))
                return
            }

            let customTodos = self.createCustomTodos(from: todos)

            completionHandler(.success(customTodos))
        }

        task.resume()
    }

    private func createCustomTodos(from jsonTodos: JSONTodoList) -> [CustomTodo] {
        var customTodos: [CustomTodo] = []

        for todo in jsonTodos.todos {
            let customTodo = CustomTodo(title: todo.todo, text: nil, date: Date(), isCompleted: todo.completed)
            customTodos.append(customTodo)
        }

        return customTodos
    }
}

extension NetworkService {
    enum NetworkError: Error {
        case invalidURL
        case invalidData
        case decodingError
    }
}
