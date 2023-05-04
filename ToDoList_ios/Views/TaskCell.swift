//
//  TaskCell.swift
//  ToDoList_ios
//
//  Created by Фараби Иса on 26.04.2023.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descryptionLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    var completed: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func completeSelected(_ sender: UIButton) {
        if !completed {
            completeButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            completeButton.currentImage?.withTintColor(.systemGreen)
            completed = true
        } else {
            completeButton.setImage(UIImage(systemName: "circle"), for: .normal)
            completeButton.currentImage?.withTintColor(.systemGreen)
            completed = false
        }
    }
}
