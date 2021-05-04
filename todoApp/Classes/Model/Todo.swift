//
//  Todo.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/02.
//

import Foundation

final class Todo: NSObject, NSCoding {
  
  var title: String
  var memo: String?
  var deadline: Date?
  var is_done: Bool
  static private let key = "todoList"
  static private var userDefaults: UserDefaults { UserDefaults.standard }
  
  init(title: String, memo: String, deadline: Date, is_done: Bool = false) {
    self.title = title
    self.memo = memo
    self.deadline = deadline
    self.is_done = is_done
  }
  
  required convenience init?(coder: NSCoder) {
    // オプショナルバインディングとダウンキャスト
    guard let title = coder.decodeObject(forKey: "title") as? String else {
      return nil
    }
    guard let memo = coder.decodeObject(forKey: "memo") as? String else {
      return nil
    }
    guard let deadline = coder.decodeObject(forKey: "deadline") as? Date else {
      return nil
    }
    
    self.init(
      title: title,
      memo: memo,
      deadline: deadline,
      is_done: coder.decodeBool(forKey: "is_done")
    )
  }
  
  func encode(with coder: NSCoder) {
    // 下記のtitleなどはselfのもの
    coder.encode(title, forKey: "title")
    coder.encode(memo, forKey: "memo")
    coder.encode(deadline, forKey: "deadline")
    coder.encode(is_done, forKey: "is_done")
  }
  
  // MARK: Methods
  
  // MARK: StaticMethods
  static func all() -> [Todo] {
    guard let data = userDefaults.data(forKey: key),
          let todoList = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Todo]
    else {
      return []
    }
    
    return todoList
  }
  
  static func save(todoList: [Todo]) {
    // Userdefaultに保存
    let data = try! NSKeyedArchiver.archivedData(
      withRootObject: todoList,
      requiringSecureCoding: false
    )
    Todo.userDefaults.set(data, forKey: Todo.key)
  }
}

