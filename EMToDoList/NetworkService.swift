//
//  NetworkService.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 16/11/24.
//

import Foundation

final class NetworkService {
    let decoder = JSONDecoder()
    var notes: TodoList = TodoList(todos: [], total: 0, skip: 0, limit: 0)

    func fetchTodos() {
        DispatchQueue.global().async {
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

                guard let todos = try? self.decoder.decode(TodoList.self, from: data) else {
                    print("Error decoding")
                    return
                }

                DispatchQueue.main.async {
                    self.notes = todos
                }
            }

            task.resume()
        }
    }
}
