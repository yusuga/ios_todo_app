//
//  ShowTodoViewController.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/04.
//

import Foundation
import UIKit

protocol TodoUpdatingDelegateProtocol {
  func updateTodo(todo: Todo)
}

final class ShowTodoViewController: UITableViewController {
  
  // MARK: Properties
  var delegate: TodoUpdatingDelegateProtocol? = nil
  var todo: Todo? = nil
  
  @IBOutlet private weak var titleLabel: UITextField!
  @IBOutlet private weak var memoTextView: UITextView!
  @IBOutlet private weak var deadlineDatePicker: UIDatePicker!
  
  // MARK: ViewDidLoad
  override func viewDidLoad() {
    if let todo = self.todo {
      titleLabel.text = todo.title
      memoTextView.text = todo.memo
      deadlineDatePicker.date = todo.deadline
    }
  }
}
