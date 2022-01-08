//
//  NetworkFailure.swift
//  PhotosList
//
//  Created by Azza on 08/01/2022.
//

import Foundation

enum NetworkFailure: LocalizedError {
    case generalFailure, failedToParseData, connectionFailed
    var errorDescription: String? {
        switch self {
        case .failedToParseData:
            return "Technical Difficulties, we can't fetch the data"
        default:
            return "Check your connectivity"
        }
    }
}
