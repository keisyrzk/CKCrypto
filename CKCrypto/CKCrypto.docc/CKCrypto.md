
# CKCrypto Documentation

`CryptoManager` is a Swift-based utility for cryptographic operations, including hashing, symmetric encryption, and signing data with various algorithms.

## Table of Contents

- [Hashing](#hashing)
- [Symmetric Encryption](#symmetric-encryption)
- [Public Key Operations](#public-key-operations)


## Hashing

### authCode Function

This function is used to generate an HMAC authentication code for given data using various hashing algorithms (`SHA256`, `SHA384`, and `SHA512`) and symmetric key types.

```swift
static func authCode(data: Data, algorithm: HashingAlgorithm, keyType: SymmetricKeyType) -> (data: Data, secretKey: SymmetricKey)
```


## Symmetric Encryption

### createSealedBox Functions

These functions are utilized to encrypt data using symmetric encryption algorithms (`ChaChaPoly` and `AES_GCM`). 

1. Encrypt data by generating a new symmetric key:

```swift
static func createSealedBox(data: Data, encryptionType: EncryptionType, keyType: SymmetricKeyType) -> (data: Data, secretKey: SymmetricKey)?
```

2. Encrypt data using a provided symmetric key:

```swift
static func createSealedBox(data: Data, encryptionType: EncryptionType, symmetricKey: SymmetricKey) -> (data: Data, secretKey: SymmetricKey)?
```

### getSealedBox Function

This function decrypts the provided encrypted data using a specified symmetric encryption algorithm and key.

```swift
static func getSealedBox(data: Data, encryptionType: EncryptionType, secretKey: SymmetricKey) -> Data?
```


## Public Key Operations

### signData Function

This function signs the provided data using different algorithms (`SHA256`, `SHA384`, `SHA512`) and keys (`Curve25519`, `P256`, `P384`, and `P521`). It returns both the signature and the associated public key.

```swift
static func signData(data: Data, with signingKeyType: SigningKeyType) -> (privateKey: Data?, publicKey: Data)
```

### isSigningValid Function

This function verifies if a given signature is valid for specified data using a public key and the associated key type.

```swift
static func isSigningValid(publicKey: Data, privateKey: Data, digestData: Data, signingKeyType: SigningKeyType) -> Bool
```
