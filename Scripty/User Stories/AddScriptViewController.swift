//
//  AddScriptViewController.swift
//  Scripty
//
//  Created by Ivan Smetanin on 22/03/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Cocoa

final class AddScriptViewController: NSViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var scriptNameTextFieldCell: NSTextFieldCell!
    @IBOutlet private weak var scriptNameTextField: NSTextField!
    @IBOutlet private weak var scriptContentTextFieldCell: NSTextFieldCell!
    @IBOutlet private var scriptTextView: NSTextView!
    @IBOutlet private weak var doneButton: NSButton!
    @IBOutlet private weak var doneTouchBarButton: NSButton!

    // MARK: - Properties

    private var scriptName: String = "" {
        didSet {
            handleTextUpdating()
        }
    }

    private var scriptText: String = "" {
        didSet {
            handleTextUpdating()
        }
    }

    // MARK: - IBActions

    @IBAction private func doneAction(_ sender: Any) {
        saveScriptAndCloseWindow()
    }


    // MARK: - NSViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        setupSubviews()
    }

    // MARK: - Private methods

    private func saveScriptAndCloseWindow() {
        let script = Command(name: scriptName, script: scriptText)
        let service = CommandsService()
        service.add(command: script)
        Shell.run(script.args)
        self.view.window?.close()
    }

    private func localize() {
        scriptNameTextFieldCell.title = L10n.Addscript.scriptNameTitle
        scriptContentTextFieldCell.title = L10n.Addscript.scriptContentTitle
        doneButton.title = L10n.Addscript.doneButtonTitle
        doneTouchBarButton.title = L10n.Addscript.doneButtonTitle
    }

    private func setupSubviews() {
        doneButton.isEnabled = false
        doneTouchBarButton.isEnabled = false
        scriptNameTextField.delegate = self
        scriptTextView.delegate = self
    }

    private func handleTextUpdating() {
        doneButton.isEnabled = !(scriptName == "" || scriptText == "")
        doneTouchBarButton.isEnabled = !(scriptName == "" || scriptText == "")
    }

}

// MARK: - NSTextFieldDelegate

extension AddScriptViewController: NSTextFieldDelegate {

    override func controlTextDidChange(_ obj: Notification) {
        guard let textField = obj.object as? NSTextField else {
            return
        }
        scriptName = textField.stringValue
    }

}

// MARK: - NSTextViewDelegate

extension AddScriptViewController: NSTextViewDelegate {

    func textView(_ textView: NSTextView, shouldChangeTextIn affectedCharRange: NSRange, replacementString: String?) -> Bool {
        guard let text = textView.textStorage?.string as NSString?, let replacementString = replacementString else {
            return true
        }
        let newText = text.replacingCharacters(in: affectedCharRange, with: replacementString)
        scriptText = newText
        return true
    }

}
