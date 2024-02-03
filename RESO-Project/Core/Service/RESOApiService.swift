//
//  RESOApiService.swift
//  RESO-Project
//
//  Created by Andrey on 07.05.2022.
//

import Foundation

enum ApiUrl: String {
    case offices = "v2/agencies/77"
}

class RESOApiService {
    
    private let baseURL = "https://mobile.reso.ru/free/"
    
    func getOffices(completion: @escaping (Result<DecodeResponse, Error>) -> ()) {
        NetworkService.request(urlString: baseURL + ApiUrl.offices.rawValue) { result in
            completion(result)
        }
    }
    
    static let shared = RESOApiService()
    private init () {}
}
