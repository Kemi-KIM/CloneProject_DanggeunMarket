//
//  ChatTableViewCell.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/15.
//

import Foundation
import UIKit

class ChatTableViewCell: UITableViewCell {
    @IBOutlet weak var receiveMessageView: UIView!
    @IBOutlet weak var receiveImageView: UIImageView!
    @IBOutlet weak var receiveMessageLabel: UILabel!
    
    @IBOutlet weak var myMessageView: UIView!
    @IBOutlet weak var myMessageLabel: UILabel!
 
    override func prepareForReuse() {
        super.prepareForReuse()
        receiveMessageView.isHidden = true
        myMessageView.isHidden = true
    }
    
    
    
    
    func setData(isMe: Bool, message: String) {
        
        receiveMessageView.isHidden = isMe
        myMessageView.isHidden = !isMe
        
        receiveMessageLabel.text = message
        myMessageLabel.text = message
        
        
        // custom
        receiveMessageView.layer.cornerRadius = 8
        myMessageView.layer.cornerRadius = 8
    }
    
    
    
//=====
}
//=====
