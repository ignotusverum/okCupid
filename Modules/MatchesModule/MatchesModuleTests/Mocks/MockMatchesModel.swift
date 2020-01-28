//
//  MockMatchesModel.swift
//  MatchesModuleTests
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

@testable import MatchesModule
import OCFoundation
import RxSwift

enum ExpectedMatchesPageType: String {
    case pages
    case empty = "pages_empty"
}

class MockMatchesModel: MatchesModelProtocol {
    
    let expectedPageType: ExpectedMatchesPageType
    var pages: MatchesPage
    init(_ pageType: ExpectedMatchesPageType) {
        expectedPageType = pageType
        
        let bundle = Bundle(for: MockMatchesModel.self)
        let path = bundle.path(forResource: pageType.rawValue, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        
        pages = try! JSONDecoder().decode(MatchesPage.self, from: data)
    }
    
    func fetchMatches() -> Single<MatchesPage> {
        return .just(pages)
    }
}
