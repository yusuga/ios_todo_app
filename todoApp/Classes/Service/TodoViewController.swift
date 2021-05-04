//
//  ViewController.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/01.
//

import UIKit
import Reusable

final class TodoViewController: UITableViewController, TodoAddingDelegateProtocol {
  
  private var todoList = (1...20).map {
    Todo(
      title: "todo\($0)",
      memo: "todo\($0)",
      deadline: Date()
    )
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(cellType: TodoCell.self)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    todoList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as TodoCell
    cell.configure(title: todoList[indexPath.row].title)
    return cell
  }
  
  func addTodo(todo: Todo) {
    todoList.append(todo)
    tableView.insertRows(
      at: [IndexPath(row: todoList.count - 1, section: 0)],
      with: .automatic
    )
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "addTodoSegue" {
      let navC = segue.destination as! UINavigationController
      let newTodoVC = navC.topViewController as! NewTodoViewController
      newTodoVC.delegate = self
    }
  }
}
