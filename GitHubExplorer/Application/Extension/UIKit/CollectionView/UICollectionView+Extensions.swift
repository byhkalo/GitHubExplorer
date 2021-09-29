//
//  UICollectionView+Extensions.swift
//
//

import Foundation
import UIKit

extension UICollectionView {
  @objc
  func indexPathsForElementsInRect(_ rect: CGRect) -> [IndexPath] {
    if let allLayoutAttributes = collectionViewLayout.layoutAttributesForElements(in: rect),
      allLayoutAttributes.isEmpty == false {
      var result = [IndexPath]()
      for layoutAttributes in allLayoutAttributes {
        let indexPath = layoutAttributes.indexPath
        result.append(indexPath)
      }
      return result
    } else {
      return [IndexPath]()
    }
  }
}
