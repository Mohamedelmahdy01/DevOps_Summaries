<<<<<<< HEAD

### Git Configuration
1. **Set username globally:**
   ```bash
   git config --global user.name "mohamed"
   ```

2. **Set email globally:**
   ```bash
   git config --global user.email "mohamed.elmahdy@gmail.com"
   ```

3. **Show current configuration:**
   ```bash
   git config --list
   ```

### Working with Directories and Files
1. **Create a new directory named `gitwork`:**
   ```bash
   mkdir gitwork
   ```

2. **Navigate into the `gitwork` directory:**
   ```bash
   cd gitwork/
   ```

3. **Create a file named `file.txt` with content "Hello, Git":**
   ```bash
   echo "Hello, Git" >> file.txt
   ```

4. **Display the SHA-1 hash for the string "Hello, Git":**
   ```bash
   echo "Hello, Git" | git hash-object --stdin
   ```

5. **List all contents in the current directory:**
   ```bash
   ls
   ```

6. **Display all files in the index area:**
   ```bash
   git ls-files
   ```

7. **Display the content of a file (e.g., `file.txt`):**
   ```bash
   cat file.txt
   ```

8. **Display all files in the `.git/objects/` directory (not as commonly used):**
   ```bash
   find .git/objects/ -type f
   ```

9. **Display the SHA-1 of all files in the index area:**
   ```bash
   git ls-files -s
   ```

10. **Display the SHA-1 hash of a specific file (e.g., `file.txt`):**
    ```bash
    git hash-object file.txt
    ```

### Inspecting Git Objects
1. **Display the type of a Git object by its SHA-1:**
   ```bash
   git cat-file -t <SHA-1>
   ```

2. **Display the size of a Git object by its SHA-1:**
   ```bash
   git cat-file -s <SHA-1>
   ```

3. **Display the content of a Git object by its SHA-1:**
   ```bash
   git cat-file -p <SHA-1>
   ```

### Managing Files in Git
1. **Stage a file, multiple files, or files matching a pattern:**
   ```bash
   git add <file name, * , *.txt or fi*>
   ```

2. **Display the status of the working directory and staging area:**
   ```bash
   git status
   ```

3. **Display a short status:**
   ```bash
   git status -s
   ```

4. **Commit staged changes with a message:**
   ```bash
   git commit -m "comment"
   ```

5. **Stage and commit changes in one step:**
   ```bash
   git commit -am "comment"
   ```

### Viewing Commit History
1. **Display the commit history:**
   ```bash
   git log
   ```

2. **Display the commit history in a condensed format:**
   ```bash
   git log --oneline
   ```

3. **Filter commit history, for example, limit to last 2 commits:**
   ```bash
   git log --oneline -2
   ```

### Viewing Differences
1. **Show differences between the working directory and the staging area:**
   ```bash
   git diff
   ```

2. **Show differences between the staging area and the repository:**
   ```bash
   git diff --staged
   ```

3. **Show differences between two commits:**
   ```bash
   git diff <First SHA commit>..<Second SHA commit>
   ```

4. **Show details of a specific commit:**
   ```bash
   git show <SHA commit>
   ```

### Unstaging and Restoring Files
1. **Unstage a file:**
   ```bash
   git rm --cached <file>
   ```

2. **Discard changes in the working directory (restore from the index area):**
   ```bash
   git restore <file>
   ```

3. **Discard changes in the staging area (restore from the repository):**
   ```bash
   git restore --staged <file>
   ```
### `git rm --cached <filename>`

The `git rm --cached` command is used to remove a file from the Git index (staging area) without deleting the actual file from your working directory. In other words, it untracks a file that was previously tracked by Git but keeps it in your local file system.

#### Example:

```bash
git rm --cached filename
```

- This will remove the file `filename` from Git's tracking, but the file will remain on your local system.
- After running the command, you need to commit the change to remove the file from the repository.

```bash
git commit -m "Untrack file 'filename' but keep it locally"
```

This is especially useful when you accidentally committed a file that shouldn't be tracked (e.g., configuration files, logs, or sensitive data).

---

### `.gitignore`

