---

## **Usage Example**

### **authenticationCode Function**

The `authenticationCode` function generates an authentication code (often referred to as a MAC - Message Authentication Code) for a given piece of data using a specific hashing algorithm and a symmetric key type. It then returns both the computed authentication code and the secret symmetric key used for its generation.

```swift
public static func authenticationCode(data: Data, algorithm: HashingAlgorithm, keyType: SymmetricKeyType) -> (data: Data, secretKey: SymmetricKey) {
    return authCode(data: data, algorithm: algorithm, keyType: keyType)
}
```

**Example:**

Let's create an authentication code for the string "Confidential Message" using the SHA256 hashing algorithm and a 128-bit symmetric key.

```swift
let sampleMessage = "Confidential Message"
if let messageData = sampleMessage.data(using: .utf8) {
    let (authCodeData, secretKey) = CryptoManager.authenticationCode(data: messageData, algorithm: .SHA256, keyType: .key128)
    print("Authentication Code: \(authCodeData)")
    print("Secret Key: \(secretKey)")
}
```

**Output:**

This will display the generated authentication code and the secret key used in the console. The exact values would be different for each execution due to the randomness of key generation, but for illustrative purposes:

```
Authentication Code: 5B4D40D344956B8CFA3C1E2AAA339E... (truncated for brevity)
Secret Key: E41D5A15370A63F8BA8A3FE35E7A16F4
```

**Explanation:**

The message "Confidential Message" is passed along with the hashing algorithm and key type specifications to the `authenticationCode` function. The function generates an HMAC (Hash-based Message Authentication Code) using the SHA-256 algorithm and a 128-bit secret key. The function then returns both the HMAC value and the secret key.

---

Note: HMACs are useful for verifying both the data integrity and the authenticity of a message. It requires a secret key, so only those who possess the key can generate a valid HMAC for a particular piece of data.
