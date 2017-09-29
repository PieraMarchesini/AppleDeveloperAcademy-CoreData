//
//  ProjectDetailTableViewController.swift
//  CoreDataExample
//
//  Created by Piera Marchesini on 28/09/17.
//  Copyright © 2017 Piera Marchesini. All rights reserved.
//

import UIKit
import CoreData

class ProjectDetailTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    weak var outletProjectTitle: UITextField!
    
    var editedProject: Project?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.saveProject))
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        //Puts the data of Project on the fields
        if let project = editedProject {
//            self.titleTask.text = task.title
//            self.priorityPicker.selectRow(Int(task.priority), inComponent: 0, animated: true)
        }
    }
    
    //MARK: - Actions
    @objc
    func saveProject(){
        var project:Project!
        
        if let editProject = self.editedProject {
            //Update task
            project = editProject
        } else {
            //Create task
            project = Project(context: context)
        }
        project.name = self.outletProjectTitle.text
        
        do {
            try context.save()
            self.navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
        
    }
    
    @objc
    func hideKeyboard() {
        tableView.endEditing(true)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if let arrayList = editedProject?.task?.array {
                return arrayList.count
            } else {
                return 0
            }
        default:
            print("Error")
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "NAME"
        case 1:
            return "TASKS"
        default:
            return ""
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //
        if indexPath.section == 0 {
            guard let cellProject = tableView.dequeueReusableCell(withIdentifier: "cellProject", for: indexPath) as? ProjectDetailProjectNameTableViewCell else {
                return UITableViewCell()
            }
            
            //Guardar a instancia do UITextField
            self.outletProjectTitle = cellProject.projectName
            
            //
            if let project = self.editedProject {
                cellProject.projectName.text = project.name
                
            } else {
                cellProject.projectName.text = ""
            }
            return cellProject
        
        //
        } else {
            guard let cellTask = tableView.dequeueReusableCell(withIdentifier: "cellTask", for: indexPath) as? ProjectDetailTableViewCell else {
                return UITableViewCell()
            }
            
            guard let arrayList = editedProject?.task?.array else {
                print("No tasks")
                return UITableViewCell()
            }
            
            var taskList = [Task]()
            
            for task in arrayList {
                if let taskCasted = task as? Task {
                    taskList.append(taskCasted)
                }
            }
            
            cellTask.taskTitle.text = taskList[indexPath.row].title
            return cellTask
        }
    }

    /*s
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
