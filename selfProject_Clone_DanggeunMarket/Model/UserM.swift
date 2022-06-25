//
//  UserM.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/13.
//

import Foundation
import FirebaseFirestore

//
struct UserM: Codable{
    
    var nickname: String!
    var phoneNumber: String!
    var profilephoto: String!
    
    //var address: String!
    //var latitude: Double!
    //var longitude: Double!
    
    
    
    // 초기값 전달을 위한 init 생성
    init( nickname: String, phoneNumber: String, profilephoto: String ) {
        self.nickname = nickname
        self.phoneNumber = phoneNumber
        self.profilephoto = profilephoto
        
        //self.address = address
        //self.latitude = latitude
        //self.longitude = longitude
        
    }
    
    
    //
    init(snapshot: QueryDocumentSnapshot) {
        
        var snapshotValue = snapshot.data()
        
        //
        nickname = snapshotValue["nickname"] as? String
        phoneNumber = snapshotValue["phoneNumber"] as? String
        profilephoto = snapshotValue["profilephoto"] as? String
        
        //address = snapshotValue["address"] as? String
        //latitude = snapshotValue["latitude"] as? Double
        //longitude = snapshotValue["longitude"] as? Double
        
        }
    
    
    
    
    static func fromDocument(data: [String: Any]) -> UserM{
        return UserM(nickname: "\(data["nickname"]!)", phoneNumber: "\(data["phoneNumber"]!)", profilephoto: "\(data["profilephoto"] ?? "")")
    }
    
}
