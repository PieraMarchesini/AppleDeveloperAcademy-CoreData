//
//  Task+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Piera Marchesini on 28/09/17.
//  Copyright © 2017 Piera Marchesini. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var priority: Int16
    @NSManaged public var title: String?
    @NSManaged public var project: Project?

}
