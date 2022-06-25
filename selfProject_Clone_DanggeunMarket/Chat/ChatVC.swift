//
//  ChatVC.swift
//  selfProject_Clone_DanggeunMarket
//
//  Created by 김성호 on 2022/06/21.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage


class ChatVC: UIViewController {
    @IBOutlet weak var chatList: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var contentView: UIView!
    
    
    // 전송 버튼
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        
       
        sendMessage()
    }
    
    
    var db: Firestore!
    var myModel: UserM!
    var ref: DatabaseReference!
    var messageContents: [ChatM] = []
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        firestMessage()
        
        
        
        
        
        // Keyboard 높이 설정
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        chatList.keyboardDismissMode = .onDrag
    }

    
    // uuid를 게시물에 올리고 나서,
    // uuid를 게시물에 넣어서 구분을 한다.?
    
//=====
}



// read, write message from Firebase/Datebase
// MARK: read/write message from Firebase/Database
extension ChatVC {
    private func firestMessage() {
        db.collection("채팅").whereField("phoneNumber", isEqualTo: "01000000000").getDocuments { [weak self] docs, error in
            guard let docs = docs, !docs.isEmpty else {
                self?.addInitialDocument()
                return
            }
            self?.loadMessages()
        }
    }
    
    
    
    
    
    private func addInitialDocument() {
        db.collection("chats").addDocument(data: [
            "phoneNumber": "01000000000",
            "message": "-",
            "date": FieldValue.serverTimestamp()
        ]) { [weak self] _ in
            self?.loadMessages()
        }
    }
    
    
    
    
    private func loadMessages() {
        db.collection("채팅").addSnapshotListener { [weak self] snaps, _ in
            guard let snapshots = snaps else {
                return
            }
            
            self?.messageContents = []
            
            for snap in snapshots.documents {
                guard let message = ChatM(dictionary: snap.data()) else {
                    return
                }
                self?.messageContents.append(message)
            }
            //self?.messageContents.sort { $0.order < $1.order }
            self?.chatList.reloadData()
            self?.chatList.scrollToRow(at: (IndexPath(row: (self?.messageContents.count ?? 0) - 1, section: 0)), at: .bottom, animated: true)
        }
    }
    
    private func sendMessage() {
        let message: [String: Any] = [
            "phoneNumber": UIDevice.current.identifierForVendor!.uuidString,
            "message": messageTextField.text ?? "",
            "date": FieldValue.serverTimestamp()
        ]
        db.collection("채팅").addDocument(data: message)
        messageTextField.text = ""
    }
}



extension ChatVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        let isMe = messageContents[indexPath.row].phoneNumber == UIDevice.current.identifierForVendor!.uuidString
        cell.setData(isMe: isMe, message: messageContents[indexPath.row].message)
        return cell
    }
}

// MARK: (Optional) Keyboard show/hide
extension ChatVC {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let window = UIApplication.shared.windows.first {
            let bottomPadding = window.safeAreaInsets.bottom
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (346 - bottomPadding)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension ChatVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
}
