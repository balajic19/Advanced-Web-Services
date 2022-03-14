//
//  DogsViewModel.swift
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

import Foundation

struct Dogs: Codable {
    let message: [String: [String]]?
    let status: String?
}

struct DogImage: Codable {
    let message: [String]?
}

struct DogsViewModel {
    
    static func fetchDogsListFromApiService(completionHandler: @escaping (Dogs?) -> Void) {
        let url = URL(string: "https://dog.ceo/api/breeds/list/all")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching dogs: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      print("Error with the response, unexpected status code: \(String(describing: response))")
                      return
                  }
            
            if let data = data,
               let dogsList = try? JSONDecoder().decode(Dogs.self, from: data) {
                completionHandler(dogsList)
            }
        })
        task.resume()
    }
    
    static func fetchDogsImage(completionHandler: @escaping (DogImage?) -> Void) {
        let url = URL(string: "https://dog.ceo/api/breed/hound/images")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching dogs: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      print("Error with the response, unexpected status code: \(String(describing: response))")
                      return
                  }
            
            if let data = data,
               let dogImagesList = try? JSONDecoder().decode(DogImage.self, from: data) {
                completionHandler(dogImagesList)
            }
        })
        task.resume()
    }
}
