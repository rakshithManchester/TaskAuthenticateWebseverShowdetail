//
//  DetailViewController.swift
//  TaskAuthenticateWebseverShowdetail
//
//  Created by Rakshith Appaiah on 1/24/18.
//  Copyright © 2018 Rakshith Appaiah. All rights reserved.
//

import UIKit

/// DetailViewController : Displays artist's data in detail.
class DetailViewController: UIViewController {
    var arrayOfActors = [ActorDetails]()
    var selectedRow : Int = 0
    @IBOutlet weak var imageVw: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorCountry: UILabel!
    @IBOutlet weak var actorDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        if let url = URL(string: arrayOfActors[selectedRow].image) {
            if let data = try? Data(contentsOf: url) {
                imageVw.image = UIImage(data: data)
            }
            actorName.text = arrayOfActors[selectedRow].name
            actorCountry.text = arrayOfActors[selectedRow].country
            actorDescription.text = arrayOfActors[selectedRow].descriptions
        }
    }
}
