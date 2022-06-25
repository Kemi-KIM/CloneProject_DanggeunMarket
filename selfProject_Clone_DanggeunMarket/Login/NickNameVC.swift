//
//  NickNameVC.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/13.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage
import YPImagePicker

class NickNameVC: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var nicknameButton: UIButton!
    
    
    
    
    var phoneNumber: String!
    var profilephoto: String!
    var selectedDatas = [Data]()
    
    var storage = Storage.storage()
    var db: Firestore!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        db = Firestore.firestore()
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        photoButton.layer.cornerRadius = 5
        nicknameButton.layer.cornerRadius = 5
    }
    
    
    
    // photo upload
    @IBAction func photoButtonAction(_ sender: Any) {
        
        profilephoto = String()
        
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 10 - selectedDatas.count
        config.screens = [.library]
        config.showsPhotoFilters = false

        let picker = YPImagePicker(configuration:  config)
                
        picker.didFinishPicking { [unowned picker] items, _ in
                    if let photo = items.singlePhoto {
                        
                        
                        // 이미지뷰를 변경한다.
                        self.profileImageView.image = photo.image
                    }
                    // 사진 선택창 닫기
                picker.dismiss(animated: true, completion: nil)
                
                }
                // 사진 선택창 보여주기
            self.present(picker, animated: true, completion: nil)
        
        
        for data in selectedDatas {
        let random = Int.random(in: 0...999)
        let name = "profilephoto" + String(random) + ".jpg"
            
        self.uploadPhoto(randomName: phoneNumber, data: data)
        
        }
    }
    
    
    
    // func - photo upload
    func uploadPhoto( randomName:String, data:Data ) {
        
        var randomName = self.phoneNumber!
        
        let riversRef = storage.reference().child("images/users/" + randomName)
        
        let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
              print(error)
            return
          }
            
          // Metadata contains file metadata such as size, content-type.
          // You can also access to download URL after upload.
          riversRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
                print(error)
              return
            }
              self.profilephoto?.append(downloadURL.absoluteString)
           
              //uploadDB
              self.signUp()
          }
        }
    }
    
    
    
    
    // + signUP 함수를 두번 호출하고 있다.
    // uploadphoto와 nicknameconfirm에서
    
    
    
    
    
    // nickname confirm
    @IBAction func confirmButton(_ sender: Any) {
        
        if(nicknameTextField.text != nil && nicknameTextField.text != "")
        {
            nicknameCheck(nickname: nicknameTextField.text!)
        }

        else {
            //
            print(" confirmButton - error ")
        }
        
        
        
        //
        signUp()
    }
    
    
    // func - nickname check
    func nicknameCheck(nickname:String)
    {
        db.collection("사용자")
            .whereField("nickName", isEqualTo: nickname)
            .getDocuments  { (querySnapshot, err) in
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    if(querySnapshot!.documents.isEmpty)
                    {
                        //
                    }
                    else
                    {
                       //
                        print("중복된 닉네임입니다.")
                    }
                }
            }
    }
    
    
    
    // -------------------------
    // func - final SignUp
    func signUp()
    {
        db.collection("사용자").document().setData([
           
            "nickname": self.nicknameTextField.text!,
            "phoneNumber": self.phoneNumber!
            //"address": self.address!,
           
            
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                
                
                let userModel = UserM (
                    nickname: self.nicknameTextField.text!,
                    phoneNumber: self.phoneNumber!,
                    profilephoto: ""
                    )
                
                
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(userModel) {
                    UserDefaults.standard.set(encoded, forKey: "myModel")
                }
                
                
                
                
                //
                let view = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeNaviVC") as! HomeNaviVC
                view.userModel = userModel
                view.modalPresentationStyle = .fullScreen
                self.present(view, animated: true)
                
                    }
            }
    }
    
    
    
//=====
}
