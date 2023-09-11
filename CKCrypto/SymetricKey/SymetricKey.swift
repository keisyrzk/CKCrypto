//
//  SymetricKey.swift
//  CKCrypto
//
//  Created by Krzysztof Banaczyk on 07/09/2023.
//

import CryptoKit

extension CryptoManager {
    
    // MARK: Symmetric key
    
    /**
        Hash-based Message Authentication Code (HMAC) protects against malicious changes by signing the digest with a symmetric cryptographic key. A common use case is signing the digest of a file so the app’s server can check that you’re authorized to upload files.

        “Symmetric key” means the sender and receiver both know the secret key. HMAC uses the secret key to derive inner and outer keys. Then it creates an internal hash from the data and the inner key. Finally, it creates the signature from the internal hash and the outer key.
     
        HMAC lets you verify the sender’s identity and the integrity of the data, but doesn’t encrypt the data.
     */
    
    /**
        `returned:`
        `data` - signed with `HMAC`
        `key` - the generated key that has to be the same while validating the input data in example coming from backend
     */
    
    /// Generates an authentication code for the given data.
    ///
    /// The function uses the specified hashing algorithm and symmetric key type to generate an HMAC authentication code.
    /// - Parameters:
    ///   - data: The data to authenticate.
    ///   - algorithm: The hashing algorithm to use.
    ///   - keyType: The symmetric key type.
    /// - Returns: A tuple containing the signed data (authentication code) and the generated secret key.
    ///            This secret key should be used for subsequent validation of data.
    public static func authenticationCode(data: Data, algorithm: HashingAlgorithm, keyType: SymmetricKeyType) -> (data: Data, secretKey: SymmetricKey) {
        return authCode(data: data, algorithm: algorithm, keyType: keyType)
    }
    
    // Validate data with authentication code
    
    /**
        `authenticationCodeData`
                - original data created with `authenticationCode256`, `authenticationCode384` or `authenticationCode512` method
     
        `dataToAuthenticate`
                - data we like to authenticate, it may be data received from the server
     
        `symmetricKey`
                - a symmetric key to make the comparison possible, the secretKey `must be the same` as the secretKey generated in `authenticationCode256`, `authenticationCode384` or            `authenticationCode512` method
     */
    /// Validates data against the provided authentication code.
    ///
    /// The function checks if the given authentication code is valid for the data to authenticate using the specified hashing algorithm and symmetric key.
    /// - Parameters:
    ///   - algorithm: The hashing algorithm used in the generation of the authentication code.
    ///   - authenticationCodeData: Original data created with the `authenticationCode` method.
    ///   - dataToAuthenticate: The data to authenticate (e.g., data received from a server).
    ///   - symmetricKey: The symmetric key used in the generation of the authentication code (a symmetric key to make the comparison possible, the secretKey `must be                    the same` as the secretKey generated in `authenticationCode256`, `authenticationCode384` or `authenticationCode512`                                               method).
    ///                   It must match the key used during the authentication code creation.
    /// - Returns: `true` if the authentication code is valid for the given data, otherwise `false`.
    @available(iOS 13.2, *)
    public static func isAuthenticationCodeValid(algorithm: HashingAlgorithm, authenticationCodeData: Data, dataToAuthenticate: Data, symmetricKey: SymmetricKey) -> Bool {
        
        switch algorithm {
        case .SHA256:
            return HMAC<SHA256>.isValidAuthenticationCode(authenticationCodeData, authenticating: dataToAuthenticate, using: symmetricKey)
            
        case .SHA384:
            return HMAC<SHA384>.isValidAuthenticationCode(authenticationCodeData, authenticating: dataToAuthenticate, using: symmetricKey)
            
        case .SHA512:
            return HMAC<SHA512>.isValidAuthenticationCode(authenticationCodeData, authenticating: dataToAuthenticate, using: symmetricKey)
        }
    }
}
