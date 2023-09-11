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
    public static func sign(data: Data, with signingKeyType: SigningKeyType) -> (privateKey: Data?, publicKey: Data) {
        return CryptoManager.signData(data: data, with: signingKeyType)
    }

    /// Verifies whether the provided signature (privateKey) is valid for the given data (digestData) using the provided public key.
    ///
    /// - Parameters:
    ///   - publicKey: The public key to use for verifying the signature.
    ///   - privateKey: The signature to be verified.
    ///   - digestData: The original data or its hash/digest.
    ///   - signingKeyType: The type of signing key used.
    ///
    /// - Returns: `true` if the signature is valid; `false` otherwise.
    public static func isSigningVerified(publicKey: Data, privateKey: Data, digestData: Data, signingKeyType: SigningKeyType) -> Bool {

        guard let publicKeyValue = try? Curve25519.Signing.PublicKey(rawRepresentation: publicKey) else { return false }
        return publicKeyValue.isValidSignature(privateKey, for: digestData)
    }
    
    /// Verifies if the provided signature (privateKey) is valid for the given data (digestData) using the specified public key.
    ///
    /// The method supports various signing key types. It takes in a public key, the signature, the original data (or its hash/digest),
    /// and the type of key to verify the signature's authenticity.
    ///
    /// - Parameters:
    ///   - publicKey: The public key to use for verifying the signature.
    ///   - privateKey: The signature to be verified.
    ///   - digestData: The original data or its hash/digest.
    ///   - signingKeyType: The type of signing key used.
    ///
    /// - Returns: `true` if the signature is valid; `false` otherwise.
    public static func isSigningValid(publicKey: Data, privateKey: Data, digestData: Data, signingKeyType: SigningKeyType) -> Bool {
        
        switch signingKeyType {
        case .Curve25519:
            guard let publicKeyValue = try? Curve25519.Signing.PublicKey(rawRepresentation: publicKey) else { return false }
            return publicKeyValue.isValidSignature(privateKey, for: digestData)
            
        case .P256:
            guard let publicKeyValue = try? P256.Signing.PublicKey(rawRepresentation: publicKey) else { return false }
            guard let signature = try? P256.Signing.ECDSASignature(rawRepresentation: privateKey) else { return false }
            return publicKeyValue.isValidSignature(signature, for: digestData)
            
        case .P384:
            guard let publicKeyValue = try? P384.Signing.PublicKey(rawRepresentation: publicKey) else { return false }
            guard let signature = try? P384.Signing.ECDSASignature(rawRepresentation: privateKey) else { return false }
            return publicKeyValue.isValidSignature(signature, for: digestData)
            
        case .P521:
            guard let publicKeyValue = try? P521.Signing.PublicKey(rawRepresentation: publicKey) else { return false }
            guard let signature = try? P521.Signing.ECDSASignature(rawRepresentation: privateKey) else { return false }
            return publicKeyValue.isValidSignature(signature, for: digestData)
        }
    }
}
