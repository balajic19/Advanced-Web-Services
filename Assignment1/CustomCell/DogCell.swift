//
//  DogCell.swift
//  Assignment1
//
//  Created by Shiva Rama Krishna nutakki on 10/03/22.
//

import UIKit

class DogCell: UITableViewCell {

    @IBOutlet weak var dogNameLabel: UILabel!
    @IBOutlet weak var dogSubBreedsLabel: UILabel!
    @IBOutlet weak var dogImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dogImage.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with dog: NSMutableDictionary?,_ image: String) {
        if let dictDog = dog {
            if let dogName = dictDog.value(forKey: "name") as? String {
                dogNameLabel.text = dogName
            }
            if let dogSubBreed = dictDog.value(forKey: "breedName") as? [String], dogSubBreed.count > 0 {
                dogSubBreedsLabel.isHidden = false
                dogSubBreedsLabel.text = dogSubBreed.joined(separator: ",")
            }
        }
        
        if let url = URL(string:image), let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                dogImage.image = image
            }
        }

    }
    
}
