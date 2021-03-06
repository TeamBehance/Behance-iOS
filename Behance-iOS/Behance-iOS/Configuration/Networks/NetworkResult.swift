//
//  NetworkResult.swift
//  Behance-iOS
//
//  Created by κΉνμ on 2022/05/31.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
