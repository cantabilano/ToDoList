//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Jason Yang on 12/16/23.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textViewDetailItem: UITextView!
    
    var receiveItem = ""
    
    @IBOutlet var lblItem: UILabel!
    
    @IBOutlet var txtViewDetailItem: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textViewDetailItem.delegate = self

//        lblItem.text = receiveItem
        // Do any additional setup after loading the view.
        if let savedText = UserDefaults.standard.string(forKey: "savedText") {
                    textViewDetailItem.text = savedText
                }
    }
    // 테이블뷰에서 받을 프로퍼티 receiveItem을 선언하고 뷰가 노출될 때마다 String을 레이블의 텍스트로 표시함.
    func receiveItem(_ item: String) {
        receiveItem = item
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        saveText()
    }

    // Save the text when the app enters the background
    func applicationWillResignActive() {
        saveText()
    }

    // Save the text to UserDefaults
    func saveText() {
        UserDefaults.standard.set(textViewDetailItem.text, forKey: "savedText")
    }

    // Implement UITextViewDelegate method to handle text changes
    func textViewDidChange(_ textView: UITextView) {
        saveText()
    }

    // Implement UITextViewDelegate method to handle return key press
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}


