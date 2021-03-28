//
//  HomeVC.swift
//  TwitterClone
//
//  Created by Asit Aslan on 24.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit
import SDWebImage

class HomeVC: BaseViewController {

    @IBOutlet weak var tableViewHome: UITableView!
    @IBOutlet weak var uploadButton: UIButton!
    var takeData: Posts!
    var postArray = [GetPost]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        viewWillAppear(true)
        tableViewHome.delegate = self
        tableViewHome.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getPostsInfo()
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        UploadViewController.goUploadPost(from: self)
        
    }
    
    func setupUI(){
        uploadButton.cornerRadius(radius: uploadButton.frame.size.width/2)
    }
    
    private func getPostsInfo(){
        Network.getPostInfo(compliton: { (result) in
            if result{
                self.postArray = Network.postArray
                DispatchQueue.main.async {
                    self.tableViewHome.reloadData()
                }
            }
        }) { (error) in
            self.makeAlert(textInput: "Error", messageInput: error.localizedDescription)
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewHome.dequeueReusableCell(withIdentifier: "toHomeCellVC", for: indexPath) as! HomeCellVC
        cell.delegate = self
        cell.usernameLbl.text = postArray[indexPath.row].userNmae
        cell.postViewLbl.text = postArray[indexPath.row].postText
        cell.postImageView1.sd_setImage(with: URL(string: postArray[indexPath.row].postImageUrl))
        cell.profileImageCellView.sd_setImage(with: URL(string: postArray[indexPath.row].profileImageUrl))
        cell.nameSuenameLbl.text = postArray[indexPath.row].name
        return cell
    }
    
}

extension HomeVC: GoProfilePage{
    func changeImage() {
        let goProfilePage = self.storyboard?.instantiateViewController(withIdentifier: "toProfilePage") as! ProfilePageVC
        self.navigationController?.pushViewController(goProfilePage, animated: true)
    }
}
