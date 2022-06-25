//
//  PostWriteVC.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/13.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import YPImagePicker



class PostWriteVC: UIViewController, SendTempDelegate {
        func tempdelegate(data: String) {
            categoryButton.setTitle(data, for: .normal)
        }
    
    
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    
    
    var myModel: UserM?
    var storage = Storage.storage()
    var db = Firestore.firestore()
    
    
    var photos:[String]?
    var postTitle:String?
    var category:String?
    var price:String?
    var contents:String?
     
    var phoneNumber:String?
    
    var selectedDatas = [Data]()
    var selectedImage = [UIImage]()
    var countPhoto = 0
    
    
  
    
    // < Close Button
    @IBAction func closeButton(_ sender: Any) {
      
        self.dismiss(animated: true)
    
    }
    
    // 저장 Save Button
    @IBAction func saveButton(_ sender: Any) {
        
        photos = [String]()
        postTitle = titleTextField.text!
        price = priceTextField.text!
        contents = contentsTextView.text!
        
        phoneNumber = myModel?.phoneNumber
        
        if(postTitle != nil && postTitle != "" && contents != nil && contents != "") {
            self.photos?.removeAll()
            
            for data in selectedDatas{
                let random = Int.random(in: 0...999)
                let name = "photo" + String(random) + ".jpg"
                self.uploadPhoto(randomName: name, data: data)
            
            
            // save 후 popview
            self.navigationController?.popViewController(animated: true)
            
            }
            
        } else {
            
            self.makeAlert(title: "제목, 카테고리, 내용은 필수 입력 항목이예요", message: "")
            
        }
    }
    
    
    // Camera button
    @IBAction func cameraButtonAction(_ sender: Any) {
        photoTapped()
    }
    
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMyModel()
        
        // delegate, datasource
        contentsTextView.delegate = self
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        
    }
    
    
    
    // Category VC 받아오기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "show" {
            
            let view = segue.destination as! CategoryVC
            //guard let view: CategoryVC = segue.destination as? CategoryVC else { return }
            
            view.delegate = self
            view.selectedCategory = self.category
            view.Listname = categoryButton.titleLabel?.text
            
        }
    }
    
    
    
    // func - add post
    func postAdd() {
        
        db.collection("게시물").document().setData([
           
            "photos": self.photos!,
            "title": self.postTitle!,
            //"category": ,
            "price": self.price!,
            "contents": self.contents!,
            
            "phoneNumber": self.phoneNumber!,
            "data": Date(),
            "chat": []
            
            
            
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                self.dismiss(animated: true)
                
            }
        }
    }
    
    
    
    
    // func - model
    func getMyModel() {
    
        let data = UserDefaults.standard.object(forKey: "myModel")
        
        if(data != nil){
            
            let decoder = JSONDecoder()
            self.myModel = try? decoder.decode(UserM.self, from: data as! Data)
            
        }
    }
    
    
    // func - photo
    @objc func photoTapped()
    {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 10 - selectedDatas.count
        config.onlySquareImagesFromCamera = true
        config.library.onlySquare = true
        config.library.mediaType = .photo
        config.wordings.albumsTitle = "앨범"
        config.wordings.cameraTitle = "카메라"
        config.wordings.cancel = "취소"
        config.wordings.next = "확인"
        config.wordings.ok = "확인"
        config.wordings.libraryTitle = "앨범"
        config.wordings.save = "저장"
        config.startOnScreen = .library
        config.showsPhotoFilters = false

        let picker = YPImagePicker(configuration: config)
        
        
        if #available(iOS 15, *) {
            let navBarAppearance = UINavigationBarAppearance()
           navBarAppearance.configureWithOpaqueBackground()
           picker.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
        
        picker.didFinishPicking { [unowned picker] items, cancelled in
            for item in items {
                switch item {
                case .photo(let photo):
                    
                    self.selectedImage.append(photo.image)
                    let photoData = photo.originalImage.jpegData(compressionQuality: 0.8)
                    self.selectedDatas.append(photoData!)
                    
                    print(photo)
                case .video(let video):
                    print(video)
                }
            }
            picker.dismiss(animated: true, completion: nil)
            self.countLabel.text = String(self.selectedImage.count) + "/10"
            self.photoCollectionView.reloadData()
        }
        self.present(picker, animated: true, completion: nil)
    }
    
    
    
    // func - uploadPhoto
    func uploadPhoto( randomName: String, data: Data )
    {
        let riversRef = storage.reference().child("images/postphotos/" + randomName)
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
              self.photos?.append(downloadURL.absoluteString)
              self.countPhoto += 1
              if(self.countPhoto == self.selectedDatas.count)
              {
                  //uploadDB
                  self.postAdd()
              }
          }
        }

    }

    
    
    
//===
}

//===



extension PostWriteVC: UICollectionViewDelegate,UICollectionViewDataSource {

   
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return selectedImage.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
       cell.photoImageView.image = selectedImage[indexPath.row]
       cell.remove = { [unowned self] in
           selectedImage.remove(at: indexPath.row)
           selectedDatas.remove(at: indexPath.row)
           collectionView.reloadData()
           //self.photoCountLabel.text = String(self.selectedImage.count) + "/10"
       }
       
       return cell
   }
}







// MARK: - contextTextView Placeholder 설정
extension PostWriteVC: UITextViewDelegate {
   func textViewDidBeginEditing(_ textView: UITextView) {
       if textView.textColor == UIColor(named: "gray") {
           textView.text = nil
           textView.textColor = UIColor.black
       }
   }
   
   func textViewDidEndEditing(_ textView: UITextView) {
       if textView.text.isEmpty {
           textView.text = "내용을 작성해주세요."
           textView.textColor = UIColor(named: "gray")
       }
   }
   
   func textViewDidChange(_ textView: UITextView) {
       let size = CGSize(width: view.frame.width, height: .infinity)
       let estimatedSize = textView.sizeThatFits(size)
       
       textView.constraints.forEach { cons in
           if estimatedSize.height <= 320 {
               
           } else {
               if cons.firstAttribute == .height {
                   cons.constant = estimatedSize.height
               }
           }
       }
       
   }
}