A `.gitignore` file tells Git which files (or patterns of files) it should ignore and not track. When you place certain filenames or patterns in a `.gitignore` file, Git will stop tracking those files.

#### Example `.gitignore`:

```
# Ignore log files
*.log

# Ignore all files in the temp directory
/temp/

# Ignore a specific config file
config/settings.py
```

- **Wildcards** (`*`) can be used to match multiple files.
- **Directories** are ignored by placing a slash (`/`) at the end.
  
Once you have a `.gitignore` file, Git will ignore the files listed there in future commits.

#### If you have already committed files that should be ignored:
1. Add the files or directories to `.gitignore`.
2. Use `git rm --cached` to untrack those files:
   
   ```bash
   git rm --cached filename
   ```

3. Commit the changes:
   ```bash
   git commit -m "Untrack ignored files"
   ```

After this, Git will stop tracking the files listed in `.gitignore`, and they won't be included in future commits.

### Amending and Resetting Commits
1. **Modify the last commit message:**
   ```bash
   git commit --amend
   ```

2. **Move the head pointer back a number of steps and adjust the staging area:**
   ```bash
   git reset HEAD~<number of steps>
   ```

3. **Move the head pointer back a number of steps and adjust the working directory:**
   ```bash
   git reset --hard HEAD~<number of steps>
   ```

4. **Display the history of moving the HEAD pointer:**
   ```bash
   git reflog
   ```

5. **Move the head pointer forward a number of steps and adjust the working directory:**
   ```bash
   git reset --hard HEAD@{<number of steps>}
   ```

### Working with Tags
1. **Create a new annotated tag:**
   ```bash
   git tag -a v2.0 -m "Version 2.0 of file"
   ```

2. **Display details of a specific tag:**
   ```bash
   git show v2.0
   ```

3. **Display details of a specific tag in a condensed format:**
   ```bash
   git show v2.0 --oneline
   ```

### Working with Branches
1. **Create a new branch:**
   ```bash
   git branch <branch name>
   ```

2. **List all branches:**
   ```bash
   git branch
   ```

3. **Switch to a different branch:**
   ```bash
   git switch <branch name>
   ```

4. **Switch to the `master` branch:**
   ```bash
   git switch master
   ```

5. **Merge a branch into the current branch:**
   ```bash
   git merge <branch name>
   ```

6. **Show branches that have been merged:**
   ```bash
   git branch --merged
   ```

7. **Delete a branch:**
   ```bash
   git branch -d <branch name>
   ```
8. **graph alias :**
   ```bash
   $ alias graph="git log --oneline --all --graph --decorate"
   ```

### Working with remotes

1. **clone remote repo :**
   ```bash
   git clone <url> <Shourtcut Name>
   ```
2. **Display Remotes :**
   ```bash
   git remote 
   git remote -v #with more details
   ```
3. **Display rempte branches :**
   ```bash
   git branch -r
   ```
4. **add remote :**
   ```bash
   git remote add <url>
   ```
5. **fetch from remote without marging updated:**
   ```bash
   git  fetch <remote name>
   #git fetch origin
   ```
6. **To marge branches :**
   ```bash
   git marge
   ```
7. **fetch and marge from remote in once :**
   ```bash
      git pull origin #Pull from origin remote
   ```

8. **push local repo with new branch :**
   ```bash
   git brach <branche name> #create a branch
   git switch <branchname>
   #add some changes in your code 
   git push origin
   git push -u origin feature #هترفع علي الريموت ريبو الي اسمها origin علي برانش هتعمله اسمه feature
   # -u = --set-upstream origin feature
   ```
9. **list local branches with some details about last commit :**
   ```bash
   git branch -v
   git branch -vv # ++ tracing with remote branches
   ```
10. **rename branch  :**
      ```bash
      git branch -M <NewName> #git branch -M main
      ```
Here’s an expanded list of version control support tools for Visual Studio Code (VSCode), including **GitLens** and more:

### Version Control Support Tools in VSCode

1. **GitLens**
   - Enhances the built-in Git capabilities of VSCode.
   - Provides features like inline blame annotations, repository insights, and a rich history view.
   - Allows you to explore commit history, see who changed what, and visualize code authorship.

