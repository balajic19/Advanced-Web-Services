//
//  ViewController.swift
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
import Foundation

class DogsListViewController: UIViewController {
    
    @IBOutlet weak var dogsListTableView: UITableView!
    private var dogslist = NSMutableArray()
    private var dogsImages = [String]()
    private var selectedDog = NSMutableDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dogsListTableView.rowHeight = 70
        registerCellIntoDogsListTable()
        getListOfDogs()
        getListOfDogsImage()
    }
    
    func registerCellIntoDogsListTable() {
        dogsListTableView.register(UINib(nibName: "DogCell", bundle: nil), forCellReuseIdentifier: "DogCell")
    }
    
    
    func getListOfDogs() {
        DogsViewModel.fetchDogsListFromApiService { [weak self] (dogs) in
            if let dogsList: [String:[String]] = dogs?.message {
                for (name,breedArray) in Array(dogsList).sorted(by: {$0.0 < $1.0}) {
                    let dog = NSMutableDictionary()
                    dog.setValue(name, forKey: "name")
                    dog.setValue(breedArray, forKey: "breedName")
                    self?.dogslist.add(dog)
                }
            }
        }
    }
    
    func getListOfDogsImage() {
        DogsViewModel.fetchDogsImage { [weak self] (dogs) in
            if let dogImages: [String] = dogs?.message {
                self?.dogsImages = dogImages
                DispatchQueue.main.async {
                    self?.dogsListTableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushToDogDetails" {
            let dogsListVC = segue.destination as! DogDetailsViewController
            dogsListVC.dog = selectedDog
        }
    }
}

extension DogsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogslist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath) as! DogCell
        cell.dogSubBreedsLabel.isHidden = true
        if let dictDog = dogslist[indexPath.row] as? NSMutableDictionary {
            cell.configureCell(with: dictDog, dogsImages[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dictDog = dogslist[indexPath.row] as? NSMutableDictionary {
            selectedDog.setValue(dictDog.value(forKey: "name"), forKey: "name")
            selectedDog.setValue(dictDog.value(forKey: "breedName"), forKey: "subbread")
            selectedDog.setValue(dogsImages[indexPath.row], forKey: "image")
        }
        performSegue(withIdentifier: "pushToDogDetails", sender: self)
    }
}



extension Dictionary {
    subscript(i:Int) -> (key:Key,value:Value) {
        get {
            return self[index(startIndex, offsetBy: i)];
        }
    }
}
