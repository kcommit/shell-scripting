# Bash Scripting Level 1 —  Foundation

A zero-level Bash scripting package that takes students from their first script to simple real-life decisions.

The package follows one teaching rule:

> **One small concept, one simple script, one clear result.**

Students should complete the assignment first, compare their work with the solution afterward, and finish with the interactive MCQ quiz.

## Learning flow

```mermaid
flowchart LR
    A["1. Read the lab"] --> B["2. Write the scripts"]
    B --> C["3. Test the work"]
    C --> D["4. Review solutions"]
    D --> E["5. Take the MCQ quiz"]
```

## Package contents

```text
level-1/
├── README.md
├── Level-1-Foundation-Lab.md
├── Bash-Scripting-Foundation-MCQ-Quiz.html
└── Bash-Baby-Steps-Foundation-Solution/
    ├── README.md
    ├── 01-welcome.sh
    ├── 02-class-info.sh
    ├── 03-student-introduction.sh
    ├── 04-session-info.sh
    ├── 05-output-error.sh
    ├── 06-fruit-arguments.sh
    ├── 07-weather-helper.sh
    ├── 08-traffic-light.sh
    ├── 09-marks-result.sh
    ├── 10-homework-check.sh
    ├── 11-class-assistant.sh
    └── homework.txt
```

## Main files

| File | Purpose |
|---|---|
| [`Level-1-Foundation-Lab.md`](./Level-1-Foundation-Lab.md) | Student assignment containing ten required tasks and one optional challenge |
| [`Bash-Baby-Steps-Foundation-Solution/README.md`](./Bash-Baby-Steps-Foundation-Solution/README.md) | Complete solution guide with explanations and commands |
| [`Bash-Scripting-Foundation-MCQ-Quiz.html`](./Bash-Scripting-Foundation-MCQ-Quiz.html) | Interactive 25-question assessment with timer, score, answer review, and reshuffling |

## Learning objectives

After completing Level 1, students should be able to:

- Write a valid Bash shebang
- Add comments to a script
- Display messages with `echo`
- Create and expand variables
- Accept user input with `read -r -p`
- Store command output with `$(command)`
- Understand standard output and standard error
- Redirect stdout and stderr to different files
- Use positional arguments
- Explain `$0`, `$1`, `$2`, `$#`, and `"$@"`
- Write `if`, `elif`, `else`, and `fi`
- Compare strings and numbers
- Test whether a regular file exists with `-f`
- Check Bash syntax with `bash -n`
- Add executable permission with `chmod u+x`

## Lab tasks

| Task | Student script | Main topic |
|---:|---|---|
| 1 | `01-welcome.sh` | Shebang, comments, and `echo` |
| 2 | `02-class-info.sh` | Variables |
| 3 | `03-student-introduction.sh` | User input |
| 4 | `04-session-info.sh` | Command substitution |
| 5 | `05-output-error.sh` | Standard output and standard error |
| 6 | `06-fruit-arguments.sh` | Script arguments |
| 7 | `07-weather-helper.sh` | `if` and `else` |
| 8 | `08-traffic-light.sh` | `if`, `elif`, and `else` |
| 9 | `09-marks-result.sh` | Numeric comparison |
| 10 | `10-homework-check.sh` | File condition with `-f` |
| 11 | `11-class-assistant.sh` | Optional combined challenge |

## Prerequisites

- Linux, WSL, or a Linux virtual machine
- Bash shell
- A text editor such as Vim, Nano, or VS Code
- Basic terminal navigation

Confirm Bash is available:

```bash
bash --version
```

No root access, cloud account, or remote server is required.

## Getting started

Extract the package:

```bash
unzip level-1.zip
cd level-1
```

Open the student assignment:

```bash
less Level-1-Foundation-Lab.md
```

Create a separate working directory so the supplied solution remains unchanged:

```bash
mkdir -p student-work
cd student-work
```

Create the scripts in this directory as you complete the lab.

## Correct student order

### 1. Complete the assignment

Start with:

```text
Level-1-Foundation-Lab.md
```

Write every script yourself. Do not copy the solution during the first attempt.

### 2. Check script syntax

From the student working directory:

```bash
bash -n *.sh
```

No output means Bash found no syntax errors.

### 3. Add executable permission

```bash
chmod u+x *.sh
ls -l *.sh
```

### 4. Run the required tests

Run each script with the examples given in the lab. Test both successful and unsuccessful conditions where required.

### 5. Review the solution

Return to the package root:

```bash
cd ..
```

Open the solution guide:

```bash
less Bash-Baby-Steps-Foundation-Solution/README.md
```

