# Bash Backup Rotation Script — Polished Version with Logical Blocks (Roman Urdu)

## Goal

Ye study notes polished `backup_rotation.sh` script ko **logical blocks** mein explain karti hain, taake poora flow clearly samajh aaye.

Script ka overall flow:

```text
Validate
   ↓
Paths ko normalize karo
   ↓
Backup create karo
   ↓
Matching backups find karo
   ↓
Newest first sort karo
   ↓
Latest N backups keep karo
   ↓
Older backups remove karo
   ↓
Final result report karo
```

---

# Polished Script

```bash
#!/bin/bash

# ==========================================================
# Backup Rotation Script
#
# Usage:
#   ./backup_rotation.sh <source> <backup-folder> [number-to-keep]
#
# Examples:
#   ./backup_rotation.sh data backups
#   ./backup_rotation.sh data backups 10
#
# Default:
#   If number-to-keep is not provided, latest 5 backups are kept.
# ==========================================================

function display_usage {
    echo "Usage: $0 <source> <backup-folder> [number-to-keep]"
    echo
    echo "Examples:"
    echo "  $0 data backups"
    echo "  $0 data backups 10"
}

function die {
    echo "Error: $*" >&2
    exit 1
}

if (( $# < 2 || $# > 3 )); then
    display_usage
    exit 1
fi

source_path="$1"
backup_folder="$2"
keep="${3:-5}"

if [[ ! -e "$source_path" ]]; then
    die "Source '$source_path' does not exist."
fi

if [[ ! "$keep" =~ ^[1-9][0-9]*$ ]]; then
    die "Number-to-keep must be a positive integer."
fi

if ! command -v zip &>/dev/null; then
    echo "Error: zip command is not installed." >&2
    echo
    echo "Ubuntu/Debian:"
    echo "  sudo apt install zip"
    echo
    echo "RHEL/Rocky/AlmaLinux:"
    echo "  sudo dnf install zip"
    exit 1
fi

if ! mkdir -p -- "$backup_folder"; then
    die "Could not create backup folder '$backup_folder'."
fi

source_path=$(realpath -- "$source_path") ||
    die "Could not resolve source path."

backup_folder=$(realpath -- "$backup_folder") ||
    die "Could not resolve backup folder."

if [[ -d "$source_path" ]]; then
    if [[ "$backup_folder" == "$source_path" ||
          "$backup_folder" == "$source_path/"* ]]; then
        die "Backup folder must not be inside the source directory."
    fi
fi

source_parent=$(dirname -- "$source_path")
source_name=$(basename -- "$source_path")

timestamp=$(date '+%Y-%m-%d_%H-%M-%S')
backup_file="${backup_folder}/${source_name}_backup_${timestamp}.zip"

function create_backup {

    echo
    echo "Creating backup..."
    echo "Source:      $source_path"
    echo "Destination: $backup_file"
    echo

    if (
        cd -- "$source_parent" &&
        zip -rq "$backup_file" "$source_name"
    ); then
        echo "Backup created successfully:"
        echo "$backup_file"
    else
        die "Backup creation failed."
    fi
}

function perform_rotation {

    local -a backup_records=()
    local -a backups=()
    local -a backups_to_keep=()
    local -a backups_to_remove=()

    local record
    local backup
    local deletion_failed=0

    mapfile -d '' backup_records < <(
        find "$backup_folder" \
            -maxdepth 1 \
            -type f \
            -name "${source_name}_backup_*.zip" \
            -printf '%T@ %p\0' |
            sort -z -nr
    )

    for record in "${backup_records[@]}"; do
        backups+=("${record#* }")
    done

    echo
    echo "Backup Rotation Status"
    echo "----------------------"
    echo "Total backups found: ${#backups[@]}"
    echo "Backups to keep:      $keep"

    backups_to_keep=("${backups[@]:0:$keep}")

    echo
    echo "Newest backups being kept:"

    if (( ${#backups_to_keep[@]} > 0 )); then
        printf '  %s\n' "${backups_to_keep[@]}"
    else
        echo "  None"
    fi

    backups_to_remove=("${backups[@]:$keep}")

    if (( ${#backups_to_remove[@]} == 0 )); then
        echo
        echo "No old backups need to be deleted."
        return 0
    fi

    echo
    echo "Old backups selected for deletion:"
    printf '  %s\n' "${backups_to_remove[@]}"

    echo
    echo "Deleting old backups..."

    for backup in "${backups_to_remove[@]}"; do
        if rm -- "$backup"; then
            echo "Deleted: $backup"
        else
            echo "Error: Could not delete '$backup'." >&2
            deletion_failed=1
        fi
    done

    if (( deletion_failed != 0 )); then
        return 1
    fi

    return 0
}

create_backup

if ! perform_rotation; then
    die "Backup was created, but rotation completed with errors."
fi

echo
echo "Backup and rotation completed successfully."
```

