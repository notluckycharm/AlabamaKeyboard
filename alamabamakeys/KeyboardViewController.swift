//
//  KeyboardViewController.swift
//  alamabamakeys
//
//  Created by Jacob Fernandes on 8/12/24.
//

import UIKit
import SwiftUI

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var letterButtons: [UIButton]!
    
    var capsLockIsOn = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        class MyClass: UIView {
        class func instanceFromNib() -> UIView {
            return UINib(nibName: "Keyboardview", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
            }
        }
        let view = MyClass.instanceFromNib()
        self.view.addSubview(view)
        

        // Setup the next keyboard button
        setupNextKeyboardButton()
    }

//        button.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)

    func handleCaps() {
        capsLockIsOn ^= 1
        for button in letterButtons {
                    if let currentTitle = button.currentTitle {
                        button.setTitle(capsLockIsOn != 0 ? currentTitle.uppercased() : currentTitle.lowercased(), for: .normal)
                    }
                }
    }
    
    func setupNextKeyboardButton() {
        self.nextKeyboardButton = UIButton(type: .system)
        if let image = UIImage(systemName: "globe")?.withRenderingMode(.alwaysTemplate) {
                // Set the image for the button
                self.nextKeyboardButton.setImage(image, for: .normal)
                // Set the image scaling to fit inside the button
                self.nextKeyboardButton.imageView?.contentMode = .scaleAspectFit
                // Set the tint color for the image
                self.nextKeyboardButton.tintColor = .systemBlue // Customize this color as needed
            }
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.systemGray4
        config.baseForegroundColor = .black
        config.cornerStyle = .medium
        
        
        self.nextKeyboardButton.configuration = config
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    @IBAction func keyPressed(button: UIButton) {
        var string = button.titleLabel?.text
        if string == "◌́" {
            string = "́"
        }
        else if string == "◌̀" {
            string = "̀"
        }
        else if string == "space" {
            string = " "
        }
        else if string == "return" {
            string = "\r"
        }
        (self.textDocumentProxy as UIKeyInput).insertText("\(string!)")
    }

    @IBAction override func delete(_ sender: Any?) {
        let proxy = self.textDocumentProxy
            proxy.deleteBackward()
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
