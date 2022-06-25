//
//  StartVC.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/13.
//

import Foundation
import UIKit

class StartVC: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    var signedUser: UserM!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        checkSignedUser()
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        startButton.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5
    }
    
    func checkSignedUser() {
        
        //
        let data = UserDefaults.standard.object(forKey: "myModel")
        
        //
        if(data != nil){
            
            let decoder = JSONDecoder()
            self.signedUser = try? decoder.decode(UserM.self, from: data as! Data)
        
        //
            
            let view = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeNaviVC") as! HomeNaviVC
            
            view.userModel = self.signedUser
            
            view.modalPresentationStyle = .fullScreen
            self.present(view, animated: true)
            
        
        }
    }
    
    
//===
}
