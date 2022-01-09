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
    var photosListSubject = BehaviorRelay<[Photo]>(value: [])
    private let photoListApi: NetworkManagerProtocol
    private var currentPage = 0
    private var page = Page()
    
    // MARK: - Observers
    var showLoader = PublishSubject<Bool>()
    var error = PublishSubject<String>()

    // MARK: - Initialization
    init(photoListApi: NetworkManagerProtocol = NetworkManager()) {
        self.photoListApi = photoListApi
        fetchData()
    }

    // MARK: - Network Call
    func fetchData() {
        guard page.shouldLoadMore else { return }
        showLoader.onNext(true)
        photoListApi.sendRequest(endPoint: PhotosApi.getPhotosList(page: page.currentPage, count: page.countPerPage), decodingType: Photos.self)
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                self.showLoader.onNext(false)
                var items = try? self.photosListSubject.value
                items?.append(contentsOf: value)
                self.page.currentPage += 1
                self.page.fetchedItemsCount += items?.count ?? 0
                self.photosListSubject.accept(items ?? [])
            }, onError: { [weak self] err in
                guard let self = self else { return }
                self.showLoader.onNext(false)
                self.error.onNext(err.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func getPhotoDetailsViewInfo(at index: Int) -> PhotoDetailsViewInfo {
        let photos = photosListSubject.value
        guard photos.isEmpty else { return .init(authorName: "", photoImageURL: nil) }
        let photo = photos[index]
        return PhotoDetailsViewInfo(authorName: photo.author, photoImageURL: URL(string: photo.downloadURL))
    }
    
    func prefetchItemsAt(indexPaths: [IndexPath]) {
            guard let max = indexPaths.map({ $0.row }).max() else { return }
            if page.fetchedItemsCount <= (max + 1) {
                fetchData()
            }
        }

}
