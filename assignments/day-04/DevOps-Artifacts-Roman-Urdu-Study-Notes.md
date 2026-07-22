# DevOps Artifacts — Roman Urdu Study Notes

## Learning objectives

Is lesson ko complete karne ke baad students:

- Artifact ko asan alfaaz mein define kar saken ge.
- Source code aur artifact ka farq samajh saken ge.
- Mukhtalif artifact formats ko pehchan saken ge.
- DevOps workflow mein artifact ki jagah samajh saken ge.
- Bata saken ge ke artifacts ko version kyun diya jata hai.
- Bash conditions se artifact validate kar saken ge.
- Arguments aur Conditionals labs ke artifacts ko pehchan saken ge.

---

## 1. Artifact kya hota hai?

**Artifact** aik file ya package hota hai jo application ke source code se tayyar kiya jata hai aur testing, storage, ya deployment ke liye istemal hota hai.

Asan alfaaz mein:

> Artifact application ka tayyar package hota hai jise DevOps engineers development se testing aur phir production environment tak le kar jate hain.

Misalain:

```text
inventory-api-v1.0.0.tar.gz
customer-portal-v2.1.0.zip
payments-api-v3.0.0.jar
```

---

## 2. Bakery ki asan misal

Aik bakery ke bare mein sochain:

| Bakery | Software development |
|---|---|
| Ingredients | Source code |
| Cake banana | Build process |
| Tayyar cake | Artifact |
| Cake ko check karna | Testing |
| Cake shop tak pohanchana | Deployment |

Developers source code par kaam karte hain, jabke deployment system aam tor par tayyar artifact ko deploy karta hai.

Yani:

```text
Ingredients se cake banta hai.
Source code se artifact banta hai.
```

---

## 3. DevOps mein artifact ka flow

```mermaid
flowchart LR
    A["Source code"] --> B["Build"]
    B --> C["Artifact"]
    C --> D["Test"]
    D --> E["Deploy"]
```

Example:

```text
Source code
    ↓
Build process
    ↓
inventory-api-v1.0.0.tar.gz
    ↓
Testing
    ↓
Deployment
```

Sab se important baat yeh hai ke testing aur production mein **wahi same artifact** istemal hona chahiye.

Har environment ke liye naya package build karna risk paida kar sakta hai, kyunke dono packages mein farq ho sakta hai.

---

## 4. Common artifact types

| Technology | Artifact ki misal |
|---|---|
| Bash lab | `.txt`, `.tar.gz`, ya `.zip` |
| Java | `.jar` ya `.war` |
| JavaScript | `dist/` package ya `.zip` |
| Python | `.whl` package |
| Linux | `.deb` ya `.rpm` |
| Containers | Docker image |
| C/C++ | Compiled binary |
| Website | Packaged HTML, CSS, aur JavaScript files |

Artifact ka compressed hona zaroori nahin. Koi bhi tayyar aur versioned output jo testing ya deployment ke liye ho, artifact ho sakta hai.

---

## 5. Arguments Lab ka artifact

Arguments Lab ka primary artifact hai:

```text
artifacts/inventory-api.txt
```

Yeh file aik simple application release ko represent karti hai:

```text
Application: Inventory API
Version: v1.0.0
Owner: Platform Engineering
Health endpoint: /health
```

Deployment script ko artifact ka path argument ke zariye diya jata hai:

```bash
./06-deployment-runner.sh inventory-api dev v1.0.0 artifacts/inventory-api.txt
```

Workflow artifact ko validate karne ke baad is destination mein copy karta hai:

```text
lab-server/dev/inventory-api/v1.0.0/inventory-api.txt
```

Arguments Lab mein hum seekhte hain:

- Artifact path ko `$4` ke zariye lena.
- Artifact path ko variable mein store karna.
- Variable ko quotation marks mein use karna.
- File ko validate karna.
- File ko sahi destination mein copy karna.

---

## 6. Conditionals Lab ka artifact

Conditionals Lab ka primary artifact hai:

```text
artifacts/inventory-api-v1.0.0.tar.gz
```

Yeh aik compressed application package hai. Iske andar yeh files hain:

```text
inventory-api-v1.0.0/
├── VERSION
├── application.txt
└── config.env
```

Artifact ko extract kiye baghair uske andar ki files dekhein:

```bash
tar -tzf artifacts/inventory-api-v1.0.0.tar.gz
```

Conditionals Lab check karta hai ke artifact:

- Regular file ke tor par mojood hai.
- Readable hai.
- Empty nahin hai.
- `.tar.gz` par khatam hota hai.
- Sirf tamam readiness gates pass hone ke baad deploy hota hai.

---

## 7. Source code aur artifact ka farq

