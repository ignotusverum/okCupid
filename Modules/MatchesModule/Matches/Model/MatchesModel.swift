//
//  MatchesModel.swift
//  MatchesModule
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

import RxSwift
import OCFoundation

protocol MatchesModelProtocol {
    func fetchMatches()-> Single<MatchesPage>
}

class MatchesModel: MatchesModelProtocol {
    func fetchMatches()-> Single<MatchesPage> {
        MatchesAdapter.fetch()
    }
}
