//
//  WeakifyTests.swift
//  OCFoundationTests
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

@testable import OCFoundation
import Nimble
import Quick

private class MockObject {
    func incrementBy1(_ val: Int) -> Int { val + 1 }
}

class WeakifyTests: QuickSpec {
    override func spec() {
        describe("Having an object") {
            var instance: MockObject!
            let nums = Array(0 ..< 10)
            
            beforeEach {
                instance = MockObject()
            }
            
            context("for void inputs") {
                it("should not be retained by weakify") {
                    let me = weakify(instance) { $0 }
                    expect(me()).toNot(beNil())
                    expect(_getRetainCount(instance)).to(equal(2)) // _getRetainCount retains
                }
                
                it("should return nil when released") {
                    let me = weakify(instance) { $0 }
                    autoreleasepool { instance = nil }
                    expect(me()).to(beNil())
                }
            }
            
            context("for 1 input") {
                context("and a nillable transform") {
                    var transform: ((Int) -> Int?)!
                    beforeEach {
                        transform = weakify(instance) { $0.incrementBy1($1) }
                    }
                    
                    it("should map 1 value") {
                        let result = nums.compactMap(transform)
                        expect(result).to(equal(Array(1 ..< 11)))
                    }
                    
                    it("should fail mapping on release ") {
                        autoreleasepool { instance = nil }
                        expect(nums.compactMap(transform)).to(equal([]))
                    }
                }
                
                context("and a defaulting transform") {
                    var transform: ((Int) -> Int)!
                    beforeEach {
                        transform = weakify(instance, default: -1) { $0.incrementBy1($1) }
                    }
                    
                    it("should map 1 value") {
                        let result = nums.map(transform)
                        expect(result).to(equal(Array(1 ..< 11)))
                    }
                    
                    it("should default on release ") {
                        autoreleasepool { instance = nil }
                        expect(nums.map(transform)).to(equal(nums.map { _ in -1 }))
                    }
                }
            }
        }
    }
}

