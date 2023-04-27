//
//  ToDoBrain.swift
//  ToDoList_ios
//
//  Created by Фараби Иса on 27.04.2023.
//

import Foundation

struct ToDoBrain {
    
    var toDoList: [ToDoItem] = []
    
    func getTitleValue(row index: Int) -> String {
        let titleValue = String(toDoList[index].title)
        return titleValue
    }
    
    func getDescryptionValue(row index: Int) -> String {
        let descryptinValue = String(toDoList[index].description)
        return descryptinValue
    }
    
    func getSize() -> Int {
        let size = toDoList.count
        return size
    }
    
    mutating func addToDo(title: String, descryption: String) {
        let newItem = ToDoItem(title: title, description: descryption)
        toDoList.append(newItem)
        print(toDoList)
    }
}