Compare the solution with your own work. Focus on:

- Correct shebang
- Variable assignment without spaces around `=`
- Quoted variable expansions
- Required spaces inside `[ condition ]`
- Correct use of `then`, `elif`, `else`, and `fi`
- Clear normal and error messages

### 6. Take the quiz

Open this file in a web browser:

```text
Bash-Scripting-Foundation-MCQ-Quiz.html
```

On Linux with a graphical browser, you may use:

```bash
xdg-open Bash-Scripting-Foundation-MCQ-Quiz.html
```

On Windows or WSL, open the `level-1` folder and double-click the HTML file.

## Interactive quiz features

- 25 multiple-choice questions
- 25-minute timer
- 80% passing score
- Progress bar
- Unanswered-question warning
- Automatic submission when time expires
- Correct and incorrect answer highlighting
- Short explanation for every answer
- Attempt counter
- Best-score tracking in the browser
- Time-used report
- Shuffled questions and answer choices on every reattempt

## Practice solution scripts

To run the supplied solution scripts:

```bash
cd Bash-Baby-Steps-Foundation-Solution
chmod u+x *.sh
```

Examples:

```bash
./01-welcome.sh
./03-student-introduction.sh
./06-fruit-arguments.sh apple banana cherry
./07-weather-helper.sh
./08-traffic-light.sh
./09-marks-result.sh
./10-homework-check.sh
./11-class-assistant.sh Ali homework.txt
```

## Verify all supplied solutions

```bash
bash -n 01-welcome.sh
bash -n 02-class-info.sh
bash -n 03-student-introduction.sh
bash -n 04-session-info.sh
bash -n 05-output-error.sh
bash -n 06-fruit-arguments.sh
bash -n 07-weather-helper.sh
bash -n 08-traffic-light.sh
bash -n 09-marks-result.sh
bash -n 10-homework-check.sh
bash -n 11-class-assistant.sh
```

## Recommended teaching schedule

Do not teach the complete package in one class.

| Lesson | Topics | Tasks |
|---|---|---:|
| 1 | Script basics, variables, and input | 1-3 |
| 2 | Command substitution, streams, and arguments | 4-6 |
| 3 | String conditionals | 7-8 |
| 4 | Numeric and file conditions | 9-10 |
| Extra practice | Combined class assistant | 11 |
| Assessment | Interactive MCQ quiz | 25 questions |

For each task:

1. Explain the idea in simple language.
2. Type the script with students.
3. Run the first test.
4. Change one value.
5. Run the script again.
6. Ask students to explain why the output changed.

## GitHub Pages quiz

After uploading this folder to a GitHub repository, the HTML quiz can be published with GitHub Pages.

If the repository is named `shell-scripting` and the file remains inside `level-1`, a typical URL will look like:

```text
https://USERNAME.github.io/shell-scripting/level-1/Bash-Scripting-Foundation-MCQ-Quiz.html
```

Replace `USERNAME` with the GitHub username and confirm the repository's Pages source and folder settings.

## Student submission

Students should submit:

```text
student-work/
├── README.md
├── 01-welcome.sh
├── 02-class-info.sh
├── 03-student-introduction.sh
├── 04-session-info.sh
├── 05-output-error.sh
├── 06-fruit-arguments.sh
├── 07-weather-helper.sh
├── 08-traffic-light.sh
├── 09-marks-result.sh
├── 10-homework-check.sh
├── 11-class-assistant.sh
└── homework.txt
```

Task 11 may be treated as an optional or bonus task.

## Completion checklist

- [ ] I completed Tasks 1-10 without copying the solution.
- [ ] Every script starts with `#!/bin/bash`.
- [ ] Every script contains a useful comment.
- [ ] Variables are assigned without spaces around `=`.
- [ ] Variable expansions are quoted.
- [ ] Conditional brackets contain the required spaces.
- [ ] `bash -n *.sh` reports no syntax errors.
- [ ] I tested both true and false conditional paths.
- [ ] I compared my work with the supplied solution.
- [ ] I completed the optional class-assistant challenge.
- [ ] I scored at least 80% on the quiz.

## Next level

Level 2 will gradually combine concepts in three stages:

1. Arguments with conditions and input validation
2. File checks, exit statuses, `&&`, `||`, and simple logs
3. A connected local automation project

Functions and loops should be introduced only after students are comfortable with these foundation skills.

## Safety

This package uses local learning files only. It does not require `sudo`, user creation, file deletion, remote access, cloud resources, or production systems.

---

Complete the lab, understand the solution, and then prove your learning with the quiz.
