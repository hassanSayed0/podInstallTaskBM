//
//  homePageViewController.swift
//  task4ex3
//
//  Created by hassan sayed on 8/10/22.
//

import UIKit
import Alamofire
import Kingfisher

class homePageViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
  
    @IBOutlet weak var tableView: UITableView!
    var arr = [UIColor.red, UIColor.yellow, UIColor.cyan]
    var userArr: [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getUserList()
        
    }
    
    func getUserList() {
        AF.request("https://reqres.in/api/users?page=2").validate()
            .responseDecodable(of: UserModel.self) { (response) in
                guard let users = response.value else { return }
                print(users.data)
                self.userArr = users.data
                self.tableView.reloadData()
            }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! homePageTableViewCell
       /* cell.containerView.layer.cornerRadius = 15
        cell.nameLbl.text = userArr[indexPath.row].firstName + " " + userArr[indexPath.row].lastName
        cell.emailLbl.text = userArr[indexPath.row].email
        
        let url = URL(string: userArr[indexPath.row].avatar)!
        let resource = ImageResource(downloadURL: url)
        cell.img.kf.setImage(with: resource)*/
        
        cell.setup(name: userArr[indexPath.row].firstName)
       return cell
    }
}
