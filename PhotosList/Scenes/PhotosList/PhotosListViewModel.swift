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
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let photoListApi: NetworkManagerProtocol
    private var currentPage = 0
    private var page = Page()
    var photosListSubject = BehaviorRelay<[Photo]>(value: [])
    
    // MARK: - Observers
    var showLoader = PublishSubject<Bool>()
    var error = PublishSubject<String>()

    // MARK: - Initialization
    init(photoListApi: NetworkManagerProtocol = NetworkManager()) {
        self.photoListApi = photoListApi
    }

    // MARK: - Network Call
    func fetchData() {
        guard page.shouldLoadMore else { return }
        showLoader.onNext(true)
        photoListApi.sendRequest(endPoint: PhotosApi.getPhotosList(page: page.currentPage, count: page.countPerPage), decodingType: Photos.self)
            .subscribe(onNext: { [weak self] value in
                guard let self = self else { return }
                self.handleApiResponse(value)
            }, onError: { [weak self] err in
                guard let self = self else { return }
                self.showLoader.onNext(false)
                self.error.onNext(err.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    private func handleApiResponse(_ value: Photos) {
        self.showLoader.onNext(false)
        var items = try? self.photosListSubject.value
        items?.append(contentsOf: value)
        self.photosListSubject.accept(items ?? [])
        self.handlePagination(count: value.count)
    }
    
    private func handlePagination(count: Int) {
        self.page.currentPage += 1
        self.page.fetchedItemsCount += count
    }
    
    func prefetchItemsAt(indexPaths: [IndexPath]) {
            guard let max = indexPaths.map({ $0.row }).max() else { return }
            if page.fetchedItemsCount <= (max + 1) {
                fetchData()
            }
        }
}
