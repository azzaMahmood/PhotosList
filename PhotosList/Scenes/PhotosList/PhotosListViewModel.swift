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
    var photosList: Observable<[Photo]> {
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

    
    func getPhotoDetailsViewInfo(at index: Int) -> PhotoDetailsViewInfo {
        let photos = photosListSubject.value
        guard photos.isEmpty else { return .init(authorName: "", photoImageURL: nil) }
        let photo = photos[index]
        return PhotoDetailsViewInfo(authorName: photo.author, photoImageURL: URL(string: photo.downloadURL))
    }

}
