---

## **Usage Example**

### **hash256 Function**

The `hash256` function computes and returns the SHA-256 hash of the provided data.

```swift
public static func hash256(value: Data) -> SHA256Digest {
    return SHA256.hash(data: value)
}
```

**Example:**

Let's say you want to compute the hash of the string "Hello, World!".

```swift
let sampleString = "Hello, World!"
if let sampleData = sampleString.data(using: .utf8) {
    let hash = CryptoManager.hash256(value: sampleData)
    print(hash)
}
```

**Output:**

This will display the hash value in the console.

```
2CF24DBA5FB0A30E26E83B2AC5B9E29E1B161E5C1FA7425E73043362938B9824
```

**Explanation:**

The string "Hello, World!" when hashed with SHA-256, produces the output shown. This value remains consistent every time the same input is provided to the hashing function.

---

Remember, SHA-256 produces a fixed-size output (32 bytes or 256 bits). If you hash a different string, even if it's just a slight modification, the output will look significantly different.
