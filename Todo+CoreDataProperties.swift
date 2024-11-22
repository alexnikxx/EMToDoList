//
//  Todo+CoreDataProperties.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 22/11/24.
//
//

import UIKit
import CoreData

@objc(Todo)
public class Todo: NSManagedObject {}

extension Todo {
    @NSManaged public var title: String
    @NSManaged public var text: String?
    @NSManaged public var id: UUID
    @NSManaged public var date: Date
    @NSManaged public var isCompleted: Bool
}

extension Todo : Identifiable {}
