//
//  ShowTodoViewController.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/04.
//

import Foundation
import UIKit

protocol TodoUpdatingDelegateProtocol {
  func updateTodo()
}

final class ShowTodoViewController: UITableViewController, UITextFieldDelegate {
  
  // MARK: Properties
  var delegate: TodoUpdatingDelegateProtocol? = nil
  var todo: Todo? = nil
  
  @IBOutlet private weak var titleLabel: UITextField!
  @IBOutlet private weak var memoTextView: UITextView!
  @IBOutlet private weak var deadlineDatePicker: UIDatePicker!
  @IBOutlet private weak var updateButton: UIBarButtonItem!
  
  
  // MARK: ViewDidLoad
  override func viewDidLoad() {
    titleLabel.delegate = self
    
    if let todo = self.todo {
      titleLabel.text = todo.title
      memoTextView.text = todo.memo
      deadlineDatePicker.date = todo.deadline
    }
  }
  
  // MARK: Delegates
  func textFieldDidChangeSelection(_ textField: UITextField) {
    updateUpdateButtonState()
  }
  
  // MARK: Actions
  @IBAction func updateTodo(_ sender: Any) {
    if delegate != nil && titleLabel.text?.isEmpty == false {
      if let todo = self.todo, let title = titleLabel.text {
        todo.title = title
        todo.memo = memoTextView.text
        todo.deadline = deadlineDatePicker.date

        delegate!.updateTodo()
        self.navigationController?.popViewController(animated: true)
      }
    }
  }
  
  // MARK: Methods
  private func updateUpdateButtonState() {
    let text = titleLabel.text ?? ""
    updateButton.isEnabled = !text.isEmpty
  }
}
