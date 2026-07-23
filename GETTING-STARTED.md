# Getting Started

Welcome! This guide will help you fork the repository, complete your assignments, and submit your work using Git and GitHub.

## 1. Fork the Repository

Click the **Fork** button in the top-right corner of this repository.

This will create your own copy under your GitHub account.

---

## 2. Clone Your Fork

Clone **your fork**, not the original repository.

```bash
git clone git@github.com:YOUR-GITHUB-USERNAME/shell-scripting.git
```

Move into the project:

```bash
cd shell-scripting
```

---

## 3. Create Your Assignment Folder

Example (this is my local path). Your path may be different.

```bash
mkdir -p assignments/day-03/your-name
```

---

## 4. Complete the Assignment

Navigate to your assignment folder and complete the assigned tasks.

Example:

```text
assignments/day-03/your-name/
```

Test every script before submitting.

---

## 5. Save Your Work

```bash
git status
git add .
git commit -m "Complete Day 3 assignment"
```

---

## 6. Update Your Local GitRepo

Before pushing, get the latest changes.

```bash
git pull --rebase origin main
```

---

## 7. Push Your Work

```bash
git push -u origin main
```

After the first push, simply use:

```bash
git push
```

---

# Repository Workflow

```text
Fork
   ↓
Clone
   ↓
Create your assignment directory
   ↓
Complete Assignment
   ↓
Test
   ↓
Commit
   ↓
Pull --rebase
   ↓
Push
   ↓
Pull Request
```

---

## Enjoyed This Repository?

If this repository helped you learn something new, please consider giving it a ⭐ Star.

Your support motivates me to continue creating free, high-quality learning content for the community.

Thank you, and happy scripting!
