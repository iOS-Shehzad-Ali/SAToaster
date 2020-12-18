//
//  ViewController.swift
//  SAToaster
//
//  Created by Shehzad Ali on 12/18/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.showToast(withMessage: "Hello World")
    }

}

