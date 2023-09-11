//
//  PublicKeyTests.swift
//  CKCryptoTests
//
//  Created by Krzysztof Banaczyk on 11/09/2023.
//

import XCTest
import CryptoKit

@testable import CKCrypto

class PublicKeyTests: XCTestCase {
    
    let testData = "This is a test string".data(using: .utf8)!

    func testIsSigningValid() {
        for type in CryptoManager.SigningKeyType.allCases {
            let result = CryptoManager.sign(data: testData, with: type)
            guard let signature = result.signature else {
                XCTFail("Signature should not be nil for type \(type)")
                continue
            }
            let isValid = CryptoManager.isSigningValid(publicKey: result.publicKey, signature: signature, digestData: testData, signingKeyType: type)
            XCTAssertTrue(isValid, "Signature should be valid for type \(type)")
        }
    }

    func testIsSigningVerified() {
        for type in CryptoManager.SigningKeyType.allCases {
            
            let result = CryptoManager.sign(data: testData, with: type)
            guard let signature = result.signature else {
                XCTFail("Signature should not be nil for type \(type)")
                return
            }

            let isValid = CryptoManager.isSigningVerified(publicKey: result.publicKey, signature: signature, digestData: testData, signingKeyType: type)
            XCTAssertTrue(isValid, "Signature should be valid for type \(type)")
        }

    }
}

