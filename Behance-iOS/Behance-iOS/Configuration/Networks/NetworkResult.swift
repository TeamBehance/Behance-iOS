//
//  NetworkResult.swift
//  Behance-iOS
//
//  Created by 김혜수 on 2022/05/31.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
