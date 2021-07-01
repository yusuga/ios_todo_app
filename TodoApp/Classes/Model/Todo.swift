//
//  Todo.swift
//  todoApp
//
//  Created by 早瀬 和輝 on 2021/05/02.
//

import Foundation
import RealmSwift

/// - SeeAlso: https://docs.mongodb.com/realm/sdk/ios/data-types/supported-property-types/
final class Todo: Object, Codable {
  
  @objc private(set) dynamic var id = UUID().uuidString
  @objc dynamic var title = ""
  @objc dynamic var memo: String?
  @objc dynamic var deadline = Date()
  @objc dynamic var isDone = false
  
  override class func primaryKey() -> String? {
    return #keyPath(id)
  }
  
  convenience init(
    title: String,
    memo: String?,
    deadline: Date
  ) {
    self.init()
    self.title = title
    self.memo = memo
    self.deadline = deadline
  }
}
