//
//  API.swift
//  myTodoList
//
//  Created by 홍희곤 on 2/2/24.
//

import Foundation

struct Video: Codable {
    var videoUrl: String
}

class API {
    
    var videoData: [Video] = []
    
    func getVideoData() {
        let urlString = "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                // 에러 처리
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                // 데이터 처리
                if let data = data {
                    do{
                        let decodingData = try JSONDecoder().decode([Video].self, from: data)
                        self.videoData = decodingData
                        print ("비디오 url 로드 성공")
                    } catch {
                        print ("디코딩 실패")
                    }
                }
            }

            task.resume()
        }
        
    }
}
