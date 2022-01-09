//
//  TestHelper.swift
//  PhotosListTests
//
//  Created by Azza on 09/01/2022.
//

import XCTest

class TestHelper {
    /**
     get data from static jsons
     - Parameter name: file name
     - Parameter extension: file extension
     */
    func loadStubDataFromBundle(name: String, extension: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: name, withExtension: `extension`)
        return try? Data(contentsOf: url!)
    }
}
