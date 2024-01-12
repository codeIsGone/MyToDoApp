//
//  PetViewController.swift
//  myTodoList
//
//  Created by 홍희곤 on 1/11/24.
//

import UIKit

class PetViewController: UIViewController {

    @IBOutlet weak var petImageView: UIImageView!
    
    struct MyPetImageUrl: Codable {
        let url: String
    }
    
    //url로 MyPetImage 업데이트 하는 메서드
    func setImage(url:String) {
        let imageURLSource = url
        
        if let imageURL = URL(string: imageURLSource) {
            URLSession.shared.dataTask(with: imageURL) {data, response, error in
                if let data = data {
                    if let image = UIImage(data:data){
                        DispatchQueue.main.async {
                            self.petImageView.image = image
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