2. **Git Graph**
   - Displays a visual representation of your Git repository's history.
   - Allows for easy branching, merging, and viewing commit details.
   - Supports creating and managing branches directly from the graph interface.

3. **GitHub Pull Requests and Issues**
   - Integrated support for GitHub pull requests and issues directly within VSCode.
   - Allows you to review, manage, and merge pull requests without leaving the editor.
   - Provides features for commenting on and resolving issues.

4. **GitHub Copilot**
   - AI-powered code completion tool that helps you write code faster.
   - Provides suggestions and helps with documentation by leveraging vast codebases.

5. **Live Share**
   - Enables real-time collaborative coding with others.
   - Allows multiple users to edit files and navigate through code together, which can be especially useful for pair programming and code reviews.

6. **Source Control Extension API**
   - Allows developers to create custom extensions for version control.
   - You can find or develop extensions that integrate with other version control systems beyond Git, such as Mercurial or Subversion.

7. **Commit Graph**
   - Visualizes the commit history as a graph, making it easy to understand branching and merging.
   - Helps track changes and navigate through the history of the project effectively.

8. **VSCode Settings Sync**
   - Allows you to synchronize your VSCode settings, extensions, and configurations across multiple machines.
   - Ensures a consistent development environment and workflow regardless of where you work.

9. **Azure Repos**
   - Integrates Azure DevOps repositories into VSCode.
   - Allows you to clone, manage, and create pull requests for Azure DevOps repositories seamlessly.

10. **Terminal Integration**
    - Built-in terminal support allows you to run Git commands directly within VSCode.
    - This enables you to manage version control operations without switching between the editor and terminal.


### SSH for GitHub

**SSH (Secure Shell)** is a protocol that provides a secure way to access remote systems and transfer data. For GitHub, SSH is commonly used to securely authenticate and connect to your GitHub repositories without needing to enter your password every time. 

Here’s how SSH works with GitHub and how to set it up:

### Why Use SSH with GitHub?

1. **Secure Authentication**: SSH keys are used to securely log into the GitHub server. Unlike HTTP-based access, you don’t need to provide a username and password every time you push or pull changes.
2. **Convenience**: Once your SSH key is added to your GitHub account, you won't need to input credentials manually.
3. **Improved Security**: SSH keys are generally more secure than password-based authentication.

### How SSH Works
SSH uses a **pair of cryptographic keys**:
1. **Public Key**: This is stored on GitHub and identifies who is accessing the repository.
2. **Private Key**: This remains securely on your local machine.

When you attempt to push or pull from GitHub, the private key on your machine is matched with the public key stored on GitHub. If they match, you gain access.

### Setting up SSH for GitHub

#### Step 1: Check for Existing SSH Keys
Before generating a new SSH key, check if you already have one:
```bash
ls -al ~/.ssh
```
This lists any SSH keys already on your machine.

#### Step 2: Generate a New SSH Key
If you don't have an existing key, generate a new one:
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
- `-t ed25519`: Specifies the type of encryption (Ed25519 is recommended).
- `-C "your_email@example.com"`: Adds a comment with your email for identification.

If your system doesn’t support `ed25519`, you can use `rsa`:
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

#### Step 3: Add SSH Key to the SSH Agent
Start the SSH agent and add your key to it:
```bash
eval "$(ssh-agent -s)"    # Start the SSH agent
ssh-add ~/.ssh/id_ed25519  # Add your SSH key
```

