//
//  ViewController.swift
//  myTodoList
//
//  Created by 홍희곤 on 12/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlet 생성
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var copyCompleteView: UIView!
    @IBOutlet weak var myLogoImageView: UIImageView!
    
    //MARK: - copyCompleteView Fade In-Out 애니메이션
    func copyCompleteViewAppear() {
        UIView.animate(withDuration: 0.3, animations: {
            self.copyCompleteView.alpha = 1
        },
                       completion: {_ in
            UIView.animate(withDuration: 0.3, delay: 2, animations: {self.copyCompleteView.alpha = 0})
        }
        )
    }
    
    //MARK: - 더블 클릭 기능 변수 초기화
    var lastSelectedIndexPath: IndexPath?
    var lastSelectedTimestamp: TimeInterval = 0
    
    //MARK: - view 로드 시 실행 로직
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //myLogoImageView 로고 설정
        myLogoImageView.image = .myToDoLogo
        
        //TableView delegation 패턴
        myTableView.delegate = self
        myTableView.dataSource = self
        
        //copyCompleteView 속성 적용
        copyCompleteView.alpha = 0
        copyCompleteView.isUserInteractionEnabled = false
        copyCompleteView.backgroundColor = .lightGray
        copyCompleteView.layer.cornerRadius = 10
    }
    
    //MARK: - addTaskButton 탭시 로직
    @IBAction func tapAddTaskButton(_ sender: UIButton) {
        
        //UIAlertController 통해 Task 추가 기능 구현
        let alert = UIAlertController(title: "할일 추가", message: "", preferredStyle: .alert)
        
        //handler: 클로저 함수로 옵셔널 바인딩된 textField값을 title 프로퍼티에 넣고 해당 프로퍼티를 가진 인스턴스를 toDoList 배열에 append 하는 로직 구현
        let confirmAction = UIAlertAction(title: "추가", style: .default) {action in
            if let userInput = alert.textFields?.first?.text {
                //빈 스트링 리턴
                guard userInput != "" else {return}
                var todo = Todo()
                todo.title = userInput
                toDoList.append(todo)
                //변경사항을 반영하여 테이블뷰 업데이트
                self.myTableView.reloadData()
            }
        }
        
        let rejectAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        
        
        //addAction 메서드를 통해 Alert 객체에 Action 객체 추가
        alert.addAction(confirmAction)
        alert.addAction(rejectAction)
        
        //addTextField 메서드로 Alert 객체에 textField 추가
        alert.addTextField {(textField) in
            textField.placeholder = "입력하세요."
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - TableView 프로토콜
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //TableView의 섹션별 로우 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    //재사용셀로 커스텀 UITableViewCell을 연결하여 해당 경로(indexPath)에 구현
    //커스텀 cell 내부의 Label 프로퍼티에 toDoList 배열 요소인 Todo 인스턴스의 title 프로퍼티 값을 대입
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        
        //선택셀 표시 off
        cell.selectionStyle = .none
        
        //isCompleted 구분
        if toDoList[indexPath.row].isCompleted {
            
            //완료시 컬러, 취소선 적용
            cell.titleLabel.textColor = .lightGray
            cell.titleLabel.attributedText = toDoList[indexPath.row].title.strikeThrough()
            
        }
        else{
            //미완료시 복구
            cell.titleLabel.textColor = .black
            cell.titleLabel.attributedText = nil
            
            cell.titleLabel.text = toDoList[indexPath.row].title
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    //스와이프 액션
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //수정 액션 초기화, 핸들러에서 alert로 label text 수정 로직 구현
        let modifyAction = UIContextualAction(style: .normal, title: "편집", handler: {(action, view, completionHandler) in
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "수정", style: .default) {action in
                if let userInput = alert.textFields?.first?.text {
                    
                    //빈 스트링 리턴
                    guard userInput != "" else {return}
                    //경로를 받아 타이틀 수정
                    toDoList[indexPath.row].title = userInput
                    //변경사항을 반영하여 테이블뷰 업데이트
                    self.myTableView.reloadData()
                }
            }
            let rejectAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            
            //addAction 메서드를 통해 Alert 객체에 Action 객체 추가
            alert.addAction(confirmAction)
            alert.addAction(rejectAction)
            
            //addTextField 메서드로 Alert 객체에 textField 추가
            alert.addTextField {(textField) in
                textField.text = toDoList[indexPath.row].title
            }
            self.present(alert, animated: true, completion: nil)
        })
        
        //삭제 액션 초기화, 핸들러에서 toDoList remove 메서드 구현
        let deleteAction = UIContextualAction(style: .normal, title: "삭제", handler: {(action, view, completionHandler) in
            toDoList.remove(at: indexPath.row)
            self.myTableView.reloadData()
        })
        
        //복사 액션 초기화, 핸들러에서 사용자 클립보드에 해당 경로 text 대입
        let copyAction = UIContextualAction(style: .normal, title: "복사", handler: {(action, view, completionHandler) in
            UIPasteboard.general.string = toDoList[indexPath.row].title
            
            self.copyCompleteViewAppear()
        })
        
        modifyAction.backgroundColor = .systemBlue
        deleteAction.backgroundColor = .systemRed
        copyAction.backgroundColor = .systemGray
        
        //UISwipeActionsConfiguration 액션 추가해주며 초기화
        let mySwipeAction = UISwipeActionsConfiguration(actions: [deleteAction, modifyAction, copyAction])
        
        //FullSwipe 옵션 off
        mySwipeAction.performsFirstActionWithFullSwipe = false
        
        return mySwipeAction
    }
    
    //셀을 누르면 구현부 로직 실행
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentTimestamp = Date().timeIntervalSince1970
        
        if lastSelectedIndexPath == indexPath && currentTimestamp - lastSelectedTimestamp < 0.4 {
            toDoList[indexPath.row].isCompleted = toDoList[indexPath.row].isCompleted ? false : true
            self.myTableView.reloadData()
            return
        }
        lastSelectedIndexPath = indexPath
        lastSelectedTimestamp = currentTimestamp
    }
    
    //섹션 수 지정
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

//MARK: - String 타입에 취소선 메서드 추가
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
