//
//  HasDefaultID.swift
//  TodoApp
//
//  Created by yusuga on 2021/06/17.
//

import Foundation

protocol HasDefaultID {
  
  associatedtype IDType
  static var defaultID: IDType { get }
}
