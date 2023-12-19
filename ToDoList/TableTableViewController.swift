//
//  TableTableViewController.swift
//  ToDoList
//
//  Created by Jason Yang on 12/16/23.
//
import SwiftUI
import UIKit


var items: [TaskItem] = [
    TaskItem(title: "To Do List 추가하기", isCompleted: false, regDate: Date()),
    TaskItem(title: "플러스 버튼을 누르세요.", isCompleted: false, regDate: Date())
]

class TaskItem {
    var title: String
    var isCompleted: Bool
    var regDate: Date
    
    init(title: String, isCompleted: Bool, regDate: Date) {
        self.title = title
        self.isCompleted = isCompleted
        self.regDate = regDate
    }
}


class TableTableViewController: UITableViewController {

    @IBOutlet var tableViewList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    // 왼쪽 edit버튼 활성화

    override func viewWillAppear(_ animated: Bool) {
        tableViewList.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        // section은 한 셀에 들어가는 표의 칸
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...
        let currentItem = items[indexPath.row]
                cell.textLabel?.text = "\(currentItem.title) - \(currentItem.regDate.toString("yyyy-MM-dd"))"
                cell.accessoryType = currentItem.isCompleted ? .checkmark : .none

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let deleteTableView = UIAlertController(title : "사용자의 모든 기기에서 삭제하겠습니까?", message: "이 할일 목록이 사용자의 모든 기기에서 삭제됩니다.", preferredStyle:  UIAlertController.Style.alert)
//            let deleteAction = UIAlertAction(title: "예", style: UIAlertAction.Style.default, handler: nil)
//            let cancelAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.default, handler: nil)
            let deleteAction = UIAlertAction(title: "예", style: .default) { _ in
                // Handle deletion here
                items.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }

            let cancelAction = UIAlertAction(title: "아니오", style: .default) { _ in
                // Handle the case where the user chooses not to delete
                print("Item not deleted")
                // You can perform additional actions if needed
            }
            
            
            deleteTableView.addAction(deleteAction)
            deleteTableView.addAction(cancelAction)
            present(deleteTableView, animated: true, completion: nil)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return  "지우기"
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = items.remove(at: fromIndexPath.row)
        items.insert(itemToMove, at: to.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Toggle the completion status when a cell is selected
            items[indexPath.row].isCompleted.toggle()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation
//    // 세그웨이를 이용하여 뷰를 이동하는 함수
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "sgDetail" {
//            let cell = sender as! UITableViewCell
//            let indexPath = self.tableViewList.indexPath(for: cell)
//            let detailView = segue.destination as! DetailViewController
//            detailView.receiveItem(items[((indexPath! as NSIndexPath).row)])
//        }
//    }


}

extension Date {
    func toString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
