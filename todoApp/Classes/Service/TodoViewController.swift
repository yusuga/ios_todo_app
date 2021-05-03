//
//  ViewController.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/01.
//

import UIKit
import Reusable

final class TodoViewController: UITableViewController {
  
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
  
//  @IBAction func addTodo(_ sender: Any) {
//    // データソースの更新
//    todoList.append(
//      Todo(
//        title: "hogehoge",
//        memo: "hogehoge",
//        deadline: Date()
//      )
//    )
//    
//    // UIの更新
//    tableView.insertRows(
//      at: [IndexPath(row: todoList.count - 1, section: 0)],
//      with: .automatic
//    )
//  }
}
