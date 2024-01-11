//
//  MyTableViewCell.swift
//  myTodoList
//
//  Created by 홍희곤 on 12/12/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    //ViewController 클래스 내부 메서드에 연결됨
    @IBOutlet weak var titleLabel: UILabel!
    
    func setCell(indexPath:IndexPath) {
        
        //카테고리(섹션)가 구분된 새로운 ToDo 배열 생성
        let toDoListInCategory = toDoListInCategory(section: indexPath.section)
        
        let todo = toDoListInCategory[indexPath.row]
        
        //선택셀 표시 off
        self.selectionStyle = .none
        
        //완료 여부 확인하여 타이틀에 취소선 적용
        if todo.isCompleted == true {
            //색 변경
            self.titleLabel.textColor = .lightGray
            //속성 적용된 텍스트 대입
            self.titleLabel.attributedText = todo.title.strikeThrough()
        } else {
            //색 복원
            self.titleLabel.textColor = .black
            //속성 복원
            self.titleLabel.attributedText = nil
            //텍스트 대입
            self.titleLabel.text = todo.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
