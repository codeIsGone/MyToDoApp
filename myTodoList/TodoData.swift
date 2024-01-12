import Foundation

//MARK: 데이터 구조체 및 인스턴스 배열 생성
//구조채
struct Todo: Codable {
    var title: String = ""
    var dueDate: String?
    var isCompleted = false
    var category = 0
    //카테고리별로 구분된 todo에서 기존의 todoList에서의 인덱스
    var id = 0
}
struct Category: Codable {
    var title: String = "기본"
    var section: Int = 0
}

//인스턴스 배열
var toDoList: [Todo] = []
var categoryList: [Category] = [Category()]

//MARK: UserDefaults 데이터 관리
class DataStore {
    //싱글톤 객체 생성
    static let shared = DataStore()
    private init() {
    }
    private let toDoKey = "ToDo"
    private let categoryKey = "Category"
    
    func load() {
        //todoList 로드
        do {
            if let TodoData = UserDefaults.standard.data(forKey: toDoKey) {
                toDoList = try JSONDecoder().decode([Todo].self, from: TodoData)
                print ("ToDo 로드 성공")
            }
        } catch {
            print ("ToDo 로드 실패")
        }
        
        //categoryList 로드
        do {
            if let categoryData = UserDefaults.standard.data(forKey: categoryKey) {
                categoryList = try JSONDecoder().decode([Category].self, from: categoryData)
                print ("category 로드 성공")
            }
        } catch {
            print ("category 로드 실패")
        }
    }
    
    func todoSave() {
        do {
            let toDoData = try JSONEncoder().encode(toDoList)
            UserDefaults.standard.set(toDoData, forKey: toDoKey)
            print ("ToDo 세이브 성공")
        } catch {
            print ("ToDo 세이브 실패")
        }
    }
    
    func categorySave() {
        do {
            let categoryData = try JSONEncoder().encode(categoryList)
            UserDefaults.standard.set(categoryData, forKey: categoryKey)
            print ("Category 세이브 성공")
        } catch {
            print ("Category 세이브 실패")
        }
    }
}

//MARK: 메서드
//toDoList 배열을 순회하며 해당 카테고리에 속하는 요소의 수를 반환
func toDoNumsInCategory(section: Int) -> Int {
    var count = 0
    
    for i in toDoList {
        if i.category == section {
            count += 1
        }
    }
    return count
}

//toDoList 배열을 순회하며 해당 카테고리에 속하는 새로운 배열을 반환
func toDoListInCategory(section:Int) -> [Todo] {
    var toDoListInCategory: [Todo] = []
    
    for i in toDoList.indices {
        if toDoList[i].category == section {
            toDoList[i].id = i
            toDoListInCategory.append(toDoList[i])
        }
    }
    return toDoListInCategory
}

//해당 카테고리에 속하는 todo 삭제
func deletetoDoInCategory(section:Int) {
    for i in toDoList.indices {
        if toDoList[i].category == section {
            toDoList.remove(at: i)
        }
    }
}

//완료 상태인 todo를 요소로 갖는 배열을 반환
func completeTodo() -> [Todo] {
    var completedtodo: [Todo] = []
    
    for i in toDoList {
        if i.isCompleted {
            completedtodo.append(i)
        }
    }
    
    return completedtodo
}
