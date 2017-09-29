//
//  ProjectTableViewController.swift
//  CoreDataExample
//
//  Created by Piera Marchesini on 28/09/17.
//  Copyright © 2017 Piera Marchesini. All rights reserved.
//

import UIKit
import CoreData

protocol ProjectDelegate:class{
    func projectTable(_ projectTable:ProjectTableViewController, didSelect project:Project)
}

class ProjectTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var projects = [Project]()
    var rowEditing = false
    var selectedProject: Project?
    var isListing = false {
        didSet{
            if self.isListing {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ProjectTableViewController.dismiss(animated:completion:)))
            }
        }
    }
    
    //O delegate e colocado como weak, pois é necessario que ele 'morra' quando a instancia associada morrer também ou vice versa
    weak var delegate:ProjectDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        //Read tasks of CoreData
        do {
            try projects = context.fetch(Project.fetchRequest()) as! [Project]
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
    
    //MARK: - Actions
    @IBAction func addProject(_ sender: Any) {
        self.rowEditing = false
        self.performSegue(withIdentifier: "toProjectDetail", sender: self)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProjectTableViewCell else {
            return UITableViewCell()
        }

        cell.nameProject.text = projects[indexPath.row].name
        cell.numberOfTasks.text = "\(projects[indexPath.row].task?.array.count ?? 0)"

        return cell
    }

    //MARK: - Edit TableViewController
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete task
            let commit = projects[indexPath.row]
            context.delete(commit)
            projects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isListing {
            self.delegate?.projectTable(self, didSelect: projects[indexPath.row])
        }
        self.rowEditing = true
        selectedProject = projects[indexPath.row]
        performSegue(withIdentifier: "toProjectDetail", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
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

    // MARK: - Methods
    class func instanceListingProject() -> ProjectTableViewController? {
        
        //
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        //
        guard let projectTableViewController = storyboard.instantiateViewController(withIdentifier: "ProjectTableViewController") as? ProjectTableViewController else {
            print("Error to cast storyboard.instantiateViewController(withIdentifier: 'ProjectTableViewController') to ProjectTableViewController ")
            return nil
        }
        projectTableViewController.isListing = true
        
        return projectTableViewController
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProjectDetail" {
            if let destination = segue.destination as? ProjectDetailTableViewController {
                if rowEditing {
                    destination.editedProject = selectedProject
                    rowEditing = false
                }
            }
        }
    }

}
