//
//  AddToDoItemViewController.swift
//  ToDoList_ios
//
//  Created by Фараби Иса on 26.04.2023.
//

import UIKit

class AddTodoItemViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var toDoItems = [ToDoItem]()
    var callback: (()->())?
    var edit: ((ToDoItem)->())?
    var toEdit = false
    
    var titlee = ""
    var descriptionn = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = titlee
        descriptionTextField.text = descriptionn
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let newItem = ToDoItem(title: titleTextField.text ?? "", description: descriptionTextField.text ?? "")
        toDoItems.append(newItem)
        saveToDoItems() // save updated to-do items to UserDefaults
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveToDoItems() {
        if !toEdit {
            if let savedData = try? PropertyListEncoder().encode(toDoItems) {
                UserDefaults.standard.set(savedData, forKey: "ToDoList")
                callback?()
            }
        } else {
            edit?(ToDoItem(title: titleTextField.text ?? "", description: descriptionTextField.text ?? ""))
            toEdit = false
        }
    }
}
