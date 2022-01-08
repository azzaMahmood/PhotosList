//
//  RequestBuilder+Base.swift
//  PhotosList
//
//  Created by Azza on 08/01/2022.
//

import Foundation
import Alamofire

protocol RequestBuilder {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
}

extension RequestBuilder {
    var baseURL: String {
        return APIConstants.BaseURL
    }
}
