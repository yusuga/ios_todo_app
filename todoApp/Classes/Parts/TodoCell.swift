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
  
  private var isChecked = false {
    didSet {
      if isChecked {
        checkButton.setImage(
          UIImage(
            systemName: "checkmark.circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(scale: .medium)),
          for: .normal
        )
      } else {
        checkButton.setImage(
          UIImage(
            systemName: "circle",
            withConfiguration: UIImage.SymbolConfiguration(scale: .medium)),
          for: .normal
        )
      }
    }
  }
  
  func configure(title: String) {
    titleLabel?.text = title
  }
  
  @IBAction func buttonTapped(_ sender: UIButton) {
    isChecked = !isChecked
  }
}
