//
//  ViewController.swift
//  HTTPSandbox
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class TableViewController: ViewController, StoryboardInstantiable {

  // MARK: Properties
  
  var viewModel: TableViewModel!
  
  @IBOutlet private weak var tableView: UITableView!
  
  // MARK: ViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
    viewModel.reloadData()
  }
  
  override func setup() {
    super.setup()
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableFooterView = UIView()
    
    let r = UIRefreshControl()
    r.addTarget(self, action: #selector(handleRefreshAction(_:)), for: .primaryActionTriggered)
    tableView.refreshControl = r
    
    title = String(describing: Self.self)
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

}

// MARK: UITableViewDataSource

extension TableViewController: UITableViewDataSource {
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

extension TableViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didSelect(at: indexPath)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

// MARK: Private

extension TableViewController {
  @objc func handleRefreshAction(_ sender: Any) {
    viewModel.reloadData()
  }
}
