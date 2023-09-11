//
//  Encryption.swift
//  CKCrypto
//
//  Created by Krzysztof Banaczyk on 07/09/2023.
//

import CryptoKit

extension CryptoManager {
    
    // MARK: Encryption
    
    /**
       Encryption functions in this section allow data to be encrypted so that only someone with the corresponding decryption key can decrypt and access the original data.
       
       It's important to note that for decryption, the same secret key used for encryption must be used.
    */
    
    /**
        `secretKey: symmetricKey`
                - a symmetric key to make the encryption and decryption possible, the secretKey in `decrypt` method `must be the same` as the secretKey generated in `encrypt` method
     */
    


    /// Encrypts the given data using a specified encryption type and generates a new symmetric key.
    ///
    /// This function will create a new symmetric key for the encryption process and return both the encrypted data and the generated key.
    /// - Parameters:
    ///   - data: The data to be encrypted.
    ///   - encryptionType: The type of encryption to use (e.g., AES_GCM, ChaChaPoly).
    ///   - keyType: The type of symmetric key to generate.
    /// - Returns: A tuple containing the encrypted data and the generated symmetric key. Returns `nil` if the encryption fails.
    public static func encrypt(data: Data, encryptionType: EncryptionType, keyType: SymmetricKeyType) -> (data: Data, secretKey: SymmetricKey)? {
        CryptoManager.createSealedBox(data: data, encryptionType: encryptionType, keyType: keyType)
    }
    
    /// Encrypts the given data using a specified encryption type and an existing symmetric key.
    ///
    /// This function will use the provided symmetric key for the encryption process.
    /// - Parameters:
    ///   - data: The data to be encrypted.
    ///   - encryptionType: The type of encryption to use (e.g., AES_GCM, ChaChaPoly).
    ///   - symmetricKey: The existing symmetric key to use for encryption.
    /// - Returns: A tuple containing the encrypted data and the used symmetric key. Returns `nil` if the encryption fails.
    public static func encrypt(data: Data, encryptionType: EncryptionType, symmetricKey: SymmetricKey) -> (data: Data, secretKey: SymmetricKey)? {
        CryptoManager.createSealedBox(data: data, encryptionType: encryptionType, symmetricKey: symmetricKey)
    }
    
    /// Decrypts the encrypted data using the specified encryption type and symmetric key.
    ///
    /// This function uses the provided symmetric key to decrypt the data. To successfully decrypt the data, the symmetric key must match the key originally used for encryption.
    /// - Parameters:
    ///   - data: The encrypted data.
    ///   - encryptionType: The type of encryption used during the encryption process (e.g., AES_GCM, ChaChaPoly).
    ///   - secretKey: The symmetric key to use for decryption.
    /// - Returns: The decrypted data. Returns `nil` if the decryption fails.
    public static func decrypt(data: Data, encryptionType: EncryptionType, secretKey: SymmetricKey) -> Data? {
        return CryptoManager.getSealedBox(data: data, encryptionType: encryptionType, secretKey: secretKey)
    }
}
