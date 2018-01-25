//
//  CollectionViewController.swift
//  TaskAuthenticateWebseverShowdetail
//
//  Created by Rakshith Appaiah on 1/24/18.
//  Copyright © 2018 Rakshith Appaiah. All rights reserved.
//

import UIKit

/// CollectionViewController : Artists collections screen.
class CollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    final let url = "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors"  ///  - Note: web server url used to get artists details.
    @IBOutlet weak var collectionVw: UICollectionView!
    var arrayOfActors = [ActorDetails]()
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
      ///  - Note: loading data in background thread.
        DispatchQueue.global(qos: .userInteractive).async {
            self.getData()
        }
        self.minSpaceCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfActors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellCollectionViewCell
        let url = URL(string: arrayOfActors[indexPath.row].image)
        let data = try? Data(contentsOf: url!)
        cell.artistImage.image = UIImage(data: data!)
        cell.artistName.text = arrayOfActors[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "Segue", sender: self)     ///  - Note: transition to next view controller is performed.
    }
    
    /// Prepare segue before performing segue.
    /// Note :  arrayOfActors, selectedRow is passed to destination view controller.
    /// - Parameters:
    ///   - segue: describes current segue
    ///   - sender: sender has self view-controller's details.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailViewController
        destination.arrayOfActors.append(contentsOf: self.arrayOfActors)
        destination.selectedRow = self.selectedRow
    }
    
    /// Added minnimum spacing between collectionview cells
    func minSpaceCells() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: width / 2.1, height: width / 2)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionVw!.collectionViewLayout = layout
    }
}

extension CollectionViewController {
    /// Actor details are fetched from here, URLSession class is used for downloading content.
    func getData() {
        guard let url = URL(string: url) else { return }
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = MyClassConstants.getMethod
        let session = URLSession.shared
        session.dataTask(with: requestUrl) { (data, response, error) in
            if let error = error {
                print("\(error)")
            }else {
                if let data = data {
                    do {
                        let json =  try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                        if let actors = json!.value(forKey: MyClassConstants.actors) as? NSArray {
                            for actor in actors {
                                if let actorDict = actor as? NSDictionary {
                                    let name = actorDict.value(forKey: MyClassConstants.name) as! String
                                    let description = actorDict.value(forKey: MyClassConstants.description) as! String
                                    let dob = actorDict.value(forKey: MyClassConstants.dob) as! String
                                    let country = actorDict.value(forKey: MyClassConstants.country) as! String
                                    let image = actorDict.value(forKey: MyClassConstants.image) as! String
                                    let actorDetails = ActorDetails(name: name, descriptions: description, dob: dob, country: country, image: image)
                                    self.arrayOfActors.append(actorDetails)
                                }
                                DispatchQueue.main.async {          ///  - Note: updating UI in main thread.
                                    self.collectionVw.reloadData()
                                }
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            }.resume()
    }
}
