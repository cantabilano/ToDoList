//
//  TaskItem.swift
//  ToDoList
//
//  Created by Jason Yang on 12/22/23.
//

import Foundation

// 별도의 스위프트 파일로 분리
class TaskItem {
    var id: Int
    var title: String
    var isCompleted: Bool
    var regDate: Date
    
    init(id: Int, title: String, isCompleted: Bool, regDate: Date) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.regDate = regDate
    }
}
