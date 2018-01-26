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
    var timer = Timer()
    let userDefault = UserDefaults.standard
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var backGroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingUserDetails()
        self.zoomInZoomOut()
        self.schedulingzoomInZoomOut()
    }
    override func viewDidDisappear(_ animated: Bool) {
        password.text =  nil
        userId.text = nil
    }
    /// Login button action after UserId and Password is entered.
    ///
    @IBAction func loginButtonTap(_ sender: Any) {
        guard let userId = userId.text?.lowercased(), let password = password.text else { return }
        if let userIdD = userDefault.string(forKey: MyClassConstants.user), let passwordD = userDefault.string(forKey: MyClassConstants.password) {
            if userIdD == userId && passwordD == password {
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                guard let collection = storyBoard.instantiateViewController(withIdentifier: "Collection") as? CollectionViewController else {
                    return }
                self.navigationController?.pushViewController(collection, animated: false)
            } else {
                self.alertMessage()
            }
        }
    }
    /// Pops Error message during User Authentication.
    func alertMessage() {
        let alert = UIAlertController(title: MyClassConstants.error, message: MyClassConstants.errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: MyClassConstants.actionTitle, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    /// Inserting mail & password value inside user’s defaults database.
    func settingUserDetails() {
        userDefault.set(MyClassConstants.mailId, forKey: MyClassConstants.user)
        userDefault.set(MyClassConstants.mailPassword, forKey: MyClassConstants.password)
    }
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