| Source code | Artifact |
|---|---|
| Developers isay edit karte hain | Yeh deployment ke liye tayyar output hota hai |
| Project ki bohat si files ho sakti hain | Release ke liye zaroori files hoti hain |
| Bar bar change hota hai | Aik khaas version ke liye banaya jata hai |
| Application build karne ke liye use hota hai | Application test aur deploy karne ke liye use hota hai |
| Misal: `source/` | Misal: `inventory-api-v1.0.0.tar.gz` |

Example:

```text
source/inventory-api-v1.0.0/
```

ko package karke yeh artifact banaya jata hai:

```text
artifacts/inventory-api-v1.0.0.tar.gz
```

Asan rule:

> Source code woh hai jo developer likhta hai. Artifact woh hai jo DevOps engineer deploy karta hai.

---

## 8. DevOps engineers artifacts kyun use karte hain?

### Consistency

Testing aur production mein same package use hota hai.

### Versioning

Har release ka aik unique version hota hai.

### Portability

Package ko aik environment se doosre environment tak move kiya ja sakta hai.

### Repeatability

Zaroorat parne par same version dobara deploy kiya ja sakta hai.

### Traceability

Engineers maloom kar sakte hain ke kaunsa version kis environment mein deploy hua tha.

### Rollback

Agar naya release fail ho jaye to purana stable artifact dobara deploy kiya ja sakta hai.

### Automation

CI/CD pipeline aik known artifact ko download, test, scan, aur deploy kar sakti hai.

---

## 9. Artifact filename mein version kyun hota hai?

Is unclear filename ko dekhein:

```text
inventory-api.tar.gz
```

Is naam se hamein pata nahin chalta ke yeh kaunsa version hai.

Ab versioned filenames dekhein:

```text
inventory-api-v1.0.0.tar.gz
inventory-api-v1.1.0.tar.gz
inventory-api-v2.0.0.tar.gz
```

Versioned filenames se releases ko:

- Identify karna
- Test karna
- Deploy karna
- Audit karna
- Compare karna
- Rollback karna

asan ho jata hai.

Application ka naam aur version artifact ke filename ya metadata mein clear hona chahiye.

---

## 10. Bash se artifact validation

Deployment se pehle DevOps engineer ko artifact validate karna chahiye.

### Check karein ke regular file mojood hai

```bash
[[ -f "$artifact" ]]
```

`-f` ka matlab hai ke given path par regular file mojood hai.

### Check karein ke file readable hai

```bash
[[ -r "$artifact" ]]
```

`-r` ka matlab hai ke current user file ko read kar sakta hai.

### Check karein ke file empty nahin hai

```bash
[[ -s "$artifact" ]]
```

`-s` true hota hai jab file mojood ho aur uska size zero se zyada ho.

### Expected extension check karein

```bash
[[ "$artifact" == *.tar.gz ]]
```

Yeh condition check karti hai ke filename `.tar.gz` par khatam hota hai.

### Complete beginner example

```bash
#!/bin/bash

artifact="$1"

if [[ -z "$artifact" ]]; then
    echo "Artifact path provide nahin kiya gaya."
elif [[ ! -f "$artifact" ]]; then
    echo "Artifact mojood nahin hai."
elif [[ ! -r "$artifact" ]]; then
    echo "Artifact readable nahin hai."
elif [[ ! -s "$artifact" ]]; then
    echo "Artifact empty hai."
elif [[ "$artifact" != *.tar.gz ]]; then
    echo "Artifact ki extension ghalat hai."
else
    echo "Artifact validation pass ho gayi."
fi
```

Script run karein:

```bash
./check_artifact.sh artifacts/inventory-api-v1.0.0.tar.gz
```

---

## 11. Useful artifact commands

### Artifacts ki list dekhein

```bash
ls -lh artifacts/
```

### File type identify karein

```bash
file artifacts/inventory-api-v1.0.0.tar.gz
```

### SHA-256 checksum banayein

```bash
sha256sum artifacts/inventory-api-v1.0.0.tar.gz
```

### `.tar.gz` package ke andar ki files dekhein

```bash
tar -tzf artifacts/inventory-api-v1.0.0.tar.gz
```

### Package extract karein

```bash
mkdir -p extracted-artifact
tar -xzf artifacts/inventory-api-v1.0.0.tar.gz -C extracted-artifact
```

### Deployed artifacts find karein

```bash
find lab-server -type f
```

---

## 12. Checksum kya hota hai?

Checksum aik calculated value hoti hai jo verify karti hai ke artifact change ya corrupt to nahin hua.

SHA-256 checksum create karein:

```bash
sha256sum artifacts/inventory-api-v1.0.0.tar.gz
```

Example output:

