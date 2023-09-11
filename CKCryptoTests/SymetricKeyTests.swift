//
//  SymetricKeyTests.swift
//  CKCryptoTests
//
//  Created by Krzysztof Banaczyk on 11/09/2023.
//

import XCTest
@testable import CKCrypto

class SymetricKeyTests: XCTestCase {
    
    func testAuthenticationCodeAndValidation_SHA256() {
        
        let data = "Test Data".data(using: .utf8)!
        let algorithm: CryptoManager.HashingAlgorithm = .SHA256
        let keyType: CryptoManager.SymmetricKeyType = .key256
        
        
        let result = CryptoManager.authenticationCode(data: data, algorithm: algorithm, keyType: keyType)
        
        
        XCTAssertTrue(CryptoManager.isAuthenticationCodeValid(algorithm: algorithm, authenticationCodeData: result.data, dataToAuthenticate: data, symmetricKey: result.secretKey))
    }
    
    func testAuthenticationCodeAndValidation_SHA384() {
        
        let data = "Test Data".data(using: .utf8)!
        let algorithm: CryptoManager.HashingAlgorithm = .SHA384
        let keyType: CryptoManager.SymmetricKeyType = .key256
        
        
        let result = CryptoManager.authenticationCode(data: data, algorithm: algorithm, keyType: keyType)
        
        
        XCTAssertTrue(CryptoManager.isAuthenticationCodeValid(algorithm: algorithm, authenticationCodeData: result.data, dataToAuthenticate: data, symmetricKey: result.secretKey))
    }
    
    func testAuthenticationCodeAndValidation_SHA512() {
        
        let data = "Test Data".data(using: .utf8)!
        let algorithm: CryptoManager.HashingAlgorithm = .SHA512
        let keyType: CryptoManager.SymmetricKeyType = .key256
        
        
        let result = CryptoManager.authenticationCode(data: data, algorithm: algorithm, keyType: keyType)
        
        
        XCTAssertTrue(CryptoManager.isAuthenticationCodeValid(algorithm: algorithm, authenticationCodeData: result.data, dataToAuthenticate: data, symmetricKey: result.secretKey))
    }
}


