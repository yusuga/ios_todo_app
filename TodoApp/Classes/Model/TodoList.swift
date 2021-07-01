//
//  TodoList.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/04.
//

import Foundation
import RealmSwift

/// - SeeAlso: https://docs.mongodb.com/realm/sdk/ios/data-types/supported-property-types/
final class TodoList: Object {
  
  @objc private(set) dynamic var id = defaultID
  let todos = List<Todo>()
  
  override class func primaryKey() -> String? {
    return #keyPath(id)
  }
}

extension TodoList: HasDefaultID {
  
  static var defaultID: Int { .defaultID }
}
