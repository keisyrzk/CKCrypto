
## **Usage Example**

### **isAuthenticationCodeValid Function**

The `isAuthenticationCodeValid` function verifies whether a given authentication code (MAC - Message Authentication Code) for a specified data is valid based on the provided symmetric key and the hashing algorithm. The function returns `true` if the authentication code is valid, otherwise `false`.

```swift
public static func isAuthenticationCodeValid(algorithm: HashingAlgorithm, authenticationCodeData: Data, dataToAuthenticate: Data, symmetricKey: SymmetricKey) -> Bool {
    // ... (truncated for brevity)
    switch algorithm {
    case .SHA256:
        return HMAC<SHA256>.isValidAuthenticationCode(authenticationCodeData, authenticating: dataToAuthenticate, using: symmetricKey)
    // ... (other cases)
    }
}
```

**Example for SHA256:**

Let's say you have generated an authentication code for the string "Confidential Message" using the SHA256 hashing algorithm and you wish to verify it later:

```swift
let sampleMessage = "Confidential Message"
if let messageData = sampleMessage.data(using: .utf8) {
    let (authCodeData, secretKey) = CryptoManager.authenticationCode(data: messageData, algorithm: .SHA256, keyType: .key128)
    
    let isValid = CryptoManager.isAuthenticationCodeValid(algorithm: .SHA256, authenticationCodeData: authCodeData, dataToAuthenticate: messageData, symmetricKey: secretKey)
    
    print("Is Authentication Code Valid? \(isValid)")
}
```

**Output:**

This will display whether the authentication code is valid:

```
Is Authentication Code Valid? true
```

**Explanation:**

The function `isAuthenticationCodeValid` receives the previously computed authentication code, the original data ("Confidential Message"), the hashing algorithm (in this example, SHA256), and the symmetric key used for generating the authentication code. It then verifies whether the provided authentication code matches with what would be generated using the given data and key. If they match, the function returns `true`, confirming the data's authenticity and integrity; otherwise, it returns `false`.


Note: HMACs (Hash-based Message Authentication Codes) are beneficial for validating both the data's integrity and authenticity. An HMAC requires a secret key, ensuring only those who possess the key can verify the HMAC for specific data correctly.