---

# Logical Block 1 — Script Header aur Usage

```bash
#!/bin/bash
```

Ye Linux ko batata hai ke script Bash ke through run karni hai.

Usage comments script chalane ka format dikhati hain:

```bash
./backup_rotation.sh <source> <backup-folder> [number-to-keep]
```

Pehle 2 arguments required hain.

Third argument optional hai.

Example:

```bash
./backup_rotation.sh data backups 10
```

Meaning:

```text
$1 = data
$2 = backups
$3 = 10
```

Agar third argument na diya jaye to default 5 backups keep hongi.

---

# Logical Block 2 — `display_usage` Function

```bash
function display_usage {
    echo "Usage: $0 <source> <backup-folder> [number-to-keep]"
    ...
}
```

Purpose:

> User ko script run karne ka correct tareeqa dikhana.

### `$0`

`$0` current script ka naam represent karta hai.

Agar file ka naam:

```text
backup_rotation.sh
```

ho to `$0` kuch aisa show kar sakta hai:

```text
./backup_rotation.sh
```

`$0` use karna hard-coded script name se better hai, kyun ke file rename ho jaye to usage message phir bhi correct rahega.

---

# Logical Block 3 — Reusable Error Handling with `die`

```bash
function die {
    echo "Error: $*" >&2
    exit 1
}
```

Instead of baar baar:

```bash
echo "Error: ..."
exit 1
```

hum likh sakte hain:

```bash
die "Backup creation failed."
```

### `$*`

Function ko pass ki gayi tamam arguments ko ek string ki tarah represent karta hai.

### `>&2`

Error message ko **stderr** par bhejta hai.

```text
1 = stdout
2 = stderr
```

Error messages ke liye stderr use karna better practice hai.

---

# Logical Block 4 — Argument Count Validate Karna

```bash
if (( $# < 2 || $# > 3 )); then
    display_usage
    exit 1
fi
```

### `$#`

Total command-line arguments ki count.

### `(( ... ))`

Arithmetic condition.

### `||`

Matlab:

> OR

So:

```bash
(( $# < 2 || $# > 3 ))
```

ka matlab:

> Agar arguments 2 se kam ya 3 se zyada hon to usage show karo aur exit karo.

Valid:

```text
2 arguments
3 arguments
```

Invalid:

```text
0
1
4+
```

---

# Logical Block 5 — Arguments Store Karna aur Default Set Karna

```bash
source_path="$1"
backup_folder="$2"
keep="${3:-5}"
```

### `$1`

Source path.

### `$2`

Backup folder.

### `${3:-5}`

Matlab:

> Agar `$3` diya gaya ho to use karo, warna default `5`.

Example:

```bash
./backup_rotation.sh data backups
```

Result:

```text
keep=5
```

Aur:

```bash
./backup_rotation.sh data backups 10
```

Result:

```text
keep=10
```

General syntax:

```text
${variable:-default}
```

---

# Logical Block 6 — Source Validate Karna

```bash
if [[ ! -e "$source_path" ]]; then
    die "Source '$source_path' does not exist."
fi
```

### `-e`

Check karta hai ke path exist karta hai ya nahi.

Ye file aur directory dono ke liye kaam karta hai.

### `!`

Matlab:

> NOT

So:

```bash
[[ ! -e "$source_path" ]]
```

ka matlab:

> Agar source exist nahi karta to script stop karo.

---

# Logical Block 7 — Retention Value Validate Karna

```bash
if [[ ! "$keep" =~ ^[1-9][0-9]*$ ]]; then
    die "Number-to-keep must be a positive integer."
fi
```

Ye check karta hai ke `keep` positive integer hai.

### `=~`

Bash regex matching operator.

Regex:

```text
^[1-9][0-9]*$
```

Breakdown:

```text
^        = string start
[1-9]    = first digit 1 se 9
[0-9]*   = uske baad zero ya zyada digits
$        = string end
```

Valid:

```text
1
5
10
25
100
```

Invalid:

```text
0
-5
abc
5.5
```

---

# Logical Block 8 — Check ke `zip` Installed Hai

```bash
if ! command -v zip &>/dev/null; then
```

### `command -v zip`

Check karta hai ke `zip` command available hai ya nahi.

Manual test:

```bash
command -v zip
```

Possible output:

```text
/usr/bin/zip
```

### `&>/dev/null`

stdout aur stderr dono hide kar deta hai.