#### Step 4: Add SSH Key to GitHub
Now, you need to add the public key to your GitHub account:
1. Copy your public key to the clipboard:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```
   or
   ```bash
   pbcopy < ~/.ssh/id_ed25519.pub  # MacOS only
   ```
2. Go to **GitHub** > **Settings** > **SSH and GPG Keys** > **New SSH Key**.
3. Paste the public key into the "Key" field and give it a meaningful title.

#### Step 5: Test SSH Connection to GitHub
Run this command to verify that your SSH connection is set up correctly:
```bash
ssh -T git@github.com
```
If it works, you’ll get a message like:
```
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
```

### Configuring Git to Use SSH

Once your SSH key is set up, you can configure Git to use SSH instead of HTTPS by changing your repository’s remote URL:

1. View the current remote URL:
   ```bash
   git remote -v
   ```

2. Change the remote URL to SSH:
   ```bash
   git remote set-url origin git@github.com:<username>/<repo-name>.git
   ```

Now, Git will use SSH to interact with your remote repository, allowing for secure, password-less operations.


---

### Overview of the Git Workflow


The workflow relies on a **central repository (origin)** with two main branches: `master` (for production-ready code) and `develop` (for ongoing development and integration).

![Git-Workflow](./images/git-model@2x.png)

In addition, there are **supporting branches** with specific purposes and limited lifetimes to handle parallel development, release management, and urgent bug fixes. These branches include:

1. **Feature Branches** - Used for new features
2. **Release Branches** - For preparing a new production release
3. **Hotfix Branches** - For urgent fixes in live production

Each branch type follows specific naming conventions and branch merge rules to keep the workflow organized and predictable.

---

### Main Branches

- **master**: Contains the production-ready code. Each merge into `master` represents a new release.
- **develop**: Integrates all new features and fixes intended for the next release. Automatic builds often pull from this branch.

![Main-Branches](./images/main-branches@2x.png)

### Supporting Branches

#### Feature Branches
- **Purpose**: Develop new features, without affecting `develop` until ready.
- **Origin**: Branches from `develop`
- **Merge Target**: Back into `develop`
- **Naming**: Use descriptive names, avoiding `master`, `develop`, `release-*`, or `hotfix-*`

![Feature-Branches](./images/fb@2x.png)

   **Steps to create and merge a feature branch**:
   ```bash
   # Create a feature branch
   git checkout -b myfeature develop

   # After finishing, merge into develop with --no-ff to retain branch history
   git checkout develop
   git merge --no-ff myfeature
   git branch -d myfeature
   git push origin develop
   ```

![merge-without-ff](./images/merge-without-ff@2x.png)
   

#### Release Branches
- **Purpose**: Prepare code for release, apply minor bug fixes, and finalize metadata.
- **Origin**: Branches from `develop`
- **Merge Target**: Merges into both `develop` and `master`
- **Naming**: `release-*` (e.g., `release-1.2`)

   **Steps to create and finish a release branch**:
   ```bash
   # Create a release branch
   git checkout -b release-1.2 develop

   # Make final tweaks (e.g., bump version), then merge into master
   git checkout master
   git merge --no-ff release-1.2
   git tag -a 1.2  # Tagging the release for easy reference

   # Merge changes back into develop to keep it up-to-date
   git checkout develop
   git merge --no-ff release-1.2

   # Delete the release branch
   git branch -d release-1.2
   ```

#### Hotfix Branches
- **Purpose**: Address urgent bugs in the current release.
- **Origin**: Branches from `master`
- **Merge Target**: Merges into both `master` and `develop`
- **Naming**: `hotfix-*` (e.g., `hotfix-1.2.1`)

![hotfix-branches](./images/hotfix-branches@2x.png)

   **Steps to create and finish a hotfix branch**:
   ```bash
   # Create a hotfix branch
   git checkout -b hotfix-1.2.1 master

   # Apply bug fix, bump version, then merge into master
   git checkout master
   git merge --no-ff hotfix-1.2.1
   git tag -a 1.2.1

   # Merge into develop as well to retain fix for future releases
   git checkout develop
   git merge --no-ff hotfix-1.2.1

   # Delete the hotfix branch
   git branch -d hotfix-1.2.1
   ```

---

#### Summary

This workflow ensures:
1. **Continuous Integration** through `develop`, allowing for streamlined feature integration.
2. **Stable Production Releases** with `master`, ensuring only well-tested code reaches production.
3. **Efficient Bug Fixing** using hotfix branches, ensuring minimal impact on ongoing development.
---
=








---

### Sources

1. [git and github `ahmed samy`](https://www.youtube.com/watch?v=Q6G-J54vgKc&t=16s)
2. [Git workflow](https://www.youtube.com/watch?v=7OTrHx56GfE)
3. [Git Docurmentation](https://git-scm.com/doc)
4. [Gitflow workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
5. [Vincent Dressen's website](https://nvie.com/posts/a-successful-git-branching-model/)

=======

### Git Configuration
1. **Set username globally:**
   ```bash
   git config --global user.name "mohamed"
   ```

2. **Set email globally:**
   ```bash
   git config --global user.email "mohamed.elmahdy@gmail.com"
   ```

3. **Show current configuration:**
   ```bash
   git config --list
   ```

### Working with Directories and Files
1. **Create a new directory named `gitwork`:**
   ```bash
   mkdir gitwork
   ```

2. **Navigate into the `gitwork` directory:**
   ```bash
   cd gitwork/
   ```

3. **Create a file named `file.txt` with content "Hello, Git":**
   ```bash
   echo "Hello, Git" >> file.txt
   ```

4. **Display the SHA-1 hash for the string "Hello, Git":**
   ```bash
   echo "Hello, Git" | git hash-object --stdin
   ```

5. **List all contents in the current directory:**
   ```bash
   ls
   ```

6. **Display all files in the index area:**
   ```bash
   git ls-files
   ```

7. **Display the content of a file (e.g., `file.txt`):**
   ```bash
   cat file.txt
   ```

8. **Display all files in the `.git/objects/` directory (not as commonly used):**
   ```bash
   find .git/objects/ -type f
   ```

9. **Display the SHA-1 of all files in the index area:**
   ```bash
   git ls-files -s
   ```

10. **Display the SHA-1 hash of a specific file (e.g., `file.txt`):**
    ```bash
    git hash-object file.txt
    ```

### Inspecting Git Objects
1. **Display the type of a Git object by its SHA-1:**
   ```bash
   git cat-file -t <SHA-1>
   ```

2. **Display the size of a Git object by its SHA-1:**
   ```bash
   git cat-file -s <SHA-1>
   ```

3. **Display the content of a Git object by its SHA-1:**
   ```bash
   git cat-file -p <SHA-1>
   ```

### Managing Files in Git
1. **Stage a file, multiple files, or files matching a pattern:**
   ```bash
   git add <file name, * , *.txt or fi*>
   ```

2. **Display the status of the working directory and staging area:**
   ```bash
   git status
   ```

3. **Display a short status:**
   ```bash
   git status -s
   ```

4. **Commit staged changes with a message:**
   ```bash
   git commit -m "comment"
   ```

5. **Stage and commit changes in one step:**
   ```bash
   git commit -am "comment"
   ```

### Viewing Commit History
1. **Display the commit history:**
   ```bash
   git log
   ```

2. **Display the commit history in a condensed format:**
   ```bash
   git log --oneline
   ```

3. **Filter commit history, for example, limit to last 2 commits:**
   ```bash
   git log --oneline -2
   ```

### Viewing Differences
1. **Show differences between the working directory and the staging area:**
   ```bash
   git diff
   ```

2. **Show differences between the staging area and the repository:**
   ```bash
   git diff --staged
   ```

3. **Show differences between two commits:**
   ```bash
   git diff <First SHA commit>..<Second SHA commit>
   ```

4. **Show details of a specific commit:**
   ```bash
   git show <SHA commit>
   ```

### Unstaging and Restoring Files
1. **Unstage a file:**
   ```bash
   git rm --cached <file>
   ```

2. **Discard changes in the working directory (restore from the index area):**
   ```bash
   git restore <file>
   ```

3. **Discard changes in the staging area (restore from the repository):**
   ```bash
   git restore --staged <file>
   ```
### `git rm --cached <filename>`

The `git rm --cached` command is used to remove a file from the Git index (staging area) without deleting the actual file from your working directory. In other words, it untracks a file that was previously tracked by Git but keeps it in your local file system.

#### Example:

```bash
git rm --cached filename
```

- This will remove the file `filename` from Git's tracking, but the file will remain on your local system.
- After running the command, you need to commit the change to remove the file from the repository.

```bash
git commit -m "Untrack file 'filename' but keep it locally"
```

This is especially useful when you accidentally committed a file that shouldn't be tracked (e.g., configuration files, logs, or sensitive data).

---

### `.gitignore`

A `.gitignore` file tells Git which files (or patterns of files) it should ignore and not track. When you place certain filenames or patterns in a `.gitignore` file, Git will stop tracking those files.

#### Example `.gitignore`:

```
# Ignore log files
*.log

