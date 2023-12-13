//
//  ViewController.swift
//  myTodoList
//
//  Created by 홍희곤 on 12/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    var todo = Todo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    @IBAction func addTaskButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "추가", message: "할일을 추가하세요", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //섹션별 로우 수 지정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.taskes.count
    }

    //스토리보드 내 myCell과 연결
    //Label 프로퍼티(MyTableViewCell 클래스에 아울렛으로 구현됨)와 연결
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        cell.myLabel.text = todo.taskes[indexPath.row]
        return cell
    }
    
    //셀을 누르면 구현부 로직 실행
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //구현부
    }
    
    //섹션 수 지정
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
