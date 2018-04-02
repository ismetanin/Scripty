//
//  NSStoryboard.swift
//  Scripty
//
//  Created by Ivan Smetanin on 01/04/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Cocoa

extension NSStoryboard {

    convenience init(name: String, bundle: Bundle? = nil) {
        self.init(name: NSStoryboard.Name(rawValue: name), bundle: bundle)
    }

    func instantiateController(withIdentifier identifier: String) -> Any {
        return self.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(identifier))
    }

}