# Ignore all files in the temp directory
/temp/

# Ignore a specific config file
config/settings.py
```

- **Wildcards** (`*`) can be used to match multiple files.
- **Directories** are ignored by placing a slash (`/`) at the end.
  
Once you have a `.gitignore` file, Git will ignore the files listed there in future commits.

#### If you have already committed files that should be ignored:
1. Add the files or directories to `.gitignore`.
2. Use `git rm --cached` to untrack those files:
   
   ```bash
   git rm --cached filename
   ```

3. Commit the changes:
   ```bash
   git commit -m "Untrack ignored files"
   ```

After this, Git will stop tracking the files listed in `.gitignore`, and they won't be included in future commits.

### Amending and Resetting Commits
1. **Modify the last commit message:**
   ```bash
   git commit --amend
   ```

2. **Move the head pointer back a number of steps and adjust the staging area:**
   ```bash
   git reset HEAD~<number of steps>
   ```

3. **Move the head pointer back a number of steps and adjust the working directory:**
   ```bash
   git reset --hard HEAD~<number of steps>
   ```

4. **Display the history of moving the HEAD pointer:**
   ```bash
   git reflog
   ```

5. **Move the head pointer forward a number of steps and adjust the working directory:**
   ```bash
   git reset --hard HEAD@{<number of steps>}
   ```

### Working with Tags
1. **Create a new annotated tag:**
   ```bash
   git tag -a v2.0 -m "Version 2.0 of file"
   ```

2. **Display details of a specific tag:**
   ```bash
   git show v2.0
   ```

3. **Display details of a specific tag in a condensed format:**
   ```bash
   git show v2.0 --oneline
   ```

### Working with Branches
1. **Create a new branch:**
   ```bash
   git branch <branch name>
   ```

2. **List all branches:**
   ```bash
   git branch
   ```

3. **Switch to a different branch:**
   ```bash
   git switch <branch name>
   ```

4. **Switch to the `master` branch:**
   ```bash
   git switch master
   ```

5. **Merge a branch into the current branch:**
   ```bash
   git merge <branch name>
   ```

6. **Show branches that have been merged:**
   ```bash
   git branch --merged
   ```

7. **Delete a branch:**
   ```bash
   git branch -d <branch name>
   ```
8. **graph alias :**
   ```bash
   $ alias graph="git log --oneline --all --graph --decorate"
   ```

### Working with remotes

1. **clone remote repo :**
   ```bash
   git clone <url> <Shourtcut Name>
   ```
2. **Display Remotes :**
   ```bash
   git remote 
   git remote -v #with more details
   ```
3. **Display rempte branches :**
   ```bash
   git branch -r
   ```
4. **add remote :**
   ```bash
   git remote add <url>
   ```
5. **fetch from remote without marging updated:**
   ```bash
   git  fetch <remote name>
   #git fetch origin
   ```
6. **To marge branches :**
   ```bash
   git marge
   ```
7. **fetch and marge from remote in once :**
   ```bash
      git pull origin #Pull from origin remote
   ```

8. **push local repo with new branch :**
   ```bash
   git brach <branche name> #create a branch
   git switch <branchname>
   #add some changes in your code 
   git push origin
   git push -u origin feature #هترفع علي الريموت ريبو الي اسمها origin علي برانش هتعمله اسمه feature
   # -u = --set-upstream origin feature
   ```
9. **list local branches with some details about last commit :**
   ```bash
   git branch -v
   git branch -vv # ++ tracing with remote branches
   ```
10. **rename branch  :**
      ```bash
      git branch -M <NewName> #git branch -M main
      ```
Here’s an expanded list of version control support tools for Visual Studio Code (VSCode), including **GitLens** and more:

### Version Control Support Tools in VSCode

1. **GitLens**
   - Enhances the built-in Git capabilities of VSCode.
   - Provides features like inline blame annotations, repository insights, and a rich history view.
   - Allows you to explore commit history, see who changed what, and visualize code authorship.

2. **Git Graph**
   - Displays a visual representation of your Git repository's history.
   - Allows for easy branching, merging, and viewing commit details.
   - Supports creating and managing branches directly from the graph interface.

3. **GitHub Pull Requests and Issues**
   - Integrated support for GitHub pull requests and issues directly within VSCode.
   - Allows you to review, manage, and merge pull requests without leaving the editor.
   - Provides features for commenting on and resolving issues.

4. **GitHub Copilot**
   - AI-powered code completion tool that helps you write code faster.
   - Provides suggestions and helps with documentation by leveraging vast codebases.

5. **Live Share**
   - Enables real-time collaborative coding with others.
   - Allows multiple users to edit files and navigate through code together, which can be especially useful for pair programming and code reviews.

6. **Source Control Extension API**
   - Allows developers to create custom extensions for version control.
   - You can find or develop extensions that integrate with other version control systems beyond Git, such as Mercurial or Subversion.

7. **Commit Graph**
   - Visualizes the commit history as a graph, making it easy to understand branching and merging.
   - Helps track changes and navigate through the history of the project effectively.

8. **VSCode Settings Sync**
   - Allows you to synchronize your VSCode settings, extensions, and configurations across multiple machines.
   - Ensures a consistent development environment and workflow regardless of where you work.

9. **Azure Repos**
   - Integrates Azure DevOps repositories into VSCode.
   - Allows you to clone, manage, and create pull requests for Azure DevOps repositories seamlessly.

10. **Terminal Integration**
    - Built-in terminal support allows you to run Git commands directly within VSCode.
    - This enables you to manage version control operations without switching between the editor and terminal.


### SSH for GitHub

**SSH (Secure Shell)** is a protocol that provides a secure way to access remote systems and transfer data. For GitHub, SSH is commonly used to securely authenticate and connect to your GitHub repositories without needing to enter your password every time. 

Here’s how SSH works with GitHub and how to set it up:

### Why Use SSH with GitHub?

1. **Secure Authentication**: SSH keys are used to securely log into the GitHub server. Unlike HTTP-based access, you don’t need to provide a username and password every time you push or pull changes.
2. **Convenience**: Once your SSH key is added to your GitHub account, you won't need to input credentials manually.
3. **Improved Security**: SSH keys are generally more secure than password-based authentication.

### How SSH Works
SSH uses a **pair of cryptographic keys**:
1. **Public Key**: This is stored on GitHub and identifies who is accessing the repository.
2. **Private Key**: This remains securely on your local machine.

When you attempt to push or pull from GitHub, the private key on your machine is matched with the public key stored on GitHub. If they match, you gain access.

### Setting up SSH for GitHub

#### Step 1: Check for Existing SSH Keys
Before generating a new SSH key, check if you already have one:
```bash
ls -al ~/.ssh
```
This lists any SSH keys already on your machine.

#### Step 2: Generate a New SSH Key
If you don't have an existing key, generate a new one:
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
- `-t ed25519`: Specifies the type of encryption (Ed25519 is recommended).
- `-C "your_email@example.com"`: Adds a comment with your email for identification.

If your system doesn’t support `ed25519`, you can use `rsa`:
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

#### Step 3: Add SSH Key to the SSH Agent
Start the SSH agent and add your key to it:
```bash
eval "$(ssh-agent -s)"    # Start the SSH agent
ssh-add ~/.ssh/id_ed25519  # Add your SSH key
```

#### Step 4: Add SSH Key to GitHub
Now, you need to add the public key to your GitHub account:
1. Copy your public key to the clipboard:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```
   or
   ```bash
   pbcopy < ~/.ssh/id_ed25519.pub  # MacOS only
   ```
