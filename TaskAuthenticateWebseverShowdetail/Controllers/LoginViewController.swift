//
//  LoginViewController.swift
//  TaskAuthenticateWebseverShowdetail
//
//  Created by Rakshith Appaiah on 1/24/18.
//  Copyright © 2018 Rakshith Appaiah. All rights reserved.
//

import UIKit

/// LoginViewController : Authentication screen.
///
/// - Parameter userDefault:  interface to the user’s defaults database.
/// - Parameter userId: Outlet reference for userName textfield, String type.
/// - Parameter password: Outlet reference for password textfield, String type.
class LoginViewController: UIViewController {
    
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var backGroundImage: UIImageView!
    
    var timer = Timer()
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settingUserDetails()
        self.zoomInZoomOut()
        self.schedulingzoomInZoomOut()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        password.text = nil
        userId.text = nil
    }
    
    /// Login button action after UserId and Password is entered.
    ///
    @IBAction func loginButtonTap(_ sender: Any) {
        guard let userId = userId.text?.lowercased(),
            let password = password.text else {
                return
        }
        if let userIdDefault = userDefault.string(forKey: MyClassConstants.user),
            let passwordDefault = userDefault.string(forKey: MyClassConstants.password) {
            if userIdDefault == userId && passwordDefault == password {
                self.pushingViewController()
            } else {
                AlertHelper.alertMessage(viewController: self)
            }
        }
    }
    
    /// Inserting mail & password value inside user’s defaults database.
    func settingUserDetails() {
        userDefault.set(MyClassConstants.mailId, forKey: MyClassConstants.user)
        userDefault.set(MyClassConstants.mailPassword, forKey: MyClassConstants.password)
    }
    
    /// Controller is pushed into navigation Controller.
    func pushingViewController() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let collection = storyBoard.instantiateViewController(withIdentifier: "Collection") as? CollectionViewController else {
            return }
        self.navigationController?.pushViewController(collection, animated: false)
    }
}

extension LoginViewController {
    
    /// Animates the background image in Login Screen.
    @objc func zoomInZoomOut() {
        UIView.animate(withDuration: 15.0, animations: {() -> Void in
            self.backGroundImage?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 20.0, animations: {() -> Void in
                self.backGroundImage?.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
    }
    /// Scheduling of animatation of the background image.
    private func schedulingzoomInZoomOut() {
        timer = Timer.scheduledTimer(timeInterval: 35,
                                     target: self,
                                     selector: #selector(self.zoomInZoomOut),
                                     userInfo: nil,
                                     repeats: true)
    }
}
