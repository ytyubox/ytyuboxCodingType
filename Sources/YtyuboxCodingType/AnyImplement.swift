//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/4/27.
//

import Foundation

public struct AnyError: Error {
  public init(_ message: String) {
    self.message = message
  }
  
  let message: String
}