2. Go to **GitHub** > **Settings** > **SSH and GPG Keys** > **New SSH Key**.
3. Paste the public key into the "Key" field and give it a meaningful title.

#### Step 5: Test SSH Connection to GitHub
Run this command to verify that your SSH connection is set up correctly:
```bash
ssh -T git@github.com
```
If it works, you’ll get a message like:
```
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
```

### Configuring Git to Use SSH

Once your SSH key is set up, you can configure Git to use SSH instead of HTTPS by changing your repository’s remote URL:

1. View the current remote URL:
   ```bash
   git remote -v
   ```

2. Change the remote URL to SSH:
   ```bash
   git remote set-url origin git@github.com:<username>/<repo-name>.git
   ```

Now, Git will use SSH to interact with your remote repository, allowing for secure, password-less operations.


---

### Overview of the Git Workflow


The workflow relies on a **central repository (origin)** with two main branches: `master` (for production-ready code) and `develop` (for ongoing development and integration).

![Git-Workflow](./images/git-model@2x.png)

In addition, there are **supporting branches** with specific purposes and limited lifetimes to handle parallel development, release management, and urgent bug fixes. These branches include:

1. **Feature Branches** - Used for new features
2. **Release Branches** - For preparing a new production release
3. **Hotfix Branches** - For urgent fixes in live production

