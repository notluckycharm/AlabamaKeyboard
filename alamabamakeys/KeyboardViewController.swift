//
//  KeyboardViewController.swift
//  alamabamakeys
//
//  Created by Jacob Fernandes on 8/12/24.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!

    let characters: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "k", "l", "ɬ", "m", "n", "o", "p", "s", "t", "w", "y", "á", "à", "é", "è", "ó", "ò", "í", "ì"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the custom keyboard buttons
        setupKeyboard()

        // Setup the next keyboard button
        setupNextKeyboardButton()
    }

    func setupKeyboard() {
        let buttonHeight: CGFloat = 50
        let buttonWidth: CGFloat = 40
        let rows = 3
        let columns = 7
        let padding: CGFloat = 5
        let startX: CGFloat = padding
        let startY: CGFloat = padding + 100

        for i in 0..<rows {
            for j in 0..<columns {
                let index = i * columns + j
                if index < characters.count {
                    let button = createButton(title: characters[index])
                    let x = startX + CGFloat(j) * (buttonWidth + padding)
                    let y = startY + CGFloat(i) * (buttonHeight + padding)
                    button.frame = CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)
                    self.view.addSubview(button)
                }
            }
        }
    }

    func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = UIColor(white: 0.9, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
        return button
    }

    @objc func keyPressed(_ sender: UIButton) {
        if let title = sender.currentTitle {
            let proxy = self.textDocumentProxy
            proxy.insertText(title)
        }
    }

    func setupNextKeyboardButton() {
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }

    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
}
