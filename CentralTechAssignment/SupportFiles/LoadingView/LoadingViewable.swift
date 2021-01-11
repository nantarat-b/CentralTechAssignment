//
//  LoadingViewable.swift
//  CentralTechAssignment
//
//  Created by Nantarat Buranajinda on 8/1/2564 BE.
//

import UIKit


protocol loadingViewable {
    func startAnimating()
    func stopAnimating()
}
extension loadingViewable where Self : UIViewController {
    func startAnimating(){
        let animateLoading = loadingView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        view.addSubview(animateLoading)
        view.bringSubviewToFront(animateLoading)
        animateLoading.translatesAutoresizingMaskIntoConstraints = false
        animateLoading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animateLoading.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        animateLoading.widthAnchor.constraint(equalToConstant: 150).isActive = true
        animateLoading.heightAnchor.constraint(equalToConstant: 150).isActive = true
        animateLoading.restorationIdentifier = "loadingView"
        animateLoading.loadingViewMessage = "Loading"
        animateLoading.cornerRadius = 15
        animateLoading.clipsToBounds = true
        animateLoading.startAnimation()
    }
    func stopAnimating() {
        for item in view.subviews
            where item.restorationIdentifier == "loadingView" {
                UIView.animate(withDuration: 0.3, animations: {
                    item.alpha = 0
                }) { (_) in
                    item.removeFromSuperview()
                }
        }
    }
}
