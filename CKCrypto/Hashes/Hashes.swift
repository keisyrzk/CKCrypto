//
//  Hashes.swift
//  CKCrypto
//
//  Created by Krzysztof Banaczyk on 07/09/2023.
//

import CryptoKit

extension CryptoManager {
    
    // MARK: Hashes
    
    /// These hash functions generate a fixed-size string or byte array from input data.
    /// It's computationally hard to regenerate original data from the hash output.
    /// Different algorithms provide different levels of security and hash output sizes.
    
    /// Hashes the provided `Data` using the SHA256 algorithm.
    ///
    /// - Parameter value: The input `Data` to hash.
    /// - Returns: The SHA256 hash digest.
    public static func hash256(value: Data) -> SHA256Digest {
        return SHA256.hash(data: value)
    }
    
    /// Hashes the provided `String` using the SHA256 algorithm.
    ///
    /// - Parameter value: The input `String` to hash.
    /// - Returns: Optional SHA256 hash digest, `nil` if the input string can't be converted to data.
    public static func hash256(value: String) -> SHA256Digest? {
        guard let data = value.data(using: .utf8) else { return nil }
        return SHA256.hash(data: data)
    }
    
    /// Hashes the provided `Data` using the SHA384 algorithm.
    ///
    /// - Parameter value: The input `Data` to hash.
    /// - Returns: The SHA384 hash digest.
    public static func hash384(value: Data) -> SHA384Digest {
        return SHA384.hash(data: value)
    }
    
    /// Hashes the provided `String` using the SHA384 algorithm.
    ///
    /// - Parameter value: The input `String` to hash.
    /// - Returns: Optional SHA384 hash digest, `nil` if the input string can't be converted to data.
    public static func hash384(value: String) -> SHA384Digest? {
        guard let data = value.data(using: .utf8) else { return nil }
        return SHA384.hash(data: data)
    }
    
    /// Hashes the provided `Data` using the SHA512 algorithm.
    ///
    /// - Parameter value: The input `Data` to hash.
    /// - Returns: The SHA512 hash digest.
    public static func hash512(value: Data) -> SHA512Digest {
        return SHA512.hash(data: value)
    }
    
    /// Hashes the provided `String` using the SHA512 algorithm.
    ///
    /// - Parameter value: The input `String` to hash.
    /// - Returns: Optional SHA512 hash digest, `nil` if the input string can't be converted to data.
    public static func hash512(value: String) -> SHA512Digest? {
        guard let data = value.data(using: .utf8) else { return nil }
        return SHA512.hash(data: data)
    }
}
