//
//  TableTableViewController.swift
//  ToDoList
//
//  Created by Jason Yang on 12/16/23.
//
import SwiftUI
import UIKit

// 더미데이터
var items: [TaskItem] = [
    TaskItem(id: 0, title: "To Do List 추가하기", isCompleted: false, regDate: Date()),
    TaskItem(id: 1, title: "플러스 버튼을 누르세요.", isCompleted: false, regDate: Date())
]

// 완료여부 체크박스 이미지 프로퍼티
var itemsIamgeFile = ["checkbox_iscompleted.png", "checkbox_isuncompleted.png"]

class TableTableViewController: UITableViewController {

    @IBOutlet var tableViewList: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        //프레젠테이션 간의 선택사항을 보존하려면 다음 행의 주석을 해제합니다
//        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // 왼쪽 edit버튼 활성화
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // 뷰가 노출될 때마다 리스트의 데이터를 다시 불러옴
    override func viewWillAppear(_ animated: Bool) {
        tableViewList.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        // section은 한 셀에 들어가는 테이블(표)의 section
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell... 셀을 설정하기 위한 프로퍼티
        let currentItem = items[indexPath.row]
                cell.textLabel?.text = "\(currentItem.title) - \(currentItem.regDate.toString("yyyy-MM-dd"))"
        //        cell.accessoryType = currentItem.isCompleted ? .checkmark : .none
                
        // Get the image file name based on completion status
        let imageName = currentItem.isCompleted ? itemsIamgeFile[0] : itemsIamgeFile[1]

        // Set the image to the cell
        cell.imageView?.image = UIImage(named: imageName)
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view. -> 삭제 구현 매소드
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // editingStyle를 delete로 구현하는 매소드
        if editingStyle == .delete {
            // Delete the row from the data source
            
            // UIAlertController을 활용한 삭제 프로퍼티
            let deleteTableView = UIAlertController(title : "사용자의 모든 기기에서 삭제하겠습니까?", message: "이 할일 목록이 사용자의 모든 기기에서 삭제됩니다.", preferredStyle:  UIAlertController.Style.alert)
//            let deleteAction = UIAlertAction(title: "예", style: UIAlertAction.Style.default, handler: nil)
            //삭제 프로퍼티 : "예"를 보여주며 해당 row의 var items 프로퍼티와 완료여부 이미지를 삭제하는 프로퍼티
            let deleteAction = UIAlertAction(title: "예", style: .default) { _ in
                // Handle deletion here
                items.remove(at: (indexPath as NSIndexPath).row)
                itemsIamgeFile.remove(at: (indexPath as NSIndexPath).row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
            }
            
            // 삭제를 취소하는 프로퍼티
            let cancelAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.default, handler: nil)
//            let cancelAction = UIAlertAction(title: "아니오", style: .default) { _ in
//                // Handle the case where the user chooses not to delete
//                print("Item not deleted")
//                // You can perform additional actions if needed
//            }

            deleteTableView.addAction(deleteAction)
            deleteTableView.addAction(cancelAction)
            
            present(deleteTableView, animated: true, completion: nil)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    // 삭제버튼 한글로 변경
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return  "지우기"
    }

    // edit 기능에서 tableView 위치 변경
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = items.remove(at: fromIndexPath.row)
        _ = itemsIamgeFile
        items.insert(itemToMove, at: to.row)
    }
    
    
    // row 선택시 '완료' 구현 매소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("select")
        // Toggle the completion status when a cell is selected
        items[indexPath.row].isCompleted.toggle()
 
        // Update the image based on completion status -> 체크박스 이미지 구현 프로퍼티
        let imageName = items[indexPath.row].isCompleted ? itemsIamgeFile[0] : itemsIamgeFile[1]
        
        // Update the cell's image -> 체크박스 이미지 구현 옵셔널 매소드
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.imageView?.image = UIImage(named: imageName)
        }
        // Deselect the row to avoid showing the selection highlight
            tableView.deselectRow(at: indexPath, animated: true)
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
