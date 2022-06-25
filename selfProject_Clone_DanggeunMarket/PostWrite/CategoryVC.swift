//
//  CategoryVC.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/15.
//

import Foundation
import UIKit


//#1 Protocol과 빈 func 선언
protocol SendTempDelegate: AnyObject {
    func tempdelegate(data: String)
}


class CategoryVC: UIViewController {
    
    
    @IBOutlet weak var categoryTableView: UITableView!
    

    var tempList = CategoryM.categoryList()
    var delegate: SendTempDelegate?

    var selectedCategory: String?
    
    var Listname: String?
    
    
    //======
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCheckMark()
        
        }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let selectedCategory = selectedCategory else { return }
        guard let index = tempList.firstIndex(where: {$0.name == selectedCategory}) else { return }
        tempList[index].isSelected = true
    }
    
    
    @IBAction func backbtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    func configureCheckMark() {

        guard let index = tempList.firstIndex(where: {$0.name == Listname}) else { return }
        tempList[index].isSelected = true
        
    }
    

    
    
    
//=============
}




// 1번과 2번이 datasource에 해당
extension CategoryVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 섹션안에 총 몇개의 셀을 보여줄건지
        return tempList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 셀 생성
        let target = tempList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        cell.textLabel?.text = target.name
        cell.accessoryType = target.isSelected ? .checkmark : .none
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 중복체크 제거
        // 테이블뷰의 0번 섹션에 있는 셀 전체만큼 반복
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            // 현재 선택한 셀이 row와 같으면 트루 아니면 false
            if row == indexPath.row {
                tempList[row].isSelected = true
                
                // #5 델리게이트 메소드 호출
                delegate?.tempdelegate(data: tempList[row].name)
            } else {
                tempList[row].isSelected = false
            }
        }
    
        self.categoryTableView.reloadData()
        // 중복체크방지 확인하려면 아래 코드 주석처리하고 확인
        self.dismiss(animated: true)
        //self.navigationController?.popViewController(animated: true)
    }
}





//카테고리 연결 시, 제발.. storyboard에서 tableview에서 해당 viewcontroller로 delegate, datasource를 연결시켜주자....

