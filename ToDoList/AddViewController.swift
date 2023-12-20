//
//  AddViewController.swift
//  ToDoList
//
//  Created by Jason Yang on 12/16/23.
//

import UIKit



class AddViewController: UIViewController {
    
    @IBOutlet var textFieldAddItem: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //    @IBAction func btnAddItem(_ sender: UIButton) {
    //        // Use items here
    //        //items.append(textFieldAddItem.text!)
    //        textFieldAddItem.text = ""
    //                _ = navigationController?.popViewController(animated: true)
    //            }
    //    }
    @IBAction func btnAddItem(_ sender: UIButton) {
           if let newItemTitle = textFieldAddItem.text, !newItemTitle.isEmpty {
               let newItem = TaskItem(title: newItemTitle, isCompleted: false, regDate: Date())
               items.append(newItem)
               itemsIamgeFile.append("checkbox_isuncompleted.png")
               textFieldAddItem.text = ""
               // Optionally, you can print or do something else with the added item
               print("Item added: \(newItem)")
           }
           _ = navigationController?.popViewController(animated: true)
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFieldAddItem.autocorrectionType = .no
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
