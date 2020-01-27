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
        
        events.capture(case: MatchesEvents.matchSelected)
            .toRoutableObservable()
            .subscribe(onNext: { match in
                print("[DEBUG] - MatchID \(match.userId) selected")
            })
            .disposed(by: module.disposeBag)
        
        return true
    }
}

