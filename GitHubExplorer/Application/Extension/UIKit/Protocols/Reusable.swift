//
//  Reusable.swift
//  ConceptOffice
//
//  Created by Denis on 06.03.17.
//  Copyright © 2017 Den Ree. All rights reserved.
//

import UIKit

protocol Reusable {
  static var identifier: String { get }
  static var nib: UINib { get }
}

extension Reusable {
  static var identifier: String {
    return String(describing: self)
  }
}
