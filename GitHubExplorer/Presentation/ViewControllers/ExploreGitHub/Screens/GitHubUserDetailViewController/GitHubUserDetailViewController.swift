//
//  GitHubUserDetailViewController.swift
//  GitHubExplorer
//
//  Created by Konstantyn on 4/25/19.
//  Copyright © 2019 Kostiantyn Bykhkalo. All rights reserved.
//

import CoreLocation
import Foundation
import MapKit
import SDWebImage
import UIKit

class GitHubUserDetailViewController: UIViewController {
  // MARK: - Outlets
  @IBOutlet fileprivate var userLocationMap: MKMapView!
  @IBOutlet fileprivate var userNicknameLabel: UILabel!
  // MARK: - Properties
  var viewModel: AnyGitHubUserDetailViewModel! {
    didSet {
      guard oldValue !== self.viewModel else { return }
      if let oldValue = oldValue { unsubscribe(anyViewModel: oldValue) }
      if self.viewModel != nil { subscribe() }
    }
  }
  // MARK: - ViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationBar()
    bindItemDetail()
  }
  // MARK: - Configuration
  func configureNavigationBar() {
    navigationItem.title = viewModel.itemTitle
    if #available(iOS 11.0, *) {
      navigationController?.navigationBar.prefersLargeTitles = true
      navigationItem.largeTitleDisplayMode = .automatic
    }
  }
  func bindItemDetail() {
    userNicknameLabel.text = viewModel.itemTitle
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(viewModel.itemLocation) { [weak self] clPlacemarks, error in
      guard let `self` = self, let clPlacemark = clPlacemarks?.first,
        error == nil else { return }
      if let coordinate = clPlacemark.location?.coordinate {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = self.viewModel.itemTitle
        self.userLocationMap.addAnnotation(annotation)
        self.userLocationMap.setCenter(coordinate, animated: true)
      }
    }
  }
}

// MARK: - Private Subscribe
fileprivate extension GitHubUserDetailViewController {
  func unsubscribe(anyViewModel: AnyGitHubUserDetailViewModel) {
    anyViewModel.exploreDetailUpdateHandler = nil
  }
  func subscribe() {
    viewModel.exploreDetailUpdateHandler = { [weak self] change in
      guard let `self` = self else { return }
      switch change {
      case .update:
        DispatchQueue.main.async {
          self.bindItemDetail()
        }
      default: break
      }
    }
  }
}
