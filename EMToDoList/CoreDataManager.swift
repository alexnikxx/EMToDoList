//
//  CoreDataManager.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 22/11/24.
//

import UIKit
import CoreData

final class CoreDataManager: NSObject {
    static let shared = CoreDataManager()
    private override init() {}

    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }

    private var context: NSManagedObjectContext {
        appDelegate.persistedContainer.viewContext
    }

    public func createTodo(id: UUID, title: String, text: String?, date: Date, isCompleted: Bool) {
        guard let todoEntityDescription = NSEntityDescription.entity(forEntityName: "Todo", in: context) else {
            print("There is mistake with creating deescription")
            return
        }
        let todo = Todo(entity: todoEntityDescription, insertInto: context)
        todo.id = id
        todo.title = title
        todo.text = text
        todo.date = date
        todo.isCompleted = isCompleted

        appDelegate.saveContext()
    }

    public func fetchTodos() -> [Todo] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        do {
            guard let todos = try context.fetch(fetchRequest) as? [Todo] else { return [] }
            return todos
        } catch {
            print(error.localizedDescription)
        }

        return []
    }

    public func fetchTodo(with id: UUID) -> Todo? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        do {
            guard let todos = try context.fetch(fetchRequest) as? [Todo] else { return nil }
            return todos.first(where: { $0.id == id })
        } catch {
            print(error.localizedDescription)
        }

        return nil
    }

    public func updateTodo(with id: UUID, title: String, text: String?, date: Date, isCompleted: Bool) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        do {
            guard let todos = try context.fetch(fetchRequest) as? [Todo],
                  let todo = todos.first(where: { $0.id == id }) else { return }
            todo.id = id
            todo.title = title
            todo.text = text
            todo.date = date
            todo.isCompleted = isCompleted
        } catch {
            print(error.localizedDescription)
        }

        appDelegate.saveContext()
    }

    public func deleteAllTodo() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        do {
            let todos = try? context.fetch(fetchRequest) as? [Todo]
            todos?.forEach { context.delete($0) }
        }

        appDelegate.saveContext()
    }

    public func deleteTodo(with id: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        do {
            guard let todos = try? context.fetch(fetchRequest) as? [Todo],
                  let todo = todos.first(where: { $0.id == id }) else { return }
            context.delete(todo)
        }

        appDelegate.saveContext()
    }
}
