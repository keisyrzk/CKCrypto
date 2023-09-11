---

## **Usage Example**

### **isSigningVerified Function**

The `isSigningVerified` function verifies the validity of a given digital signature using the provided public key, private key (signature in most cases), and the digest of the data. It returns `true` if the signature is valid for the provided data and `false` otherwise.

Digital signature verification is crucial for ensuring that the data was indeed signed by the possessor of the private key and that the data hasn't been tampered with.

```swift
public static func isSigningVerified(publicKey: Data, privateKey: Data, digestData: Data, signingKeyType: SigningKeyType) -> Bool {
    ...
}
```

**Example of signature verification:**

Suppose you have a message, its digital signature, and a public key, and you want to verify the authenticity of the message:

```swift
let message = "Hello, World!".data(using: .utf8)!
let signedMessage = CryptoManager.sign(data: message, with: .Curve25519(algorithm: .SHA256))

// Let's say you send the signedMessage and message to another system or save it for later.
// At a later point, you want to verify the signature:

let isVerified = CryptoManager.isSigningVerified(publicKey: signedMessage.publicKey, 
                                                 privateKey: signedMessage.privateKey!, 
                                                 digestData: SHA256.hash(data: message), 
                                                 signingKeyType: .Curve25519)

print("Is the signature valid? \(isVerified ? "Yes" : "No")")
```

**Output:**

```
Is the signature valid? Yes
```

**Explanation:**

In this example, we first sign the message using the `sign` function. This yields a signature (private key) and the corresponding public key. 

For verification, the `isSigningVerified` function is provided with the public key, the signature (private key), the SHA256 hash of the message (digest), and the key type (Curve25519 in this case). It then verifies if the signature is valid for the given message digest. If everything is in order, the function will return `true`, indicating a valid signature.

---

Note: It's important to never share or expose the private key used for signing. The private key is sensitive, and its exposure can lead to malicious actors creating fraudulent signatures.
