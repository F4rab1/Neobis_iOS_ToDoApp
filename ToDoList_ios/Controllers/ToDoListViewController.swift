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
        tasksView.rowHeight = UITableView.automaticDimension
        
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
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        tasksView.isEditing = !tasksView.isEditing
        sender.setTitle(tasksView.isEditing ? "" : "", for: .normal)
    }
    
}

extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TaskCell
        
        let title = toDoItems[indexPath.row].title
        let description = toDoItems[indexPath.row].description
        
        // Set the text label for the cell
        cell.titleLabel.text = title
        cell.descryptionLabel.text = description
        cell.titleLabel.numberOfLines = 0
        cell.descryptionLabel.numberOfLines = 0
        cell.accessoryType = .detailDisclosureButton
        cell.showsReorderControl = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = toDoItems.remove(at: sourceIndexPath.row)
        toDoItems.insert(movedItem, at: destinationIndexPath.row)
        
        saveToDoItems()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            saveToDoItems()
        }
    }
    
    private func saveToDoItems() {
        if let savedData = try? PropertyListEncoder().encode(toDoItems) {
            UserDefaults.standard.set(savedData, forKey: "ToDoList")
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        self.selectedItem = toDoItems[indexPath.row]
        self.index = indexPath.row
        toEdit = true
        performSegue(withIdentifier: "AddTodoItemSegue", sender: self)
    }
}
