//
//  ImageViewController.swift
//  GUDom
//
//  Created by Andrey Fokin on 02.06.2020.
//  Copyright © 2020 First Line Software. All rights reserved.
//

import UIKit
import SnapKit

class ImageViewController: UIViewController {
  
  var images: [UIImage] = []
  var didFinishHandler: (() -> ())? = nil
  
  private var imageCells: [ImageCell] = []
  
  private lazy var collectionView: UICollectionView = {
    let l = UICollectionViewFlowLayout()
    l.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    l.scrollDirection = .horizontal
    let c = UICollectionView(frame: .zero, collectionViewLayout: l)
    c.delegate = self
    c.dataSource = self
    c.isPagingEnabled = true
    c.showsHorizontalScrollIndicator = false
    c.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)
    self.view.addSubview(c)
    return c
  }()
  
  private lazy var backButton: UIButton = {
    let b = UIButton(type: .custom)
    b.addTarget(self, action: #selector(didPressBack(_:)), for: .touchUpInside)
    //b.setImage(UIImage(named: "back")!.withRenderingMode(.alwaysTemplate).bma_tintWithColor(.white), for: .normal)
    self.view.addSubview(b)
    return b
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
}


// MARK: UICollectionViewDataSource

extension ImageViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseId, for: indexPath) as? ImageCell else { fatalError() }
    cell.imageView.image = images[indexPath.row]
    return cell
  }
  
}

// MARK: UICollectionViewDelegateFlowLayout

extension ImageViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.safeAreaLayoutGuide.layoutFrame.width - 10, height: collectionView.safeAreaLayoutGuide.layoutFrame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
  }
  
}

// MARK: Private Methods

private extension ImageViewController {
  
  @objc func didPressBack(_ sender: UIButton) {
    didFinishHandler?()
  }
  
  func setupLayout() {
    collectionView.snp.makeConstraints { make in
      make.top.bottom.leading.trailing.equalToSuperview()
    }
    backButton.snp.makeConstraints { make in
      make.width.height.equalTo(44)
      make.leading.equalToSuperview()
      make.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height)
    }
  }
  
}
