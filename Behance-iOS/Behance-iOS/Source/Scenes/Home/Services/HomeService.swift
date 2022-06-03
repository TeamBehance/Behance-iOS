//
//  HomeService.swift
//  Behance-iOS
//
//  Created by 강윤서 on 2022/06/03.
//

import Foundation
import Alamofire

class HomeService {
    static let shared = HomeService()
    private init() {}
    
    func story(completion: @escaping (NetworkResult<Any>) -> Void)
    {
        let url =  "\(URLConstants.baseURL)\(URLConstants.story)"
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                let networkResult = self.judgeStoryStatus(by: statusCode, value)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func project(completion: @escaping (NetworkResult<Any>) -> Void)
    {
        let url =  "\(URLConstants.baseURL)\(URLConstants.project)"
        let header: HTTPHeaders = ["Content-Type" : "application/json"]

        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)

        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                let networkResult = self.judgeProjectStatus(by: statusCode, value)
                completion(networkResult)

            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    private func judgeStoryStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        // 성공 시에는 넘겨받은 데이터를 decode(해독)하는 함수를 호출합니다.
        case 200..<300: return isVaildStoryData(data: data)
        case 400..<500: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func judgeProjectStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        // 성공 시에는 넘겨받은 데이터를 decode(해독)하는 함수를 호출합니다.
        case 200..<300: return isVaildProjectData(data: data)
        case 400..<500: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    // 성공 시 넘겨받은 데이터를 decode하는 함수
    // 이 때 우리가 codable을 채택해서 만들어 놓은 구조체 형식의 데이터 모델을 사용
    private func isVaildStoryData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(StoryResponse.self, from: data)
        else { return .pathErr }
        
        return .success(decodedData as Any)
    }
    
    private func isVaildProjectData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(ProjectResponse.self, from: data)
        else { return .pathErr }
        
        return .success(decodedData as Any)
    }
}

