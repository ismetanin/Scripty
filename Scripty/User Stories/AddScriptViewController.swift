//
//  AddScriptViewController.swift
//  Scripty
//
//  Created by Ivan Smetanin on 22/03/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Cocoa

class AddScriptViewController: NSViewController {

    @IBOutlet var scriptTextView: NSTextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        scriptTextView.isContinuousSpellCheckingEnabled = false
        if #available(OSX 10.12.2, *) {
            scriptTextView.isAutomaticTextCompletionEnabled = false
        } else {
            // Fallback on earlier versions
        }
        scriptTextView.isAutomaticTextReplacementEnabled = false
    }
    
}

class MyTextView: NSTextView {

}
