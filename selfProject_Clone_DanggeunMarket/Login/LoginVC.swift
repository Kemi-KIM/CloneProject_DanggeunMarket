//
//  LoginVC.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/13.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class LoginVC: UIViewController {
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var authTextField: UITextField!
    @IBOutlet weak var authButton: UIButton!
    
    
    
    
    var phoneNumber: String!
    
    var db: Firestore!
    var verificationID: String!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        sendButton.layer.cornerRadius = 5
        authButton.layer.cornerRadius = 5
    }
    
    
    
    // Send SMS
    @IBAction func sendButtonAction(_ sender: Any) {
        
        var number = numberTextField.text!
        self.phoneNumber = number
        
        //
        if(numberTextField.text! != nil && numberTextField.text! != "") {
            
            sendSMS(phoneNumber: "+82" + number)
            
        } else {
            
            // not 11, wrong number..
            print(" sendSMSAction - not 11, wrong number.. ")
        
        }
    }
    
    
    // func - Send SMS
    func sendSMS( phoneNumber: String )
    {
        
        
        Auth.auth().languageCode = "kr"
        PhoneAuthProvider.provider()
          .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
              
              if let error = error {
                print(error.localizedDescription)
                return
              }
              
              
              // 에러가 없다면 사용자에게 인증코드와 verificationID(인증ID) 전달
              self.verificationID = verificationID
              print("인증번호 전송완료")
              
          }
    }
    
    
    
 
    
    
    
    
    
    // SMS Auth OK
    @IBAction func authButtonAction(_ sender: Any) {
        
        //
        if(authTextField.text != nil && authTextField.text != "")
        {
            
            let verificationCode = authTextField.text!
            let credential = PhoneAuthProvider.provider().credential(
              withVerificationID: verificationID,
              verificationCode: verificationCode
            )
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    
                    print("error+ \(error.localizedDescription)")
                    self.makeAlert(title: "error. 1", message: "")
                    return
                    
                }
                
                // 인증 완료 -> 로그인 진행
                self.checkPhoneNumber()
            }
        } else {
            
            //not authnumber
            print("not authnumber")
            print(" authButtonAction - not authnumber ")
            self.makeAlert(title: "다시 입력하세요. 2", message: "")
        }
    }
    
    
    
    
    
    // func checkPhoneNumber
    func checkPhoneNumber()
        {
            
            db.collection("사용자")
               .whereField("phoneNumber", isEqualTo: self.phoneNumber!)
                .getDocuments  { (querySnapshot, err) in
                    
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {

                        
                        if(querySnapshot!.documents.isEmpty)
                        {
                            
                            let view = self.storyboard?.instantiateViewController(withIdentifier: "NickNameVC") as! NickNameVC
                        
                            view.phoneNumber = self.phoneNumber
                            //view.address = self.address
                            
                            self.navigationController?.pushViewController(view, animated: true)
                        }
                        
                        
                        // Login
                        else {
                            
                            
                            let view = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeNaviVC") as! HomeNaviVC
                            
                            
                            view.modalPresentationStyle = .fullScreen
                            view.modalTransitionStyle = .crossDissolve
                            
                            
                            
                            let userModel = UserM(snapshot: querySnapshot!.documents[0])
                            
                            view.userModel = userModel
                            
                            
                            //
                            let encoder = JSONEncoder()
                            if let encoded = try? encoder.encode(userModel) {
                                UserDefaults.standard.set(encoded, forKey: "myModel")
                            }
                            
                            
                            
                            view.modalPresentationStyle = .fullScreen
                            self.present(view, animated: true)
                            
                            }
                        }
                }
        }
    
   
//====
}
