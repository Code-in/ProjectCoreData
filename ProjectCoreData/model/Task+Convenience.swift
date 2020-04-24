//
//  Task+Convenience.swift
//  ProjectCoreData
//
//  Created by Pete Parks on 4/22/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    convenience init(name: String, note: String?, due: Date?, isComplete: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.note = note
        self.due = due
        self.isComplete = isComplete
    }
}
