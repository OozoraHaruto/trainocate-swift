//
//  ContentView.swift
//  Trainocate-swiftUI
//
//  Created by 大空太陽 on 6/10/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var posts = PostsDataObvObj()
    
    var body: some View {
        NavigationView{
            if (posts.postData.count > 0) {
                List{
                    ForEach(posts.postData, id: \.id) {post in
                        NavigationLink(destination: DataView(postTitle: post.title, postBody: post.body, postId: post.id)){
                            VStack(alignment: .leading, spacing: 5) {
                                Text(post.title)
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                Text(post.body)
                                    .font(.body)
                                    .foregroundColor(.green)
                                Text("Post ID: \(post.id)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .navigationTitle("Posts")
            } else {
                HStack {
                    VStack {
                        if (posts.loaded) {
                            Image(systemName: "xmark.octagon")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                            Text("No posts found")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                        } else {
                            Text("Loading...")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .onAppear {
            posts.getData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
