//
//  ChatM.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/19.
//

import Foundation
import FirebaseFirestore


struct ChatM {
    let phoneNumber: String
    let message: String
    let date: Date
    
    init?(dictionary: [String: Any]) {
        guard let phoneNumber = dictionary["phoneNumber"] as? String,
            let message = dictionary["message"] as? String,
            let date = dictionary["date"] as? Timestamp else {
            return nil
        }
        self.phoneNumber = phoneNumber
        self.message = message
        self.date = date.dateValue()
    }
   
    
    /*
     
     이렇게 만들어서 배열을 넘겨주는 것과

     채팅 모델
     1. 게시물 정보
     2. 채팅 신청 유저 db
     3. 게시물 작성자 유저 db
     ㄴ date: 날짜

     message array
     1. user model
     2. message: String
     3. date: String
     
     
     
     */
}
