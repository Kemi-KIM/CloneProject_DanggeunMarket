//
//  ProfileVC.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/15.
//

import Foundation
import UIKit

class ProfileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // refreshControl()
        //-.refreshControl = UIRefreshControl()
        //-.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    
    
    
    @objc private func didPullToRefresh(){
        
        DispatchQueue.main.async {
           // self.-.reloadData()
            //self.-.refreshControl?.endRefreshing()
        }
    }
    
    
    
//===
}
