//
//  StoryboardHelper.swift
//  NextMovie
//
//  Created by Luís Wolf on 25/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

enum StoryboardName: String {
    case splash = "Splash"
    case movie = "Movie"
}

class StoryboardHelper {
    static let sharedInstance = StoryboardHelper()
    private init() {}
    
    func get(_ storyboard: StoryboardName) -> String {
        return storyboard.rawValue
    }
    
    func instantiate<T>(storyboard: StoryboardName, withIdentifier identifier: String) -> T {
        let sb = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: identifier) as! T
        return vc
    }
}

