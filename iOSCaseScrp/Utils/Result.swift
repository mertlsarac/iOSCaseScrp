//
//  Result.swift
//  iOSCase
//
//  Created by Mert Saraç on 18.09.2021.
//

import Foundation

enum Result<Success, Failure> where Success: FetchResponse, Failure: FetchError {
    case success(Success)
    case failure(Failure)
}
