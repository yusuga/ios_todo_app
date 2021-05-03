//
//  NewTodoView.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/03.
//

import Foundation
import UIKit

final class NewTodoViewController: UITableViewController, UITextViewDelegate {
  @IBOutlet weak var memoTextView: UITextView!
  
  override func viewDidLoad() {
    memoTextView.delegate = self
    memoTextView.text = "メモ"
    memoTextView.textColor = UIColor.lightGray
  }
  
  @IBAction func cancel(_ sender: Any) {
    self.dismiss(animated: true)
  }
  
  @IBAction func saveTodo(_ sender: Any) {
    // userDefauldに保存
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
}
