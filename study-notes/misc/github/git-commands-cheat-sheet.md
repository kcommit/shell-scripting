# Essential Git Commands

> A practical, beginner-friendly reference for configuring Git, creating repositories, tracking changes, working with branches, and synchronizing projects with GitHub.

## Table of Contents

1. [What Is Version Control?](#what-is-version-control)
2. [Git and GitHub](#git-and-github)
3. [Check, Configure, and Get Help](#check-configure-and-get-help)
4. [Create or Clone a Repository](#create-or-clone-a-repository)
5. [Check and Track Changes](#check-and-track-changes)
6. [Use `.gitignore`](#use-gitignore)
7. [Commit Changes](#commit-changes)
8. [View and Compare History](#view-and-compare-history)
9. [Restore and Unstage Changes](#restore-and-unstage-changes)
10. [Remove, Move, or Stop Tracking Files](#remove-move-or-stop-tracking-files)
11. [Work with Branches](#work-with-branches)
12. [Manage Remote Repositories](#manage-remote-repositories)
13. [Fetch, Pull, and Push](#fetch-pull-and-push)
14. [Temporarily Save Work with Stash](#temporarily-save-work-with-stash)
15. [Undo Commits Safely](#undo-commits-safely)
16. [Work with Tags](#work-with-tags)
17. [Authenticate with GitHub](#authenticate-with-github)
18. [Common Daily Workflow](#common-daily-workflow)
19. [Common Problems and Solutions](#common-problems-and-solutions)
20. [Quick Command Reference](#quick-command-reference)

---

## What Is Version Control?

Version control is a system that records changes to files over time. It allows you to review earlier versions, identify what changed, restore previous work, and collaborate safely with other people.

A Version Control System (VCS) helps you:

- Maintain a history of your project.
- Compare old and new versions of files.
- Restore an earlier version when necessary.
- Develop features independently with branches.
- Collaborate without overwriting another person's work.

---

## Git and GitHub

**Git** is a distributed version control system installed on your computer. It tracks file changes and maintains the project's history.

**GitHub** is an online platform that hosts Git repositories and provides collaboration tools such as pull requests, issues, and GitHub Actions.

| Git | GitHub |
|---|---|
| Runs locally on your computer | Hosts repositories online |
| Tracks changes and creates commits | Supports sharing and collaboration |
| Can work without internet access | Requires a network connection for synchronization |

---

## Check, Configure, and Get Help

### Check the installed Git version

```bash
git --version
```

### Get general help

```bash
git help
```

### Get help for a specific command

```bash
git help <command>
```

Examples:

```bash
git help commit
git add --help
git status -h
```

`--help` normally opens detailed documentation, while `-h` usually prints a shorter summary in the terminal.

### Set your global username

```bash
git config --global user.name "Your Name"
```

### Set your global email address

Use an email address verified in your GitHub account if you want GitHub to associate your commits with your profile.

```bash
git config --global user.email "you@example.com"
```

### Set `main` as the default initial branch

```bash
git config --global init.defaultBranch main
```

### Review your global configuration

```bash
git config --global --list
```

### Show where each configuration value comes from

```bash
git config --list --show-origin
```

> The `--global` option applies the setting to all repositories used by your current operating-system account. Omit `--global` to configure only the current repository.

---

## Create or Clone a Repository

### Initialize a new repository

Run this command inside an existing project directory:

```bash
git init
```

Git creates a hidden `.git` directory containing repository metadata and history.

### Clone an existing repository

```bash
git clone <repository-url>
```

Example using HTTPS:

```bash
git clone https://github.com/USERNAME/REPOSITORY.git
```

Example using SSH:

```bash
git clone git@github.com:USERNAME/REPOSITORY.git
```

Cloning downloads the project files, commit history, branches, and remote configuration.

---

## Check and Track Changes

### Show repository status

```bash
git status
```

This command shows:

- The current branch.
- Untracked files.
- Modified files.
- Staged changes.
- Whether the local branch is ahead of or behind its remote branch.

### Show unstaged changes

```bash
git diff
```

### Show staged changes

```bash
git diff --staged
```

### Stage one file

```bash
git add <filename>
```

Example:

```bash
git add README.md
```

### Stage all changes in the current directory

```bash
git add .
```

> Review `git status` and `git diff` before staging everything, especially in production or shared repositories.

---

## Use `.gitignore`

A `.gitignore` file lists untracked files and directories that Git should ignore.

Example:

```gitignore
# Environment variables and secrets
.env

# Log files
*.log

# Dependency directories
node_modules/

# Editor settings
.vscode/

# Large local videos
videos/*.mp4
```

Check whether a file is ignored and identify the matching rule:

```bash
git check-ignore -v <filename>
```

Example:

```bash
git check-ignore -v videos/demo.mp4
```

List files currently tracked by Git:

```bash
git ls-files
```

> `.gitignore` affects untracked files. It does not automatically stop tracking a file that has already been committed. Use `git rm --cached` for that situation.

---

## Commit Changes

A commit saves a snapshot of the staged changes in the local repository.

```bash
git commit -m "Describe the change clearly"
```

Example:

```bash
git commit -m "Add Git installation instructions"
```

Use clear, specific commit messages. Avoid vague messages such as `update`, `changes`, or `final`.

### Commit all modified and deleted tracked files

```bash
git commit -am "Describe the change"
```

The `-a` option does not include new untracked files. New files must first be staged with `git add`.

### Correct the most recent commit

Stage any missing changes and amend the last commit:

```bash
git add <filename>
git commit --amend
```

Change only the latest commit message:

```bash
git commit --amend -m "Corrected commit message"
```

> Amending rewrites the most recent commit. Avoid amending a commit that other people have already pulled unless your team agrees.

---

## View and Compare History

### Show detailed history

```bash
git log
```

### Show a compact history

```bash
git log --oneline
```

### Show a branch graph

```bash
git log --oneline --graph --decorate --all
```

Press `q` to exit the log viewer when necessary.

### Show one commit in detail

```bash
git show <commit-id>
```

Show the latest commit:

```bash
git show HEAD
```

### Show changed-file statistics

```bash
git diff --stat
```

### Compare two commits or branches

```bash
git diff <first-ref>..<second-ref>
```

Example:

```bash
git diff main..feature/add-login
```

### Show who last changed each line

```bash
git blame <filename>
```

`git blame` is a diagnostic tool for understanding history, not for assigning personal blame.

---

## Restore and Unstage Changes

### Discard unstaged changes in a tracked file

```bash
git restore <filename>
```

Example:

```bash
git restore README.md
```

> Warning: This discards the file's uncommitted working-directory changes. Use it carefully.

### Remove a file from the staging area

This keeps the changes in the working directory:

```bash
git restore --staged <filename>
```

Example:

```bash
git restore --staged README.md
```

### Restore an older version of a file

```bash
git restore --source=<commit-id> <filename>
```

`git checkout -- <filename>` is an older alternative for discarding file changes, but `git restore` communicates the intention more clearly.

---

## Remove, Move, or Stop Tracking Files

### Remove a tracked file from Git and the working directory

```bash
git rm <filename>
```

Example:

```bash
git rm old-notes.txt
```

This command:

- Deletes the file from the working directory.
- Stages its removal for the next commit.

Create a commit to record the removal:

```bash
git commit -m "Remove obsolete notes"
```

### Stop tracking a file but keep it on your computer

```bash
git rm --cached <filename>
```

Example:

```bash
git rm --cached .env
```

This command removes the file from Git's **index**—also called the staging area—but does not delete the working copy from your computer.

Use it when:

- A file was added to Git accidentally.
- A file was already tracked before you added it to `.gitignore`.
- A local configuration file should remain on your computer but should no longer be stored in future commits.

After running it, add the file pattern to `.gitignore`:

```gitignore
.env
```

Then commit the change:

```bash
git add .gitignore
git commit -m "Stop tracking environment file"
```

### Stop tracking a directory but keep it locally

Use the recursive `-r` option:

```bash
git rm -r --cached <directory-name>
```

Example:

```bash
git rm -r --cached videos/
```

Then add an appropriate rule to `.gitignore` and commit the change:

```gitignore
videos/
```

```bash
git add .gitignore
git commit -m "Stop tracking video files"
```

### `git restore --staged` vs. `git rm --cached`

| Command | Main purpose |
|---|---|
| `git restore --staged <file>` | Unstages the current change while the file remains tracked |
| `git rm --cached <file>` | Removes the file from Git's index so it becomes untracked after the change is committed |

> Important: In `git rm --cached`, the word `cached` refers to Git's index. It does not mean a temporary browser-style cache.

> Security warning: If a password, token, or private key was committed previously, `git rm --cached` only stops tracking it in future commits. It does not remove the secret from older Git history. Revoke or rotate the exposed credential immediately and clean the history using an appropriate history-rewriting procedure.

### Rename or move a tracked file

```bash
git mv <old-path> <new-path>
```

Example:

```bash
git mv notes.txt docs/git-notes.txt
```

This moves or renames the file and stages the change.

---

## Work with Branches

### List local branches

```bash
git branch
```

List local and remote-tracking branches:

```bash
git branch -a
```

The branch marked with `*` is the current branch.

### Create a new branch

```bash
git branch <branch-name>
```

### Create and switch to a new branch

```bash
git switch -c <branch-name>
```

Example:

```bash
git switch -c feature/add-login
```

Older equivalent:

```bash
git checkout -b <branch-name>
```

### Switch to an existing branch

```bash
git switch <branch-name>
```

Older equivalent:

```bash
git checkout <branch-name>
```

### Merge a branch into the current branch

First switch to the branch that should receive the changes:

```bash
git switch main
git merge <branch-name>
```

### Delete a merged local branch

```bash
git branch -d <branch-name>
```

The lowercase `-d` protects an unmerged branch from accidental deletion. The uppercase `-D` forces deletion and should be used carefully.

### Push a new branch and set its upstream

```bash
git push -u origin <branch-name>
```

### Delete a remote branch

```bash
git push origin --delete <branch-name>
```

This deletes the named branch from the remote repository, not your local branch.

### Create a local branch that tracks a remote branch

```bash
git switch --track origin/<branch-name>
```

---

## Manage Remote Repositories

A remote is a named connection to another Git repository, usually hosted on GitHub.

### Show configured remotes

```bash
git remote -v
```

### Add a remote named `origin`

```bash
git remote add origin <repository-url>
```

Example:

```bash
git remote add origin https://github.com/USERNAME/REPOSITORY.git
```

`origin` is the conventional name for the primary remote repository.

### Change the URL of an existing remote

```bash
git remote set-url origin <new-repository-url>
```

### Remove the `origin` remote

```bash
git remote remove origin
```

Removing a remote does not delete the local repository or the remote GitHub repository. It only removes the local connection.

---

## Fetch, Pull, and Push

### Fetch remote information

```bash
git fetch
```

Fetch from a specific remote and remove stale remote-tracking references:

```bash
git fetch --prune origin
```

`git fetch` downloads remote commits, branches, and references but does not automatically integrate them into the current branch.

### Pull remote changes

```bash
git pull origin <branch-name>
```

Example:

```bash
git pull origin main
```

`git pull` normally performs a fetch followed by an integration operation, such as a merge or rebase, according to your configuration and options.

Pull and replay your local commits on top of the updated remote branch:

```bash
git pull --rebase
```

Use this only when it matches your team's workflow. If conflicts occur during a rebase, resolve them and continue with `git rebase --continue`, or cancel with `git rebase --abort`.

### Push local commits

```bash
git push origin <branch-name>
```

Example:

```bash
git push origin main
```

### First push with upstream tracking

```bash
git push -u origin main
```

The `-u` option connects the local `main` branch to `origin/main`. Future synchronization can usually use shorter commands:

```bash
git pull
git push
```

---

## Temporarily Save Work with Stash

Stashing temporarily stores uncommitted changes so you can work with a clean directory.

### Stash tracked-file changes

```bash
git stash push -m "Work in progress"
```

Include untracked files:

```bash
git stash push -u -m "Work in progress"
```

### List stashes

```bash
git stash list
```

### Apply the latest stash and keep it in the stash list

```bash
git stash apply
```

### Apply the latest stash and remove it from the list

```bash
git stash pop
```

### Remove one stash

```bash
git stash drop stash@{0}
```

> Stash is useful for temporary work, but it is not a replacement for meaningful commits or backups.

---

## Undo Commits Safely

### Reverse a commit with a new commit

```bash
git revert <commit-id>
```

`git revert` is generally the safest choice for shared history because it does not remove existing commits.

### Move `HEAD` back but keep changes staged

```bash
git reset --soft HEAD~1
```

Use this when you want to redo the most recent local commit while keeping its changes in the staging area.

### Move `HEAD` back and keep changes unstaged

```bash
git reset HEAD~1
```

The default mode is `--mixed`. It removes the commit and unstages its changes while keeping them in the working directory.

### Remove a commit and discard its changes

```bash
git reset --hard HEAD~1
```

> Danger: `--hard` can permanently discard uncommitted work. Do not use it on shared history or when you are unsure.

### Recover a recently lost commit reference

```bash
git reflog
```

`git reflog` records recent movements of local references and can help locate commits after a reset or rebase.

### Safe decision guide

| Situation | Recommended command |
|---|---|
| Undo a commit already pushed to a shared branch | `git revert <commit-id>` |
| Redo the latest local commit and keep changes staged | `git reset --soft HEAD~1` |
| Redo the latest local commit and keep changes unstaged | `git reset HEAD~1` |
| Correct only the latest local commit | `git commit --amend` |
| Find a commit after an accidental reset | `git reflog` |

---

## Work with Tags

Tags identify important points in history, such as releases.

### List tags

```bash
git tag
```

### Create an annotated tag

```bash
git tag -a v1.0.0 -m "Release version 1.0.0"
```

### Push one tag

```bash
git push origin v1.0.0
```

### Push all local tags

```bash
git push origin --tags
```

---

## Authenticate with GitHub

Git configuration identifies the author of a commit; authentication proves that you are allowed to access a GitHub repository.

### HTTPS remote

```text
https://github.com/USERNAME/REPOSITORY.git
```

Use Git Credential Manager, GitHub CLI, or a personal access token when required. GitHub does not accept a normal account password for command-line Git operations.

### SSH remote

```text
git@github.com:USERNAME/REPOSITORY.git
```

Test SSH authentication:

```bash
ssh -T git@github.com
```

Change an existing remote from HTTPS to SSH:

```bash
git remote set-url origin git@github.com:USERNAME/REPOSITORY.git
```

### Authenticate with GitHub CLI

```bash
gh auth login
```

> Never commit passwords, personal access tokens, SSH private keys, or cloud credentials.

---

## Common Daily Workflow

```text
Edit → Inspect → Stage → Commit → Pull → Push
```

```bash
# Check the current repository state
git status

# Review unstaged changes
git diff

# Stage the intended changes
git add .

# Save a local snapshot
git commit -m "Describe the completed change"

# Integrate remote work before publishing yours
git pull

# Upload local commits
git push
```

---

## Common Problems and Solutions

### `fatal: not a git repository`

Confirm your location and enter the correct repository:

```bash
pwd
ls
cd <repository-directory>
git status
```

Use `git init` only when you intend to create a new repository.

### `remote origin already exists`

Inspect the existing remote and update it if necessary:

```bash
git remote -v
git remote set-url origin <correct-url>
```

### `src refspec main does not match any`

The repository may not have a commit yet, or its branch may use another name:

```bash
git status
git add .
git commit -m "Initial commit"
git branch -M main
git push -u origin main
```

### Push rejected because the remote contains newer commits

```bash
git pull --rebase origin main
git push
```

Resolve any conflicts carefully. Cancel the rebase if necessary:

```bash
git rebase --abort
```

### Accidentally staged a file

```bash
git restore --staged <filename>
```

### File remains tracked after adding it to `.gitignore`

```bash
git rm --cached <filename>
git add .gitignore
git commit -m "Stop tracking ignored file"
```

### Preview untracked files that Git could remove

```bash
git clean -n
```

`git clean -n` is a safe preview. `git clean -f` deletes untracked files, so use it only after reviewing the preview and confirming that those files are disposable.

---

## Quick Command Reference

| Command | Purpose |
|---|---|
| `git config --global --list` | Display global Git configuration |
| `git help <command>` | Open help for a Git command |
| `git init` | Initialize a local repository |
| `git clone <url>` | Download an existing repository |
| `git status` | Show the current repository state |
| `git diff` | Show unstaged changes |
| `git diff --staged` | Show staged changes |
| `git add <file>` | Stage one file |
| `git add .` | Stage changes in the current directory |
| `git commit -m "message"` | Commit staged changes |
| `git commit --amend` | Correct the latest commit |
| `git log --oneline` | Display compact commit history |
| `git show <commit>` | Display one commit in detail |
| `git restore <file>` | Discard unstaged file changes |
| `git restore --staged <file>` | Unstage a file but keep its changes |
| `git rm <file>` | Delete a tracked file and stage its removal |
| `git rm --cached <file>` | Stop tracking a file but keep it locally |
| `git rm -r --cached <directory>` | Stop tracking a directory but keep it locally |
| `git mv <old> <new>` | Rename or move a tracked file |
| `git stash push` | Temporarily save uncommitted work |
| `git stash pop` | Restore and remove the latest stash |
| `git revert <commit>` | Reverse a commit with a new commit |
| `git reset --soft HEAD~1` | Remove the latest local commit but keep changes staged |
| `git reflog` | Show recent local reference movements |
| `git branch` | List local branches |
| `git switch -c <branch>` | Create and switch to a branch |
| `git switch <branch>` | Switch to an existing branch |
| `git merge <branch>` | Merge a branch into the current branch |
| `git remote -v` | Show remote repository URLs |
| `git fetch` | Download remote history without integrating it |
| `git pull` | Download and integrate remote changes |
| `git push` | Upload local commits |
| `git tag` | List tags |

---

## Important Safety Notes

- Run `git status` before and after important operations.
- Review changes before using `git add .`.
- Never commit passwords, tokens, private keys, or cloud credentials.
- Use `.gitignore` for files that should not be tracked.
- Use `git clean -n` before any destructive `git clean` operation.
- Avoid force operations until you understand their effect.
- Prefer `git revert` for commits already shared with other people.
- Pull recent team changes before pushing your own work.

---

**Happy learning and keep practicing!**
