---

## **Usage Example**

### **createSymmetricKey Function**

The `createSymmetricKey` function creates a symmetric key through Elliptic Curve Diffie-Hellman (ECDH) key agreement using Curve25519. The purpose of this function is to allow two parties (e.g., an app and a client) to independently create the same shared symmetric key, which can be used for encryption or other cryptographic operations. 

The function requires the public key data from the client and uses it with the app's own private key to derive a shared secret. This shared secret is then hashed to produce a symmetric key. Salt is used during the hash key derivation function (HKDF) to add an extra layer of randomness and security.

```swift
public static func createSymmetricKey(algorithm: HashingAlgorithm, salt: Data, clientPublicKeyData: Data) -> (appPublicKeyData: Data, symmetricKey: SymmetricKey) {
    ...
}
```

**Example using SHA256 hashing with Curve25519 ECDH:**

Let's say you received the client's public key data and wish to establish a shared symmetric key:

```swift
let clientPublicKeyData: Data = ... // This is the client's public key data, possibly received from them.
let salt: Data = ... // Salt should ideally be random and unique for each key derivation.

let keyData = CryptoManager.createSymmetricKey(algorithm: .SHA256, salt: salt, clientPublicKeyData: clientPublicKeyData)

// `keyData.appPublicKeyData` is the public key of the app.
// `keyData.symmetricKey` is the shared symmetric key derived from the ECDH agreement and the SHA256 hash function.
print("App Public Key Data: \(keyData.appPublicKeyData)")
print("Derived Symmetric Key: \(keyData.symmetricKey)")
```

**Output:**

The output will display the app's public key data and the derived symmetric key:

```
App Public Key Data: <app_public_key_representation>
Derived Symmetric Key: <derived_symmetric_key_representation>
```

**Explanation:**

In this example, the `createSymmetricKey` function is supplied with the client's public key data, salt, and the specified hashing algorithm (SHA256). The function generates the app's public and private key pair, then uses its private key with the client's public key to derive a shared secret. The shared secret is subsequently hashed using SHA256 (with the provided salt) to produce a symmetric key.

This approach ensures that both the client and the app can independently create the same symmetric key without directly sharing it.

---

Always remember that the salt used during key derivation should be random and unique for every key derivation operation. It should ideally be stored or communicated securely if it needs to be reused.
