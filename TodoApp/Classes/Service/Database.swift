//
//  Database.swift
//  todoApp
//
//  Created by yusuga on 2021/05/20.
//

import Foundation
import RealmSwift

/// - SeeAlso:
///   - https://qiita.com/sagaraya/items/96708cd451021fb040b7
///   - https://academy.realm.io/posts/nspredicate-cheatsheet/
final class Database {
  
  static var shared = Database()
  private let realmConfiguration = Realm.Configuration(
    schemaVersion: 2,
    objectTypes: [
      TodoList.self,
      Todo.self,
    ]
  )
  
  private func realm() throws -> Realm {
    return try .init(configuration: realmConfiguration)
  }
  
  private func todoList() throws -> TodoList {
    let realm = try realm()
    
    // Realmに保存されているTodoListを取得
    if let todoList = realm.object(ofType: TodoList.self, forPrimaryKey: TodoList.defaultID) {
      return todoList
    }
    
    let todoList = TodoList()
    print("\(#function) \(#line) todoList.realm: \(String(describing: todoList.realm))") // nil

    // todoList.todos.append(Todo(title: "", memo: nil, deadline: Date()))
    
    try realm.write {
      realm.add(todoList)
    }

     // realm.write を使わない場合
//     realm.beginWrite()
//     realm.add(todoList)
//     try realm.commitWrite()
    
    print("\(#function) \(#line) todoList.realm: \(String(describing: todoList.realm))") // not nil
    // 以下はトランザクション外の書き込みなのでランタイムエラー
    // todoList.todos.append(Todo(title: "", memo: nil, deadline: Date()))
    
    return todoList
  }
  
  // MARK: -
  
  private let key = "todoList"
  
  var todoCount: Int {
    return try! todoList().todos.count
  }
  
//  func todo(at index: Int) -> Todo {
//    (try! todoList()).todos[index]
//  }
  
  func add(_ todo: Todo) throws {
    let todoList = try todoList()
    let realm = try realm()
    
    try realm.write {
      todoList.todos.append(todo)
    }
  }
  
  func deleteTodo(_ todo: Todo) throws {
    assert(todo.realm != nil)
    let realm = try realm()
    
    try realm.write {
      realm.delete(todo)
    }
  }
  
  func moveTodo(from fromIndex: Int, to toIndex: Int) throws {
    let realm = try realm()
    
    try realm.write {
      try todoList().todos.move(from: fromIndex, to: toIndex)
    }
    
  }
  
  func updateTodo(
    for id: String,
    modificationHandler: (Todo) -> Void
  ) throws {
    let realm = try realm()
    
    try realm.write {
      try modificationHandler(
        fetchTodo(for: id)
      )
    }
  }
  
  func update(_ todo: Todo) throws {
    let todoList = try self.todoList()
    let realm = try realm()
    
    try realm.write {
      realm.add(todo, update: .modified)
    }
    
    if todoList.todos.first(where: { $0.id == todo.id }) == nil {
      try add(todo)
    }
  }
  
  func setIsDone(_ isDone: Bool, for id: String) throws {
    let realm = try realm()
    
    try realm.write {
      try fetchTodo(for: id).isDone = isDone
    }
  }
  
  func todos() throws -> List<Todo> {
    return try todoList().todos
  }
}

private extension Database {
  
  func fetchTodo(for id: String) throws -> Todo {
    guard let todo = try realm().object(ofType: Todo.self, forPrimaryKey: id) else {
      fatalError() // TODO: throw Error
    }
    return todo
  }
}
