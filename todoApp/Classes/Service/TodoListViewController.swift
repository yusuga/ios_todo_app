//
//  ViewController.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/01.
//

import UIKit
import Reusable

final class TodoListViewController: UITableViewController, TodoUpdatingDelegateProtocol {
    
  // MARK: ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(cellType: TodoCell.self)
    NotificationCenter.default.addObserver(self, selector: #selector(updateTodoList), name: .updateTodoList, object: nil)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    navigationItem.leftBarButtonItem = editButtonItem
  }
  
  // MARK: Delegates
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    Database.shared.todoList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as TodoCell
    cell.configure(title: Database.shared.todoList[indexPath.row].title)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let todo = Database.shared.todoList[indexPath.row]
    performSegue(withIdentifier: "showTodoSegue", sender: todo)
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    switch editingStyle {
    case .delete:
      Database.shared.deleteTodo(
        Database.shared.todoList[indexPath.row]
      )
      tableView.deleteRows(at: [indexPath], with: .automatic)
    default:
      break
    }
  }
  
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    Database.shared.moveTodo(
      from: sourceIndexPath.row,
      to: destinationIndexPath.row
    )
  }
  
  override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
    return false
  }
  
  override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
    return proposedDestinationIndexPath
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showTodoSegue" {
      if let showTodoVC = segue.destination as? TodoViewController, let todo = sender as? Todo {
        showTodoVC.delegate = self
        showTodoVC.todo = todo
      }
    }
  }
  
  // MARK: Methods
  func updateTodo() {
    tableView.reloadData()
  }
  
  @objc private func updateTodoList() {
    tableView.reloadData()
  }
}
