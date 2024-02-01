//
//  ProfileViewController.swift
//  myTodoList
//
//  Created by 홍희곤 on 2/1/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setUI()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ProfileViewController {
    func setUI() {
        let userID = UILabel()
        userID.text = "아이디: hee.gone"
        view.addSubview(userID)
        
        let userName = UILabel()
        userName.text = "이름: 홍희곤"
        view.addSubview(userName)
        
        userID.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userID.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            userID.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            userName.topAnchor.constraint(equalTo: userID.bottomAnchor, constant: 8),
            userName.leadingAnchor.constraint(equalTo: userID.leadingAnchor)
        ])
    }
}
