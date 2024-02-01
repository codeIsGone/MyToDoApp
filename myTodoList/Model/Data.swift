import Foundation
import CoreData
import UIKit

class DataStore {
    
    //MARK: 싱글톤 패턴
    static let shared = DataStore()
    private init () {}
    
    var tasks:[Task] = []
    
    //MARK: CoreData
    //persistentContainer 생성
    private var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    //Create: Task 쓰기
    func createTask(title: String) {
        //Context 생성
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let newTask = Task(context: context)
        
        newTask.id = UUID()
        newTask.title = "\(title)"
        newTask.createDate = Date.now
        newTask.isCompleted = false
        
        do {
            self.tasks.append(newTask)
            try context.save()
            print ("Create 성공")
        } catch {
            print ("Create 실패")
        }
    }
    
    //Read: Task 읽기
    func readTask() {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let request = Task.fetchRequest()
        
        if let tasks = try? context.fetch(request) {
            
            //만들어진 순서를 보장하여 불러오기
            self.tasks = tasks.sorted { $0.createDate! < $1.createDate! }

            print ("Read 성공")
        }
    }
    
    //Update: Task title 수정
    func fetchTaskTitle(title: String, index: Int) {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        self.tasks[index].title = title
        self.tasks[index].modifyDate = Date.now
        
        print ("Update: Title 수정")
        try? context.save()
    }
    
    //Update: Task isCompleted 수정
    func fetchTaskIsCompleted(index: Int) {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        self.tasks[index].isCompleted = !self.tasks[index].isCompleted
        self.tasks[index].modifyDate = Date.now
        
        print ("Update: isCompleted 수정")
        try? context.save()
    }
    
    //Delete: Task 삭제
    func deleteTask(index: Int) {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        context.delete(self.tasks[index])
        self.tasks.remove(at: index)
        
        try? context.save()
    }
}
