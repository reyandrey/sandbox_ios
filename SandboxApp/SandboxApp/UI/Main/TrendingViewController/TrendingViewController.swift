//
//  ViewController.swift
//  HTTPSandbox
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

fileprivate typealias PeriodType = TrendingViewModel.PeriodType

class TrendingViewController: ViewController, StoryboardInstantiable {

  // MARK: Properties
  
  var viewModel: TrendingViewModel!
  
  @IBOutlet private weak var tableView: UITableView!
  
  lazy var segmentedControl: UISegmentedControl = {
    let s = UISegmentedControl(items: PeriodType.titleItems)
    s.selectedSegmentIndex = viewModel.since.rawValue
    s.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    return s
  }()
  
  // MARK: ViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
    viewModel.reloadData()
  }
  
  override func setActivityIndication(_ active: Bool, animated: Bool = true) {
    super.setActivityIndication(active, animated: animated)
    segmentedControl.isEnabled = !active
  }
  
  override func setup() {
    super.setup()
    view.backgroundColor = UIColor(hex: "#040810")
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableFooterView = UIView()
    
    let r = UIRefreshControl()
    r.addTarget(self, action: #selector(handleRefreshAction(_:)), for: .primaryActionTriggered)
    tableView.refreshControl = r
    navigationItem.titleView = segmentedControl
    navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.0006932450342, green: 0.007819609717, blue: 0.04820142686, alpha: 1)//UIColor(hex: "#040810")

  }
  
  func bindViewModel() {
    viewModel.onSelect = { [weak self] repo in
      guard let self = self else { return }
      WebViewController.open(url: repo.url, from: self, presentPanModal: true, completionHandler: nil)
    }
    
    viewModel.onError = { [weak self] error in
      guard let self = self else { return }
      self.presentAlert(withTitle: "Error", message: error)
    }
    
    viewModel.onUpdating = { [weak self] updating in
      guard let self = self else { return }
      self.setActivityIndication(updating)
      
      if !updating {
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
      }
    }
  }
  
  @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
    viewModel.since = PeriodType(rawValue: sender.selectedSegmentIndex) ?? PeriodType.daily
  }

}

// MARK: UITableViewDataSource

extension TrendingViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return viewModel.items[indexPath.row].dequeueCell(tableView: tableView, indexPath: indexPath)
  }
}

// MARK: UITableViewDelegate

extension TrendingViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didSelect(at: indexPath)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

// MARK: Private

extension TrendingViewController {
  @objc func handleRefreshAction(_ sender: Any) {
    viewModel.reloadData()
  }
}
