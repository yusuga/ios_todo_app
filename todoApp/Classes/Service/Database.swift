//
//  Database.swift
//  todoApp
//
//  Created by yusuga on 2021/05/20.
//

import Foundation

final class Database {
  
  static var shared = Database()
  
  private(set) var todoList: [Todo] {
    didSet {
      NotificationCenter.default.post(name: .updateTodoList, object: nil)
    }
  }
  
  private init() {
    if let data = UserDefaults.standard.data(forKey: key) {
      todoList = try! JSONDecoder().decode([Todo].self, from: data)
    } else {
      todoList = []
    }
  }
  
  // MARK: Static
  private let key = "todoList"
  
  func deleteTodo(_ todo: Todo) {
    guard let index = todoList.firstIndex(where: { $0.id == todo.id }) else {
      fatalError()
    }
    todoList.remove(at: index)
  }
  
  func moveTodo(from fromIndex: Int, to toIndex: Int) {
    todoList.insert(
      todoList.remove(at: fromIndex),
      at: toIndex
    )
  }
  
  func saveTodoList() {
    // Userdefaultに保存
    try! UserDefaults.standard.set(
      JSONEncoder().encode(todoList),
      forKey: key
    )
  }
  
  func add(_ todo: Todo) {
    todoList.append(todo)
  }
}
