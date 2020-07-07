//
//  ImageCell.swift
//  GUDom
//
//  Created by Andrey Fokin on 02.06.2020.
//  Copyright © 2020 First Line Software. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell, UIScrollViewDelegate, CellIdentifiable {
  var indexPath: IndexPath?
  
  // MARK: Private Properties
  
  var imageView: UIImageView!
  private var scrollImg: UIScrollView!
  
  // MARK: Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupScrollingForImage()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    scrollImg.frame = self.bounds
    imageView.frame = self.bounds
    
  }
  
}

// MARK: Private Methods

private extension ImageCell {
  
  
  private func setupScrollingForImage () {
    
    imageView = UIImageView()
    imageView.backgroundColor = .clear
    
    scrollImg = UIScrollView()
    scrollImg.delegate = self
    scrollImg.alwaysBounceVertical = false
    scrollImg.alwaysBounceHorizontal = false
    scrollImg.showsVerticalScrollIndicator = true
    scrollImg.flashScrollIndicators()
    
    scrollImg.minimumZoomScale = 1.0
    scrollImg.maximumZoomScale = 4.0
    
    let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
    doubleTapGest.numberOfTapsRequired = 2
    scrollImg.addGestureRecognizer(doubleTapGest)
    
    self.addSubview(scrollImg)
    
    scrollImg.addSubview(imageView)
    imageView.contentMode = .scaleAspectFit
    
    scrollImg.isUserInteractionEnabled = true
    imageView.isUserInteractionEnabled = true
    
    
    
  }
  
  @objc private func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
    if scrollImg.zoomScale == 1 {
      scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
    } else {
      scrollImg.setZoomScale(1, animated: true)
    }
  }
  
  private func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
    var zoomRect = CGRect.zero
    zoomRect.size.height = imageView.frame.size.height / scale
    zoomRect.size.width  = imageView.frame.size.width  / scale
    let newCenter = imageView.convert(center, from: scrollImg)
    zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
    zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
    return zoomRect
  }
  
  
}

// MARK: Collection View Cell Methods

extension ImageCell {
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
    scrollImg.setZoomScale(1, animated: true)
  }
  
}


// MARK: Scroll View Methods

extension ImageCell {
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.imageView
  }
  
}
