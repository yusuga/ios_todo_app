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
  
  func configure(title: String) {
    titleLabel?.text = title
  }
}
