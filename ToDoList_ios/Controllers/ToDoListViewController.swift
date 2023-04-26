//
//  ViewController.swift
//  ToDoList_ios
//
//  Created by Фараби Иса on 25.04.2023.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var tasksView: UITableView!
    
    var todoItems: [ToDoItem] = [
        ToDoItem(title: "First", description: "First"),
        ToDoItem(title: "2", description: "First"),
        ToDoItem(title: "3", description: "First")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasksView.dataSource = self
        tasksView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TodoCell")
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "AddTodoItemSegue", sender: self)
    }
    
    @objc func editButtonPressed() {
//        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
}

extension ToDoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TaskCell
        
        let todoItem = todoItems[indexPath.row]
        cell.titleLabel.text = todoItem.title
        cell.descryptionLabel.text = todoItem.description
        
        return cell
    }
}
