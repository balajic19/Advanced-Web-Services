//
//  DogDetailsViewController.swift
//  Assignment1
//
//  Created by
//balajichandupatla1@gmail.com
//A00245077

//nutakki.shivaramakrishna99@gmail.com
//A00245380

//A00245384 - rohith.god1997@gmail.com
//A00245382 - Alekhyachowdary605@gmail.com

//kavyach23@gmail.com
//A00246628

import UIKit

class DogDetailsViewController: UIViewController {
    
    var dog = NSMutableDictionary()
    @IBOutlet weak var lblDogName: UILabel!
    @IBOutlet weak var lblDogDescription: UILabel!
    @IBOutlet weak var imageDog: UIImageView!
    @IBOutlet weak var lblDogSubBread: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPUI()
    }
    
    func setUPUI() {
        if let name = dog.value(forKey: "name") as? String {
            navigationController?.navigationBar.topItem?.title = name
            lblDogName.text = name
        }
        
        if let subBread = dog.value(forKey: "subbread") as? [String], subBread.count > 0 {
            lblDogSubBread.isHidden = false
            lblDogSubBread.text = subBread.joined(separator: ",")
        }
        
        if let image = dog.value(forKey: "image") as? String,
           let url = URL(string:image), let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
            imageDog.image = image
        }
    }
}
