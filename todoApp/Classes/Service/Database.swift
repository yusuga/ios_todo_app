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
      saveTodoList()
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
  
  func add(_ todo: Todo) {
    todoList.append(todo)
  }
  
  func update(_ newTodo: Todo) {
    guard let index = todoList.firstIndex(where: { $0.id == newTodo.id }) else {
      fatalError()
    }
    todoList.remove(at: index)
    todoList.insert(newTodo, at: index)
    
    // 配列内のstructを直接変更
//    todoList[index].title = newTodo.title
//    todoList[index].memo = newTodo.memo
//    todoList[index].deadline = newTodo.deadline
//    todoList[index].isDone = newTodo.isDone
    
    
    // NG
//    guard var oldTodo = todoList.first(where: { $0.id == newTodo.id }) else {
//      return
//    }
//    oldTodo.title = newTodo.title
  }
  
  func setIsDone(_ isDone: Bool, for id: UUID) {
    guard let index = todoList.firstIndex(where: { $0.id == id }) else {
      fatalError()
    }
    print("id: \(id), \(isDone)")
    todoList[index].isDone = isDone
  }
}

private extension Database {
  
  func saveTodoList() {
    // Userdefaultに保存
    try! UserDefaults.standard.set(
      JSONEncoder().encode(todoList),
      forKey: key
    )    
  }
}
