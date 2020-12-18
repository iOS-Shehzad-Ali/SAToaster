//
//  SAToaster.swift
//  FMSDriver
//
//  Created by Shehzad Ali on 08/07/19.
//  Copyright © 2019 Shehzad Ali. All rights reserved.
//

import UIKit

let defaultToastWidth = (UIApplication.shared.keyWindow?.frame.width ?? 280) - 100

extension UIView {
    
    enum AppearanceType {
        case whiteBackground
        case whiteTextColor
        case custom
    }
    
    /*func showToastAlert(withMessage message: String, toastWidth width: CGFloat = defaultToastWidth, fontStyle font: UIFont = UIFont.systemFont(ofSize: 17), appearanceTime time: TimeInterval = 2, _ textColor: UIColor = .appThemeBlue(), _ backgroundColor: UIColor = .white/*.appThemeBlue()*/, owner: UIViewController) {
        if let window = UIApplication.shared.keyWindow {
            removePreviousToastMessage(forOwner: owner)
            
            guard let toastView = Bundle.main.loadNibNamed("\(ToastAlertView.self)", owner: owner, options: nil)?.first as? ToastAlertView else { return }
            
            toastView.layer.cornerRadius = 10
            
            toastView.backgroundColor = backgroundColor
            
            let messageHeight = message.height(withConstrainedWidth: width, font: font)
            
            let messageWidth = message.sizeOfString(constrainedToWidth: width, font: font).width
            
            toastView.frame = CGRect(x: 0, y: window.frame.height, width: messageWidth < width ? messageWidth + 30 : width, height: messageHeight + 20)
            
            toastView.center.x = window.center.x
            
            toastView.labelToastMessage.font = font
            
            toastView.labelToastMessage.textColor = textColor
            
            toastView.labelToastMessage.text = message
            
            var bottomTabHeight: CGFloat = 0
            
            if let bottomBarHeight = owner.tabBarController?.tabBar.frame.height {
                bottomTabHeight = bottomBarHeight
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                if owner.view.bounds.maxY == window.frame.maxY {
                    owner.view.addSubview(toastView)
                } else {
                    window.addSubview(toastView)
                }
                
                UIView.animate(withDuration: 0.3, animations: {
                    toastView.transform = CGAffineTransform(translationX: 0, y: -(toastView.frame.size.height + bottomTabHeight + 50))
                }) { (completed) in
                    UIView.animate(withDuration: 0.3, delay: time, options: [.curveEaseOut], animations: {
                        //toastView.transform = .identity
                        toastView.alpha = 0
                    }, completion: { (_) in
                        toastView.removeFromSuperview()
                    })
                }
            }
        }
    }
    
    func removePreviousToastMessage(forOwner owner: UIViewController) {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        for view in owner.view.frame.maxY == window.frame.maxY ? owner.view.subviews : window.subviews where view is ToastAlertView {
            DispatchQueue.main.async {
                view.removeFromSuperview()
            }
        }
    }*/
    
    func showToast(withMessage message: String, toastWidth width: CGFloat = defaultToastWidth, fontStyle font: UIFont = UIFont.systemFont(ofSize: 17), appearanceTime time: TimeInterval = 2, _ textColor: UIColor = .blue, _ backgroundColor: UIColor = .white, appearanceType type: AppearanceType = .whiteTextColor) {
        if let window = UIApplication.shared.keyWindow {
            removePreviousToastMessage()
            
            guard let toastView = Bundle.main.loadNibNamed("\(ToastAlertView.self)", owner: self, options: nil)?.first as? ToastAlertView else { return }
            
            toastView.layer.cornerRadius = 10
            
            let messageHeight = message.height(withConstrainedWidth: width, font: font)
            
            let messageWidth = message.sizeOfString(constrainedToWidth: width, font: font).width
            
            toastView.frame = CGRect(x: 0, y: window.frame.height, width: messageWidth < width ? messageWidth + 30 : width, height: messageHeight + 20)
            
            toastView.center.x = window.center.x
            
            toastView.labelToastMessage.font = font
            
            switch type {
            case .whiteBackground:
                toastView.backgroundColor = .white
                toastView.labelToastMessage.textColor = .blue
            case .whiteTextColor:
                toastView.backgroundColor = .blue
                toastView.labelToastMessage.textColor = .white
            default:
                toastView.backgroundColor = backgroundColor
                toastView.labelToastMessage.textColor = textColor
            }
            
            toastView.labelToastMessage.text = message
            
            var bottomTabHeight: CGFloat = 0
            
            if let controller = next as? UIViewController {//finding superview as UIViewController
                if !(controller.tabBarController?.tabBar.isHidden ?? false) {
                    if let bottomBarHeight = controller.tabBarController?.tabBar.frame.height {
                        bottomTabHeight = bottomBarHeight
                    }
                }
                /*if let bottomBarHeight = controller.tabBarController?.tabBar.frame.height {
                    bottomTabHeight = bottomBarHeight
                }*/
            }
                        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.addSubview(toastView)
                
                UIView.animate(withDuration: 0.3, animations: {
                    toastView.transform = CGAffineTransform(translationX: 0, y: -(toastView.frame.size.height + bottomTabHeight + 30))
                }) { (completed) in
                    UIView.animate(withDuration: 0.3, delay: time, options: [.curveEaseOut], animations: {
                        //toastView.transform = .identity
                        toastView.alpha = 0
                    }, completion: { (_) in
                        toastView.removeFromSuperview()
                    })
                }
            }
        }
    }
    
    func removePreviousToastMessage() {
        for subView in subviews where subView is ToastAlertView {
            DispatchQueue.main.async { subView.removeFromSuperview() }
        }
    }
    
}

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func sizeOfString (constrainedToWidth width: CGFloat, font: UIFont) -> CGSize {
        return NSString(string: self).boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude),
                                                   options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                   attributes: [NSAttributedString.Key.font: font],
                                                   context: nil).size
    }
}
