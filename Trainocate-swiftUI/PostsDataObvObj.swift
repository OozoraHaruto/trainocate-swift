//
//  PostsDataObvObj.swift
//  Trainocate-swiftUI
//
//  Created by 大空太陽 on 6/10/21.
//

import Foundation


class PostsDataObvObj: ObservableObject {
    @Published var postData: [Post]
    @Published var loaded: Bool
    
    init() {
//        callAPI()
        postData = []
        loaded = false
    }
    
    func getData(){
        
        let session = URLSession.shared
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
//        print("Calling \(url)")

        let task = session.dataTask(with: url, completionHandler: { data, response, error in
//            print(response)
            DispatchQueue.main.async {
                self.loaded = true
            }
            
            if let _error = error {
                print(_error)
                return
            }
            
            guard let _data = data else {
                return
            }
            
            // Serialize the data into an object
            do {
                let json = try JSONDecoder().decode([Post].self, from: _data)
                print(json) // an array of MyPosts...
                DispatchQueue.main.async {
                    self.postData = json
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        })
        task.resume()
    }
}


struct Post: Codable {
    var id: Int
    var userId: Int
    var title: String
    var body: String
}
