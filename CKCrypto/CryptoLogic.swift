//
//  CryptoLogic.swift
//  CKCrypto
//
//  Created by Krzysztof Banaczyk on 07/09/2023.
//

import CryptoKit
import Foundation

internal extension CryptoManager {
    
    /// Generates an HMAC authentication code using the specified data, hashing algorithm, and symmetric key type.
    ///
    /// - Parameters:
    ///   - data: The input data to authenticate.
    ///   - algorithm: The hashing algorithm to use for HMAC.
    ///   - keyType: The type/size of the symmetric key to use.
    ///
    /// - Returns: A tuple containing the generated authentication code and the used symmetric key.
    static func authCode(data: Data, algorithm: HashingAlgorithm, keyType: SymmetricKeyType) -> (data: Data, secretKey: SymmetricKey) {
        
        switch algorithm {
        case .SHA256:
            switch keyType {
            case .key128:
                let secretKey = SymmetricKey(size: .bits128)
                return (Data(HMAC<SHA256>.authenticationCode(for: data, using: secretKey)), secretKey)
                
            case .key192:
                let secretKey = SymmetricKey(size: .bits192)
                return (Data(HMAC<SHA256>.authenticationCode(for: data, using: secretKey)), secretKey)
                
            case .key256:
                let secretKey = SymmetricKey(size: .bits256)
                return (Data(HMAC<SHA256>.authenticationCode(for: data, using: secretKey)), secretKey)
            }
            
        case .SHA384:
            switch keyType {
            case .key128:
                let secretKey = SymmetricKey(size: .bits128)
                return (Data(HMAC<SHA384>.authenticationCode(for: data, using: secretKey)), secretKey)
                
            case .key192:
                let secretKey = SymmetricKey(size: .bits192)
                return (Data(HMAC<SHA384>.authenticationCode(for: data, using: secretKey)), secretKey)
                
            case .key256:
                let secretKey = SymmetricKey(size: .bits256)
                return (Data(HMAC<SHA384>.authenticationCode(for: data, using: secretKey)), secretKey)
            }
            
        case .SHA512:
            switch keyType {
            case .key128:
                let secretKey = SymmetricKey(size: .bits128)
                return (Data(HMAC<SHA512>.authenticationCode(for: data, using: secretKey)), secretKey)
                
            case .key192:
                let secretKey = SymmetricKey(size: .bits192)
                return (Data(HMAC<SHA512>.authenticationCode(for: data, using: secretKey)), secretKey)
                
            case .key256:
                let secretKey = SymmetricKey(size: .bits256)
                return (Data(HMAC<SHA512>.authenticationCode(for: data, using: secretKey)), secretKey)
            }
        }
    }
    
    /// Encrypts the given data using the specified encryption algorithm and generates a new symmetric key of the given type.
    ///
    /// - Parameters:
    ///   - data: The input data to encrypt.
    ///   - encryptionType: The encryption algorithm to use.
    ///   - keyType: The type/size of the symmetric key to generate and use.
    ///
    /// - Returns: A tuple containing the encrypted data and the used symmetric key, or nil if encryption fails.
    static func createSealedBox(data: Data, encryptionType: EncryptionType, keyType: SymmetricKeyType) -> (data: Data, secretKey: SymmetricKey)? {
        
        var secretKey: SymmetricKey!
        
        switch keyType {
        case .key128:
            secretKey = SymmetricKey(size: .bits128)
            
        case .key192:
            secretKey = SymmetricKey(size: .bits192)
            
        case .key256:
            secretKey = SymmetricKey(size: .bits256)
        }
        
        switch encryptionType {
        case .ChaChaPoly:
            guard let sealedBoxData = try? ChaChaPoly.seal(data, using: secretKey).combined else { return nil }
            return (sealedBoxData, secretKey)
            
        case .AES_GCM:
            guard let sealedBoxData = try? AES.GCM.seal(data, using: secretKey).combined else { return nil }
            return (sealedBoxData, secretKey)
        }
    }
    
