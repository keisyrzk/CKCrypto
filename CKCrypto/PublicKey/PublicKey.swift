//
//  PublicKey.swift
//  CKCrypto
//
//  Created by Krzysztof Banaczyk on 11/09/2023.
//

import CryptoKit

extension CryptoManager {
    
    // MARK: Public key
    
    /**
     The section handles public-key operations such as signing data and verifying signatures.
     */
    
    /**
     `Example`, your app might need to authenticate an operation with your back-end server. On the user’s device, it creates a private key, which it stores in Keychain or SecureEnclave, then registers the corresponding public key on the server. When your user sets up the operation, your app signs the operation’s details with the user’s private key and sends the signed details to the server, which verifies it with the user’s public key.
     
     */
    
    /// Signs the given data using the specified key type.
    ///
    /// This function provides a public interface for signing data. It's essentially
    /// a convenience method that wraps around the more detailed `signData` function.
    ///
    /// - Parameters:
    ///   - data: The data to be signed.
    ///   - signingKeyType: The type of signing key to be used.
    ///
    /// - Returns: A tuple containing the generated signature and the corresponding public key.
    public static func sign(data: Data, with signingKeyType: SigningKeyType) -> (signature: Data?, publicKey: Data) {
        return CryptoManager.signData(data: data, with: signingKeyType)
    }
    
    /// Verifies whether the provided signature  is valid for the given data (digestData) using the provided public key.
    ///
    /// - Parameters:
    ///   - publicKey: The public key to use for verifying the signature.
    ///   - signature: The signature to be verified.
    ///   - digestData: The original data or its hash/digest.
    ///   - signingKeyType: The type of signing key used.
    ///
    /// - Returns: `true` if the signature is valid; `false` otherwise.
    public static func isSigningVerified(publicKey: Data, signature: Data, digestData: Data, signingKeyType: SigningKeyType) -> Bool {
        switch signingKeyType {
        case .Curve25519(let algorithm):
            guard let publicKeyValue = try? Curve25519.Signing.PublicKey(rawRepresentation: publicKey) else { return false }
            
            // Ensure the data is hashed with the specified algorithm before verifying the signature
            let hashedData: Data
            switch algorithm {
            case .SHA256:
                hashedData = Data(SHA256.hash(data: digestData))
            case .SHA384:
                hashedData = Data(SHA384.hash(data: digestData))
            case .SHA512:
                hashedData = Data(SHA512.hash(data: digestData))
            }
            
            return publicKeyValue.isValidSignature(signature, for: hashedData)
            
        case .P256:
            guard let publicKeyValue = try? P256.Signing.PublicKey(rawRepresentation: publicKey) else { return false }
            guard let signatureValue = try? P256.Signing.ECDSASignature(rawRepresentation: signature) else { return false }
            return publicKeyValue.isValidSignature(signatureValue, for: digestData)
            
        case .P384:
            guard let publicKeyValue = try? P384.Signing.PublicKey(rawRepresentation: publicKey) else { return false }
            guard let signatureValue = try? P384.Signing.ECDSASignature(rawRepresentation: signature) else { return false }
            return publicKeyValue.isValidSignature(signatureValue, for: digestData)
            
        case .P521:
            guard let publicKeyValue = try? P521.Signing.PublicKey(rawRepresentation: publicKey) else { return false }
            guard let signatureValue = try? P521.Signing.ECDSASignature(rawRepresentation: signature) else { return false }
            return publicKeyValue.isValidSignature(signatureValue, for: digestData)
        }
    }
    
    
    
    /// Verifies if the provided signature (signature) is valid for the given data (digestData) using the specified public key.
    ///
    /// The method supports various signing key types. It takes in a public key, the signature, the original data (or its hash/digest),
    /// and the type of key to verify the signature's authenticity.
    ///
    /// - Parameters:
    ///   - publicKey: The public key to use for verifying the signature.
    ///   - signature: The signature to be verified.
    ///   - digestData: The original data or its hash/digest.
    ///   - signingKeyType: The type of signing key used.
    ///
    /// - Returns: `true` if the signature is valid; `false` otherwise.
    public static func isSigningValid(publicKey: Data, signature: Data, digestData: Data, signingKeyType: SigningKeyType) -> Bool {
        
        switch signingKeyType {
        case .Curve25519(let algorithm):
            guard let publicKeyValue = try? Curve25519.Signing.PublicKey(rawRepresentation: publicKey) else { return false }
            
            // Ensure the data is hashed with the specified algorithm before verifying the signature
            let hashedData: Data
            switch algorithm {
            case .SHA256:
                hashedData = Data(SHA256.hash(data: digestData))
            case .SHA384:
                hashedData = Data(SHA384.hash(data: digestData))
            case .SHA512:
                hashedData = Data(SHA512.hash(data: digestData))
            }
            
            return publicKeyValue.isValidSignature(signature, for: hashedData)
            
        case .P256:
            guard let publicKeyValue = try? P256.Signing.PublicKey(rawRepresentation: publicKey) else { return false }
            guard let signatureValue = try? P256.Signing.ECDSASignature(rawRepresentation: signature) else { return false }
            return publicKeyValue.isValidSignature(signatureValue, for: digestData)
            
        case .P384:
            guard let publicKeyValue = try? P384.Signing.PublicKey(rawRepresentation: publicKey) else { return false }
            guard let signatureValue = try? P384.Signing.ECDSASignature(rawRepresentation: signature) else { return false }
            return publicKeyValue.isValidSignature(signatureValue, for: digestData)
            
        case .P521:
            guard let publicKeyValue = try? P521.Signing.PublicKey(rawRepresentation: publicKey) else { return false }
            guard let signatureValue = try? P521.Signing.ECDSASignature(rawRepresentation: signature) else { return false }
            return publicKeyValue.isValidSignature(signatureValue, for: digestData)
        }
    }
    
}
