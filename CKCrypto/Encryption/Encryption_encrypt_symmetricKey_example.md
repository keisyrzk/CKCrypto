
## **Usage Example**

### **encrypt Function with Pre-defined SymmetricKey**

This variant of the `encrypt` function allows for the encryption of given data using a pre-defined symmetric key and a specified symmetric encryption algorithm. Upon successful encryption, the function returns the encrypted data (`sealed box`) and the symmetric key that was used.

```swift
public static func encrypt(data: Data, encryptionType: EncryptionType, symmetricKey: SymmetricKey) -> (data: Data, secretKey: SymmetricKey)? {
    return CryptoManager.createSealedBox(data: data, encryptionType: encryptionType, symmetricKey: symmetricKey)
}
```

**Example using AES_GCM encryption with a pre-defined SymmetricKey:**

Imagine you wish to encrypt the string "Confidential Data" using AES_GCM encryption with a pre-defined key:

```swift
let sampleText = "Confidential Data"
let predefinedKey = SymmetricKey(size: .bits128) // Example of generating a pre-defined symmetric key.

if let textData = sampleText.data(using: .utf8) {
    if let (encryptedData, secretKey) = CryptoManager.encrypt(data: textData, encryptionType: .AES_GCM, symmetricKey: predefinedKey) {
        // Now `encryptedData` holds the encrypted version of "Confidential Data"
        // and `secretKey` matches the pre-defined symmetric key.
        print("Encrypted Data: \(encryptedData)")
        print("Secret Key: \(secretKey)")
    }
}
```

**Output:**

The output will display the encrypted data and the secret key:

```
Encrypted Data: <encrypted_data_representation>
Secret Key: <symmetric_key_representation>
```

**Explanation:**

In this example, the `encrypt` function is supplied with the data to encrypt, the desired encryption type (AES_GCM in this scenario), and a pre-defined symmetric key (in this case, a 128-bit key). The function then encrypts the data using the provided key and returns the encrypted version along with the symmetric key.

Utilizing a pre-defined key can be useful in scenarios where both the sender and the receiver have already exchanged symmetric keys securely, and they need to perform encryption/decryption operations using that same key.


As always, handle symmetric keys with utmost care. If they get compromised, any data encrypted with them becomes vulnerable to unauthorized decryption. Ensure secure storage and transmission mechanisms for keys.
