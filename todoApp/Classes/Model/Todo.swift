//
//  Todo.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/02.
//

import Foundation

struct Todo: Codable, Equatable {
  
  private(set) var id = UUID()
  var title: String
  var memo: String?
  var deadline: Date
  var isDone = false
}