Yahan humein output nahi chahiye, sirf success/failure status chahiye.

Script Ubuntu/Debian aur RHEL/Rocky/AlmaLinux ke install commands bhi show karti hai.

---

# Logical Block 9 — Backup Folder Create Karna

```bash
if ! mkdir -p -- "$backup_folder"; then
    die "Could not create backup folder '$backup_folder'."
fi
```

### `mkdir`

Directory create karta hai.

### `-p`

Useful kyun ke:

- directory already ho to error nahi
- missing parent directories bhi create ho jati hain

### `--`

Options ka end show karta hai.

Ye block `mkdir` failure ko bhi handle karta hai.

---

# Logical Block 10 — Paths ko Absolute Paths mein Convert Karna

```bash
source_path=$(realpath -- "$source_path") ||
    die "Could not resolve source path."

backup_folder=$(realpath -- "$backup_folder") ||
    die "Could not resolve backup folder."
```

Example relative path:

```text
data
```

convert ho sakta hai:

```text
/home/khalid/project/data
```

### Ye kyun important hai?

Baad mein script `cd` karti hai.

Agar backup path relative rahe to `cd` ke baad uska meaning change ho sakta hai.

Absolute path hamesha same location ko refer karta hai.

---

# Logical Block 11 — Backup Folder ko Source ke Andar Hone se Prevent Karna

```bash
if [[ -d "$source_path" ]]; then
    if [[ "$backup_folder" == "$source_path" ||
          "$backup_folder" == "$source_path/"* ]]; then
        die "Backup folder must not be inside the source directory."
    fi
fi
```

Example:

```text
source=/home/khalid/data
```

Unsafe destination:

```text
/home/khalid/data/backups
```

Isko prevent kiya gaya hai.

Reason:

> Backup file ko usi source directory ke andar create nahi karna chahiye jiska backup liya ja raha hai.

---

# Logical Block 12 — Source Parent aur Source Name Nikalna

```bash
source_parent=$(dirname -- "$source_path")
source_name=$(basename -- "$source_path")
```

Example:

```text
source_path=/home/khalid/data
```

Results:

```text
source_parent=/home/khalid
source_name=data
```

Visual:

```text
/home/khalid/data
│            │
│            └── source_name
└─────────────── source_parent
```

Easy memory:

```text
dirname  = kahan rakha hua hai?
basename = iska naam kya hai?
```

---

# Logical Block 13 — Timestamped Backup Filename

```bash
timestamp=$(date '+%Y-%m-%d_%H-%M-%S')
backup_file="${backup_folder}/${source_name}_backup_${timestamp}.zip"
```

### `$(...)`

Command substitution.

Example timestamp:

```text
2026-09-05_19-45-30
```

Final backup name:

```text
/home/khalid/backups/data_backup_2026-09-05_19-45-30.zip
```

Is se har backup ka unique aur readable naam banta hai.

---

# Logical Block 14 — `create_backup` Function

Is function ka purpose:

> ZIP backup create karna aur failure properly handle karna.

Function pehle source aur destination show karti hai:

```text
Source
Destination
```

Ye troubleshooting mein helpful hai.

---

# Logical Block 15 — Subshell Use Karna

```bash
if (
    cd -- "$source_parent" &&
    zip -rq "$backup_file" "$source_name"
); then
```

### `( ... )`

Parentheses ke andar commands **subshell** mein run hoti hain.

Iska faida:

```bash
cd -- "$source_parent"
```

sirf subshell mein directory change karta hai.

Main script ki working directory permanently change nahi hoti.

---

# Logical Block 16 — `cd` aur `&&`

```bash
cd -- "$source_parent" &&
zip -rq "$backup_file" "$source_name"
```

### `&&`

Matlab:

> Next command sirf tab run karo jab previous command successful ho.

Flow:

```text
cd successful?
   ├── YES → zip run
   └── NO  → zip skip
```

---

# Logical Block 17 — Parent Directory mein `cd` Kyun?

Suppose:

```text
source=/home/khalid/data
```

Script:

```bash
cd /home/khalid
```

karti hai aur phir:

```bash
zip -r backup.zip data
```

run karti hai.

Is se ZIP ke andar clean structure milta hai:

```text
data/
├── file1.txt
├── file2.txt
└── logs/
```

instead of unnecessary long path.

---

# Logical Block 18 — ZIP Options

```bash
zip -rq -- "$backup_file" "$source_name"
```

### `-r`

Recursive.

### `-q`

Quiet mode.

### `--`

Options ka end.

### `"$backup_file"`

Destination ZIP archive.

### `"$source_name"`

Source item jo archive hona hai.

