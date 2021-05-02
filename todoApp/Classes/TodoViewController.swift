//
//  ViewController.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/01.
//

import UIKit
import Reusable

final class TodoViewController: UITableViewController {
  
  private let todoList = (1...20).map { "todo \($0)" }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(cellType: TodoCell.self)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    todoList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as TodoCell
    cell.configure(title: todoList[indexPath.row])
    return cell
  }
}
