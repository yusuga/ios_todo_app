//
//  TodoViewController.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/04.
//

import Foundation
import UIKit

final class TodoViewController: UITableViewController, UITextFieldDelegate {
  
  // MARK: Properties
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
    guard titleLabel.text?.isEmpty == false,
          let id = todo?.id,
          let title = titleLabel.text
    else {
      fatalError()
    }
    
    try! Database.shared.updateTodo(
      for: id
    ) { [unowned self] todo in
      todo.title = title
      todo.memo = self.memoTextView.text
      todo.deadline = self.deadlineDatePicker.date
    }
    
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: Methods
  private func updateUpdateButtonState() {
    let text = titleLabel.text ?? ""
    updateButton.isEnabled = !text.isEmpty
  }
}
