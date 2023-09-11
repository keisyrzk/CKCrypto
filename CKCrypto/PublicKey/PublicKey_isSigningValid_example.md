---

## **Usage Example**

### **isSigningValid Function - P256 Case**

The `isSigningValid` function verifies the validity of a given digital signature for various signing key types. For this example, we will focus on the P256 elliptic curve. This function returns `true` if the signature is valid for the provided data and `false` otherwise.

Digital signature verification ensures data integrity and the authenticity of the signer.

```swift
public static func isSigningValid(publicKey: Data, privateKey: Data, digestData: Data, signingKeyType: SigningKeyType) -> Bool {
    ...
}
```

**Example of P256 signature verification:**

Suppose you have a message, its digital signature, and a public key. You want to verify if the message was truly signed by the possessor of the private key:

```swift
let message = "Hello, P256!".data(using: .utf8)!
// Assuming a function to sign data with P256 exists:
let signedMessage = CryptoManager.signWithP256(data: message)

// Let's say you send the signedMessage and message to another system or save it for later.
// At a later point, you want to verify the signature:

let isVerified = CryptoManager.isSigningValid(publicKey: signedMessage.publicKey, 
                                              privateKey: signedMessage.privateKey!, 
                                              digestData: SHA256.hash(data: message), 
                                              signingKeyType: .P256)

print("Is the P256 signature valid? \(isVerified ? "Yes" : "No")")
```

**Output:**

```
Is the P256 signature valid? Yes
```

**Explanation:**

In this example, we first sign the message using a hypothetical `signWithP256` function, which yields a signature (private key) and the corresponding public key.

For verification, the `isSigningValid` function is provided with the public key, the signature (private key), the SHA256 hash of the message (digest), and the key type (P256). The function checks if the provided public key and signature are valid P256 representations and then verifies if the signature matches the message digest. If everything is in order, the function returns `true`, indicating a valid signature for P256.

---

Note: Keep your private keys safe and never expose them. In cryptographic systems, the private key's security is paramount to ensure data integrity and authenticity.
