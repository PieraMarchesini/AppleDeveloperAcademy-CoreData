//
//  TasksTableViewController.swift
//  CoreDataExample
//
//  Created by Piera Marchesini on 27/09/17.
//  Copyright © 2017 Piera Marchesini. All rights reserved.
//

import UIKit

class TasksTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks = [Task]()
    var rowEditing = false
    var selectedTask: Task?
    
    override func viewWillAppear(_ animated: Bool) {
        //Read tasks of CoreData
        do {
            try tasks = context.fetch(Task.fetchRequest()) as! [Task]
            self.tableView.reloadData()
        } catch  {
            fatalError("Failed to fetch tasks: \(error)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red: 249/255, green: 252/255, blue: 252/255, alpha: 1 )]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func addPressed(_ sender: Any) {
        self.rowEditing = false
        self.performSegue(withIdentifier: "toDetailTableView", sender: self)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        cell.titleTask.text = tasks[indexPath.row].title
        cell.priorityTask.text = Priority(rawValue: Int(tasks[indexPath.row].priority))?.description
        cell.dateTask.text = tasks[indexPath.row].date?.description
        
        return cell
    }
    
    //MARK: - Edit TableViewController
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete task
            let commit = tasks[indexPath.row]
            context.delete(commit)
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.rowEditing = true
        selectedTask = tasks[indexPath.row]
        performSegue(withIdentifier: "toDetailTableView", sender: self)
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
        if segue.identifier == "toDetailTableView" {
            if let destination = segue.destination as? TaskDetailTableViewController {
                if rowEditing {
                    destination.editedTask = selectedTask
                    rowEditing = false
                }
            }
        }
    }

}
