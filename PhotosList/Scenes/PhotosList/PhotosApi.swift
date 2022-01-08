//
//  PhotosApi.swift
//  PhotosList
//
//  Created by Azza on 08/01/2022.
//

import Foundation
import Alamofire


// https://picsum.photos/v2/list?page=1&limit=10
enum PhotosApi {
    case getPhotosList(page: Int, count: Int)
}

extension PhotosApi: RequestBuilder {
    var path: String {
        switch self {
        case .getPhotosList:
            return ""
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getPhotosList:
            return .get
        }
    }

    var parameters: [String: Any]? {
        var parameters = ["": ""]
        switch self {
        case .getPhotosList(let page, let count):
            parameters["limit"] = count.description
            parameters["page"] = page.description
            return parameters
        }
    }
}
