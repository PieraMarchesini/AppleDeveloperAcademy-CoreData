//
//  TaskDetailTableViewController.swift
//  CoreDataExample
//
//  Created by Piera Marchesini on 27/09/17.
//  Copyright © 2017 Piera Marchesini. All rights reserved.
//

import UIKit
import CoreData

class TaskDetailTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource,ProjectDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var titleTask: UITextField!
    @IBOutlet weak var priorityPicker: UIPickerView!
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    @IBOutlet weak var projectTask: UITextField!
    
    @IBOutlet weak var outletProjectButton: UIButton!
    
    var pickerData = [String]()
    var editedTask: Task?
    var project:Project?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.outletProjectButton.titleLabel?.textAlignment = .left
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.saveTask))
        
        //input data into the array
        self.priorityPicker.delegate = self
        self.priorityPicker.dataSource = self
        self.pickerData = ["High", "Medium", "Low"]
        self.priorityPicker.selectRow(1, inComponent: 0, animated: true)
        
        //Puts the data of Task on the fields
        if let task = editedTask {
            self.titleTask.text = task.title
            self.priorityPicker.selectRow(Int(task.priority), inComponent: 0, animated: true)
        }
        
        //Tap Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Actions
    @objc
    func saveTask(){
        if let editTask = self.editedTask {
            //Update task
            editTask.title = self.titleTask.text
            editTask.priority = Int16(priorityPicker.selectedRow(inComponent: 0))
            editTask.date = deadlinePicker.date as NSDate
//            editTask.project = Project(context: context)
//            editTask.project?.addToTask(<#T##value: Task##Task#>)
        } else {
            //Create task
            let newTask = NSEntityDescription.insertNewObject(forEntityName: "Task", into: context) as! Task
            newTask.title = self.titleTask.text
            newTask.priority = Int16(priorityPicker.selectedRow(inComponent: 0))
            newTask.date = deadlinePicker.date as NSDate
        }
        
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
    
    //MARK: - PickerView

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // MARK: - ProjectDelegate
    func projectTable(_ projectTable: ProjectTableViewController, didSelect project: Project) {
        self.project = project
        self.outletProjectButton.setTitle(project.name!, for: .normal)
        projectTable.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - IBAction
    
    @IBAction func tapProject(_ sender: UIButton) {
        self.presentProjectList()
    }
    
    // MARK: - Method
    func presentProjectList() {
        if let projectList = ProjectTableViewController.instanceListingProject() {
            projectList.delegate = self
            let navigationController = UINavigationController(rootViewController: projectList)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    

}
