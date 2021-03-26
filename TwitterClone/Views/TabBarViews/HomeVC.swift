//
//  HomeVC.swift
//  TwitterClone
//
//  Created by Asit Aslan on 24.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController {

    @IBOutlet weak var tableViewHome: UITableView!
    @IBOutlet weak var uploadButton: UIButton!
    var takeData: Posts!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        getPostsInfo()
        tableViewHome.delegate = self
        tableViewHome.dataSource = self
        
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        UploadViewController.goUploadPost(from: self)
        
    }
    
    func setupUI(){
        uploadButton.cornerRadius(radius: uploadButton.frame.size.width/2)
    }
    
    private func getPostsInfo(){
        Network.getPostInfo(compliton: { (result) in
           
        }) { (error) in
            self.makeAlert(textInput: "Error", messageInput: error.localizedDescription)
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewHome.dequeueReusableCell(withIdentifier: "toHomeCellVC", for: indexPath) as! HomeCellVC
        cell.delegate = self
        return cell
    }
    
}

extension HomeVC: GoProfilePage{
    func changeImage() {
        let goProfilePage = self.storyboard?.instantiateViewController(withIdentifier: "toProfilePage") as! ProfilePageVC
        self.navigationController?.pushViewController(goProfilePage, animated: true)
    }
}
