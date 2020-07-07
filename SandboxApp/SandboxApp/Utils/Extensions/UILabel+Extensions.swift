//
//  UILabel+Extensions.swift
//  Utility
//
//  Created by Andrey Fokin on 21.11.2019.
//  Copyright © 2019 First Line Software. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {
  
  private func getLinesCount() -> Int {
    // Call self.layoutIfNeeded() if your view is uses auto layout
    let myText = self.text! as NSString
    let attributes = [NSAttributedString.Key.font : self.font]
    
    let labelSize = myText.boundingRect(with: CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
    return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
  }
  
  var isTruncated: Bool {
    return self.getLinesCount() > self.numberOfLines
  }
}
