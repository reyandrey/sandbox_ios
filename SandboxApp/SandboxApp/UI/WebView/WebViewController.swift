//
//  WebViewController.swift
//  GUDom
//
//  Created by Andrey Fokin on 19.06.2020.
//  Copyright © 2020 First Line Software. All rights reserved.
//

import UIKit
import WebKit
import PanModal

class WebViewController: ViewController {
  
  var url: URL!
  var completionHanler: (()->())? = nil
  private lazy var cookies: [String: String] = {
    return [:]
  }()
  
  private lazy var webView: WKWebView = {
    var webView = WKWebView()
    webView.navigationDelegate = self
    webView.allowsBackForwardNavigationGestures = true
    webView.isMultipleTouchEnabled = false
    webView.translatesAutoresizingMaskIntoConstraints = false
    return webView
  }()
  
  convenience init(url: URL) {
    self.init()
    self.url = url
  }
  
  override func setup() {
    super.setup()
    view.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
    webView.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
    webView.isOpaque = false
    let doneItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneDidTap(_:)))
    let shareItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(share(_:)))
    doneItem.tintColor = .systemGreen
    shareItem.tintColor = #colorLiteral(red: 0.2549019608, green: 0.6117647059, blue: 1, alpha: 1)
    navigationItem.setRightBarButton(doneItem, animated: false)
    navigationItem.setLeftBarButton(shareItem, animated: false)
    view.addSubview(webView)
  }
  
  override func loadView() {
    super.loadView()
    setCookies()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    load(url)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    webView.frame = view.bounds.inset(by: UIEdgeInsets(top: view.safeAreaInsets.top, left: 0, bottom: 0, right: 0))
  }
  
  override func setActivityIndication(_ active: Bool, animated: Bool = true) {
    super.setActivityIndication(active, animated: animated)
    self.title = active ? "Loading..." : url.host ?? "Web"
  }
  
}

// MARK: WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    print(#function)
    setActivityIndication(false, animated: true)
  }
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    setActivityIndication(true, animated: true)
  }
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    setActivityIndication(false)
    presentAlert(withTitle: "Error", message: error.localizedDescription) {
    }
  }
  
  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    setActivityIndication(false)
    presentAlert(withTitle: "Error", message: error.localizedDescription) {
    }
  }
}

// MARK: Private

private extension WebViewController {
  func setCookies() {
    let httpCookies = cookies.compactMap {
      HTTPCookie(properties: [
        .domain: url.host ?? "",
        .path: "/",
        .name: $0.key,
        .value: $0.value,
        .secure: "TRUE"
      ])
    }
    HTTPCookieStorage.shared.setCookies(httpCookies, for: self.url, mainDocumentURL: nil)
  }
  
  func load(_ url: URL) {
    let request = URLRequest(url: url)
    HTTPCookieStorage.shared.cookies?.forEach({ (cookie) in
      webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
    })
    webView.load(request)
  }
  
  @objc func doneDidTap(_ sender: Any) {
    dismiss(animated: true, completion: completionHanler)
  }
  
  @objc func share(_ sender:UIView) {
    //UIGraphicsBeginImageContext(webView.frame.size)
    //webView.layer.render(in: UIGraphicsGetCurrentContext()!)
    //let snapshot = UIGraphicsGetImageFromCurrentImageContext()
    //UIGraphicsEndImageContext()
    //let urlString = webView.url?.absoluteString ?? "<empty>"
    if let url = webView.url {
      //      let objectsToShare = [urlString, url, snapshot ?? #imageLiteral(resourceName: "app-logo")] as [Any]
      let objectsToShare = [url]
      let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
      
      //Excluded Activities
      //activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
      
      activityVC.popoverPresentationController?.sourceView = sender
      self.present(activityVC, animated: true, completion: nil)
    }
  }
  
}

// MARK: Static

extension WebViewController {
  
  class func open(url: URL, from presenter: UIViewController, presentPanModal: Bool = true, completionHandler: (()->())? = nil) {
    let webVC = WebViewController()
    webVC.url = url
    webVC.completionHanler = completionHandler
    let modalNC = NavigationController()
    modalNC.setViewControllers([webVC], animated: false)
    if presentPanModal {
      presenter.presentPanModal(modalNC)
    } else {
      modalNC.modalPresentationStyle = .overFullScreen
      presenter.present(modalNC, animated: true, completion: nil)
    }
  }
  
}

extension WebViewController: PanModalPresentable {
  var panScrollable: UIScrollView? {
    return nil
  }
  
  var longFormHeight: PanModal.PanModalHeight {
    return .maxHeight
  }
  
  var cornerRadius: CGFloat {
    return 16
  }
}
