//
//  MatchesViewModelTests.swift
//  MatchesModuleTests
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

@testable import MatchesModule
import Nimble
import Quick
import RxTest
import RxSwift

class MatchesViewModelTests: QuickSpec {
    let disposeBag = DisposeBag()
    
    func testObservable(for viewModel: MatchesViewModelProtocol,
                        input: [Recorded<Event<MatchesUIAction>>], scheduler: TestScheduler) -> TestableObserver<MatchesState> {
        let observable = scheduler.createObserver(MatchesState.self)
        let output = viewModel.transform(input: scheduler.createColdObservable(input).asObservable(), scheduler: scheduler).publish()
        
        output
            .subscribe(observable)
            .disposed(by: disposeBag)
        
        output.connect()
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        return observable
    }
}
