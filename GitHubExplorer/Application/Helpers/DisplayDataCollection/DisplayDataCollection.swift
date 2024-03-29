//
//  DisplayDataCollection.swift
//
//

import UIKit

// MARK: - General

protocol DisplayDataCollection {
  ///Static Properties
  static var modelsForRegistration: [AnyViewDataModelType.Type] { get }
  ///Datasource Properties
  var numberOfSections: Int { get }
  ///Datasource Functions
  func numberOfRows(in section: Int) -> Int
  func model(for indexPath: IndexPath) -> AnyViewDataModelType
}

extension DisplayDataCollection {
  var numberOfSections: Int {
    return 1
  }
}

extension DisplayDataCollection {
  func isLast(_ indexPath: IndexPath) -> Bool {
    return numberOfRows(in: indexPath.section) - 1 == indexPath.row
  }

  func isFirst(_ indexPath: IndexPath) -> Bool {
    return 0 == indexPath.row
  }
}

protocol DisplayImageRequestableDataCollection: DisplayDataCollection {
  func willDisplay(cell: UIView, forItemAt indexPath: IndexPath)
  func didEndDisplaying(cell: UIView, forItemAt indexPath: IndexPath)
}
