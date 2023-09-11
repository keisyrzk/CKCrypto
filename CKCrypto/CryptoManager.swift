//
//  CryptoManager.swift
//  CKCrypto
//
//  Created by Krzysztof Banaczyk on 07/09/2023.
//

import CryptoKit

public class CryptoManager {
    
    public enum SymmetricKeyType {
        case key128
        case key192
        case key256
    }
    
    public enum EncryptionType {
        case AES_GCM
        case ChaChaPoly
    }
    
    public enum HashingAlgorithm {
        case SHA256
        case SHA384
        case SHA512
    }
    
    public enum SigningKeyType {
        case Curve25519(HashingAlgorithm)
        case P521
        case P384
        case P256
    }
}
