# Bash Backup Rotation Script — Polished Version with Logical Blocks

## Goal

This note explains the polished `backup_rotation.sh` script by **logical blocks** rather than isolated lines. The goal is to understand the complete flow:

```text
Validate
   ↓
Normalize paths
   ↓
Create backup
   ↓
Find matching backups
   ↓
Sort newest first
   ↓
Keep latest N
   ↓
Remove older backups
   ↓
Report result
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

# Logical Block 1 — Script Header and Usage

```bash
#!/bin/bash
```

This tells Linux to run the script with Bash.

The usage comments show the command format:

```bash
./backup_rotation.sh <source> <backup-folder> [number-to-keep]
```

The first two arguments are required. The third is optional.

Example:

```bash
./backup_rotation.sh data backups 10
```

```text
$1 = data
$2 = backups
$3 = 10
```

---

# Logical Block 2 — `display_usage`

```bash
function display_usage {
    echo "Usage: $0 <source> <backup-folder> [number-to-keep]"
    ...
}
```

Purpose:

> Show the correct way to run the script.

`$0` is the current script name. Using `$0` is better than hard-coding `backup_rotation.sh` because the message still stays correct if the file is renamed.

---

# Logical Block 3 — Reusable Error Handling with `die`

```bash
function die {
    echo "Error: $*" >&2
    exit 1
}
```

Instead of repeatedly writing:

```bash
echo "Error: ..."
exit 1
```

we can use:

```bash
die "Backup creation failed."
```

`$*` represents all arguments passed to the function.

`>&2` sends the error message to **stderr**.

```text
1 = stdout
2 = stderr
```

---

# Logical Block 4 — Validate Argument Count

```bash
if (( $# < 2 || $# > 3 )); then
    display_usage
    exit 1
fi
```

`$#` = total number of command-line arguments.

`(( ... ))` = arithmetic condition.

`||` = OR.

So the condition means:

> If fewer than 2 arguments or more than 3 arguments are supplied, show usage and exit.

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

# Logical Block 5 — Store Arguments and Set Default Retention

```bash
source_path="$1"
backup_folder="$2"
keep="${3:-5}"
```

`$1` = source.

`$2` = backup folder.

`${3:-5}` means:

> Use `$3` if provided; otherwise use `5`.

Examples:

```bash
./backup_rotation.sh data backups
```

Result:

```text
keep=5
```

```bash
./backup_rotation.sh data backups 10
```

Result:

```text
keep=10
```

General form:

```text
${variable:-default}
```

---

# Logical Block 6 — Validate Source

```bash
if [[ ! -e "$source_path" ]]; then
    die "Source '$source_path' does not exist."
fi
```

`-e` checks whether a path exists.

It supports both files and directories.

`!` means NOT.

So this block means:

> If the source does not exist, stop the script.

---

# Logical Block 7 — Validate Retention Value

```bash
if [[ ! "$keep" =~ ^[1-9][0-9]*$ ]]; then
    die "Number-to-keep must be a positive integer."
fi
```

`=~` performs regex matching.

Regex:

```text
^[1-9][0-9]*$
```

Meaning:

```text
^        start
[1-9]    first digit 1-9
[0-9]*   zero or more additional digits
$        end
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

# Logical Block 8 — Check Whether `zip` Is Installed

```bash
if ! command -v zip &>/dev/null; then
```

`command -v zip` checks whether `zip` is available.

`&>/dev/null` hides both stdout and stderr.

We only need the exit status, not the printed path.

The script provides installation commands for both Debian/Ubuntu and RHEL-family systems.

---

# Logical Block 9 — Create the Backup Folder

```bash
if ! mkdir -p -- "$backup_folder"; then
    die "Could not create backup folder '$backup_folder'."
fi
```

`mkdir` creates a directory.

`-p`:

- creates missing parent directories
- does not fail just because the directory already exists

`--` marks the end of options.

This block also checks whether directory creation failed.

---

# Logical Block 10 — Convert Paths to Absolute Paths

```bash
source_path=$(realpath -- "$source_path") ||
    die "Could not resolve source path."

backup_folder=$(realpath -- "$backup_folder") ||
    die "Could not resolve backup folder."
```

Example:

```text
data
```

may become:

```text
/home/khalid/project/data
```

Why is this important?

Later the script changes directory with `cd`. A relative backup path could then point to the wrong location. Absolute paths remain correct regardless of the current working directory.

---

# Logical Block 11 — Prevent the Backup Folder from Being Inside the Source

```bash
if [[ -d "$source_path" ]]; then
    if [[ "$backup_folder" == "$source_path" ||
          "$backup_folder" == "$source_path/"* ]]; then
        die "Backup folder must not be inside the source directory."
    fi
fi
```

Example source:

```text
/home/khalid/data
```

Unsafe destination:

```text
/home/khalid/data/backups
```

This is prevented because the backup archive should not be created inside the directory being backed up.

---

# Logical Block 12 — Extract Source Parent and Source Name

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

`dirname` asks:

> Where is it located?

`basename` asks:

> What is its final name?

---

# Logical Block 13 — Create Timestamped Backup Filename

```bash
timestamp=$(date '+%Y-%m-%d_%H-%M-%S')
backup_file="${backup_folder}/${source_name}_backup_${timestamp}.zip"
```

`$(...)` is command substitution.

Example timestamp:

```text
2026-09-05_19-45-30
```

Example final file:

```text
/home/khalid/backups/data_backup_2026-09-05_19-45-30.zip
```

This produces unique and readable backup names.

---

# Logical Block 14 — `create_backup` Function

This function creates the ZIP archive and handles failures.

It first prints:

```text
Source
Destination
```

so it is easy to see exactly what is happening.

---

# Logical Block 15 — Use a Subshell

```bash
if (
    cd -- "$source_parent" &&
    zip -rq "$backup_file" "$source_name"
); then
```

Commands inside:

```bash
( ... )
```

run in a **subshell**.

This means the `cd` only affects the subshell. The main script's working directory does not permanently change.

---

# Logical Block 16 — `cd` and `&&`

```bash
cd -- "$source_parent" &&
zip -rq -- "$backup_file" "$source_name"
```

`&&` means:

> Run the next command only if the previous command succeeds.

Flow:

```text
cd successful?
   ├── YES → run zip
   └── NO  → skip zip
```

---

# Logical Block 17 — Why Change to the Parent Directory?

Suppose:

```text
source=/home/khalid/data
```

The script changes to:

```text
/home/khalid
```

and then zips:

```text
data
```

This gives a clean ZIP structure:

```text
data/
├── file1.txt
├── file2.txt
└── logs/
```

instead of storing an unnecessarily long path.

---

# Logical Block 18 — ZIP Options

```bash
zip -rq  "$backup_file" "$source_name"
```

`-r` = recursive.

`-q` = quiet.

`--` = end of options.

`"$backup_file"` = destination archive.

`"$source_name"` = source item being archived.

---

# Logical Block 19 — Backup Success or Failure

If `cd` and `zip` succeed:

```bash
echo "Backup created successfully:"
```

If either fails:

```bash
die "Backup creation failed."
```

This gives accurate status instead of printing success blindly.

---

# Logical Block 20 — `perform_rotation` Function

Purpose:

> Find matching backups, sort them newest first, keep the latest N, and delete older ones.

This function uses local variables so they stay inside the function.

---

# Logical Block 21 — Local Arrays

```bash
local -a backup_records=()
local -a backups=()
local -a backups_to_keep=()
local -a backups_to_remove=()
```

`local` = variable exists only inside the function.

`-a` = indexed Bash array.

This keeps the script cleaner and avoids unnecessary global variables.

---

# Logical Block 22 — Find and Sort Matching Backups

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
sort newest first
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

Search in the backup folder.

```bash
-maxdepth 1
```

Do not search inside nested subdirectories.

```bash
-type f
```

Only regular files.

```bash
-name "${source_name}_backup_*.zip"
```

Only backups belonging to the current source.

If:

```text
source_name=data
```

then matches look like:

```text
data_backup_*.zip
```

---

# Logical Block 24 — `find -printf`

```bash
-printf '%T@ %p\0'
```

`%T@` = modification timestamp.

`%p` = file path.

`\0` = null separator.

Null separators are safer for filenames containing spaces or unusual characters.

---

# Logical Block 25 — Sort Newest First

```bash
sort -z -nr
```

`-z` = null-separated records.

`-n` = numeric sort.

`-r` = reverse order.

Because the first value is the modification timestamp, reverse numeric order gives:

```text
newest
↓
older
↓
oldest
```

---

# Logical Block 26 — `mapfile`

```bash
mapfile -d '' backup_records
```

Loads records into a Bash array.

`-d ''` uses the null character as the delimiter.

These work together:

```text
find ... \0
     ↓
sort -z
     ↓
mapfile -d ''
```

---

# Logical Block 27 — Remove Timestamp Portion

```bash
for record in "${backup_records[@]}"; do
    backups+=("${record#* }")
done
```

A record conceptually looks like:

```text
1788650000.123 /home/khalid/backups/data_backup_01.zip
```

`${record#* }` removes the timestamp and first space.

Result:

```text
/home/khalid/backups/data_backup_01.zip
```

Then that path is added to the `backups` array.

---

# Logical Block 28 — Show Rotation Status

```bash
echo "Total backups found: ${#backups[@]}"
echo "Backups to keep:      $keep"
```

`${#backups[@]}` = number of elements in the array.

Example:

```text
Total backups found: 8
Backups to keep:      5
```

---

# Logical Block 29 — Select Backups to Keep

```bash
backups_to_keep=("${backups[@]:0:$keep}")
```

Array slice format:

```text
${array[@]:start:length}
```

If:

```text
keep=5
```

then:

```bash
"${backups[@]:0:5}"
```

selects indexes:

```text
0 1 2 3 4
```

These are the newest 5 backups.

---

# Logical Block 30 — Select Backups to Remove

```bash
backups_to_remove=("${backups[@]:$keep}")
```

If:

```text
keep=5
```

this means:

```bash
"${backups[@]:5}"
```

So:

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

# Logical Block 31 — No Old Backups

```bash
if (( ${#backups_to_remove[@]} == 0 )); then
    ...
    return 0
fi
```

If there are no old backups, the function finishes successfully.

`return 0` ends only the function.

This is better than `exit 0`, which would terminate the entire script.

---

# Logical Block 32 — Delete Old Backups

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

Each old backup is processed one at a time.

Deletion success is checked.

Failed deletions are reported to stderr.

---

# Logical Block 33 — Track Rotation Failure

```bash
local deletion_failed=0
```

If any deletion fails:

```bash
deletion_failed=1
```

After the loop:

```bash
if (( deletion_failed != 0 )); then
    return 1
fi
```

This allows the function to report failure back to the main program.

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

If backup creation fails, the script stops immediately.

If backup succeeds but cleanup fails, the script reports that accurately.

---

# Complete Script Flow

```text
START
  ↓
Validate argument count
  ↓
Read arguments
  ↓
Validate source
  ↓
Validate retention
  ↓
Check zip
  ↓
Create backup directory
  ↓
Convert paths to absolute paths
  ↓
Prevent unsafe backup destination
  ↓
Get source parent and name
  ↓
Create timestamped backup filename
  ↓
Create ZIP in subshell
  ↓
Find matching backups
  ↓
Sort newest first
  ↓
Load into arrays
  ↓
Keep latest N
  ↓
Select older backups
  ↓
Delete older backups
  ↓
Report result
END
```

---

# Key Improvements in This Polished Version

1. **Reusable error handling** with `die`.
2. **Optional retention argument** with default value.
3. **Input validation** for source and retention.
4. **Dependency check** for `zip`.
5. **Absolute paths** with `realpath`.
6. **Protection** against backup folder being inside source.
7. **Clean ZIP structure** using a subshell and `cd`.
8. **Local arrays** inside rotation function.
9. **Production-safer discovery** using `find + sort + mapfile`.
10. **Null-separated records** for safer filename handling.
11. **Separate keep/remove arrays** for clearer rotation logic.
12. **Deletion error tracking** instead of silently ignoring failures.
13. **`return` inside functions** rather than terminating the whole script unnecessarily.

---

# Quick Revision

```text
$0                         = script name
$1                         = source
$2                         = backup folder
$3                         = number to keep
$#                         = number of arguments

${3:-5}                    = use $3 or default to 5

-e                         = path exists
-d                         = directory test
=~                         = regex match

command -v                 = check command availability
&>/dev/null                = hide stdout + stderr

mkdir -p                   = create directory safely
realpath                    = absolute path
dirname                     = parent path
basename                    = final name

$(command)                 = command substitution

( commands )               = subshell
&&                         = run next only on success

zip -r                     = recursive
zip -q                     = quiet

local -a                    = local indexed array
mapfile                     = load input into array

find -maxdepth 1            = current folder only
find -type f                = regular files
find -name                  = filename pattern
%T@                         = modification timestamp
%p                          = path
\0                          = null separator

sort -z                     = null-separated
sort -n                     = numeric
sort -r                     = reverse

${#array[@]}                = array length
${array[@]:0:N}             = first N elements
${array[@]:N}               = index N to end

${record#* }                = remove prefix through first space

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
16. return codes
17. Rotation
```

---

# Example Commands

Default — keep 5:

```bash
./backup_rotation.sh data backups
```

Keep 10:

```bash
./backup_rotation.sh data backups 10
```

Absolute paths:

```bash
./backup_rotation.sh /home/khalid/data /home/khalid/backups 5
```

---

# Final Memory Flow

```text
VALIDATE
   ↓
NORMALIZE PATHS
   ↓
CREATE BACKUP
   ↓
FIND + SORT
   ↓
KEEP N
   ↓
REMOVE OLD
   ↓
REPORT RESULT
```
