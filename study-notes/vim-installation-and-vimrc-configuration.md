# Vim Installation and Basic `.vimrc` Configuration

## 1. Install Vim on Ubuntu or Debian

Update the package index:

```bash
sudo apt update
```

Install Vim:

```bash
sudo apt install vim -y
```

Run both together:

```bash
sudo apt update && sudo apt install vim -y
```

## 2. Install Vim on RHEL-Based Systems

For RHEL, AlmaLinux, Rocky Linux, or CentOS Stream:

```bash
sudo dnf upgrade -y
sudo dnf install vim -y
```

Or:

```bash
sudo dnf upgrade -y && sudo dnf install vim -y
```


## 3. Verify Vim

```bash
vim --version
which vim
```

## 4. Check Whether `.vimrc` Exists

```bash
ls -la ~/.vimrc
```

If it does not exist, create and open it:

```bash
vim ~/.vimrc
```

## 5. Add Indentation Settings

Add:

```vim
set smartindent
set autoindent
syntax on
set number
```

- `set autoindent` copies the current line's indentation to the next line.
- `set smartindent` adds automatic indentation for programming structures.
- `set number` Displays absolute line numbers on the left side of the Vim editor to make navigation and 
- 'syntax on'  Enables syntax highlighting to display code, commands, comments, and keywords in different colors for better readability.

# Vim Installation and Basic `.vimrc` Configuration

## 1. Install Vim on Ubuntu or Debian

Update the package index:

```bash
sudo apt update
```

Install Vim:

```bash
sudo apt install vim -y
```

Run both commands together:

```bash
sudo apt update && sudo apt install vim -y
```

---

## 2. Install Vim on RHEL-Based Systems

For RHEL, AlmaLinux, Rocky Linux, or CentOS Stream:

```bash
sudo dnf upgrade -y
sudo dnf install vim -y
```

Or run both commands together:

```bash
sudo dnf upgrade -y && sudo dnf install vim -y
```

---

## 3. Verify Vim

```bash
vim --version
which vim
```

---

## 4. Check Whether `.vimrc` Exists

```bash
ls -la ~/.vimrc
```

If it does not exist, create and open it:

```bash
vim ~/.vimrc
```

---

## 5. Add Basic Vim Settings for One User

Add these lines to `~/.vimrc`:

```vim
set smartindent
set autoindent
syntax on
set number
```

### One-Line Explanations

- `set number` displays absolute line numbers on the left side of the Vim editor.
- `set autoindent` copies the indentation of the current line to the next line.
- `set smartindent` automatically adds indentation based on programming structures, making code easier to write and read.
- 'syntax on'  Enables syntax highlighting to display code, commands, comments, and keywords in different colors for better readability.

Because these settings are stored in:

```text
~/.vimrc
```

they apply only to the current user.

---

## 6. Configure Vim Globally for All Users

To apply the same settings to every user, add them to the system-wide Vim configuration file.

### Ubuntu or Debian

Common global Vim configuration files are:

```text
/etc/vim/vimrc
/etc/vim/vimrc.local
```

Open the system configuration:

```bash
sudo vim /etc/vim/vimrc
```

Or, when available:

```bash
sudo vim /etc/vim/vimrc.local
```

Add:

```vim
set smartindent
set autoindent
syntax on
set number
```

### RHEL, AlmaLinux, Rocky Linux, or CentOS Stream

The common global Vim configuration file is:

```text
/etc/vimrc
```

Open it:

```bash
sudo vim /etc/vimrc
```

Add:

```vim
set number
set autoindent
set smartindent
```

### User vs Global Scope

| Configuration File | Scope |
|---|---|
| `~/.vimrc` | Current user only |
| `/etc/vim/vimrc` | All users on many Debian-based systems |
| `/etc/vim/vimrc.local` | Local system-wide settings on some Debian-based systems |
| `/etc/vimrc` | All users on many RHEL-based systems |

A user's `~/.vimrc` can override a global setting because the user configuration is normally loaded after the system-wide configuration.

---

## 7. Save and Exit Vim

Press:

```text
Esc
```

Then run:

```vim
:wq
```

---

## 8. Reload `.vimrc` Inside Vim

Use:

```vim
:source ~/.vimrc
```

Or:

```vim
:source $MYVIMRC
```

---

## 9. Load `.vimrc` from Bash

Normally, Vim automatically loads `~/.vimrc` whenever it starts.

To test it manually from Bash:

```bash
vim -c 'source ~/.vimrc' -c 'qa'
```

Explanation:

- `-c 'source ~/.vimrc'` loads the configuration.
- `-c 'qa'` quits all Vim windows.

---

## 10. Important Correction

Do not run this in Bash:

```bash
source ~/.vimrc
```

The `.vimrc` file contains Vim commands, not Bash commands.

Use this inside Vim:

```vim
:source ~/.vimrc
```

Or simply start Vim:

```bash
vim
```

Vim will automatically read `~/.vimrc`.

---

## 11. Complete Ubuntu Workflow

```bash
sudo apt update && sudo apt install vim -y
vim --version
ls -la ~/.vimrc
vim ~/.vimrc
```

Add:

```vim
set number
set autoindent
set smartindent
```

Then press `Esc` and run:

```vim
:wq
```

Test:

```bash
vim -c 'source ~/.vimrc' -c 'qa'
```

---

## 12. Complete RHEL Workflow

```bash
sudo dnf upgrade -y && sudo dnf install vim -y
vim --version
ls -la ~/.vimrc
vim ~/.vimrc
```

Add:

```vim
set smartindent
set autoindent
syntax on
set number
```

Then press `Esc` and run:

```vim
:wq
```

Test:

```bash
vim -c 'source ~/.vimrc' -c 'qa'
```

---

## 13. One-Line Summary

Use `~/.vimrc` for one user's Vim settings and the system-wide Vim configuration file for settings that should apply to all users.
editing easier.

## 6. Save and Exit

Press:

```text
Esc
```

Then:

```vim
:wq
```

## 7. Reload `.vimrc` Inside Vim

Use:

```vim
:source ~/.vimrc
```

or:

```vim
:source $MYVIMRC
```

## 8. Load `.vimrc` from Bash

Normally, Vim automatically loads `~/.vimrc` when it starts.

To test it manually:

```bash
vim -c 'source ~/.vimrc' -c 'qa'
```

Explanation:

- `-c 'source ~/.vimrc'` loads the configuration.
- `-c 'qa'` quits all Vim windows.

## Important Correction

Do not run this in Bash:

```bash
source ~/.vimrc
```

`.vimrc` contains Vim commands, not Bash commands.

Use this inside Vim:

```vim
:source ~/.vimrc
```

Or simply start Vim:

```bash
vim
```

Vim will automatically read `~/.vimrc`.

## Complete Ubuntu Workflow

```bash
sudo apt update && sudo apt install vim -y
vim --version
ls -la ~/.vimrc
vim ~/.vimrc
```

Add:

```vim
set autoindent
set smartindent
set number
```

Then press `Esc` and run:

```vim
:wq
```

Test:

```bash
vim -c 'source ~/.vimrc' -c 'qa'
```

## Complete RHEL Workflow

```bash
sudo dnf upgrade -y && sudo dnf install vim -y
vim --version
ls -la ~/.vimrc
vim ~/.vimrc
```

Add:

```vim
set smartindent
set autoindent
syntax on
set number
```

Then press `Esc` and run:

```vim
:wq
```

Test:

```bash
vim -c 'source ~/.vimrc' -c 'qa'
```

## One-Line Summary

Install Vim, create `~/.vimrc`, add your settings, save the file, and let Vim load it automatically whenever Vim starts.
