//
//  PostsDataObvObj.swift
//  Trainocate-swiftUI
//
//  Created by 大空太陽 on 6/10/21.
//

import Foundation


class PostsDataObvObj: ObservableObject {
    @Published var postData: [Post]
    var allPostData: [Post]
    var limit: Int
    let showNumberOfPost = 10
    @Published var loaded: Bool
    @Published var moreItems: Bool
    
    init() {
//        callAPI()
        postData = []
        allPostData = []
        limit = 10
        loaded = false
        moreItems = false
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
//                print(json) // an array of MyPosts...
                DispatchQueue.main.async {
                    self.allPostData = json
                    if (json.count > 0) {
                        self.loadMore()
                    }
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
    func loadMore() {
        let currentCount = postData.count
        var endIndex = currentCount + showNumberOfPost
        moreItems = allPostData.count > endIndex
        if (endIndex > allPostData.count) {
            endIndex = allPostData.count
        }
            
        postData += allPostData[currentCount...(endIndex-1)]
        
        print("Published Array Items: \(postData.count)")
    }
}


struct Post: Codable {
    var id: Int
    var userId: Int
    var title: String
    var body: String
}
