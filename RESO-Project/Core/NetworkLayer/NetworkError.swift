//
//  NetworkError.swift
//  RESO-Project
//
//  Created by Andrey on 07.05.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case responseDecodingError
    case responseError
    case requestError(String)
    case statusCodeError
    case dataNotFoundError
}
