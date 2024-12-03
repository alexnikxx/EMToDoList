//
//  JSONTodo.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 16/11/24.
//

import Foundation

// MARK: - TodoList
struct JSONTodoList: Codable {
    let todos: [JSONTodo]
    let total, skip, limit: Int
}

// MARK: - Todo
struct JSONTodo: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}
