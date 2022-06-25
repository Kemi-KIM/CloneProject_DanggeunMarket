//
//  PostDetailVC.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/13.
//

import Foundation
import UIKit
import Kingfisher
import FirebaseFirestore
import FirebaseStorage



class PostDetailVC: UIViewController {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    //@IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    //@IBOutlet weak var chatButton: UIButton!
    
    
    
    var myModel: UserM!
    var storage: Storage!
    
    var data: PostM?
    var db: Firestore!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        db = Firestore.firestore()
        
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        
        
        titleLabel.text = data?.title ?? ""
        timeLabel.text = data?.date ?? ""
        contentsLabel.text = data?.contents ?? ""
        priceLabel.text = data?.price ?? "원"
        
        
        getUserModel()
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        titleLabel.numberOfLines = 0
        contentsLabel.numberOfLines = 0
    }
    
    
    
    
    // func - get model
    func getUserModel()
    {
        if(data?.phoneNumber != nil && data?.phoneNumber != "")
        {
            
            db.collection("사용자")
                .whereField("phoneNumber", isEqualTo: data?.phoneNumber)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            print("\(document.documentID) => \(document.data())")
                            
                            let model = UserM(snapshot: document)
                            
                            //self.userImageView.kf.setImage(with: URL(string: model.photo ?? ""), placeholder: UIImage(named: "ImgFile"))
                            
                            self.nicknameLabel.text = model.nickname
                            
                        }
                        print("===")

                    }
                }
            
                    
        }
    }
    //======================
    //======================
    //======================
    //======================
    //======================
    //======================
    
        
    
    @IBAction func chatButton(_ sender: Any) {
        
        
        let users = UserDefaults.standard.object(forKey: "myModel")
        
        
        let view = UIStoryboard(name: "Chat", bundle: nil).instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
            view.myModel = self.myModel
            view.modalPresentationStyle = .fullScreen
 
            self.navigationController?.pushViewController(view, animated: true)
        
           
    
    
        /*
         
         서버통신 개념, 예제 찾아보고 "이해"하기
         
         
         
         
         
         
         
         상대방: 현재 게시물을 게시한 사람
         사용자: 사용자
         
         
         // (1) 상대방 - 사용자 형태의 채팅방을 생성 후 이동하기.
         // -> Chat 스토리보드의 ChatVC로 이동.
         
         // 현재 사용자와 상대방을 decoder
         var user: UserM!
         
         
         if(data != nil){
             let decoder = JSONDecoder()
             self.user = try? decoder.decode(UserM.self, from: data as! Data)
         
         
        
        
         
         제이슨 형식은 문자전송할 때 쓴다?
         
         필드 안에 또 필드를 만들어서 적용시킨다....
         
         
         
         
         
          // (2) 사용자 - 사용자 일 경우 에러 메세지 송출
         
         
          // (3) 생성 후 상대방은 사용자와의 채팅방이 생성되며, 채팅방 리스트에 나타난다.
         */
        
        
        
        
        
        
    }
    
    
    
    //======================
    //======================
    //======================
    //======================
    //======================
    //======================
    //======================
    //======================
    //======================
    
    
    
    
    
    
    
         
    
//===
}
//===


extension PostDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data?.photos?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostDetailCollectionViewCell", for: indexPath) as! PostDetailCollectionViewCell
        
        cell.photoImageView.kf.setImage(with: URL(string:self.data?.photos?[indexPath.row] ?? ""))

        return cell
    }

}


