//
//  DataTableVC.swift
//  Trainocate-swift
//
//  Created by 大空太陽 on 5/10/21.
//

import UIKit

class DataTableVC: UITableViewController {
    
    var postData: [Post] = []
    var limit: Int = 10
    
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Posts"
        
        showLoader()
        
        getData { [weak self] success in
            self?.hideLoader()
            
            if (self?.postData.count ?? 0 > 0 && success) {
                DispatchQueue.main.async {
                    self?.tableView.delegate = self
                    self?.tableView.dataSource = self
                    self?.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.limit > self.postData.count ? self.postData.count : (self.limit + 1)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellIdentifier = "dataView"
        if (self.limit < self.postData.count && indexPath.row == limit){
            cellIdentifier = "addLimitRow"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if (cellIdentifier == "dataView") {
            let rowData = self.postData[indexPath.row]
            
            let labelTitle: UILabel = cell.viewWithTag(1) as! UILabel
            labelTitle.text = rowData.title
            let labelBody: UILabel = cell.viewWithTag(2) as! UILabel
            labelBody.text = rowData.body
            let labelPostID: UILabel = cell.viewWithTag(3) as! UILabel
            labelPostID.text = "Post ID: \(rowData.id)"
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.limit < self.postData.count && indexPath.row == limit){
            self.limit += 10
            self.tableView.reloadData()
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "viewPostDetails") {
            let rowData = self.postData[self.tableView.indexPathForSelectedRow!.row]
            let vc:DataVC = segue.destination as! DataVC
            vc.configure(data: rowData)
        }
    }
    
    
    // MARK: - Private methods
    
    // MARK: Activity Indicator
    private func showLoader() {
        DispatchQueue.main.async {
            self.activityIndicator.center = self.view.center
            self.activityIndicator.startAnimating()
            self.view.addSubview(self.activityIndicator)
            self.view.bringSubviewToFront(self.activityIndicator)
        }
    }
    
    private func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
        
    }
    
    // MARK: - API Call
    
    func getData(completion: @escaping (Bool)->()){
        
        let session = URLSession.shared
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            completion(false)
            return
        }
//        print("Calling \(url)")

        let task = session.dataTask(with: url, completionHandler: { data, response, error in
//            print(response)
            if let _error = error {
                print(_error)
                completion(false)
                return
            }
            
            guard let _data = data else {
                completion(false)
                return
            }
            
            // Serialize the data into an object
            do {
                let json = try JSONDecoder().decode([Post].self, from: _data)
//                print(json) // an array of MyPosts...
                self.postData = json
                completion(true)
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
                completion(true)
            }
        })
        task.resume()
    }
}


struct Post: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}
