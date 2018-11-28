//
//  DeviceHelper.swift
//  NextMovie
//
//  Created by Luís Wolf on 27/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

class DeviceHelper {
    // indicate current device is in the LandScape orientation
    static var isLandscape: Bool {
        get {
            return UIDevice.current.orientation.isValidInterfaceOrientation
                ? UIDevice.current.orientation.isLandscape
                : UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
    // indicate current device is in the Portrait orientation
    static var isPortrait: Bool {
        get {
            return UIDevice.current.orientation.isValidInterfaceOrientation
                ? UIDevice.current.orientation.isPortrait
                : UIApplication.shared.statusBarOrientation.isPortrait
        }
    }
}
