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
    
    override func spec() {
        describe("Having a matchesViewModel") {
            var viewModel: MatchesViewModelProtocol!

            var scheduler: TestScheduler!

            beforeEach {
                scheduler = TestScheduler(initialClock: 0,
                                          simulateProcessingDelay: false)
            }

            context("with a model that returns empty matches") {
                let model = MockMatchesModel(.empty)

                beforeEach {
                    viewModel = MatchesViewModel(model: model, events: PublishSubject())
                }

                it("should transform to no pages") {
                    expect(self.testObservable(for: viewModel,
                                               input: [],
                                               scheduler: scheduler).events).to(equal([
                        .next(0, .loading(whileInState: nil)),
                        .next(0, .pages([]))
                    ]))
                }
            }

            context("with a model that returns a pages with matches") {
                var model: MockMatchesModel!

                beforeEach {
                    model = MockMatchesModel(.pages)
                    viewModel = MatchesViewModel(model: model,
                                                 events: PublishSubject())
                }

                it("should transform to pages") {
                    expect(self.testObservable(for: viewModel, input: [], scheduler: scheduler).events).to(equal([
                        .next(0, .loading(whileInState: nil)),
                        .next(0, .pages(model.pages.items
                            .map(MatchesRow.init)
                        ))
                    ]))
                }
            }
        }
    }
}
