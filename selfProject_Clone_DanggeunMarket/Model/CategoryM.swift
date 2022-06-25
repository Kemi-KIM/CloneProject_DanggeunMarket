//
//  CategoryM.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/13.
//

import Foundation


struct CategoryM {
    
    let name: String
    var isSelected: Bool
    
    
    static func categoryList() -> [CategoryM] {
        return [
            CategoryM(name: "디지털기기", isSelected: false),
            CategoryM(name: "생활가전", isSelected: false),
            CategoryM(name: "가구/인테리어", isSelected: false),
            CategoryM(name: "유아동", isSelected: false),
            CategoryM(name: "유아도서", isSelected: false),
            CategoryM(name: "생활/가공식품", isSelected: false),
            CategoryM(name: "스포츠/레저", isSelected: false),
            CategoryM(name: "여성잡화", isSelected: false),
            CategoryM(name: "여성의류", isSelected: false),
            CategoryM(name: "남성패션/잡화", isSelected: false),
            CategoryM(name: "게임/취미", isSelected: false),
            CategoryM(name: "뷰티/미용", isSelected: false),
            CategoryM(name: "반려동물용품", isSelected: false),
            CategoryM(name: "도서/티켓/음반", isSelected: false),
            CategoryM(name: "식물", isSelected: false),
            CategoryM(name: "기타중고물품", isSelected: false),
            CategoryM(name: "삽니다", isSelected: false)
                ]
        }
}
