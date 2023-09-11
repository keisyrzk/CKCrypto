---

## **Usage Example**

### **encrypt Function**

The `encrypt` function enables the encryption of a given data using a specified symmetric encryption algorithm. Once encrypted, the function returns the encrypted data (`sealed box`) and the symmetric key used for the encryption.

```swift
public static func encrypt(data: Data, encryptionType: EncryptionType, keyType: SymmetricKeyType) -> (data: Data, secretKey: SymmetricKey)? {
    return CryptoManager.createSealedBox(data: data, encryptionType: encryptionType, keyType: keyType)
}
```

**Example using AES_GCM encryption:**

Imagine you wish to encrypt the string "Sensitive Information" using AES_GCM encryption:

```swift
let sampleText = "Sensitive Information"
if let textData = sampleText.data(using: .utf8) {
    if let (encryptedData, secretKey) = CryptoManager.encrypt(data: textData, encryptionType: .AES_GCM, keyType: .key128) {
        // Now `encryptedData` holds the encrypted version of "Sensitive Information"
        // and `secretKey` is the symmetric key used for encryption.
        print("Encrypted Data: \(encryptedData)")
        print("Secret Key: \(secretKey)")
    }
}
```

**Output:**

The output will show the encrypted data and the secret key:

```
Encrypted Data: <encrypted_data_representation>
Secret Key: <symmetric_key_representation>
```

**Explanation:**

In the example, the function `encrypt` receives the data, the desired encryption type (AES_GCM, in this case), and the key type (key128, meaning a 128-bit key). It then encrypts the data and returns the encrypted version along with the symmetric key used for encryption. 

This symmetric key is crucial for decryption, so it's imperative to store it securely, often in secure storage mechanisms like Keychains or Hardware Security Modules. Without the correct key, the encrypted data cannot be decrypted.

---

Note: It's vital always to be cautious about the handling, storage, and transmission of encryption keys. If an attacker gains access to the encryption key, they can decrypt any data encrypted with that key.
