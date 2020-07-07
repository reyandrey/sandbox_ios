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
    view.backgroundColor = .white
    let doneItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneDidTap(_:)))
    doneItem.tintColor = .darkText
    navigationItem.setRightBarButton(doneItem, animated: false)
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
    self.title = active ? "Loading..." : self.webView.title
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
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    setActivityIndication(false)
    presentAlert(withTitle: "Error", message: error.localizedDescription) {
      self.dismiss(animated: true, completion: nil)
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
  
}

// MARK: Static

extension WebViewController {
  
  class func open(url: URL, from presenter: UIViewController, presentPanModal: Bool = true, completionHandler: (()->())? = nil) {
    let webVC = WebViewController()
    webVC.url = url
    webVC.completionHanler = completionHandler
    if presentPanModal {
      presenter.presentPanModal(webVC)
    } else {
      let modalNC = NavigationController()
      modalNC.setViewControllers([webVC], animated: false)
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
    return .maxHeightWithTopInset(view.safeAreaInsets.top + 44)
  }
  
  var cornerRadius: CGFloat {
    return 16
  }
}