Each branch type follows specific naming conventions and branch merge rules to keep the workflow organized and predictable.

---

### Main Branches

- **master**: Contains the production-ready code. Each merge into `master` represents a new release.
- **develop**: Integrates all new features and fixes intended for the next release. Automatic builds often pull from this branch.

![Main-Branches](./images/main-branches@2x.png)

### Supporting Branches

#### Feature Branches
- **Purpose**: Develop new features, without affecting `develop` until ready.
- **Origin**: Branches from `develop`
- **Merge Target**: Back into `develop`
- **Naming**: Use descriptive names, avoiding `master`, `develop`, `release-*`, or `hotfix-*`

![Feature-Branches](./images/fb@2x.png)

   **Steps to create and merge a feature branch**:
   ```bash
   # Create a feature branch
   git checkout -b myfeature develop

   # After finishing, merge into develop with --no-ff to retain branch history
   git checkout develop
   git merge --no-ff myfeature
   git branch -d myfeature
   git push origin develop
   ```

![merge-without-ff](./images/merge-without-ff@2x.png)
   

#### Release Branches
- **Purpose**: Prepare code for release, apply minor bug fixes, and finalize metadata.
- **Origin**: Branches from `develop`
- **Merge Target**: Merges into both `develop` and `master`
- **Naming**: `release-*` (e.g., `release-1.2`)

   **Steps to create and finish a release branch**:
   ```bash
   # Create a release branch
   git checkout -b release-1.2 develop

   # Make final tweaks (e.g., bump version), then merge into master
   git checkout master
   git merge --no-ff release-1.2
   git tag -a 1.2  # Tagging the release for easy reference

   # Merge changes back into develop to keep it up-to-date
   git checkout develop
   git merge --no-ff release-1.2

   # Delete the release branch
   git branch -d release-1.2
   ```

