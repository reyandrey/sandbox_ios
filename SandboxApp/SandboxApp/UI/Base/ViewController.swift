//
//  ViewController.swift
//  SandboxApp
//
//  Created by Andrey on 07.07.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  private lazy var activityView: UIView = {
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
    let v = UIView()
    v.isUserInteractionEnabled = false
    
    let l = UILabel()
    l.textColor = .darkText
    l.font = .systemFont(ofSize: 12, weight: .medium)
    l.text = "Загрузка..."
    
    let a = UIActivityIndicatorView(style: .gray)
    a.layer.cornerRadius = 10
    a.hidesWhenStopped = false
    a.startAnimating()
    
    v.addSubview(blurView)
    v.addSubview(a)
    v.addSubview(l)
    
    blurView.snp.makeConstraints { m in
      m.edges.equalToSuperview()
    }
    
    l.snp.makeConstraints { m in
      m.center.equalToSuperview()
    }
    
    a.snp.makeConstraints { m in
      m.centerX.equalTo(l.snp.centerX)
      m.bottom.equalTo(l.snp.top).offset(-12)
    }
    
    return v
  }()
  
  override func loadView() {
    super.loadView()
    setup()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    activityView.frame = view.bounds
  }
  
  open func setActivityIndication(_ active: Bool, animated: Bool = true) {
    self.view.isUserInteractionEnabled = !active
    if active { self.view.addSubview(activityView) }
    let duration: TimeInterval = animated ? (active ? TimeInterval.animationDuration / 3 : TimeInterval.animationDuration) : 0
    UIView.transition(with: view, duration: duration, options: [.transitionCrossDissolve], animations: {
      self.activityView.alpha = active ? 1:0
    }, completion: { (_) in
      if !active { self.activityView.removeFromSuperview() }
    })
  }
  
  open func setup() {
    
  }
  
}
