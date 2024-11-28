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

    private lazy var persistedContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { description, error in
            if let error {
                print(error.localizedDescription)
            } else {
                guard let url = description.url else { return }
                print("DB url - ", url.absoluteString)
            }
        }

        return container
    }()

    private func saveContext() {
        let context = persistedContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }

    public func createTodo(id: UUID, title: String, text: String?, date: Date, isCompleted: Bool) {
        guard let todoEntityDescription = NSEntityDescription.entity(forEntityName: "Todo", in: persistedContainer.viewContext) else {
            print("There is mistake with creating deescription")
            return
        }
        let todo = Todo(entity: todoEntityDescription, insertInto: persistedContainer.viewContext)
        todo.id = id
        todo.title = title
        todo.text = text
        todo.date = date
        todo.isCompleted = isCompleted

        saveContext()
    }

    public func fetchTodos() -> [Todo] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        do {
            guard let todos = try persistedContainer.viewContext.fetch(fetchRequest) as? [Todo] else { return [] }
            return todos
        } catch {
            print(error.localizedDescription)
        }

        return []
    }

    public func fetchTodo(with id: UUID) -> Todo? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        do {
            guard let todos = try persistedContainer.viewContext.fetch(fetchRequest) as? [Todo] else { return nil }
            return todos.first(where: { $0.id == id })
        } catch {
            print(error.localizedDescription)
        }

        return nil
    }

    public func updateTodo(with id: UUID, title: String, text: String?, date: Date, isCompleted: Bool) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        do {
            guard let todos = try persistedContainer.viewContext.fetch(fetchRequest) as? [Todo],
                  let todo = todos.first(where: { $0.id == id }) else { return }
            todo.id = id
            todo.title = title
            todo.text = text
            todo.date = date
            todo.isCompleted = isCompleted
        } catch {
            print(error.localizedDescription)
        }

        saveContext()
    }

    public func deleteAllTodo() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        do {
            let todos = try? persistedContainer.viewContext.fetch(fetchRequest) as? [Todo]
            todos?.forEach { persistedContainer.viewContext.delete($0) }
        }

        saveContext()
    }

    public func deleteTodo(with id: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        do {
            guard let todos = try? persistedContainer.viewContext.fetch(fetchRequest) as? [Todo],
                  let todo = todos.first(where: { $0.id == id }) else { return }
            persistedContainer.viewContext.delete(todo)
        }

        saveContext()
    }
}
