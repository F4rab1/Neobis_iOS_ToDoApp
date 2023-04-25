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
    
//    var onSave: ((TodoItem) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
//        let todoItem = TodoItem(title: titleTextField.text ?? "", description: descriptionTextField.text ?? "")
//        onSave?(todoItem)
        dismiss(animated: true, completion: nil)
        print(titleTextField.text!)
        print(descriptionTextField.text!)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
