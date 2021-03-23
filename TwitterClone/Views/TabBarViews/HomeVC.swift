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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cornerRadius()
        tableViewHome.delegate = self
        tableViewHome.dataSource = self
        tableViewHome.reloadData()
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        goUploadPost()
        
    }
    
    func cornerRadius(){
        uploadButton.layer.cornerRadius = uploadButton.frame.size.width/2
        uploadButton.layer.masksToBounds = true
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
