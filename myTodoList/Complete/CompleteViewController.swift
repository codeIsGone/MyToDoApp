//
//  CompleteViewController.swift
//  myTodoList
//
//  Created by 홍희곤 on 1/11/24.
//

import UIKit

class CompleteViewController: UIViewController {
    
    @IBOutlet weak var completeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        completeTableView.dataSource = self
        completeTableView.delegate = self
    }
}

extension CompleteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let completedTask = DataStore.shared.tasks.filter({$0.isCompleted == true})
        return completedTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = completeTableView.dequeueReusableCell(withIdentifier: "completeCell", for: indexPath) as! CompleteTableViewCell
        
        let completedTask = DataStore.shared.tasks.filter({$0.isCompleted == true})[indexPath.row]
        
        cell.titleLabel.text = completedTask.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
