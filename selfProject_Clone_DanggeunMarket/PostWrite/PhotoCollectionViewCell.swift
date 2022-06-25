//
//  PhotoCollectionViewCell.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/13.
//

import Foundation
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
  
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var removeButton: UIButton!
    
    var remove: (()->())?
    
    
    @IBAction func removeAction(_ sender: Any) {
        remove?()
    }
    
    
}
