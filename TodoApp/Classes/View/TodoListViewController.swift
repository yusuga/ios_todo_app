//
//  ViewController.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/01.
//

import UIKit
import Reusable
import RealmSwift

final class TodoListViewController: UITableViewController {
  
  private let todos = try! Database.shared.todos()
  private var notificationToken: NotificationToken?
  
  // MARK: ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(cellType: TodoCell.self)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    navigationItem.leftBarButtonItem = editButtonItem
    
    notificationToken = todos.observe { [weak self] changes in
      guard let tableView = self?.tableView else { return }
      
      switch changes {
      case .initial:
        tableView.reloadData()
      case let .update(_, deletions, insertions, modifications):
        // TODO: 並び替えをサポート
//        tableView.beginUpdates()
//        tableView.deleteRows(
//          at: deletions.map { IndexPath(row: $0, section: 0) },
//          with: .automatic
//        )
//        tableView.insertRows(
//          at: insertions.map { IndexPath(row: $0, section: 0) },
//          with: .automatic
//        )
//        tableView.reloadRows(
//          at: modifications.map { IndexPath(row: $0, section: 0) },
//          with: .automatic
//        )
//        tableView.endUpdates()
        tableView.reloadData()
      case let .error(error):
        fatalError("\(error)")
      }
    }
  }
  
  // MARK: Delegates
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    todos.count
  }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as TodoCell
    cell.configure(todo: todos[indexPath.row])
    return cell
  }
  
  override func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    let todo = todos[indexPath.row]
    performSegue(withIdentifier: "showTodoSegue", sender: todo)
  }
  
  override func tableView(
    _ tableView: UITableView,
    canEditRowAt indexPath: IndexPath
  ) -> Bool {
    return true
  }
  
  override func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    switch editingStyle {
    case .delete:
      try! Database.shared.deleteTodo(
        todos[indexPath.row]
      )
      tableView.deleteRows(at: [indexPath], with: .automatic)
    default:
      break
    }
  }
  
  override func tableView(
    _ tableView: UITableView,
    canMoveRowAt indexPath: IndexPath
  ) -> Bool {
    return true
  }
  
  override func tableView(
    _ tableView: UITableView,
    moveRowAt sourceIndexPath: IndexPath,
    to destinationIndexPath: IndexPath
  ) {
    try! Database.shared.moveTodo(
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
        showTodoVC.todo = todo
      }
    }
  }
  
  // MARK: Methods
  
  @objc private func updateTodoList() {
    tableView.reloadData()
  }
}