    /// Encrypts the given data using the specified encryption algorithm and an already available symmetric key.
    ///
    /// - Parameters:
    ///   - data: The input data to encrypt.
    ///   - encryptionType: The encryption algorithm to use.
    ///   - symmetricKey: The symmetric key to use for encryption.
    ///
    /// - Returns: A tuple containing the encrypted data and the used symmetric key, or nil if encryption fails.
    static func createSealedBox(data: Data, encryptionType: EncryptionType, symmetricKey: SymmetricKey) -> (data: Data, secretKey: SymmetricKey)? {
        
        switch encryptionType {
        case .ChaChaPoly:
            guard let sealedBoxData = try? ChaChaPoly.seal(data, using: symmetricKey).combined else { return nil }
            return (sealedBoxData, symmetricKey)
            
        case .AES_GCM:
            guard let sealedBoxData = try? AES.GCM.seal(data, using: symmetricKey).combined else { return nil }
            return (sealedBoxData, symmetricKey)
        }
    }
    
    /// Decrypts the given encrypted data using the specified encryption algorithm and a symmetric key.
    ///
    /// - Parameters:
    ///   - data: The encrypted data to decrypt.
    ///   - encryptionType: The encryption algorithm to use.
    ///   - secretKey: The symmetric key to use for decryption.
    ///
    /// - Returns: The decrypted data, or nil if decryption fails.
    static func getSealedBox(data: Data, encryptionType: EncryptionType, secretKey: SymmetricKey) -> Data? {
        
        switch encryptionType {
        case .ChaChaPoly:
            guard let sealedBox = try? ChaChaPoly.SealedBox(combined: data) else { return nil }
            guard let decryptedData = try? ChaChaPoly.open(sealedBox, using: secretKey) else { return nil }
            return decryptedData
            
        case .AES_GCM:
            guard let sealedBox = try? AES.GCM.SealedBox(combined: data) else { return nil }
            guard let decryptedData = try? AES.GCM.open(sealedBox, using: secretKey) else { return nil }
            return decryptedData
        }
    }
    
    
    /**
     This function is for creating digital signatures on data. Here's a breakdown:
     
     The function takes in some data (data) that needs to be signed and the type of key (signingKeyType) that should be used for signing.
     
     Depending on the type of key specified, the function generates a new signing key pair (both private and public keys).
     
     After generating the key pair, it hashes the input data using the algorithm specified (SHA256, SHA384, or SHA512) and creates a signature on this hashed data using the private key.
     
     The function returns the created signature and the public key corresponding to the private key used for signing. This public key can be distributed openly and used to verify the signature in the future, ensuring the data hasn't been tampered with.
     
     In practice, the signer (who possesses the private key) would use this function to sign some data. The verifier (who possesses only the public key) can then check this signature to ensure data authenticity.
     */
    
    /// Creates a digital signature on the provided data using the specified key type and returns the generated signature and corresponding public key.
    ///
    /// - Parameters:
    ///   - data: The input data to be signed.
    ///   - signingKeyType: The type of signing key to use for creating the signature.
    ///
    /// - Returns: A tuple containing the generated signature and the public key.
    static func signData(data: Data, with signingKeyType: SigningKeyType) -> (signature: Data?, publicKey: Data) {
        
        switch signingKeyType {
        case let .Curve25519(algorithm):
            let signingPrivateKey = Curve25519.Signing.PrivateKey()
            let signingPublicKeyData = signingPrivateKey.publicKey.rawRepresentation
            
            let hashedData: Data
            switch algorithm {
            case .SHA256:
                hashedData = Data(SHA256.hash(data: data))
            case .SHA384:
                hashedData = Data(SHA384.hash(data: data))
            case .SHA512:
                hashedData = Data(SHA512.hash(data: data))
            }
            
            return (signature: try? signingPrivateKey.signature(for: hashedData), publicKey: signingPublicKeyData)
            
        case .P256:
            let signingPrivateKey = P256.Signing.PrivateKey()
            let signingPublicKeyData = signingPrivateKey.publicKey.rawRepresentation
            return (signature: try? signingPrivateKey.signature(for: data).rawRepresentation, publicKey: signingPublicKeyData)
            
        case .P384:
            let signingPrivateKey = P384.Signing.PrivateKey()
            let signingPublicKeyData = signingPrivateKey.publicKey.rawRepresentation
            return (signature: try? signingPrivateKey.signature(for: data).rawRepresentation, publicKey: signingPublicKeyData)
            
        case .P521:
            let signingPrivateKey = P521.Signing.PrivateKey()
            let signingPublicKeyData = signingPrivateKey.publicKey.rawRepresentation
            return (signature: try? signingPrivateKey.signature(for: data).rawRepresentation, publicKey: signingPublicKeyData)
        }
    }
}