#### Hotfix Branches
- **Purpose**: Address urgent bugs in the current release.
- **Origin**: Branches from `master`
- **Merge Target**: Merges into both `master` and `develop`
- **Naming**: `hotfix-*` (e.g., `hotfix-1.2.1`)

![hotfix-branches](./images/hotfix-branches@2x.png)

   **Steps to create and finish a hotfix branch**:
   ```bash
   # Create a hotfix branch
   git checkout -b hotfix-1.2.1 master

   # Apply bug fix, bump version, then merge into master
   git checkout master
   git merge --no-ff hotfix-1.2.1
   git tag -a 1.2.1

   # Merge into develop as well to retain fix for future releases
   git checkout develop
   git merge --no-ff hotfix-1.2.1

   # Delete the hotfix branch
   git branch -d hotfix-1.2.1
   ```

---

#### Summary

This workflow ensures:
1. **Continuous Integration** through `develop`, allowing for streamlined feature integration.
2. **Stable Production Releases** with `master`, ensuring only well-tested code reaches production.
3. **Efficient Bug Fixing** using hotfix branches, ensuring minimal impact on ongoing development.
---
=








---

### Sources

1. [git and github `ahmed samy`](https://www.youtube.com/watch?v=Q6G-J54vgKc&t=16s)
2. [Git workflow](https://www.youtube.com/watch?v=7OTrHx56GfE)
3. [Git Docurmentation](https://git-scm.com/doc)
4. [Gitflow workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
5. [Vincent Dressen's website](https://nvie.com/posts/a-successful-git-branching-model/)

>>>>>>> 0cc62acef8126efc964bc44b2282d7b8e2b0f07b
