//
//  PhotosListTests.swift
//  PhotosListTests
//
//  Created by Azza on 09/01/2022.
//

import XCTest
@testable import PhotosList
import RxSwift
import RxCocoa

class PhotosListTests: XCTestCase {
    
    var viewModel: PhotosListViewModel!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        viewModel = PhotosListViewModel(photoListApi: MockPhotoListApi.shared)
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        disposeBag = nil
    }

    func testLoadDataOnline() {
        viewModel.fetchData()
        let expectation = expectation(description: "Wait for loading photos")
        viewModel.photosListSubject.subscribe(onNext: { photos in
            expectation.fulfill()
            XCTAssertEqual(photos.count, 10, "Photos count should equal 10" )
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5) { (error) in
            if error != nil {
                XCTFail("Expectation not fulfilled")
            }
        }
    }
}
