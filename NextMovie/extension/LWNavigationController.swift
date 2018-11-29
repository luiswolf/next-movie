//
//  LWNavigationController.swift
//  NextMovie
//
//  Created by Luís Wolf on 25/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

class LWNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
}

extension LWNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
