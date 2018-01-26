//
//  AlertHelper.swift
//  TaskAuthenticateWebseverShowdetail
//
//  Created by Rakshith Appaiah on 1/26/18.
//  Copyright © 2018 Rakshith Appaiah. All rights reserved.
//

import UIKit

class AlertHelper: NSObject {
    /// Pops Error message during User Authentication.
    static func alertMessage(viewController : UIViewController) {
        let alert = UIAlertController(title: MyClassConstants.error, message: MyClassConstants.errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: MyClassConstants.actionTitle, style: UIAlertActionStyle.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
