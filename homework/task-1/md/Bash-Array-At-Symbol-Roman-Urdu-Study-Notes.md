# Bash Array `[@]` — Roman Urdu Study Notes

## Table of Contents

- [Introduction](#introduction)
- [Bash Array Banana](#bash-array-banana)
- [Har Symbol ka Matlab](#har-symbol-ka-matlab)
- [Loop Mein Istemal](#loop-mein-istemal)
- [Double Quotes Kyun Zaroori Hain?](#double-quotes-kyun-zaroori-hain)
- [Array ka Ek Element Access Karna](#array-ka-ek-element-access-karna)
- [Array Elements Count Karna](#array-elements-count-karna)
- [`[@]` aur `[*]` ka Farq](#array-at-aur-array-star-ka-farq)
- [Array ko Function Mein Pass Karna](#array-ko-function-mein-pass-karna)
- [Common Mistakes](#common-mistakes)
- [Quick Reference](#quick-reference)
- [Complete Practice Script](#complete-practice-script)
- [Key Lesson](#key-lesson)

## Introduction

Bash mein:

```bash
"${fruits[@]}"
```

ka matlab hai:

> `fruits` array ke tamam elements ko expand karo aur har element ko alag aur bilkul usi halat mein rakho.

`[@]` ko array ke naam ke saath uske tamam elements select karne ke liye use kiya jata hai.

## Bash Array Banana

```bash
fruits=("apple" "banana" "red cherry")
```

Is array mein teen elements hain:

| Index | Element |
|---:|---|
| `0` | `apple` |
| `1` | `banana` |
| `2` | `red cherry` |

Bash arrays normally index `0` se shuru hoti hain.

## Har Symbol ka Matlab

Is expression ko dekhein:

```bash
"${fruits[@]}"
```

| Part | Roman Urdu mein matlab |
|---|---|
| `$` | Bash se value hasil karo |
| `{ }` | Parameter-expansion expression ko wazeh taur par mark karo |
| `fruits` | Array ka naam |
| `[@]` | Array ke tamam elements select karo |
| `" "` | Har element ko safely preserve karo |

Aap isay is tarah parh sakte hain:

> Dollar, opening brace, fruits array at, closing brace—in double quotes.

Iska sab se important practical matlab hai:

```text
Array ke har element ko ek alag value ke taur par use karo.
```

## Loop Mein Istemal

```bash
#!/bin/bash

fruits=("apple" "banana" "red cherry")

for fruit in "${fruits[@]}"
do
    echo "Fruit: $fruit"
done
```

Output:

```text
Fruit: apple
Fruit: banana
Fruit: red cherry
```

Loop teen martaba chalta hai kyun ke array mein teen elements hain.

| Loop run | `fruit` ki value |
|---:|---|
| 1 | `apple` |
| 2 | `banana` |
| 3 | `red cherry` |

## Double Quotes Kyun Zaroori Hain?

Recommended form:

```bash
for fruit in "${fruits[@]}"
```

Double quotes `red cherry` ko ek hi element ke taur par preserve karti hain.

Quotes ke baghair:

```bash
for fruit in ${fruits[@]}
```

Bash word splitting kar sakta hai. Do alfaaz wala element alag ho sakta hai:

```text
Fruit: apple
Fruit: banana
Fruit: red
Fruit: cherry
```

Loop ghalti se teen array elements ki jagah chaar words process karega.

Is liye normally yeh form use karein:

```bash
"${fruits[@]}"
```

## Array ka Ek Element Access Karna

Kisi ek element ko access karne ke liye square brackets ke andar uska index use karein.

### Pehla element

```bash
echo "${fruits[0]}"
```

Output:

```text
apple
```

### Doosra element

```bash
echo "${fruits[1]}"
```

Output:

```text
banana
```

### Teesra element

```bash
echo "${fruits[2]}"
```

Output:

```text
red cherry
```

### Tamam elements

```bash
echo "${fruits[@]}"
```

Screen par output:

```text
apple banana red cherry
```

`echo` values ko ek line par dikhata hai, lekin quoted `[@]` phir bhi har element ko ek alag argument ke taur par expand karta hai.

## Array Elements Count Karna

```bash
echo "${#fruits[@]}"
```

Output:

```text
3
```

Matlab:

| Part | Roman Urdu mein matlab |
|---|---|
| `${fruits[@]}` | Tamam elements |
| `#` | Selected elements ko count karo |
| `${#fruits[@]}` | Array mein elements ki total tadaad |

Example:

```bash
echo "Total fruits: ${#fruits[@]}"
```

Output:

```text
Total fruits: 3
```

## Array At aur Array Star ka Farq

Jab in expressions ko double quotes mein likha jata hai, to inka behavior mukhtalif hota hai.

### Quoted `[@]`

```bash
"${fruits[@]}"
```

Har element ko ek alag argument ke taur par expand karta hai:

```text
Argument 1: apple
Argument 2: banana
Argument 3: red cherry
```

### Quoted `[*]`

```bash
"${fruits[*]}"
```

Tamam elements ko jor kar ek hi argument bana deta hai:

```text
Argument 1: apple banana red cherry
```

### Comparison

| Expression | Arguments ki tadaad | Normal use |
|---|---:|---|
| `"${fruits[@]}"` | Har array element ke liye ek argument | Loops, functions aur commands |
| `"${fruits[*]}"` | Ek combined argument | Puri array ko ek string mein join karna |

Zyada tar array loops aur function calls ke liye yeh use karein:

```bash
"${fruits[@]}"
```

## Array ko Function Mein Pass Karna

```bash
#!/bin/bash

fruits=("apple" "banana" "red cherry")

show_items()
{
    echo "Argument count: $#"

    for item in "$@"
    do
        echo "Item: $item"
    done
}

show_items "${fruits[@]}"
```

Output:

```text
Argument count: 3
Item: apple
Item: banana
Item: red cherry
```

Yeh expansion:

```bash
show_items "${fruits[@]}"
```

function ko teen alag arguments pass karta hai.

Function ke andar:

```bash
"$@"
```

tamam function arguments ko represent karta hai aur har argument ko alag preserve karta hai.

### `[*]` ke saath kya hota hai?

```bash
show_items "${fruits[*]}"
```

Output:

```text
Argument count: 1
Item: apple banana red cherry
```

Tamam array elements join hokar ek argument ke taur par pass hue.

## Common Mistakes

### Mistake 1: Double quotes bhool jana

```bash
for fruit in ${fruits[@]}
```

Yeh spaces wale elements ko alag words mein split kar sakta hai.

Sahi form:

```bash
for fruit in "${fruits[@]}"
```

### Mistake 2: Sirf `$fruits` use karna

```bash
echo "$fruits"
```

Yeh normally sirf element `0` ko access karta hai.

Tamam elements ke liye:

```bash
echo "${fruits[@]}"
```

### Mistake 3: Array `[@]` aur positional `"$@"` ko ek samajhna

```bash
"${fruits[@]}"
```

ka matlab named array `fruits` ke tamam elements hain.

```bash
"$@"
```

ka matlab script ya current function ko pass kiye gaye tamam positional arguments hain.

Jab dono quoted hon, to dono apni values ko alag arguments ke taur par preserve karte hain.

## Quick Reference

```bash
fruits=("apple" "banana" "red cherry")
```

| Expression | Roman Urdu mein matlab |
|---|---|
| `${fruits[0]}` | Pehla element |
| `${fruits[1]}` | Doosra element |
| `${fruits[@]}` | Tamam elements |
| `"${fruits[@]}"` | Tamam elements ko safely aur alag preserve karo |
| `${#fruits[@]}` | Elements ki tadaad |
| `"${fruits[*]}"` | Tamam elements ko jor kar ek argument banao |
| `"$@"` | Script ya function ke tamam arguments ko alag preserve karo |
| `$#` | Script ya function arguments ki tadaad |

## Complete Practice Script

```bash
#!/bin/bash

fruits=("apple" "banana" "red cherry")

echo "Total fruits: ${#fruits[@]}"

item_number=1

for fruit in "${fruits[@]}"
do
    echo "Item $item_number: $fruit"
    ((item_number++))
done
```

Output:

```text
Total fruits: 3
Item 1: apple
Item 2: banana
Item 3: red cherry
```

Script ka syntax check karein:

```bash
bash -n array-practice.sh
```

Script run karein:

```bash
bash array-practice.sh
```

## Key Lesson

```bash
"${array[@]}"
```

ka matlab hai:

> Array ke har element ko alag expand karo aur har element ke andar maujood spaces aur special characters ko preserve karo.

Bash array loops aur function arguments ke liye quoted `[@]` normally sab se safe aur munasib form hai.

