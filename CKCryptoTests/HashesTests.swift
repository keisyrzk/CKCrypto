//
//  HashesTests.swift
//  CKCryptoTests
//
//  Created by Krzysztof Banaczyk on 11/09/2023.
//

import XCTest
@testable import CKCrypto

class HashesTests: XCTestCase {
    
    // MARK: SHA256 Tests

    func testHash256WithData() {
        let data = "Hello World".data(using: .utf8)!
        let hash = CryptoManager.hash256(value: data)
        XCTAssertNotNil(hash, "Hash should not be nil for valid data input.")
    }

    func testHash256WithString() {
        let value = "Hello World"
        let hash = CryptoManager.hash256(value: value)
        XCTAssertNotNil(hash, "Hash should not be nil for valid string input.")
    }

    // MARK: SHA384 Tests

    func testHash384WithData() {
        let data = "Hello World".data(using: .utf8)!
        let hash = CryptoManager.hash384(value: data)
        XCTAssertNotNil(hash, "Hash should not be nil for valid data input.")
    }

    func testHash384WithString() {
        let value = "Hello World"
        let hash = CryptoManager.hash384(value: value)
        XCTAssertNotNil(hash, "Hash should not be nil for valid string input.")
    }

    // MARK: SHA512 Tests

    func testHash512WithData() {
        let data = "Hello World".data(using: .utf8)!
        let hash = CryptoManager.hash512(value: data)
        XCTAssertNotNil(hash, "Hash should not be nil for valid data input.")
    }

    func testHash512WithString() {
        let value = "Hello World"
        let hash = CryptoManager.hash512(value: value)
        XCTAssertNotNil(hash, "Hash should not be nil for valid string input.")
    }
}


