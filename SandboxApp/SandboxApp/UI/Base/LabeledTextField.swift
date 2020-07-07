//
//  RounedTextField.swift
//  GUDom
//
//  Created by Andrey Fokin on 23.06.2020.
//  Copyright © 2020 First Line Software. All rights reserved.
//

import SnapKit
import UIKit

class LabeledTextField: UITextField {
  
  // MARK: Constants
  
  enum Colors {
    static let normalText: UIColor = UIColor.darkText
    static let errorText: UIColor = UIColor.systemRed
    static let normalBorder: UIColor = UIColor.lightGray.withAlphaComponent(0.5)
    static let errorBorder: UIColor = UIColor.systemRed
  }
  
  enum Layout {
    static let borderWidth: CGFloat = 1.0
    static let containerHeight: CGFloat = 50
    static let containerPaddingV: CGFloat = 5.0
    static let containerPaddingH: CGFloat = 0.0
    static let textInsetV: CGFloat = 10
    static let textInsetH: CGFloat = 15
  }
  
  // MARK: Private Properties
  
  private lazy var titleLabel: UILabel = {
    let title = UILabel()
    title.textColor = Colors.normalText
    title.font = .systemFont(ofSize: 14, weight: .medium)
    title.numberOfLines = 1
    title.setContentHuggingPriority(.defaultLow, for: .horizontal)
    title.setContentHuggingPriority(.required, for: .vertical)
    return title
  }()
  
  private lazy var errorLabel: UILabel = {
    let error = UILabel()
    error.textColor = Colors.errorText
    error.font = .systemFont(ofSize: 12, weight: .medium)
    error.numberOfLines = 3
    return error
  }()
  
  private lazy var countLabel: UILabel = {
    let count = UILabel()
    count.textAlignment = .right
    count.textColor = Colors.normalText
    count.font = .systemFont(ofSize: 12, weight: .medium)
    count.numberOfLines = 1
    count.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    return count
  }()
  
  var limit: Int? {
    didSet { updateLimitLabel(limit) }
  }
  
  
  
  // MARK: UITextField
  
  override func borderRect(forBounds bounds: CGRect) -> CGRect {
    return super.borderRect(forBounds: bounds.inset(by: textInsets))
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return super.textRect(forBounds: bounds.inset(by: textInsets))
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds//super.placeholderRect(forBounds: bounds.inset(by: textInsets))
  }
  
  override open func editingRect(forBounds bounds: CGRect) -> CGRect {
    return super.editingRect(forBounds: bounds.inset(by: textInsets))
  }
  
  override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
    return super.clearButtonRect(forBounds: bounds)
  }
  
  override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: textInsets))
  }
  
  override func drawPlaceholder(in rect: CGRect) {
    super.drawPlaceholder(in: rect.inset(by: textInsets))
  }
  
  
  // MARK: Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: Layout
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    drawBorder(rect)
  }
  
  override var intrinsicContentSize: CGSize {
    let w: CGFloat = titleLabel.intrinsicContentSize.width + Layout.containerPaddingV + countLabel.intrinsicContentSize.width
    let h: CGFloat = containerInset.top + containerInset.bottom + Layout.containerHeight
    return CGSize(width: w, height: h)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    titleLabel.frame = titleFrame()
    errorLabel.frame = errorFrame()
    countLabel.frame = countFrame()
  }
}

// MARK: Public

extension LabeledTextField {
  var title: String? {
    get { return titleLabel.text }
    set {
      titleLabel.isHidden = newValue?.isEmpty ?? true
      titleLabel.text = newValue
    }
  }
  
  func setErrorMessage(_ text: String?) {
    setNeedsDisplay()
    UIView.transition(with: errorLabel, duration: TimeInterval.animationDuration, options: [.transitionFlipFromBottom], animations: {
      self.errorLabel.isHidden = text == nil
      self.errorLabel.text = text
      self.setNeedsLayout()
    }, completion: nil)
  }
}

// MARK: Private Methods

private extension LabeledTextField {
  func setup() {
    addSubview(titleLabel)
    addSubview(errorLabel)
    addSubview(countLabel)
    addTarget(self, action: #selector(handleEditing(_:)), for: .allEditingEvents)
    addTarget(self, action: #selector(handleStartEditing(_:)), for: .editingDidBegin)
    font = UIFont.systemFont(ofSize: 12, weight: .regular)
    autocorrectionType = .no
    limit = nil
  }
  
  @objc func handleStartEditing(_ sender: UITextField) {
    setErrorMessage(nil)
  }
  
  @objc func handleEditing(_ sender: UITextField) {
    updateLimitLabel(limit)
  }
  
  var containerInset: UIEdgeInsets {
    let top = Layout.containerPaddingV + max(titleLabel.intrinsicContentSize.height, 15)
    let bottom = Layout.containerPaddingV + max(errorLabel.intrinsicContentSize.height, 15)
    return UIEdgeInsets(top: top, left: Layout.containerPaddingH, bottom: bottom, right: Layout.containerPaddingH)
  }
  
  var textInsets: UIEdgeInsets {
    let top = Layout.textInsetV + containerInset.top
    let bottom = Layout.textInsetV + containerInset.bottom
    let left = Layout.textInsetH + containerInset.left
    let right = Layout.textInsetH + containerInset.right
    return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
  }
  
  
  func updateLimitLabel(_ limit: Int?) {
    let max = limit ?? 0
    let count = text?.count ?? 0
    countLabel.isHidden = limit == nil || count == 0
    UIView.transition(with: countLabel, duration: TimeInterval.animationDuration, options: [.transitionCrossDissolve, .beginFromCurrentState], animations: {
      self.countLabel.textColor = count >= max ? Colors.errorText : Colors.normalText
      self.countLabel.text = "\(count)/\(max)"
    }, completion: nil)
  }
  
  func titleFrame() -> CGRect {
    let size = titleLabel.intrinsicContentSize
    return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width - countLabel.intrinsicContentSize.width - 5, height: size.height))
  }
  
  func countFrame() -> CGRect {
    let size = countLabel.intrinsicContentSize
    let origin = CGPoint(x: bounds.maxX - size.width, y: bounds.minY)
    return CGRect(origin: origin, size: CGSize(width: size.width, height: size.height))
  }
  
  func errorFrame() -> CGRect {
    let size = errorLabel.intrinsicContentSize
    let origin = CGPoint(x: bounds.minX, y: bounds.maxY - size.height)
    return CGRect(origin: origin, size: CGSize(width: bounds.width, height: size.height))
  }
  
  func drawBorder(_ rect: CGRect) {
    let lineWidth: CGFloat = Layout.borderWidth
    let containerRect = rect.inset(by: containerInset)
    let containerBorderRect = containerRect.inset(by: UIEdgeInsets(top: lineWidth, left: lineWidth, bottom: lineWidth, right: lineWidth))
    let path = UIBezierPath(roundedRect: containerBorderRect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 10, height: 10))
    path.lineWidth = lineWidth
    (errorLabel.text?.isEmpty ?? true) ? Colors.normalBorder.setStroke() : Colors.errorBorder.setStroke()
    path.stroke()
  }
}
