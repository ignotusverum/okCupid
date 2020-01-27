//
//  PhotoProtocol.swift
//  OCFoundation
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

public enum PhotoType: String {
    case large
    case medium
    case original
    case small
    case undefined
}

public protocol PhotoProtocol {
    var type: PhotoType { get }
    var path: String { get }
}

public protocol PhotoContainerProtocol {
    var photos: [Photo] { get }
}
