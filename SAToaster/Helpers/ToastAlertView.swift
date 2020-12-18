//
//  ToastAlertView.swift
//  FMSDriver
//
//  Created by Shehzad Ali on 16/05/19.
//  Copyright © 2019 Shehzad Ali. All rights reserved.
//

import UIKit

class ToastAlertView: UIView {
    
    deinit { NotificationCenter.default.removeObserver(self) }
    
    @IBOutlet weak var labelToastMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func rotated() {
        self.removeFromSuperview()
    }
    
}
