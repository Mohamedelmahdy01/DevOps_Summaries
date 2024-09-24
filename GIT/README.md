Here are some of the most common and widely used Git commands along with their purposes:

1. **git init:**
   - Initializes a new Git repository in the current directory.

2. **git clone <repository_url>:**
   - Creates a copy of an existing repository from a remote server (e.g., GitHub) to your local machine.

3. **git add <file(s)>:**
   - Stages changes to be committed. You can add specific files or use `git add .` to stage all changes in the current directory.

4. **git commit -m "Commit message":**
   - Records the staged changes in the repository with a descriptive message.

5. **git status:**
   - Displays the state of the working directory and the staging area, showing which changes are staged, unstaged, and untracked.

6. **git log:**
   - Shows the commit history for the repository, including commit messages, authors, and timestamps.

7. **git pull:**
   - Fetches and merges changes from the remote repository into the current branch.

8. **git push:**
   - Pushes committed changes from the local repository to the remote repository.

9. **git branch:**
   - Lists all branches in the local repository. The `-a` option shows both local and remote branches.

10. **git checkout <branch_name>:**
    - Switches to the specified branch or commit. The `-b` option can be used to create and switch to a new branch.

11. **git merge <branch_name>:**
    - Merges changes from the specified branch into the current branch.

12. **git diff:**
    - Shows the differences between the working directory and the staging area, or between different commits.

13. **git remote -v:**
    - Displays the URLs of the remote repositories associated with the local repository.

14. **git fetch:**
    - Downloads objects and refs from another repository without merging them.

15. **git reset:**
    - Resets the current branch to a specified state. The `--soft`, `--mixed`, and `--hard` options determine the level of reset (keeping or discarding changes).

16. **git rebase:**
    - Reapplies commits on top of another base tip, useful for streamlining a series of commits.

These commands cover the fundamental operations you are likely to perform in your day-to-day work with Git.

Here’s a detailed explanation of each command you mentioned:

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
### version control support in VSC

1.**Gitlens**

2.**adf :**
