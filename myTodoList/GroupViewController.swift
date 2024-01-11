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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupTableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupTableViewCell
        
        return cell
    }
}
