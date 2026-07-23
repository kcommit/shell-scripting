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
set autoindent
syntax on
set number
```

- `set autoindent` copies the current line's indentation to the next line.
- `set smartindent` adds automatic indentation for programming structures.
- `set number` Displays absolute line numbers on the left side of the Vim editor to make navigation and editing easier.

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

## One-Line Summary

Install Vim, create `~/.vimrc`, add your settings, save the file, and let Vim load it automatically whenever Vim starts.
