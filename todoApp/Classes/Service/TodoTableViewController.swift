//
//  ViewController.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/01.
//

import UIKit
import Reusable

final class TodoTableViewController: UITableViewController, TodoAddingDelegateProtocol, TodoUpdatingDelegateProtocol {
  
  // MARK: Properties
  private var todoList = [Todo]()
  
  // MARK: ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(cellType: TodoCell.self)

    todoList = Todo.all()
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
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let todo = todoList[indexPath.row]
    performSegue(withIdentifier: "showTodoSegue", sender: todo)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "addTodoSegue":
      let navC = segue.destination as! UINavigationController
      let newTodoVC = navC.topViewController as! NewTodoViewController
      newTodoVC.delegate = self
    case "showTodoSegue":
      if let showTodoVC = segue.destination as? ShowTodoViewController, let todo = sender as? Todo {
        showTodoVC.delegate = self
        showTodoVC.todo = todo
      }
    default:
      fatalError()
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
    Todo.save(todoList: todoList)
  }
  
  func updateTodo(todo: Todo) {
    print("updated")
  }
}