```text
abc123...  artifacts/inventory-api-v1.0.0.tar.gz
```

Agar artifact ki content change ho jaye to uska checksum bhi change ho jata hai.

DevOps pipeline deployment se pehle checksum compare karke artifact ki integrity, yani uske theek aur unchanged hone ki tasdeeq kar sakti hai.

---

## 13. Artifact repository kya hoti hai?

**Artifact repository** aik system hota hai jahan versioned artifacts ko store, organize, secure, aur distribute kiya jata hai.

Common examples:

- JFrog Artifactory
- Sonatype Nexus Repository
- GitHub Packages
- AWS CodeArtifact
- Amazon ECR for container images
- Docker Hub

Typical workflow:

```text
Developer source code push karta hai
        ↓
CI pipeline artifact build karti hai
        ↓
Pipeline artifact ko test aur scan karti hai
        ↓
Artifact repository usay store karti hai
        ↓
Deployment pipeline artifact download karti hai
        ↓
Wahi same artifact deploy hota hai
```

Artifact repository normal shared folder se zyada useful hoti hai kyunke yeh versions, permissions, metadata, aur downloads ko manage karti hai.

---

## 14. Artifact aur doosri DevOps files ka farq

| Item | Purpose |
|---|---|
| Source code | Application build karne ke liye |
| Artifact | Deployment ke liye tayyar application package |
| Configuration | Application ka behavior control karti hai |
| Log | Batata hai ke execution ke dauran kya hua |
| Deployment script | Validation aur deployment automate karta hai |
| Checksum | Artifact ki integrity verify karne mein madad karta hai |

Deployment log aam tor par application artifact nahin hota. Log sirf yeh record karta hai ke deployment ke waqt kya hua.

---

## 15. Successful aur failed artifact examples

### Valid artifact

```text
artifacts/inventory-api-v1.0.0.tar.gz
```

Expected result:

```text
Artifact validation pass ho gayi.
```

### Missing artifact

```text
artifacts/missing.tar.gz
```

Expected result:

```text
Artifact mojood nahin hai.
```

### Empty artifact

Empty artifact create karein:

```bash
touch artifacts/empty.tar.gz
```

Expected result:

```text
Artifact empty hai.
```

### Incorrect extension

```text
artifacts/release.txt
```

Conditionals Lab mein expected result:

```text
Artifact ki extension ghalat hai.
```

---

## 16. Classroom ke liye important definitions

### One-line definition

> DevOps artifact aik versioned, testable, aur deployable package hota hai jo application ke source code se tayyar kiya jata hai.

### Bohat asan definition

> Source code developer likhta hai; artifact DevOps engineer deploy karta hai.

### Interview answer

**Question:** DevOps mein artifact kya hota hai?

**Answer:** Artifact build process ka packaged output hota hai, jaise `.jar`, `.zip`, `.tar.gz`, binary, ya container image. Isay store, test, version, aur mukhtalif environments mein consistently deploy kiya jata hai.

---

## 17. Student practice tasks

1. `artifacts/` directory ki files list karein.
2. `file` command se `.tar.gz` artifact ka type identify karein.
3. `tar -tzf` se archive ke andar ki files dekhein.
4. Artifact ko aik new directory mein extract karein.
5. Artifact ka SHA-256 checksum generate karein.
6. Empty artifact create karke us par `-s` test karein.
7. Missing artifact par `-f` test karein.
8. `.txt` file ko `*.tar.gz` pattern ke against test karein.
9. Apne alfaaz mein `source/` aur `artifacts/` ka farq likhein.
10. Explain karein ke testing aur production mein same artifact kyun use hona chahiye.

---

## 18. Review questions

1. Artifact kya hota hai?
2. Artifact source code se kaise different hai?
3. Artifact formats ki teen misalain dein.
4. Artifact ko version kyun diya jata hai?
5. `-f` kya check karta hai?
6. `-r` kya check karta hai?
7. `-s` kya check karta hai?
8. `[[ ]]` ke andar `*.tar.gz` ka kya matlab hai?
9. Checksum kyun useful hota hai?
10. Artifact repository kya hoti hai?
11. Kya deployment log application artifact hota hai?
12. Same artifact ko test aur production mein kyun use karna chahiye?

---

## Quick summary

```text
Source code → Build → Artifact → Test → Store → Deploy
```

Yaad rakhein:

- Developer source code edit karta hai.
- Build process artifact create karta hai.
- Artifact ka clear version hona chahiye.
- Deployment se pehle artifact validate hona chahiye.
- Same artifact ko environments ke darmiyan move karna chahiye.
- Artifact repository packages ko store aur distribute karti hai.
- Logs batate hain ke kya hua; woh aam tor par application artifact nahin hote.

