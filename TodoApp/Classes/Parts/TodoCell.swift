//
//  TodoCell.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/01.
//

import Foundation
import UIKit
import Reusable

final class TodoCell: UITableViewCell, NibReusable {
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var checkButton: UIButton!
  private var id: String?
  
  private var isDone = false {
    didSet {
      if isDone {
        checkButton.setImage(
          UIImage(
            systemName: "checkmark.circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)),
          for: .normal
        )
      } else {
        checkButton.setImage(
          UIImage(
            systemName: "circle",
            withConfiguration: UIImage.SymbolConfiguration(scale: .large)),
          for: .normal
        )
      }
    }
  }
  
  func configure(todo: Todo) {
    self.id = todo.id
    titleLabel?.text = todo.title
    isDone = todo.isDone
  }
  
  @IBAction func buttonTapped(_ sender: UIButton) {
    isDone.toggle()
    guard let id = id else { return }
    try! Database.shared.setIsDone(isDone, for: id)
  }
}
