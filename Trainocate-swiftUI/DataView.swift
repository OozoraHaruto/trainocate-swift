//
//  DataView.swift
//  Trainocate-swiftUI
//
//  Created by 大空太陽 on 6/10/21.
//

import SwiftUI

struct DataView: View {
    let postTitle: String
    let postBody: String
    let postId: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(postTitle)
                .font(.title2)
                .foregroundColor(.blue)
            Text(postBody)
                .font(.body)
                .foregroundColor(.green)
            Text("Post ID: \(postId)")
                .font(.caption)
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
        .navigationBarTitle("Post ID: \(postId)")
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView(postTitle: "Title", postBody: "body", postId: 1)
    }
}
