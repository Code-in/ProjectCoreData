//
//  TaskListTableViewController.swift
//  ProjectCoreData
//
//  Created by Pete Parks on 4/23/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.fetchedResultsController.delegate = self
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // what do we want to do here
        //TaskController.shared.fetchedResultsController
        return TaskController.shared.fetchedResultsController.sections?[section].name == "0" ? "Incomplete" : "Complete"
        //Labeling headers complete or not
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TaskController.shared.fetchedResultsController.sections?.count ?? 0
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.shared.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else { return UITableViewCell()}
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
        
        cell.delegate = self
        cell.update(withTask: task)
        
        return cell
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
            TaskController.shared.remove(task: task)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskSegue" {
            
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? TaskDetailTableViewController else { return}
            
            //let entry = EntryController.sharedInstance.entries[selectedIndexPath.row]
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
            destinationVC.task = task
        }
    }
}

extension TaskListTableViewController: NSFetchedResultsControllerDelegate {
    
   func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
       tableView.beginUpdates()
   }
   
   func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
       tableView.endUpdates()
   }
   
   func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    
       switch type {
       case .delete:
            guard let index = indexPath else { break }
           tableView.deleteRows(at: [index], with: .fade)
       case .insert:
           guard let newIndexPath = newIndexPath else { break }
           tableView.insertRows(at: [newIndexPath], with: .automatic)
       case .move:
           guard let indexPath = indexPath, let newIndexPath = newIndexPath else { break }
           tableView.moveRow(at: indexPath, to: newIndexPath)
       case .update:
           guard let indexPath = indexPath else { break }
           tableView.reloadRows(at: [indexPath], with: .automatic)
       @unknown default:
           fatalError("NSFetchedResultsChangeType process failed!!!")
       }
   }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        @unknown default:
            fatalError()
        }
    }
    
    
}

extension TaskListTableViewController: ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
        TaskController.shared.toggleIsTaskComplete(task: task)
        // Am I suppose to Toggle the button isComplete here?
        sender.update(withTask: task)
    }
}
