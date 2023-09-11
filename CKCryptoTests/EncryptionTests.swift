//
//  EncryptionTests.swift
//  CKCryptoTests
//
//  Created by Krzysztof Banaczyk on 11/09/2023.
//

import XCTest
import CryptoKit
@testable import CKCrypto

class EncryptionTests: XCTestCase {
    
    let testData = "This is a test string".data(using: .utf8)!
    
    func testAuthCode() {
        let authCodeResult = CryptoManager.authCode(data: testData, algorithm: .SHA256, keyType: .key256)
        XCTAssertNotNil(authCodeResult.data)
        // Further tests can include verifying the HMAC using the secretKey
    }
    
    func testCreateSealedBoxAndDecryption() {
        let sealedBoxResult = CryptoManager.createSealedBox(data: testData, encryptionType: .AES_GCM, keyType: .key256)
        XCTAssertNotNil(sealedBoxResult)
        
        let decryptedData = CryptoManager.getSealedBox(data: sealedBoxResult!.data, encryptionType: .AES_GCM, secretKey: sealedBoxResult!.secretKey)
        XCTAssertNotNil(decryptedData)
        XCTAssertEqual(decryptedData, testData)
    }
    
    func testCreateSealedBoxWithKeyAndDecryption() {
        let sealedBoxWithKeyResult = CryptoManager.createSealedBox(data: testData, encryptionType: .AES_GCM, symmetricKey: SymmetricKey(size: .bits256))
        XCTAssertNotNil(sealedBoxWithKeyResult)
        
        let decryptedData = CryptoManager.getSealedBox(data: sealedBoxWithKeyResult!.data, encryptionType: .AES_GCM, secretKey: sealedBoxWithKeyResult!.secretKey)
        XCTAssertNotNil(decryptedData)
        XCTAssertEqual(decryptedData, testData)
    }
    
    func testSignData() {
        let signatureResult = CryptoManager.signData(data: testData, with: .P256)
        XCTAssertNotNil(signatureResult.signature)
        XCTAssertNotNil(signatureResult.publicKey)
        
        // Normally, you would also verify the signature using the public key to ensure data authenticity.
    }
}
                                                                                                                            
