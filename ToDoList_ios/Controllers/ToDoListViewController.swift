//
//  ViewController.swift
//  ToDoList_ios
//
//  Created by Фараби Иса on 25.04.2023.
//

import UIKit

class ToDoListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tasksView: UITableView!
    
    var todoItems: [ToDoItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "AddTodoItemSegue", sender: self)
    }
    
    @objc func editButtonPressed() {
//        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        let todoItem = todoItems[indexPath.row]
        cell.textLabel?.text = todoItem.title
        cell.detailTextLabel?.text = todoItem.description
        
        return cell
    }
    
}


