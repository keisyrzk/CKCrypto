
## **Usage Example**

### **decrypt Function**

The `decrypt` function allows for decryption of given encrypted data (`sealed box`) using a specified symmetric encryption algorithm and a known symmetric key. Upon successful decryption, the function returns the decrypted data.

```swift
public static func decrypt(data: Data, encryptionType: EncryptionType, secretKey: SymmetricKey) -> Data? {
    return CryptoManager.getSealedBox(data: data, encryptionType: encryptionType, secretKey: secretKey)
}
```

**Example using AES_GCM decryption with a known SymmetricKey:**

Imagine you have encrypted data and you wish to decrypt it using AES_GCM encryption with a known key:

```swift
let encryptedData: Data = ... // This is your encrypted data, often received or loaded from a source.
let knownSecretKey: SymmetricKey = ... // The known symmetric key used for encryption.

if let decryptedData = CryptoManager.decrypt(data: encryptedData, encryptionType: .AES_GCM, secretKey: knownSecretKey),
   let decryptedText = String(data: decryptedData, encoding: .utf8) {
    // Now `decryptedText` holds the decrypted version of the encrypted data.
    print("Decrypted Text: \(decryptedText)")
}
```

**Output:**

The output will display the decrypted text:

```
Decrypted Text: <original_data_representation>
```

**Explanation:**

In this example, the `decrypt` function is supplied with the encrypted data, the encryption type (AES_GCM in this scenario), and the known symmetric key that was used during encryption. The function then decrypts the data using the provided key and returns the decrypted version.

It's crucial to remember that using the correct symmetric key for decryption is essential. If a different key is used, or if the key is compromised, the decryption will either fail or yield incorrect results.


For optimal security, always ensure that the symmetric key used for decryption is the same as the one used for encryption. Any discrepancies can lead to data corruption or failed decryption attempts.