---

# Logical Block 19 — Backup Success ya Failure

Agar `cd` aur `zip` dono successful hon:

```bash
echo "Backup created successfully:"
```

Agar fail hon:

```bash
die "Backup creation failed."
```

Ye accurate status provide karta hai.

---

# Logical Block 20 — `perform_rotation` Function

Purpose:

> Matching backups find karo, newest first sort karo, latest N keep karo aur older remove karo.

---

# Logical Block 21 — Local Arrays

```bash
local -a backup_records=()
local -a backups=()
local -a backups_to_keep=()
local -a backups_to_remove=()
```

### `local`

Variable sirf current function ke andar available hota hai.

### `-a`

Indexed Bash array declare karta hai.

Ye unnecessary global variables se bachata hai.

---

# Logical Block 22 — Matching Backups Find aur Sort Karna

```bash
mapfile -d '' backup_records < <(
    find "$backup_folder" \
        -maxdepth 1 \
        -type f \
        -name "${source_name}_backup_*.zip" \
        -printf '%T@ %p\0' |
        sort -z -nr
)
```

Overall flow:

```text
find
 ↓
matching ZIP files
 ↓
timestamp + path
 ↓
newest-first sort
 ↓
mapfile
 ↓
backup_records array
```

---

# Logical Block 23 — `find` Options

```bash
find "$backup_folder"
```

Backup folder mein search.

### `-maxdepth 1`

Subdirectories ke andar mat jao.

### `-type f`

Sirf regular files.

### `-name`

```bash
-name "${source_name}_backup_*.zip"
```

Sirf current source ke matching backups.

Agar:

```text
source_name=data
```

to pattern:

```text
data_backup_*.zip
```

---

# Logical Block 24 — `find -printf`

```bash
-printf '%T@ %p\0'
```

### `%T@`

Modification timestamp.

### `%p`

File path.

### `\0`

Null separator.

Null separator filenames with spaces aur unusual characters ke liye safer hota hai.

---

# Logical Block 25 — Newest First Sort

```bash
sort -z -nr
```

### `-z`

Null-separated records.

### `-n`

Numeric sort.

### `-r`

Reverse order.

Timestamp numeric value ko reverse sort karne se result:

```text
newest
↓
older
↓
oldest
```

milta hai.

---

# Logical Block 26 — `mapfile`

```bash
mapfile -d '' backup_records
```

Input records ko Bash array mein load karta hai.

### `-d ''`

Null delimiter use karta hai.

Ye teen cheezen team ki tarah kaam karti hain:

```text
find ... \0
     ↓
sort -z
     ↓
mapfile -d ''
```

---

# Logical Block 27 — Timestamp Portion Remove Karna

```bash
for record in "${backup_records[@]}"; do
    backups+=("${record#* }")
done
```

Record conceptually:

```text
1788650000.123 /home/khalid/backups/data_backup_01.zip
```

### `${record#* }`

Beginning se first space tak shortest matching portion remove karta hai.

Result:

```text
/home/khalid/backups/data_backup_01.zip
```

Phir path `backups` array mein add hota hai.

---

# Logical Block 28 — Rotation Status Show Karna

```bash
echo "Total backups found: ${#backups[@]}"
echo "Backups to keep:      $keep"
```

### `${#backups[@]}`

Array ke total elements ki count.

Example:

```text
Total backups found: 8
Backups to keep:      5
```

---

# Logical Block 29 — Backups to Keep Select Karna

```bash
backups_to_keep=("${backups[@]:0:$keep}")
```

Array slicing format:

```text
${array[@]:start:length}
```

Agar:

```text
keep=5
```

to:

```bash
"${backups[@]:0:5}"
```

indexes:

```text
0 1 2 3 4
```

select hongi.

Ye latest 5 backups hain.

---

# Logical Block 30 — Backups to Remove Select Karna

```bash
backups_to_remove=("${backups[@]:$keep}")
```

Agar:

```text
keep=5
```

to conceptually:

```bash
"${backups[@]:5}"
```

Meaning:

```text
0 → KEEP
1 → KEEP
2 → KEEP
3 → KEEP
4 → KEEP

5 → REMOVE
6 → REMOVE
7 → REMOVE
```

---

# Logical Block 31 — Agar Old Backups na Hon

```bash
if (( ${#backups_to_remove[@]} == 0 )); then
    ...
    return 0
fi
```

Agar koi old backup nahi hai to function successfully finish ho jata hai.

### `return 0`

Sirf current function ko finish karta hai.

Ye `exit 0` se better hai, kyun ke `exit` poori script terminate kar deta.

---

# Logical Block 32 — Old Backups Delete Karna

