//
//  Todo.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/02.
//

import Foundation

struct Todo {
  let title: String
  let memo: String?
  let deadline: Date?
  let is_done: Bool = false
}
