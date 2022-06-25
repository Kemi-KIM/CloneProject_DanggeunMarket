//
//  HomeVC.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/13.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseDatabase
import Kingfisher


class HomeVC: UIViewController {
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var postWriteButton: UIButton!
    
    
    
    
    var myModel:UserM!
    var storage:Storage!
    var array:[PostM]?
    
    
    
    
    @IBAction func postWriteButtonAction(_ sender: Any) {
        
        let view = UIStoryboard(name: "PostWrite", bundle: nil).instantiateViewController(withIdentifier: "PostWriteVC") as! PostWriteVC
        
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: true)
        
    }
    
    
    
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        postWriteButton.layer.cornerRadius = 35
        
        getMyModel()
        
        array = [PostM]()
        
        storage = Storage.storage()
        
        
        postTableView.delegate = self
        postTableView.dataSource = self
        
        
        getDocuList()
        
        
        // refreshControl()
        postTableView.refreshControl = UIRefreshControl()
        postTableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    
    
    

    
    // func - model
    func getMyModel()
    {
        
        let data = UserDefaults.standard.object(forKey: "myModel")
        if(data != nil){
            
            let decoder = JSONDecoder()
            self.myModel = try? decoder.decode(UserM.self, from: data as! Data)
            
        }
    }
    
    // func - DocuList
    func getDocuList()
    {
        
        let db = Firestore.firestore()
        
        db.collection("게시물").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                      } else {
                          
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        
                        let model = PostM(snapshot: document)
                        self.array?.append(model)
                        
                    }
                    
                    self.postTableView.reloadData()
                          
                }
        }
    }
    

    
    @objc private func didPullToRefresh(){
        
        DispatchQueue.main.async {
            self.postTableView.reloadData()
            self.postTableView.refreshControl?.endRefreshing()
        }
    }
    
 
    
    
    
//===
}


//===
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    
    // Data 받아와서 전환
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let view = UIStoryboard(name: "PostDetail", bundle: nil).instantiateViewController(withIdentifier: "PostDetailVC") as! PostDetailVC
        
        view.modalPresentationStyle = .fullScreen
        view.data = array?[indexPath.row]
        
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.array?.count ?? 0
        // 그 섹션만큼 리턴, ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
        
        cell.postImageView.kf.setImage(with: URL(string: array![indexPath.row].photos![0]))
        cell.titleLabel.text = array![indexPath.row].title!
        
        //cell.timeLabel.text = array![indexPath.row].date!
        //cell.timeLabel.text = Date.Datefunc(array[indexPath.row].date)()

        cell.priceLabel.text = "\(array![indexPath.row].price!)원"
        
        return cell
    }
    

}


