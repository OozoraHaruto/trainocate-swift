//
//  DataVC.swift
//  Trainocate-swift
//
//  Created by 大空太陽 on 5/10/21.
//

import UIKit

class DataVC: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    @IBOutlet weak var lblPostID: UILabel!
    
    var postTitle: String = ""
    var body: String = ""
    var postID: Int = 0
    
//    init(title: String, body: String, postID: Int){
//        super.init(nibName: nil, bundle: nil)
//        self.title = title
//        self.body = body
//        self.postID = postID
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = postTitle
        lblBody.text = body
        lblPostID.text = "Post ID: \(postID)"
    }


}

