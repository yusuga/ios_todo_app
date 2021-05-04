//
//  ViewController.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/01.
//

import UIKit
import Reusable

final class TodoViewController: UITableViewController, TodoAddingDelegateProtocol {
  
  // MARK: Properties
  private var todoList = [Todo]()
  private var userDefaults: UserDefaults { UserDefaults.standard }
  private let key = "todoList"
  
  // MARK: ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(cellType: TodoCell.self)
    
    guard let data = userDefaults.data(forKey: key),
          let todoList = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Todo]
    else {
      print("data: nil")
      return
    }

    self.todoList = todoList
  }
  
  // MARK: Delegates
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    todoList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as TodoCell
    cell.configure(title: todoList[indexPath.row].title)
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "addTodoSegue" {
      let navC = segue.destination as! UINavigationController
      let newTodoVC = navC.topViewController as! NewTodoViewController
      newTodoVC.delegate = self
    }
  }
  
  // MARK: Methods
  func addTodo(todo: Todo) {
    todoList.append(todo)
    tableView.insertRows(
      at: [IndexPath(row: todoList.count - 1, section: 0)],
      with: .automatic
    )
    
    // Userdefaultに保存
    let data = try! NSKeyedArchiver.archivedData(
      withRootObject: todoList,
      requiringSecureCoding: false
    )
    userDefaults.set(data, forKey: key)
  }
}
