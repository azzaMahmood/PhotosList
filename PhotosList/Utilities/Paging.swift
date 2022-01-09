//
//  Paging.swift
//  PhotosList
//
//  Created by Azza on 09/01/2022.
//

import Foundation

final class Page {

    var currentPage = 1
    var maxPages = 100
    var countPerPage = 10
    var fetchedItemsCount = 0
    var shouldLoadMore: Bool {
        (currentPage <= maxPages)
    }

}

protocol Pageable {
    func loadCells(for indexPaths: [IndexPath])
}
