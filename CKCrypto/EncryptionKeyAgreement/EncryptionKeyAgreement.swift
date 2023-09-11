//
//  EncryptionKeyAgreement.swift
//  CKCrypto
//
//  Created by Krzysztof Banaczyk on 07/09/2023.
//

import CryptoKit

extension CryptoManager {
    
    // MARK: Encryption key agreement
    
    /**
        `salt` - it can be sent over the network to let the server and the app to have the same `salt` value
                `Example:` let salt = "this_is_sample_salt_string".data(using: .utf8)!
     
        `sharedSecret` - a value create
     
        `clientPublicKeyData` - the public key of the client that might be the server
     
     
        `INFO`
                
            1) The app has to generate its `private key` and `public key`
            2) The client (ex. server) has to generate its `private key` and `public key`
            3) The app and the client must have the same salt data
            4) The app must have the client's public key data
            5) The server must have the app's public key data
            6) The client creates app's public key from its raw representation, then combines it with client's private key to calculate first the sharedSecret and then the symmetricKey (the app does the same)
            7) May use the encryption function now
                func encrypt(data: Data, encryptionType: EncryptionType, symmetricKey: SymmetricKey)
     
     */
    /**
        `Example:`
     
        // input `myData` and the `salt` that is already the same on the client's side
        `let myData = "sample data to encode".data(using: .utf8)!`
        `let salt = "abracadabra hocus pocus".data(using: .utf8)!`

        // create clients's private & public keys
        `let clientPrivateKey = Curve25519.KeyAgreement.PrivateKey()`
        `let clientPublicKeyData = clientPrivateKey.publicKey.rawRepresentation`

        // create symmetric key sharef with the client (the same key for app and the client)
        `let sharedSymmetricKeyData = CryptoManager.createSymmetricKey(algorithm: .SHA256, salt: salt, clientPublicKeyData: clientPublicKeyData)`

        // encyrpt input `myData` data with the shared symmetric key
        `let encryptionResult = CryptoManager.encrypt(data: myData, encryptionType: .ChaChaPoly, symmetricKey: sharedSymmetricKeyData.symmetricKey)`
        `let encryptionResult_data = encryptionResult?.data`
        `let encryptionResult_symmetricKey = encryptionResult?.secretKey`

        // (...) the encrypted data are being sent to the client, the client sends back some data encypted the same way

        // decrypt the data received using the shared symmetric key
        `let decryptionResult = CryptoManager.decrypt(data: encryptionResult_data!, encryptionType: .ChaChaPoly, secretKey: sharedSymmetricKeyData.symmetricKey)`

        // and finally read the decrypted data
        `let value = String(data: decryptionResult!, encoding: .utf8)    // "sample data to encode"`
     */
    
    /// Creates a symmetric key using a given hashing algorithm, a shared secret value, and a salt.
    ///
    /// This function establishes a key agreement between the app and a client (e.g., a server). It uses the Curve25519 key agreement protocol to derive a shared secret. The derived symmetric key can be used for both encryption and decryption, assuming both parties follow the protocol correctly.
    ///
    /// - Parameters:
    ///   - algorithm: The hashing algorithm to use for key derivation (e.g., .SHA256, .SHA384, .SHA512).
    ///   - salt: A data value that can be openly shared between the app and the client to ensure both derive the same symmetric key.
    ///   - clientPublicKeyData: The raw representation of the client's public key.
    ///
    /// - Returns: A tuple containing the raw representation of the app's public key and the derived symmetric key.
    public static func createSymmetricKey(algorithm: HashingAlgorithm, salt: Data, clientPublicKeyData: Data, outputByteCount: Int = 32) -> (appPublicKeyData: Data, symmetricKey: SymmetricKey) {
        
        var appPublicKeyData: Data!
        
        // create app's private & public keys
        
        let appPrivateKey = Curve25519.KeyAgreement.PrivateKey()
        appPublicKeyData = appPrivateKey.publicKey.rawRepresentation
        
        // create a symmetric key with a shared secret value
        
        let clientPublicKey = try! Curve25519.KeyAgreement.PublicKey(rawRepresentation: clientPublicKeyData)
        let appSharedSecret = try! appPrivateKey.sharedSecretFromKeyAgreement(with: clientPublicKey)
        
        switch algorithm {
        case .SHA256:
            return (appPublicKeyData, appSharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self, salt: salt, sharedInfo: Data(), outputByteCount: outputByteCount))
        case .SHA384:
            return (appPublicKeyData, appSharedSecret.hkdfDerivedSymmetricKey(using: SHA384.self, salt: salt, sharedInfo: Data(), outputByteCount: outputByteCount))
        case .SHA512:
            return (appPublicKeyData, appSharedSecret.hkdfDerivedSymmetricKey(using: SHA512.self, salt: salt, sharedInfo: Data(), outputByteCount: outputByteCount))
        }
    }
}
