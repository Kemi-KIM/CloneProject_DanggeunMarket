//
//  ListChatVC.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/21.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

class ListChatVC: UIViewController {
    @IBOutlet weak var chatUsersTableView: UITableView!
    
    
    var myModel: UserM!
    var storage: Storage!
    
    var data: PostM?
    var db: Firestore!
    
    var array: [ChatM]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatUsersTableView.delegate = self
        chatUsersTableView.dataSource = self
        
    }
    
    
    
    func getChatList() {
        
        //
        
        
    }
    
    
    
    
    
    
    
    
//===
}
//===

extension ListChatVC: UITableViewDelegate, UITableViewDataSource {
    
    
    // Data 받아와서 전환
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let view = UIStoryboard(name: "Chat", bundle: nil).instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        
        view.modalPresentationStyle = .fullScreen
        //view.data = array?[indexPath.row]
        
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.array?.count ?? 0
        // 그 섹션만큼 리턴, ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
  
        /*
         
         userPhoto
         userNickName
         recentlyChat
         userPostPhoto
         */
        
        return cell
    }
    

}