```bash
for backup in "${backups_to_remove[@]}"; do
    if rm -- "$backup"; then
        echo "Deleted: $backup"
    else
        echo "Error: Could not delete '$backup'." >&2
        deletion_failed=1
    fi
done
```

Har old backup one-by-one process hota hai.

Deletion result check hota hai.

Failure stderr par report hoti hai.

---

# Logical Block 33 — Deletion Failure Track Karna

```bash
local deletion_failed=0
```

Agar koi deletion fail kare:

```bash
deletion_failed=1
```

Loop ke baad:

```bash
if (( deletion_failed != 0 )); then
    return 1
fi
```

Is se function main program ko bata sakta hai ke rotation mein error aayi.

---

# Logical Block 34 — Main Program

```bash
create_backup

if ! perform_rotation; then
    die "Backup was created, but rotation completed with errors."
fi

echo
echo "Backup and rotation completed successfully."
```

Execution order:

```text
create_backup
      ↓
perform_rotation
      ↓
final status
```

Agar backup creation fail ho to script immediately stop ho jati hai.

Agar backup create ho jaye lekin rotation fail ho to accurate error show hota hai.

---

# Complete Script Flow

```text
START
  ↓
Argument count validate
  ↓
Arguments read
  ↓
Source validate
  ↓
Retention validate
  ↓
zip check
  ↓
Backup directory create
  ↓
Paths absolute banao
  ↓
Unsafe destination prevent karo
  ↓
Source parent aur name nikalo
  ↓
Timestamped filename banao
  ↓
Subshell mein ZIP create karo
  ↓
Matching backups find karo
  ↓
Newest-first sort karo
  ↓
Arrays mein load karo
  ↓
Latest N keep karo
  ↓
Older backups select karo
  ↓
Delete karo
  ↓
Result report karo
END
```

---

# Polished Version ki Main Improvements

1. **Reusable error handling** with `die`.
2. **Optional retention argument** with default 5.
3. **Source validation**.
4. **Retention value validation**.
5. **`zip` dependency check**.
6. **Backup directory auto-create**.
7. **Absolute paths with `realpath`**.
8. **Backup folder ko source ke andar hone se prevent karna**.
9. **Clean ZIP structure using subshell + `cd`**.
10. **Local arrays** inside rotation function.
11. **Safer backup discovery using `find + sort + mapfile`**.
12. **Null-separated records** for safer filename handling.
13. **Clear keep/remove arrays**.
14. **Deletion failure tracking**.
15. **`return` inside functions** instead of unnecessary `exit`.

---

# Quick Revision

```text
$0                         = script name
$1                         = source
$2                         = backup folder
$3                         = number to keep
$#                         = total arguments

${3:-5}                    = $3 use karo, warna 5

-e                         = path exist karta hai
-d                         = directory test
=~                         = regex match

command -v                 = command availability check
&>/dev/null                = stdout + stderr hide

mkdir -p                   = directory safely create
realpath                    = absolute path
dirname                     = parent path
basename                    = final name

$(command)                 = command substitution

( commands )               = subshell
&&                         = next command sirf success par

zip -r                     = recursive
zip -q                     = quiet

local -a                    = local indexed array
mapfile                     = input ko array mein load karo

find -maxdepth 1            = current folder only
find -type f                = regular files only
find -name                  = filename pattern
%T@                         = modification timestamp
%p                          = file path
\0                          = null separator

sort -z                     = null-separated
sort -n                     = numeric
sort -r                     = reverse

${#array[@]}                = array length
${array[@]:0:N}             = first N elements
${array[@]:N}               = index N se end tak

${record#* }                = first space tak prefix remove

return 0                    = function success
return 1                    = function failure
>&2                         = stderr
```

---

# Suggested Study Order

```text
1. Arguments
2. Default values
3. Validation
4. Error function
5. Paths
6. dirname / basename
7. Timestamp
8. Subshell
9. ZIP
10. find
11. sort
12. mapfile
13. Arrays
14. Array slicing
15. Loops
16. Return codes
17. Rotation
```

---

# Example Commands

Default — latest 5 keep karo:

```bash
./backup_rotation.sh data backups
```

Latest 10 keep karo:

```bash
./backup_rotation.sh data backups 10
```

Absolute paths ke saath:

```bash
./backup_rotation.sh /home/khalid/data /home/khalid/backups 5
```

---

# Final Memory Flow

```text
VALIDATE
   ↓
PATHS NORMALIZE
   ↓
BACKUP CREATE
   ↓
FIND + SORT
   ↓
KEEP N
   ↓
REMOVE OLD
   ↓
REPORT RESULT
```
