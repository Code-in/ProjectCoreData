//
//  CoreDataStack.swift
//  ProjectCoreData
//
//  Created by Pete Parks on 4/22/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    static let container: NSPersistentContainer = {
        let appName = Bundle.main.object(forInfoDictionaryKey: (kCFBundleNameKey as String)) as! String
        let container = NSPersistentContainer(name: appName)
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("ProjectCoreData unresolved error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    static var context: NSManagedObjectContext { return container.viewContext }
}
