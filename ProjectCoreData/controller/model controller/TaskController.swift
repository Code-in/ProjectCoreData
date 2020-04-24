//
//  TaskController.swift
//  ProjectCoreData
//
//  Created by Pete Parks on 4/22/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static var shared = TaskController()
    
    let fetchedResultsController: NSFetchedResultsController<Task>
    
    init() {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: false)]
        let resultsTaskController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath:"Complete", cacheName: nil)
        fetchedResultsController = resultsTaskController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("fetchedResultsController failed \(error)")
        }
        
    }
    
    
    // MARK: CRUD Functions
    
    // MARK: Create
    func add(name: String, note: String?, due: Date?) {
        let _ = Task(name: name, note: note, due: due, isComplete: false)  // Ask why we don't pass this is from UI then set isComplete
        saveToPersistence()
    }
    
    // MARK: Update
    func update(task: Task, name: String, note: String?, due: Date?, isComplete: Bool) {
        task.name = name
        task.note = note
        task.due = due
        task.isComplete = isComplete
        saveToPersistence()
    }
    
    // MARK: Delete
    func remove(task: Task) {
        /*if let moc = task.managedObjectContext {
            moc.delete(task)
            saveToPersistence()
        }*/
        CoreDataStack.context.delete(task)
    }
    
    func saveToPersistence() {
        let  moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            print("Error - saveToPeresistence: \(error), \(error.localizedDescription)")
        }
    }
    
    func  toggleIsTaskComplete(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistence()
    }
}  // End of Class
