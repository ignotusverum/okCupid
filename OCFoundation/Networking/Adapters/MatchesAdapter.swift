//
//  MatchesAdapter.swift
//  OCFoundation
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

import Foundation

import RxSwift

public protocol MatchesNetworkingProtocol where Self: NetworkingAdapter {
    static func fetch()-> Single<[MatchesPage]>
}

public class MatchesAdapter: NetworkingAdapter {
    public var settings: AdapterConfig!
    private static var adapter: MatchesAdapter!
    
    @discardableResult
    public init(config: AdapterConfig) {
        settings = config
        MatchesAdapter.adapter = self
    }
}

extension MatchesAdapter: MatchesNetworkingProtocol {
    public static func fetch() -> Single<[MatchesPage]> {
        let config = Requests
            .fetch
            .configure
        
        return adapter
            .request(config)
            .decode()
    }
}

private extension MatchesAdapter {
    enum Requests: FrameAPIRequest {
        case fetch
        
        public var configure: RequestConfig {
            switch self {
            case .fetch:
                return RequestConfig(method: .get)
            }
        }
    }
}

