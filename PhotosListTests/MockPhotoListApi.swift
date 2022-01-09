//
//  MockPhotoListApi.swift
//  PhotosListTests
//
//  Created by Azza on 09/01/2022.
//

import XCTest
import RxSwift
@testable import PhotosList

class MockPhotoListApi: NetworkManagerProtocol {
    // MARK: - Properties
    static let shared = MockPhotoListApi()

    // MARK: - Initialization
    private init() {}

    func sendRequest<ResponseType>(endPoint: RequestBuilder, decodingType: ResponseType.Type) -> Observable<ResponseType> where ResponseType: Decodable {
            return Observable<ResponseType>.create { observer in
                guard let data = TestHelper().loadStubDataFromBundle(name: "PhotoListMockedJson", extension: "json"),
                      let model: ResponseType =  try? JSONDecoder().decode(decodingType.self, from: data) else {
                    observer.onError(NetworkFailure.generalFailure)
                    return Disposables.create()
                }
                observer.onNext(model)
                observer.onCompleted()
                return Disposables.create()
            }
    }
}
