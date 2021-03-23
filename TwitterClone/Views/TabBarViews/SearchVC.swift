//
//  SearchVC.swift
//  TwitterClone
//
//  Created by Asit Aslan on 24.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class SearchVC: BaseViewController{

    
    @IBOutlet weak var addPostSearchButton: UIButton!
    @IBOutlet weak var tableViewSearch: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addPostSearchButton.layer.cornerRadius = addPostSearchButton.frame.size.width/2
        addPostSearchButton.layer.masksToBounds = true
        tableViewSearch.delegate = self
        tableViewSearch.dataSource = self
    }
    
    @IBAction func addPostSearchButtonClicked(_ sender: Any) {
        UploadViewController.goUploadPost(from: self)
    }
    @IBAction func goSettingPage(_ sender: UIButton) {
        let toSettingPage = self.storyboard?.instantiateViewController(identifier: "toSettingVC") as! LogOutVC
        self.present(toSettingPage, animated: true, completion: nil)
    }
    

}
extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewSearch.dequeueReusableCell(withIdentifier: "toSearchCellVC", for: indexPath) as! SearchCellVC
        return cell
        
    }
    
    
}
