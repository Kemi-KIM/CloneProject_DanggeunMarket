//
//  RelativeDate.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/17.
//


import UIKit


extension Date {
    func Datefunc() -> String {
        
        let formatter = RelativeDateTimeFormatter()
            
        //
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.unitsStyle = .short
            
        return formatter.localizedString( for: self, relativeTo: Date() )
        
    }
}
