
# CKCrypto Documentation

`CKCrypto` offers a broad spectrum of cryptographic functionalities, designed to ensure data security, integrity, and confidentiality in your applications. Below is a comprehensive overview of the main features provided by the library.

## Table of Contents
- [Encryption](#encryption)
- [Symmetric Key](#symmetric-key)
- [Hashes](#hashes)
- [Public Key](#public-key)
- [Encryption Key Agreement](#encryption-key-agreement)

## Encryption

Utilities for data encryption and decryption, ensuring data confidentiality.

### Methods:

- **encrypt (with auto-generated key)**:
  - Description: Encrypts data, auto-generating a symmetric key.
  - Signature: 
    ```swift
    public static func encrypt(data: Data, encryptionType: EncryptionType, keyType: SymmetricKeyType) -> (data: Data, secretKey: SymmetricKey)?
    ```

- **encrypt (with existing key)**:
  - Description: Encrypts data using an existing symmetric key.
  - Signature: 
    ```swift
    public static func encrypt(data: Data, encryptionType: EncryptionType, symmetricKey: SymmetricKey) -> (data: Data, secretKey: SymmetricKey)?
    ```

- **decrypt**:
  - Description: Decrypts encrypted data using a symmetric key.
  - Signature: 
    ```swift
    public static func decrypt(data: Data, encryptionType: EncryptionType, secretKey: SymmetricKey) -> Data?
    ```
### Notes:
- Ensure the confidentiality of symmetric keys.
- Use matching encryption types and symmetric keys for successful decryption.

## Symmetric Key

HMAC utilities using symmetric keys to both sign and verify data. HMAC provides verification of the sender's identity and the data's integrity, without encrypting the data itself.

### Methods:

- **authenticationCode**:
  - Description: Generates an HMAC authentication code for provided data.
  - Signature: 
    ```swift
    public static func authenticationCode(data: Data, algorithm: HashingAlgorithm, keyType: SymmetricKeyType) -> (data: Data, secretKey: SymmetricKey)
    ```

- **isAuthenticationCodeValid**:
  - Description: Validates data against a given HMAC authentication code.
  - Signature: 
    ```swift
    @available(iOS 13.2, *)
    public static func isAuthenticationCodeValid(algorithm: HashingAlgorithm, authenticationCodeData: Data, dataToAuthenticate: Data, symmetricKey: SymmetricKey) -> Bool
    ```

### Notes:
- Ensure confidentiality of symmetric keys.
- HMAC validates the integrity and authenticity of a message. It doesn't encrypt the content.
- It's vital to use the same symmetric key for generating and verifying the HMAC.

## Hashes

These hash functions convert input data into a fixed-size string or byte array. It's computationally challenging to reverse a hash back to its original data. Different algorithms offer varied security and hash output sizes.

### Methods:

- **hash256 (Data)**
  - Description: Generates a SHA256 hash from provided data.
  - Signature: 
    ```swift
    public static func hash256(value: Data) -> SHA256Digest
    ```

- **hash256 (String)**
  - Description: Generates a SHA256 hash from a provided string.
  - Signature: 
    ```swift
    public static func hash256(value: String) -> SHA256Digest?
    ```

- **hash384 (Data)**
  - Description: Generates a SHA384 hash from provided data.
  - Signature: 
    ```swift
    public static func hash384(value: Data) -> SHA384Digest
    ```

- **hash384 (String)**
  - Description: Generates a SHA384 hash from a provided string.
  - Signature: 
    ```swift
    public static func hash384(value: String) -> SHA384Digest?
    ```

- **hash512 (Data)**
  - Description: Generates a SHA512 hash from provided data.
  - Signature: 
    ```swift
    public static func hash512(value: Data) -> SHA512Digest
    ```

- **hash512 (String)**
  - Description: Generates a SHA512 hash from a provided string.
  - Signature: 
    ```swift
    public static func hash512(value: String) -> SHA512Digest?
    ```

### Notes:
- Ensure correct input types for hashing functions (Data or String).
- A hash function is one-way, meaning it's computationally infeasible to reverse the hash to obtain original data.

## Public Key

Public-key operations are vital for security tasks like authenticating an operation with a back-end server. For example, an app may generate a private key, store it in Keychain or SecureEnclave, and register the corresponding public key on a server. To authenticate an operation, the app can sign its details with the private key and then send the signed data to the server for verification using the public key.

### Methods:

- **sign(data:with:)**
  - Description: Provides a public interface for signing data.
  - Signature: 
    ```swift
    public static func sign(data: Data, with signingKeyType: SigningKeyType) -> (signature: Data?, publicKey: Data)
    ```

- **isSigningVerified(publicKey:signature:digestData:signingKeyType:)**
  - Description: Verifies if a provided signature is valid for given data using the supplied public key.
  - Signature: 
    ```swift
    public static func isSigningVerified(publicKey: Data, signature: Data, digestData: Data, signingKeyType: SigningKeyType) -> Bool
    ```

- **isSigningValid(publicKey:signature:digestData:signingKeyType:)**
  - Description: Confirms if a given signature is authentic for specified data using a designated public key.
  - Signature: 
    ```swift
    public static func isSigningValid(publicKey: Data, signature: Data, digestData: Data, signingKeyType: SigningKeyType) -> Bool
    ```

### Notes:
- These methods leverage various signing key types, including Curve25519 and P256/384/521 curves.
- Ensuring correct data types and key types is crucial for successful signing and verification operations.
- For both verification methods, input data may need to be hashed with the specified algorithm before verifying the signature.


## Encryption Key Agreement

Creating symmetric keys using a key agreement protocol with the Curve25519 elliptic curve. This process ensures both the application and a client (e.g., a server) derive the same symmetric key, allowing them to establish encrypted communication.

### Methods

- **createSymmetricKey(algorithm:salt:clientPublicKeyData:outputByteCount:)**
  - **Description**: Derives a symmetric encryption key using a given hashing algorithm, a shared secret value (created by the Curve25519 elliptic curve key agreement protocol), and a salt.
  - **Signature**:
    ```swift
    public static func createSymmetricKey(algorithm: HashingAlgorithm, salt: Data, clientPublicKeyData: Data, outputByteCount: Int = 32) -> (appPublicKeyData: Data, symmetricKey: SymmetricKey)
    ```

### Notes

- The method leverages the Curve25519 key agreement protocol.
- The derived symmetric key is suitable for both encryption and decryption, provided both parties adhere to the protocol accurately.
- Appropriate error handling should be considered given the force unwraps (`try!`) present in the provided method.
