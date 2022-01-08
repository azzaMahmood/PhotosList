//
//  PhotosListModel.swift
//  PhotosList
//
//  Created by Azza on 08/01/2022.
//

import Foundation

// MARK: - Photo
struct Photo: Codable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}

typealias Photos = [Photo]
