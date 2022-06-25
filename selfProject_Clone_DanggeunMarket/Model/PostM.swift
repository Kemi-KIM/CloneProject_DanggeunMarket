//
//  PostM.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/13.
//

import Foundation
import FirebaseFirestore

struct PostM: Codable{
    
    var photos:[String]?
    var title:String?
    var category:String?
    var price:String?
    var contents:String?
    
    var phoneNumber:String?
    var date:String?
    //var address:String?
    
    //+
    var chat: [String]?
    
    
    
    init(snapshot: QueryDocumentSnapshot) {
        
        var snapshotValue = snapshot.data()
        
        photos = snapshotValue["photos"] as? [String]
        title = snapshotValue["title"] as? String
        category = snapshotValue["category"] as? String
        price = snapshotValue["price"] as? String
        contents = snapshotValue["contents"] as? String
        
        phoneNumber = snapshotValue["phoneNumber"] as? String
        date = snapshotValue["date"] as? String
        //address = snapshotValue["address"] as? String
        
        //+
        chat = snapshotValue["chat"] as? [String]
        

    }

}
