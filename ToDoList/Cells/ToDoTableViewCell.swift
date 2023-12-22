//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Jason Yang on 12/22/23.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var doneSwitch: UISwitch!
    
    var todo: TaskItem?
    
    // doneSwitch를 눌렀을 때 밑줄이 그어지는 액션 매소드
    @IBAction func switchChanged(_ sender: Any) {
        
        if doneSwitch.isOn {
            textLabel?.text = nil
            textLabel?.attributedText = todo?.title.strikeThrough()
        } else {
            textLabel?.attributedText = nil
            textLabel?.text = todo?.title
        }
    }
    
    func setTask(_ _todo: TaskItem) {
        todo = _todo
        guard let todo else { return }
        if todo.isCompleted {
            textLabel?.text = nil
            textLabel?.attributedText = todo.title.strikeThrough()
        } else {
            textLabel?.attributedText = nil
            textLabel?.text = todo.title
        }
        doneSwitch.isOn = todo.isCompleted
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
