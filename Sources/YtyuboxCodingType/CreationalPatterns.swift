//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/5/11.
//

import Foundation

public protocol Prototyped {
  static func `default`() -> Self
}
public protocol Signtoned: AnyObject {
  static var global: Self {get set}
}

public typealias SigntonWithPrototyped = Signtoned & Prototyped
