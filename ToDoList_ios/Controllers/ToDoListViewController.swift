//
//  ViewController.swift
//  ToDoList_ios
//
//  Created by Фараби Иса on 25.04.2023.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var tasksView: UITableView!
    
    var toDoItems = ToDoBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasksView.dataSource = self
        tasksView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TodoCell")
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "AddTodoItemSegue", sender: self)
    }
    
    @objc func editButtonPressed() {
    }
    
}

extension ToDoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let size = toDoItems.getSize()
        return size
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! TaskCell
        
        // Get the title and description for the current row
        let title = toDoItems.getTitleValue(row: indexPath.row)
        let description = toDoItems.getDescryptionValue(row: indexPath.row)
        
        // Set the text label for the cell
        cell.titleLabel.text = title
        cell.descryptionLabel.text = description
        
        return cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TaskCell
//
////        let todoItem = todoItems[indexPath.row]
////        cell.titleLabel.text = todoItem.title
////        cell.descryptionLabel.text = todoItem.description
//        cell.titleLabel.text = toDoItems.getTitleValue(row: indexPath.row)
////        cell.descryptionLabel.text = toDoItems.getDescryptionValue(row: indexPath.row)
//
//        return cell
    }
}
