//
//  MainViewController.swift
//  myTodoList
//
//  Created by 홍희곤 on 1/11/24.
//

import UIKit
import AVKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainLogoImage: UIImageView!
    
    let apiMagager = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataStore.shared.readTask()
        apiMagager.getVideoData()
        
        //URL 주소 설정
        let logoImageURLSource = "https://spartacodingclub.kr/css/images/scc-og.jpg"
        
        //URL 주소를 대입하여 URL 객체 생성
        if let imageURL = URL(string: logoImageURLSource){
            
            // URLSession을 사용하여 이미지 다운로드
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let data = data {
                    // 다운로드된 데이터로 UIImage 객체 생성
                    if let image = UIImage(data: data) {
                        // 이미지뷰에 설정 (메인 쓰레드에서 실행되어야 함)
                        DispatchQueue.main.async {
                            self.mainLogoImage.image = image
                            print ("이미지 로드 성공")
                        }
                    }
                }
            }.resume()
        }
    }
    
    @IBAction func videoVCBtTap(_ sender: UIButton) {
        
        let avVC = AVPlayerViewController()
        
        let randomIndex = Int.random(in: apiMagager.videoData.indices)
        
        print(randomIndex)
        
        guard let videoURL = URL(string: apiMagager.videoData[randomIndex].videoUrl) else { return }
        
        let avplayer = AVPlayer(url: videoURL)
        
        avVC.player = avplayer
        
        self.navigationController?.pushViewController(avVC, animated: true)
    }
}
