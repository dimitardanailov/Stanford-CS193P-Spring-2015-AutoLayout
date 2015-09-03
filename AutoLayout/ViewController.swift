//
//  ViewController.swift
//  AutoLayout
//
//  Created by dimitar on 8/28/15.
//  Copyright (c) 2015 dimityr.danailov. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    var loggedinUser: User? {
        didSet {
            updateUI()
        }
    }
    var secure: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secure password" : "Password"
        nameLabel.text = loggedinUser?.name
        companyLabel.text = loggedinUser?.company
        image = loggedinUser?.image
    }
    
    @IBAction func toggleSecurity(sender: UIButton) {
        secure = !secure
    }
    
    @IBAction func signUp(sender: UIButton) {
        loggedinUser = User.login(login: loginField.text ?? "", password: passwordField.text ?? "")
    }
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            if let constrainedView = imageView {
                if let newImage = newValue {
                    aspectRatioConstraint = NSLayoutConstraint(
                        item: constrainedView,
                        attribute: .Width,
                        relatedBy: .Equal,
                        toItem: constrainedView,
                        attribute: .Height,
                        multiplier: newImage.aspectRatio,
                        constant: 0
                    )
                }
            }
        }
    }
    
    var aspectRatioConstraint: NSLayoutConstraint? {
        willSet {
            if let existingConstraint = aspectRatioConstraint {
                view.removeConstraint(existingConstraint)
            }
        }
        didSet {
            if let newConstraint = aspectRatioConstraint {
                view.addConstraint(newConstraint)
            }
        }
    }
    
}

extension User
{
    var image: UIImage? {
        if let image = UIImage(named: login) {
            return image
        } else {
            return UIImage(named: "unknown_user")
        }
    }
}

extension UIImage
{
    var aspectRatio: CGFloat {
        if (size.height != 0) {
            return size.width / size.height
        } else {
            return 0
        }
    }
}
