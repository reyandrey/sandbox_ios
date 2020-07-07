//
//  UIView+Extensions.swift
//  SandboxApp
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
  
  /**
   Add shadow effect to view's layer.
   
   - parameter color: shadow color
   - parameter opacity: shadow opacity; defaults to 0.3
   - parameter radius: shadow blur radius; defaults to 10
   - parameter xOffset: horizontal offseet of the shadow; defaults to 0
   - parameter yOffset: vertical offseet of the shadow; defaults to 0
   */
  func addShadow(withColor color: UIColor, opacity: Float = 0.3, radius: CGFloat = 10, xOffset: CGFloat = 0, yOffset: CGFloat = 0) {
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowRadius = radius
    layer.shadowOffset = CGSize(width: xOffset, height: yOffset)
  }
  
  /**
   Add view to a super view and flush it with layout constraints.
   
   - parameter view: a view to which the original view will be flushed.
   */
  func flush(to view: UIView) {
    view.addSubview(self)
    leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  /**
   Add round corners
   */
  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
  
  func addDashedBorder(_ color: UIColor = UIColor.black, withWidth width: CGFloat = 2, cornerRadius: CGFloat = 5, dashPattern: [NSNumber] = [3,6]) {
    
    let shapeLayer = CAShapeLayer()
    
    shapeLayer.bounds = bounds
    shapeLayer.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
    shapeLayer.fillColor = nil
    shapeLayer.strokeColor = color.cgColor
    shapeLayer.lineWidth = width
    shapeLayer.lineJoin = CAShapeLayerLineJoin.round // Updated in swift 4.2
    shapeLayer.lineDashPattern = dashPattern
    shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    
    self.layer.addSublayer(shapeLayer)
  }
  
}

public extension UIView {
  
  func flash(duration: TimeInterval = TimeInterval.animationDuration) {
    let duration = duration / 2
    let startAlpha = self.alpha
    UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
      self.alpha = 1.0
    }) { success in
      UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
        self.alpha = startAlpha
      }) { success in
      }
    }
  }
  
  func hide(duration: TimeInterval = TimeInterval.animationDuration, completion: ((Bool) -> Void)? = nil) {
    UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
      self.alpha = 0.0
    }) { success in
      self.isHidden = true
      if let completion = completion { completion(success) }
    }
  }
  
  func show(duration: TimeInterval = TimeInterval.animationDuration, completion: ((Bool) -> Void)? = nil) {
    self.isHidden = false
    UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
      self.alpha = 1.0
    }, completion: completion)
  }
  
}

//MARK: Converters

public extension UIView {
  
  func convertToImage() -> UIImage? {
    let size = self.bounds.size
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    if let context = UIGraphicsGetCurrentContext() { self.layer.render(in: context) }
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
  
}
