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
    var toEdit = false
    var selectedItem: ToDoItem?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasksView.dataSource = self
        tasksView.delegate = self
        tasksView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TodoCell")
        
        if let savedData = UserDefaults.standard.object(forKey: "ToDoList") as? Data,
           let savedList = try? PropertyListDecoder().decode([ToDoItem].self, from: savedData) {
            toDoItems = savedList
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "AddTodoItemSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "AddTodoItemSegue" {
            print("Segue triggered for SomeViewController")
            if let destination = segue.destination as? AddTodoItemViewController {
                if !toEdit {
                    destination.callback = {
                        if let savedData = UserDefaults.standard.object(forKey: "ToDoList") as? Data,
                           let savedList = try? PropertyListDecoder().decode([ToDoItem].self, from: savedData) {
                            self.toDoItems += savedList
                        }
                        DispatchQueue.main.async {
                            self.tasksView.reloadData()
                        }
                    }
                } else {
                    destination.titlee = selectedItem?.title ?? ""
                    destination.descriptionn = selectedItem?.description ?? ""
                    destination.toEdit = true
                    destination.edit = { item in
                        guard let index = self.index else { return }
                        print(item)
                        self.toDoItems[index] = item
                        if let savedData = try? PropertyListEncoder().encode(self.toDoItems) {
                            UserDefaults.standard.set(savedData, forKey: "ToDoList")
                        }
                        DispatchQueue.main.async {
                            self.tasksView.reloadData()
                        }
                    }
                    toEdit = false
                }
                
            }
        }
    }
    
    @objc func editButtonPressed() {
    }
    
}

extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TaskCell
        
        // Get the title and description for the current row
        let title = toDoItems[indexPath.row].title
        let description = toDoItems[indexPath.row].description
        
        // Set the text label for the cell
        cell.titleLabel.text = title
        cell.descryptionLabel.text = description
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print(toDoItems[indexPath.row])
        self.selectedItem = toDoItems[indexPath.row]
        self.index = indexPath.row
        toEdit = true
        performSegue(withIdentifier: "AddTodoItemSegue", sender: self)
    }
}
