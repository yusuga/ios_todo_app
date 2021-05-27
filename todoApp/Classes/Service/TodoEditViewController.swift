//
//  NewTodoView.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/03.
//

import Foundation
import UIKit

final class TodoEditViewController: UITableViewController, UITextViewDelegate, UITextFieldDelegate {
  
  // MARK: Properties
  
  @IBOutlet private weak var titleLabel: UITextField!
  @IBOutlet private weak var memoTextView: UITextView!
  @IBOutlet private weak var deadlineDatePicker: UIDatePicker!
  @IBOutlet private weak var addButton: UIBarButtonItem!
  
  // MARK: ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleLabel.delegate = self
    memoTextView.delegate = self
    
    memoTextView.text = "メモ"
    memoTextView.textColor = UIColor.lightGray
    addButton.isEnabled = false
  }
  
  // MARK: Actions
  @IBAction func cancel(_ sender: Any) {
    self.dismiss(animated: true)
  }
  
  @IBAction func addTodo(_ sender: Any) {
    // TodoViewControllerに新しいタスクを渡す
    if titleLabel.text?.isEmpty == false {
      // プレースホルダーの場合はnilにする
      if memoTextView.textColor == UIColor.lightGray {
        memoTextView.text = nil
      }
      
      let todo = Todo(
        title: titleLabel.text!,
        memo: memoTextView.text,
        deadline: deadlineDatePicker.date
      )
      
      Database.shared.add(todo)
      NotificationCenter.default.post(name: .updateTodoList, object: nil)

      dismiss(animated: true, completion: nil)
    }
  }
  
  // MARK: Delegates
  func textFieldDidChangeSelection(_ textField: UITextField) {
    updateAddButtonState()
  }
  
  // TextViewのプレースホルダー
  func textViewDidBeginEditing(_ textView: UITextView) {
    if memoTextView.textColor == UIColor.lightGray {
      memoTextView.text = nil
      memoTextView.textColor = UIColor.black
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if memoTextView.text.isEmpty {
      memoTextView.text = "メモ"
      memoTextView.textColor = UIColor.lightGray
    }
  }
  
  // MARK: Methods
  private func updateAddButtonState() {
    let text = titleLabel.text ?? ""
    addButton.isEnabled = !text.isEmpty
  }
}
