//
//  ViewController.swift
//  ToDoList_ios
//
//  Created by Фараби Иса on 25.04.2023.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var tasksView: UITableView!
    
    var toDoItems = [ToDoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasksView.dataSource = self
        tasksView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TodoCell")
        
        if let savedData = UserDefaults.standard.object(forKey: "ToDoList") as? Data,
           let savedList = try? PropertyListDecoder().decode([ToDoItem].self, from: savedData) {
            toDoItems = savedList
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "AddTodoItemSegue", sender: self)
    }
    
    @objc func editButtonPressed() {
    }
    
}

extension ToDoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! TaskCell
        
        // Get the title and description for the current row
        let title = toDoItems[indexPath.row].title
        let description = toDoItems[indexPath.row].description
        
        // Set the text label for the cell
        cell.titleLabel.text = title
        cell.descryptionLabel.text = description
        
        return cell
    }
}
