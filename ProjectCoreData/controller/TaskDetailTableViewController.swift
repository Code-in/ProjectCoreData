//
//  TaskDetailTableViewController.swift
//  ProjectCoreData
//
//  Created by Pete Parks on 4/22/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    fileprivate var nameCellIdentifier: String = "nameCell"
    fileprivate var dueCellIdentifier: String = "dueCell"
    fileprivate var notesCellIdentifier: String = "notesCell"
    
    // MARK: Source of Truth
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    var dueDateValue: Date?
    
    // MARK: Outlets
    @IBOutlet weak var nameTextFieldOutlet: UITextField!
    @IBOutlet weak var notesTextFieldOutlet: UITextView!
    @IBOutlet weak var dueTextFieldOutlet: UITextField!
    
    @IBOutlet var dueDatePickerOutlet: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        dueTextFieldOutlet.inputView = dueDatePickerOutlet
    }
    
    func updateViews() {
        guard let task = task, isViewLoaded else { return }
        nameTextFieldOutlet.text = task.name
        notesTextFieldOutlet.text = task.note
        dueTextFieldOutlet.text = task.due?.stringValue()
    }
    
    // MARK: Actions
    
    @IBAction func cancelButtonTabbedAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func userTappedViewAction(_ sender: UIGestureRecognizer) {
        nameTextFieldOutlet.resignFirstResponder()
        notesTextFieldOutlet.resignFirstResponder()
        dueTextFieldOutlet.resignFirstResponder()
    }
    
    @IBAction func datePickerValueChangedAction(_ sender: UIDatePicker) {
        dueDateValue = sender.date
        dueTextFieldOutlet.text = dueDateValue?.stringValue()
        
    }
    @IBAction func saveButtonTappedAction(_ sender: Any) {
        guard let name = nameTextFieldOutlet.text,
            let due = dueDateValue,
            let notes = notesTextFieldOutlet.text,
            !name.isEmpty,
            !notes.isEmpty else { return }
        
        if let task = task {
            // update task
            TaskController.shared.update(task: task, name: name, note: notes, due: due, isComplete: task.isComplete)  // TODO: ask why can't we get a isComplete value say we can say thing is done.
        } else {
            // new task
            TaskController.shared.add(name: name, note: notes, due: due)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1    // MARK: - Table view data source
    }
    
    
    
      
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        

        
        /*
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: nameCellIdentifier, for: indexPath)
        cell1.textLabel?.text = TaskController.shared.tasks[indexPath.row].name
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: dueCellIdentifier, for: indexPath)
        cell2.textLabel?.text = TaskController.shared.tasks[indexPath.row].name
        
        let cell3 = tableView.dequeueReusableCell(withIdentifier: notesCellIdentifier, for: indexPath)
        cell3.textLabel?.text = TaskController.shared.tasks[indexPath.row].name
        */
        
        
        
        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
