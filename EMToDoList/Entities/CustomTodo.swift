//
//  CustomTodo.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 17/11/24.
//

import Foundation

struct CustomTodo: Identifiable {
    let id = UUID()
    var title: String
    var text: String
    var date: Date
    var isCompleted: Bool

    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let stringDate: String = dateFormatter.string(from: date)
        return stringDate
    }
}

extension CustomTodo {
    static var examples: [CustomTodo] {[
        CustomTodo(title: "Почитать книгу", text: "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике.", date: Date(), isCompleted: true),
        CustomTodo(title: "Уборка в квартире", text: "Провести генеральную уборку в квартире", date: Date(), isCompleted: false),
        CustomTodo(title: "Заняться спортом", text: "Сходить в спортзал или сделать тренировку дома. Не забыть про разминку и растяжку!", date: Date(), isCompleted: false),
        CustomTodo(title: "Работа над проектом", text: "Выделить время для работы над проектом на работе. Сфокусироваться на выполнении важных задач", date: Date(), isCompleted: true),
        CustomTodo(title: "Вечерний отдых", text: "Найти время для расслабления перед сном: посмотреть фильм или послушать музыку", date: Date(), isCompleted: false),
        CustomTodo(title: "Почитать книгу", text: "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике.", date: Date(), isCompleted: true),
        CustomTodo(title: "Уборка в квартире", text: "Провести генеральную уборку в квартире", date: Date(), isCompleted: false),
        CustomTodo(title: "Заняться спортом", text: "Сходить в спортзал или сделать тренировку дома. Не забыть про разминку и растяжку!", date: Date(), isCompleted: false),
        CustomTodo(title: "Работа над проектом", text: "Выделить время для работы над проектом на работе. Сфокусироваться на выполнении важных задач", date: Date(), isCompleted: true),
        CustomTodo(title: "Вечерний отдых", text: "Найти время для расслабления перед сном: посмотреть фильм или послушать музыку", date: Date(), isCompleted: false)
    ]}
}
