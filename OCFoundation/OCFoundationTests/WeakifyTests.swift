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
    func sum(_ a: Int, _ b: Int) -> Int { a + b }
    func sum(_ a: Int, _ b: Int, _ c: Int) -> Int { a + b + c }
    func sum(_ a: Int, _ b: Int, _ c: Int, _ d: Int) -> Int { a + b + c + d }
    func sum(_ a: Int, _ b: Int, _ c: Int, _ d: Int, _ e: Int) -> Int { a + b + c + d + e }
    func sum(_ a: Int, _ b: Int, _ c: Int, _ d: Int, _ e: Int, _ f: Int) -> Int { a + b + c + d + e + f }
    func sum(_ a: Int, _ b: Int, _ c: Int, _ d: Int, _ e: Int, _ f: Int, _ g: Int) -> Int { a + b + c + d + e + f + g }
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
                
                it("should not be retained by weakify with default") {
                    let me = weakify(instance, default: MockObject()) { $0 }
                    expect(me()).toNot(beNil())
                    expect(_getRetainCount(instance)).to(equal(2)) // _getRetainCount retains
                }
                
                it("should return default when released") {
                    let def = MockObject()
                    let me = weakify(instance, default: def) { $0 }
                    autoreleasepool { instance = nil }
                    XCTAssert(me() === def)
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
            
            context("having an array of tuples2") {
                let tuples = nums.map { ($0, $0) }
                
                context("and a nillable transform") {
                    var transform: ((Int, Int) -> Int?)!
                    beforeEach {
                        transform = weakify(instance) { $0.sum($1, $2) }
                    }
                    
                    it("should map values") {
                        let result = tuples.compactMap(transform)
                        expect(result).to(equal(Array(0 ..< 10).map { $0 * 2 }))
                    }
                    
                    it("should fail mapping on release") {
                        autoreleasepool { instance = nil }
                        expect(tuples.compactMap(transform)).to(equal([]))
                    }
                }
                
                context("and a defaulting transform") {
                    var transform: ((Int, Int) -> Int)!
                    beforeEach {
                        transform = weakify(instance, default: -1) { $0.sum($1, $2) }
                    }
                    
                    it("should map 1 value") {
                        let result = tuples.map(transform)
                        expect(result).to(equal(Array(0 ..< 10).map { $0 * 2 }))
                    }
                    
                    it("should default on release ") {
                        autoreleasepool { instance = nil }
                        expect(tuples.map(transform)).to(equal(nums.map { _ in -1 }))
                    }
                }
            }
            
            context("having an array of tuples3") {
                let tuples = nums.map { ($0, $0, $0) }
                context("and a nillable transform") {
                    var transform: ((Int, Int, Int) -> Int?)!
                    beforeEach {
                        transform = weakify(instance) { $0.sum($1, $2, $3) }
                    }
                    
                    it("should map values") {
                        let result = tuples.compactMap(transform)
                        expect(result).to(equal(Array(0 ..< 10).map { $0 * 3 }))
                    }
                    
                    it("should fail mapping on release") {
                        autoreleasepool { instance = nil }
                        expect(tuples.compactMap(transform)).to(equal([]))
                    }
                }
                
                context("and a defaulting transform") {
                    var transform: ((Int, Int, Int) -> Int)!
                    beforeEach {
                        transform = weakify(instance, default: -1) { $0.sum($1, $2, $3) }
                    }
                    
                    it("should map 1 value") {
                        let result = tuples.map(transform)
                        expect(result).to(equal(Array(0 ..< 10).map { $0 * 3 }))
                    }
                    
                    it("should default on release ") {
                        autoreleasepool { instance = nil }
                        expect(tuples.map(transform)).to(equal(nums.map { _ in -1 }))
                    }
                }
            }
            
            context("having an array of tuples4") {
                let tuples = nums.map { ($0, $0, $0, $0) }
                context("and a nillable transform") {
                    var transform: ((Int, Int, Int, Int) -> Int?)!
                    beforeEach {
                        transform = weakify(instance) { $0.sum($1, $2, $3, $4) }
                    }
                    
                    it("should map values") {
                        let result = tuples.compactMap(transform)
                        expect(result).to(equal(Array(0 ..< 10).map { $0 * 4 }))
                    }
                    
                    it("should fail mapping on release") {
                        autoreleasepool { instance = nil }
                        expect(tuples.compactMap(transform)).to(equal([]))
                    }
                }
                
                context("and a defaulting transform") {
                    var transform: ((Int, Int, Int, Int) -> Int)!
                    beforeEach {
                        transform = weakify(instance, default: -1) { $0.sum($1, $2, $3, $4) }
                    }
                    
                    it("should map 1 value") {
                        let result = tuples.map(transform)
                        expect(result).to(equal(Array(0 ..< 10).map { $0 * 4 }))
                    }
                    
                    it("should default on release ") {
                        autoreleasepool { instance = nil }
                        expect(tuples.map(transform)).to(equal(nums.map { _ in -1 }))
                    }
                }
            }
            
            context("having an array of tuples5") {
                let tuples = nums.map { ($0, $0, $0, $0, $0) }
                context("and a nillable transform") {
                    var transform: ((Int, Int, Int, Int, Int) -> Int?)!
                    beforeEach {
                        transform = weakify(instance) { $0.sum($1, $2, $3, $4, $5) }
                    }
                    
                    it("should map values") {
                        let result = tuples.compactMap(transform)
                        expect(result).to(equal(Array(0 ..< 10).map { $0 * 5 }))
                    }
                    
                    it("should fail mapping on release") {
                        autoreleasepool { instance = nil }
                        expect(tuples.compactMap(transform)).to(equal([]))
                    }
                }
                
                context("and a defaulting transform") {
                    var transform: ((Int, Int, Int, Int, Int) -> Int)!
                    beforeEach {
                        transform = weakify(instance, default: -1) { $0.sum($1, $2, $3, $4, $5) }
                    }
                    
                    it("should map 1 value") {
                        let result = tuples.map(transform)
                        expect(result).to(equal(Array(0 ..< 10).map { $0 * 5 }))
                    }
                    
                    it("should default on release ") {
                        autoreleasepool { instance = nil }
                        expect(tuples.map(transform)).to(equal(nums.map { _ in -1 }))
                    }
                }
            }
            
            context("having an array of tuples6") {
                let tuples = nums.map { ($0, $0, $0, $0, $0, $0) }
                context("and a nillable transform") {
                    var transform: ((Int, Int, Int, Int, Int, Int) -> Int?)!
                    beforeEach {
                        transform = weakify(instance) { $0.sum($1, $2, $3, $4, $5, $6) }
                    }
                    
                    it("should map values") {
                        let result = tuples.compactMap(transform)
                        expect(result).to(equal(Array(0 ..< 10).map { $0 * 6 }))
                    }
                    
                    it("should fail mapping on release") {
                        autoreleasepool { instance = nil }
                        expect(tuples.compactMap(transform)).to(equal([]))
                    }
                }
                
                context("and a defaulting transform") {
                    var transform: ((Int, Int, Int, Int, Int, Int) -> Int)!
                    beforeEach {
                        transform = weakify(instance, default: -1) { $0.sum($1, $2, $3, $4, $5, $6) }
                    }
                    
                    it("should map 1 value") {
                        let result = tuples.map(transform)
                        expect(result).to(equal(Array(0 ..< 10).map { $0 * 6 }))
                    }
                    
                    it("should default on release ") {
                        autoreleasepool { instance = nil }
                        expect(tuples.map(transform)).to(equal(nums.map { _ in -1 }))
                    }
                }
            }
            
            context("having an array of tuples7") {
                let tuples = nums.map { ($0, $0, $0, $0, $0, $0, $0) }
                context("and a nillable transform") {
                    var transform: ((Int, Int, Int, Int, Int, Int, Int) -> Int?)!
                    beforeEach {
                        transform = weakify(instance) { $0.sum($1, $2, $3, $4, $5, $6, $7) }
                    }
                    
                    it("should map values") {
                        let result = tuples.compactMap(transform)
                        expect(result).to(equal(Array(0 ..< 10).map { $0 * 7 }))
                    }
                    
                    it("should fail mapping on release") {
                        autoreleasepool { instance = nil }
                        expect(tuples.compactMap(transform)).to(equal([]))
                    }
                }
                
                context("and a defaulting transform") {
                    var transform: ((Int, Int, Int, Int, Int, Int, Int) -> Int)!
                    beforeEach {
                        transform = weakify(instance, default: -1) { $0.sum($1, $2, $3, $4, $5, $6, $7) }
                    }
                    
                    it("should map 1 value") {
                        let result = tuples.map(transform)
                        expect(result).to(equal(Array(0 ..< 10).map { $0 * 7 }))
                    }
                    
                    it("should default on release ") {
                        autoreleasepool { instance = nil }
                        expect(tuples.map(transform)).to(equal(nums.map { _ in -1 }))
                    }
                }
            }
        }
    }
}

