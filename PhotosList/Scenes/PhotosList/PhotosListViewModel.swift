//
//  PhotosListViewModel.swift
//  PhotosList
//
//  Created by Azza on 08/01/2022.
//

import Foundation
import RxSwift
import RxRelay

final class PhotosListViewModel {
    

    // MARK: - private state
    private let disposeBag = DisposeBag()
    private var photosListSubject = BehaviorRelay<[Photo]>(value: [])
    private let photoListApi: NetworkManagerProtocol

    // MARK: - Observers
    var photossList: Observable<[Photo]> {
        return photosListSubject.asObservable()
    }
    var showLoader = PublishSubject<Bool>()
    var error = PublishSubject<Error>()

    // MARK: - Initialization
    init(photoListApi: NetworkManagerProtocol = NetworkManager()) {
        self.photoListApi = photoListApi
        fetchData()
    }

    // MARK: - Network Call
     func fetchData() {
        showLoader.onNext(true)
        photoListApi.sendRequest(endPoint: PhotosApi.getPhotosList(page: 1, count: 8),
                                  decodingType: Photos.self)
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                self.showLoader.onNext(false)
                self.photosListSubject.accept(value)
                print("=======\(value.count)")
            }, onError: { [weak self] err in
                guard let self = self else { return }
                self.showLoader.onNext(false)
                self.error.onNext(err)
            }).disposed(by: disposeBag)
    }

}
