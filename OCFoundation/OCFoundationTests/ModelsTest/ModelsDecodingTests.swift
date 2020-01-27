//
//  ModelsDecodingTests.swift
//  OCFoundationTests
//
//  Created by Vlad Z. on 1/27/20.
//  Copyright © 2020 Vlad Z. All rights reserved.
//

@testable import OCFoundation
import Nimble
import Quick

class EntitiesDecodingTests: QuickSpec {
    func canDecode<T: Decodable>(_ type: T.Type, decoder: JSONDecoder = JSONDecoder()) -> (Data) throws -> T {
        return { try decoder.decode(T.self, from: $0) }
    }
    
    override func spec() {
        describe("a bundle") {
            let bundle = Bundle(for: EntitiesDecodingTests.self)
            let resources: [(String, (Data) throws -> Any)] = [
                ("matches", canDecode(MatchesPage.self))
            ]
            
            for (resource, canDecode) in resources {
                describe("from \(resource) json") {
                    let path = bundle.path(forResource: resource, ofType: "json")!
                    let data = try! Data(contentsOf: URL(fileURLWithPath: path))
                    
                    it("can decode to object") {
                        expect { try canDecode(data) }.notTo(throwError())
                    }
                }
            }
        }
    }
}
