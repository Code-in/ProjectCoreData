//
//  TaskListTableViewController.swift
//  ProjectCoreData
//
//  Created by Pete Parks on 4/22/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    fileprivate var cellIdentifier: String = "taskCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // This is going to update song count in playlists if a song is added
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.shared.tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ButtonTableViewCell else  { return UITableViewCell() }
        
        let task = TaskController.shared.tasks[indexPath.row]
        cell.delegate = self
        cell.update(withTask: task)
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let task = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.remove(task: task)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let dstVC = segue.destination as? TaskDetailTableViewController else { return }
            let task = TaskController.shared.tasks[indexPath.row]
            dstVC.task = task
            dstVC.dueDateValue = task.due
        }
    }
}


extension TaskListTableViewController: ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let task = TaskController.shared.tasks[indexPath.row]
        sender.update(withTask: task)
    }
    
    
}
