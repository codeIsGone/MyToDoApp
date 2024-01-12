//
//  GroupViewController.swift
//  myTodoList
//
//  Created by 홍희곤 on 1/10/24.
//

import UIKit

class GroupViewController: UIViewController {

    @IBOutlet weak var groupTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupTableView.dataSource = self
        groupTableView.delegate = self
    }
}


extension GroupViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Rows 수 지정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryList.count
    }
    
    //cell 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupTableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupTableViewCell
        cell.setCell(indexPath: indexPath)
        
        return cell
    }
    
    //cell select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //cell swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //편집 스와이프
        let modifyAction = UIContextualAction(style: .normal, title: "편집", handler: {(action, view, completionHandler) in
            let alert = UIAlertController(title: "카테고리명 변경", message: "타이틀을 입력하세요.", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "수정", style: .default) {action in
                if let userInput = alert.textFields?.first?.text {
                    
                    //빈 스트링 리턴
                    guard userInput != "" else {return}
                    //경로를 받아 타이틀 수정
                    categoryList[indexPath.row].title = userInput
                    //변경사항을 반영하여 테이블뷰 업데이트
                    self.groupTableView.reloadData()
                    
                    //UserDefaults에 categoryList 저장
                    DataStore.shared.categorySave()
                }
            }
            let rejectAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            
            //addAction 메서드를 통해 Alert 객체에 Action 객체 추가
            alert.addAction(confirmAction)
            alert.addAction(rejectAction)
            
            //addTextField 메서드로 Alert 객체에 textField 추가
            alert.addTextField {(textField) in
                textField.text = categoryList[indexPath.row].title
            }
            self.present(alert, animated: true, completion: nil)
        })
        
        let deleteAction = UIContextualAction(style: .normal, title: "삭제", handler: {(action, view, completionHandler) in
            categoryList.remove(at: indexPath.row)
            deletetoDoInCategory(section: indexPath.row)
            self.groupTableView.reloadData()
            
            DataStore.shared.categorySave()
            DataStore.shared.todoSave()
        })
        
        modifyAction.backgroundColor = .systemBlue
        deleteAction.backgroundColor = .systemRed
        
        let mySwipeAction = UISwipeActionsConfiguration(actions: [deleteAction, modifyAction])
        
        mySwipeAction.performsFirstActionWithFullSwipe = false
    return mySwipeAction
    }
}
