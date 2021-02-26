//
//  NetworkController.swift
//  OSRS Flipping App
//
//  Created by Bronson Mullens on 2/26/21.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case noData
    case noImage
    case tryAgain
    case decodeFailed
}

class NetworkController {
    
    let baseURL: URL? = URL(string: "http://services.runescape.com/m=itemdb_oldschool")!
    
    var favoritedItems: [Item] = []
    
    func fetchItem(with item: String, completion: @escaping (Result<Item, NetworkError>) -> Void) {
        let fetchItemURL = baseURL!.appendingPathComponent("4151") // = Whip
        
        var request = URLRequest(url: fetchItemURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error fetching: \(error.localizedDescription)")
                completion(.failure(.tryAgain))
                return
            }
            
            guard let data = data else {
                NSLog("Error: No data")
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let item = try decoder.decode(Item.self, from: data)
                completion(.success(item))
            } catch {
                NSLog("Could not decode item \(item)")
                completion(.failure(.decodeFailed))
                return
            }
        } .resume()
    }
    
}
