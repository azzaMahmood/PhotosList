//
//  PhotoDetailsViewModel.swift
//  PhotosList
//
//  Created by Azza on 09/01/2022.
//

import Foundation

struct PhotoDetailsViewInfo {
    let authorName: String
    let photoImageURL: URL?
}

class PhotoDetailsViewModel {
    
    private var photoDetailsViewInfo: PhotoDetailsViewInfo!
    
    init(photoDetailsViewInfo: PhotoDetailsViewInfo) {
        self.photoDetailsViewInfo = photoDetailsViewInfo
    }
    
    func getAuthorName() -> String {
        return photoDetailsViewInfo.authorName
    }
    
    func getPhotoDownloadURL() -> URL? {
        return photoDetailsViewInfo.photoImageURL
    }
}
