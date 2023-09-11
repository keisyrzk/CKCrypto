//
//  EncryptionKeyAgreementTests.swift
//  CKCryptoTests
//
//  Created by Krzysztof Banaczyk on 11/09/2023.
//

import XCTest
import CryptoKit
@testable import CKCrypto

final class EncryptionKeyAgreementTests: XCTestCase {
    
    func testCreateSymmetricKey() {
        // Generate a client's private and public key to mimic a client's provided public key.
        let clientPrivateKey = Curve25519.KeyAgreement.PrivateKey()
        let clientPublicKeyData = clientPrivateKey.publicKey.rawRepresentation
        
        // Arbitrary salt for key derivation.
        let salt = "SomeSalt".data(using: .utf8)!
        
        // Create symmetric key using the client's public key data.
        let result = CryptoManager.createSymmetricKey(algorithm: .SHA256, salt: salt, clientPublicKeyData: clientPublicKeyData)
        
        // Validate the results.
        XCTAssertNotNil(result.appPublicKeyData)
        XCTAssertNotNil(result.symmetricKey)
        
        // Normally, to fully verify the correctness of the shared secret key, you would perform a key agreement on both sides (app and client) and ensure they derive the same symmetric key. However, that would require a reverse process for the client (using the app's public key to derive the symmetric key), which isn't provided here.
    }
}
