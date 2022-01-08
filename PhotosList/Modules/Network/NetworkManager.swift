//
//  NetworkManager.swift
//  PhotosList
//
//  Created by Azza on 08/01/2022.
//

import Foundation
import RxSwift
import Alamofire

protocol NetworkManagerProtocol {
    func sendRequest<ResponseType: Decodable>(endPoint: RequestBuilder, decodingType: ResponseType.Type) -> Observable<ResponseType>
}

class NetworkManager: NetworkManagerProtocol {

    // MARK: - Network call
    func sendRequest<ResponseType: Decodable>(endPoint: RequestBuilder, decodingType: ResponseType.Type) -> Observable<ResponseType> {

        let responseSubject = PublishSubject<ResponseType>()

        guard let url =  URL.init(string: endPoint.baseURL + endPoint.path) else {                         responseSubject.onError(NetworkFailure.generalFailure)
            return responseSubject
        }

        AF.request(url, method: endPoint.method,
                   parameters: endPoint.parameters,
                   encoding: URLEncoding.init(destination: .queryString))
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let responseDate):
                    do {
                        let model: ResponseType =  try JSONDecoder().decode(decodingType.self, from: responseDate)
                        responseSubject.onNext(model)
                    } catch {
                        responseSubject.onError(NetworkFailure.failedToParseData)
                    }

                case .failure(let error):
                    responseSubject.onError(error)
                }
            }
        return responseSubject
    }
}
