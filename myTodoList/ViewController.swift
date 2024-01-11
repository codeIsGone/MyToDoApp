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
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var onTasksViewButton: UIButton!
    @IBOutlet weak var offTasksViewButton: UIButton!
    @IBOutlet weak var tasksViewBackground: UIView!
    @IBOutlet weak var tasksView: UIView!
    
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
        
        //UserDefaults에 저장된 데이터 read
        DataStore.shared.load()
        
        //배경 터치 감지용 변수 생성
        let backgroundTouchGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundtap))
        tasksViewBackground.addGestureRecognizer(backgroundTouchGesture)
        
        //task 모음 숨기기
        tasksViewBackground.isHidden = true
        tasksViewBackground.alpha = 0
        tasksView.isHidden = true
        tasksView.alpha = 0
        
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
    
    //MARK: - 배경 터치 시 로직
    @objc func backgroundtap() {
        self.offTasksViewButton(self.offTasksViewButton)
    }
    
    //MARK: - onTasksViewButton 탭 로직
    @IBAction func onTasksViewButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
            sender.isHidden = true
            sender.alpha = 0
            self.tasksViewBackground.isHidden = false
            self.tasksViewBackground.alpha = 0.3
            self.tasksView.isHidden = false
            self.tasksView.alpha = 1.0
        }
    }
    
    //MARK: - offTasksViewButton 탭 로직
    @IBAction func offTasksViewButton(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5) {
            self.onTasksViewButton.transform = .identity
            self.onTasksViewButton.isHidden = false
            self.onTasksViewButton.alpha = 1.0
            self.tasksViewBackground.isHidden = true
            self.tasksViewBackground.alpha = 0
            self.tasksView.isHidden = true
            self.tasksView.alpha = 0
        }
    }
    
    //MARK: - editCategory 탭 로직
    
    @IBAction func editCategory(_ sender: UIButton) {
        
    }
    
    //MARK: - addCategoryButton 탭 로직
    @IBAction func tapAddCategoryButton(_ sender: UIButton) {
        
        //UIAlertController 통해 Task 추가 기능 구현
        let alert = UIAlertController(title: "카테고리 추가", message: "", preferredStyle: .alert)
        
        //handler: 클로저 함수로 옵셔널 바인딩된 textField값을 title 프로퍼티에 넣고 해당 프로퍼티를 가진 인스턴스를 toDoList 배열에 append 하는 로직 구현
        
        let confirmAction = UIAlertAction(title: "저장", style: .default) {action in
            if let userInput = alert.textFields?.first?.text {
                
                //예외처리
                guard userInput != "" else {return}
                
                //Category 인스턴스 생성
                var newCategory = Category()
                newCategory.title = userInput
                newCategory.section = categoryList.count
                categoryList.append(newCategory)
                
                //테스크뷰 off
                self.offTasksViewButton(self.offTasksViewButton)
                
                //변경사항을 반영하여 테이블뷰 업데이트
                self.myTableView.reloadData()
                
                //UserDefaults에 배열 저장
                DataStore.shared.categorySave()
            }
        }
        
        let rejectAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        //addAction 메서드를 통해 Alert 객체에 Action 객체 추가
        alert.addAction(confirmAction)
        alert.addAction(rejectAction)
        
        //addTextField 메서드로 Alert 객체에 textField 추가
        alert.addTextField {(textField) in
            textField.placeholder = "New category"
        }
        
        //present로 Alert 나타내기
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - addTaskButton 탭 로직
    @IBAction func tapAddTaskButton(_ sender: UIButton) {
        
        //UIAlertController 통해 Task 추가 기능 구현
        let alert = UIAlertController(title: "ToDo 추가", message: "할일을 입력하세요.", preferredStyle: .alert)
        
        //handler: 클로저 함수로 옵셔널 바인딩된 textField값을 title 프로퍼티에 넣고 해당 프로퍼티를 가진 인스턴스를 toDoList 배열에 append 하는 로직 구현
        
        let confirmAction = UIAlertAction(title: "저장", style: .default) {action in
            if let userInput = alert.textFields?.first?.text {
                
                //예외처리
                guard userInput != "" else {return}
                
                //Todo 인스턴스 생성
                var todo = Todo()
                todo.title = userInput
                
                //배열에 append
                toDoList.append(todo)
                
                //tasksview off
                self.offTasksViewButton(self.offTasksViewButton)
                
                //변경사항을 반영하여 테이블뷰 업데이트
                self.myTableView.reloadData()
                
                //UserDefaults에 todoList 저장
                DataStore.shared.todoSave()
            }
        }
        
        let rejectAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        //addAction 메서드를 통해 Alert 객체에 Action 객체 추가
        alert.addAction(confirmAction)
        alert.addAction(rejectAction)
        
        //addTextField 메서드로 Alert 객체에 textField 추가
        alert.addTextField {(textField) in
            textField.placeholder = "New task"
        }
        
        //present로 Alert 나타내기
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - TableView 프로토콜
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //재사용셀로 커스텀 UITableViewCell을 연결하여 해당 경로(indexPath)에 구현
    //커스텀 cell 내부의 Label 프로퍼티에 toDoList 배열 요소인 Todo 인스턴스의 title 프로퍼티 값을 대입
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell

        cell.setCell(indexPath: indexPath)
                
        return cell
    }
    
    //로우 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    //스와이프 액션
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //수정 액션 초기화, 핸들러에서 alert로 label text 수정 로직 구현
        let modifyAction = UIContextualAction(style: .normal, title: "편집", handler: {(action, view, completionHandler) in
            let alert = UIAlertController(title: "ToDo 추가", message: "할일을 입력하세요.", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "수정", style: .default) {action in
                if let userInput = alert.textFields?.first?.text {
                    
                    //빈 스트링 리턴
                    guard userInput != "" else {return}
                    //경로를 받아 타이틀 수정
                    toDoList[indexPath.row].title = userInput
                    //변경사항을 반영하여 테이블뷰 업데이트
                    self.myTableView.reloadData()
                    
                    //UserDefaults에 todoList 저장
                    DataStore.shared.todoSave()
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
            
            let todo = toDoListInCategory(section: indexPath.section)[indexPath.row]
            toDoList.remove(at: todo.id)
            self.myTableView.reloadData()
            
            //UserDefaults에 todoList 저장
            DataStore.shared.todoSave()
        })
        
        //복사 액션 초기화, 핸들러에서 사용자 클립보드에 해당 경로 text 대입
        let copyAction = UIContextualAction(style: .normal, title: "복사", handler: {(action, view, completionHandler) in
            let todo = toDoListInCategory(section: indexPath.section)[indexPath.row]
            UIPasteboard.general.string = todo.title
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
            let todo = toDoListInCategory(section: indexPath.section)[indexPath.row]
            
            toDoList[todo.id].isCompleted = !toDoList[todo.id].isCompleted
            self.myTableView.reloadData()
            
            //UserDefaults에 todoList 데이터 저장
            DataStore.shared.todoSave()
            
            return
        }
        lastSelectedIndexPath = indexPath
        lastSelectedTimestamp = currentTimestamp
    }
    
    //섹션 수 지정
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryList.count
    }
    
    //TableView의 섹션별 로우 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoNumsInCategory(section: section)
    }
    
    //섹션별 헤더에 뷰 추가
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //헤더뷰 생성
        let headerView = UIView()
        
        //헤더뷰 레이블 생성
        let headerlabel = UILabel()
        headerlabel.text = "\(categoryList[section].title)(\(toDoNumsInCategory(section: section)))"
        headerlabel.font = .systemFont(ofSize: 12)
        headerlabel.textColor = .systemGray
        headerlabel.translatesAutoresizingMaskIntoConstraints = false
        
        //헤더뷰에 컴포넌트 추가
        headerView.addSubview(headerlabel)
        
        //Autolayout 제약 조건 추가
        NSLayoutConstraint.activate([
            headerlabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8),
            headerlabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 24),
        ])
        
        return headerView
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
