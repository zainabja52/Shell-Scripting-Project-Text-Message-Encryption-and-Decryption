# **🔐 SimpleEncryption - Shell Script for Text Encryption & Decryption**  

<p align="center">
<img src="https://upload.wikimedia.org/wikipedia/commons/4/4b/Bash_Logo_Colored.svg" width="120"/>
</p>

---

## **📌 Overview**
This project implements a **simple encryption and decryption system** using **shell scripting** under **Linux**. It utilizes **XOR operations** for encryption and decryption, following a structured process to ensure data security.

✅ **Encryption**: Converts a plain text file into an encrypted format using an XOR-based algorithm.  
✅ **Decryption**: Restores the original text from the encrypted file using the stored key.  

**📖 Encryption Process:**
1. **Generate a Key**:  
   - The key is calculated based on the sum of character positions in words.  
   - Converted to an **8-bit binary representation**.
2. **XOR each character** with the key.  
3. **Swap** the first and last **4-bits** of the binary result.  
4. **Store the key** (after swapping its bits) at the **end of the encrypted file**.

**🔓 Decryption Process:**
1. Extract the **key** from the **last line** of the encrypted file.  
2. Swap the **first and last 4-bits** back to original.  
3. Reverse the **XOR operation** to retrieve the original text.  

---

## **🛠️ Technologies Used**
| Technology | Purpose |
|------------|---------|
| **Bash (Shell Scripting)** | Core scripting language |
| **XOR Operation** | Encryption logic |
| **Binary Manipulation** | Bitwise operations & swapping |
| **Linux Commands** | File handling, execution, and validation |

---

## **🚀 How to Run the Program**
### **1️⃣ Clone the Repository**
```bash
git clone https://github.com/zainabja52/Shell-Scripting-Project-Text-Message-Encryption-and-Decryption.git
```

### **2️⃣ Run the Script**
Run the encryption or decryption process:
```bash
bash script.sh
```
The script will prompt you to:
- **Enter "1"** for **Encryption**
- **Enter "2"** for **Decryption**

---

## **🔐 Encryption Process**
1️⃣ Run the script and **choose Encryption (1)**  
2️⃣ Enter the **plaintext file name**  
3️⃣ The script will:
   - Validate the file
   - Generate the encryption key
   - Convert text to binary and apply XOR logic
   - Swap 4-bit sections and store output in **encrypted_output.txt**
4️⃣ Enter the **output filename for encryption**  
5️⃣ **Encrypted content** is stored in the specified file.

📌 **Example Input (plain text file):**
```
Hello World
```
📌 **Example Encrypted Output:**
```
10101101 11001100 01100111 ...
```

---

## **🔓 Decryption Process**
1️⃣ Run the script and **choose Decryption (2)**  
2️⃣ Enter the **ciphertext file name**  
3️⃣ The script will:
   - Extract the **key** from the last line of the encrypted file
   - Reverse the 4-bit swap
   - Perform XOR operation to restore the original text  
4️⃣ Enter the **output filename for decryption**  
5️⃣ **Decrypted text** is stored in the specified file.

📌 **Example Decrypted Output:**
```
Hello World
```

---

## **📊 Performance & Testing**
✔ **Tested with multiple text files** for encryption & decryption.  
✔ **Handles invalid input gracefully** (e.g., non-alphabetic characters).  
✔ **Ensures correct key retrieval & decryption accuracy.**  

### **🔍 Example Test Cases**
| Input | Expected Output |
|--------|----------------|
| "Linux Shell Scripting" | Successfully encrypted & decrypted |
| "Security is important!" | Error: Non-alphabet characters detected |
| "Bash is powerful" | Successfully encrypted & decrypted |

---

## **🤝 Contributors**  
👩‍💻 **Zainab Jaradat**  
👩‍💻 **Maryan Kassis**  
