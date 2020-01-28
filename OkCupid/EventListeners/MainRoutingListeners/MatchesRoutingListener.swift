//
//  MatchesRoutingListener.swift
//  OkCupid
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

import MERLin

class MatchesRoutingListener: ModuleEventsListener {
    var router: Router
    init(_ router: Router) {
        self.router = router
    }
    
    func listenEvents(from module: AnyEventsProducerModule,
                      events: Observable<MatchesEvents>) -> Bool {
        events.capture(case: MatchesEvents.matchIdSelected)
            .toRoutableObservable()
            .subscribe(onNext: { matchId in
                /// In the future it should call separate module that's going to be responsible for fetching match with provided id and presenting details
                print("[DEBUG] - MatchID \(matchId) selected")
            })
            .disposed(by: module.disposeBag)
        
        return true
    }
}

