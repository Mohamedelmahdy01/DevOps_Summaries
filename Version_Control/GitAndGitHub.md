
# Git Cheatsheet & Workflow Guide

This guide covers essential Git commands, concepts, workflows, and tools, organized for clarity and ease of reference.

## I. Initial Git Setup & Configuration

Before starting, configure Git with your identity. This information is embedded into your commits.

1.  **Set Username Globally:**
    *   Associates your commits with your name.
    ```bash
    git config --global user.name "mohamed"
    ```

2.  **Set Email Globally:**
    *   Associates your commits with your email address.
    ```bash
    git config --global user.email "mohamed.elmahdy@gmail.com"
    ```

3.  **Show Current Configuration:**
    *   Lists all Git configuration settings (global, system, local).
    ```bash
    git config --list
    ```

## II. Creating and Examining a Repository

Setting up a new project or working with existing files under Git control.

1.  **Create a Project Directory:**
    ```bash
    mkdir gitwork
    ```

2.  **Navigate into the Directory:**
    ```bash
    cd gitwork/
    ```

3.  **Initialize a New Git Repository:**
    *   Creates a hidden `.git` directory where Git stores all its metadata. This command turns the current directory into a Git repository.
    ```bash
    git init
    ```

4.  **Create a Sample File:**
    ```bash
    echo "Hello, Git" >> file.txt
    ```

5.  **List Directory Contents (OS Command):**
    *   Shows files in the current working directory.
    ```bash
    ls
    ```

6.  **Display File Content (OS Command):**
    *   Shows the content of a specific file.
    ```bash
    cat file.txt
    ```

7.  **Hashing Content (Plumbing Command):**
    *   Calculates the SHA-1 hash Git would use for given content without creating an object.
    ```bash
    echo "Hello, Git" | git hash-object --stdin
    ```

8.  **Hashing a File (Plumbing Command):**
    *   Calculates the SHA-1 hash for a file's content and optionally creates a blob object in the Git database (use `-w` to write).
    ```bash
    git hash-object file.txt
    ```

9.  **List Files in the Index (Staging Area):**
    *   Shows files currently staged. Initially empty after `git init`.
    ```bash
    git ls-files
    ```

10. **List Files in the Index with Details:**
    *   Shows staged files with their mode, SHA-1 hash, and stage number.
    ```bash
    git ls-files -s
    ```

11. **Inspect Git Objects (Plumbing Commands):**
    *   These low-level commands allow direct interaction with Git's object database using an object's SHA-1 hash.
    *   **Display Object Type:** (blob, tree, commit, tag)
        ```bash
        git cat-file -t <SHA-1>
        ```
    *   **Display Object Size:**
        ```bash
        git cat-file -s <SHA-1>
        ```
    *   **Display Object Content (Pretty Print):**
        ```bash
        git cat-file -p <SHA-1>
        ```

12. **Find Object Files (Advanced):**
    *   Lists the actual files within the `.git/objects/` directory. Less commonly used for direct inspection.
    ```bash
    find .git/objects/ -type f
    ```

## III. The Basic Git Workflow: Staging & Committing

The fundamental cycle of making changes, preparing them, and saving them to the repository history.

1.  **Check Repository Status:**
    *   Shows the state of the working directory and staging area: tracked, untracked, modified, and staged files.
    ```bash
    git status
    ```
    *   **Short Status:** Provides a compact overview.
        ```bash
        git status -s
        ```

2.  **Stage Changes:**
    *   Adds file contents to the index (staging area), preparing them for the next commit.
    *   Stage a specific file:
        ```bash
        git add file.txt
        ```
    *   Stage all changes in the current directory and subdirectories:
        ```bash
        git add .
        # or
        git add *
        ```
    *   Stage all `.txt` files:
        ```bash
        git add *.txt
        ```
    *   Stage files starting with `fi`:
        ```bash
        git add fi*
        ```

3.  **Commit Staged Changes:**
    *   Records the snapshot of the staging area to the commit history.
    ```bash
    git commit -m "Your descriptive commit message"
    ```

4.  **Stage and Commit in One Step:**
    *   Stages all tracked, modified files and commits them. **Note:** Does not stage *new* (untracked) files.
    ```bash
    git commit -am "Stage and commit tracked changes"
    ```

## IV. Inspecting History & Changes

Viewing past commits and understanding the differences between states.

1.  **View Commit History:**
    *   Shows the commit log in reverse chronological order.
    ```bash
    git log
    ```
    *   **Condensed Log:** Shows each commit on a single line.
        ```bash
        git log --oneline
        ```
    *   **Limit Log Output:** Shows only the last `n` commits.
        ```bash
        git log --oneline -2 # Shows the last 2 commits
        ```
    *   **Graphical Log:** Displays the log with branches and merge history visually (often used with `--oneline --all --decorate`).
        ```bash
        git log --oneline --graph --all --decorate
        ```
        *   **Alias for Graphical Log:** You can create a shell alias for convenience (add to `.bashrc` or `.zshrc`):
            ```bash
            alias graph="git log --oneline --all --graph --decorate"
            ```
            Then simply run `graph`.

2.  **Show Changes (Diffs):**
    *   **Working Directory vs. Staging Area:** Shows changes made but not yet staged.
        ```bash
        git diff
        ```
    *   **Staging Area vs. Last Commit:** Shows changes staged but not yet committed.
        ```bash
        git diff --staged
        # or
        git diff --cached
        ```
    *   **Between Two Commits:** Shows the difference between two specific commits.
        ```bash
        git diff <First_SHA_Commit>..<Second_SHA_Commit>
        ```
    *   **Working Directory vs. Specific Commit:** Shows differences between your current files and a past commit.
        ```bash
        git diff <SHA_Commit>
        ```

3.  **Show Details of a Specific Commit:**
    *   Displays the commit metadata (author, date, message) and the changes introduced by that commit.
    ```bash
    git show <SHA_Commit>
    ```

## V. Undoing Changes & Managing History

Correcting mistakes, reverting changes, and modifying commit history (use with caution, especially on shared branches).

1.  **Unstage a File:**
    *   Removes a file from the staging area, but leaves the changes in the working directory. (Use `git restore --staged <file>` in modern Git versions).
    ```bash
    git rm --cached <file> # Older command, still works
    git restore --staged <file> # Recommended modern command
    ```

2.  **Discard Working Directory Changes:**
    *   Reverts changes in a specific file back to the version in the staging area (Index). **Warning:** Discards changes permanently.
    ```bash
    git restore <file>
    ```

3.  **Modify the Last Commit:**
    *   Allows you to change the last commit message or add more staged changes to the previous commit. **Warning:** Rewrites history; avoid if already pushed.
    ```bash
    # Stage any additional changes if needed: git add <file>
    git commit --amend -m "New or corrected commit message"
    # To only change the message without adding files:
    git commit --amend --no-edit # Keeps existing message but adds newly staged files
    git commit --amend # Opens editor to change message and includes staged files
    ```

4.  **Resetting Commits (`git reset`):**
    *   Moves the current branch pointer (`HEAD`) to a different commit, potentially altering the staging area and working directory.
    *   **Soft Reset:** Moves `HEAD` only. Staging area and working directory are unchanged. Changes from undone commits appear as staged.
        ```bash
        git reset --soft HEAD~<number_of_steps> # Example: git reset --soft HEAD~1
        ```
    *   **Mixed Reset (Default):** Moves `HEAD` and updates the staging area to match the target commit. Working directory is unchanged. Changes from undone commits appear as unstaged modifications.
        ```bash
        git reset HEAD~<number_of_steps> # Example: git reset HEAD~1
        ```
    *   **Hard Reset:** Moves `HEAD`, updates the staging area, AND updates the working directory to match the target commit. **Warning:** Discards all changes (staged and unstaged) since the target commit permanently.
        ```bash
        git reset --hard HEAD~<number_of_steps> # Example: git reset --hard HEAD~1
        ```

5.  **Viewing History of HEAD Movements (`reflog`):**
    *   Shows a log of where `HEAD` has pointed. Invaluable for recovering from mistakes, especially after resets.
    ```bash
    git reflog
    ```

6.  **Resetting to a Reflog Entry:**
    *   You can use `git reset` with reflog entries (e.g., `HEAD@{<number>}`) to move the branch pointer back to a previous state.
    *   Move `HEAD` forward/backward based on reflog, adjusting working directory:
        ```bash
        git reset --hard HEAD@{<number>} # Example: git reset --hard HEAD@{2}
        ```

## VI. Managing Tracked Files (`.gitignore` and Untracking)

Controlling which files Git should track or ignore.

### `.gitignore` File

*   A `.gitignore` file specifies intentionally untracked files that Git should ignore. Files already tracked by Git are not affected.
*   Create a file named `.gitignore` in your repository's root directory.
*   Add patterns for files or directories to ignore (one pattern per line).

    **Example `.gitignore`:**
    ```
    # Ignore log files
    *.log

    # Ignore all files in the temp directory (relative to .gitignore location)
    temp/

    # Ignore a specific config file in a specific path
    config/settings.py

    # Ignore build artifacts
    build/
    dist/

    # Ignore IDE/editor specific files
    .vscode/
    *.suo
    *.user
    ```

### Untracking Files (`git rm --cached`)

*   The `git rm --cached <filename>` command removes a file from Git's tracking (the index/staging area) *without* deleting the file from your working directory.
*   This is useful if you accidentally added and committed a file that *should* have been ignored (like configuration files, logs, or sensitive data).

    **Steps to Untrack an Already Committed File:**

    1.  **Add the file/pattern to `.gitignore`:**
        ```
        # In .gitignore
        sensitive_data.log
        config/local_settings.py
        ```

    2.  **Remove the file from Git's tracking:**
        ```bash
        git rm --cached sensitive_data.log
        git rm --cached config/local_settings.py
        # For a directory
        git rm -r --cached build/
        ```

    3.  **Commit the removal and the `.gitignore` changes:**
        ```bash
        git add .gitignore
        git commit -m "Untrack sensitive files and update .gitignore"
        ```
    *   Now, the file remains in your local working directory but will no longer be tracked by Git in future commits.

## VII. Tagging Releases

Marking specific points in history, typically used for version releases.

1.  **Create an Annotated Tag:**
    *   Recommended type; stores extra metadata (tagger, date, message) and is checksummed.
    ```bash
    git tag -a v1.0 -m "Version 1.0 release" <optional_commit_SHA>
    # If commit SHA is omitted, it tags the current HEAD
    ```

2.  **Create a Lightweight Tag:**
    *   A simple pointer to a commit; doesn't store extra metadata.
    ```bash
    git tag v1.0-lw <optional_commit_SHA>
    ```

3.  **List Tags:**
    ```bash
    git tag
    ```

4.  **Show Tag Details:**
    *   Displays the commit the tag points to and the tag metadata (for annotated tags).
    ```bash
    git show v1.0
    ```
    *   **Condensed Tag Details:**
        ```bash
        git show v1.0 --oneline
        ```

5.  **Push Tags to Remote:**
    *   Tags are not pushed automatically with `git push`.
    *   Push a specific tag:
        ```bash
        git push origin v1.0
        ```
    *   Push all local tags:
        ```bash
        git push origin --tags
        ```

## VIII. Branching & Merging

Managing parallel lines of development.

1.  **Create a New Branch:**
    *   Creates a new pointer to the current commit. Does not switch to it.
    ```bash
    git branch <new-branch-name>
    ```

2.  **List Branches:**
    *   Shows all local branches. The current branch is marked with `*`.
    ```bash
    git branch
    ```
    *   List local branches with last commit details:
        ```bash
        git branch -v
        ```
    *   List local branches with tracking information:
        ```bash
        git branch -vv
        ```
    *   List remote-tracking branches:
        ```bash
        git branch -r
        ```
    *   List all branches (local and remote-tracking):
        ```bash
        git branch -a
        ```

3.  **Switch to a Different Branch:**
    *   Updates the working directory and staging area to match the selected branch.
    ```bash
    git switch <branch-name> # Recommended modern command
    # Or the older command:
    git checkout <branch-name>
    ```

4.  **Create and Switch to a New Branch:**
    ```bash
    git switch -c <new-branch-name> # Recommended modern command
    # Or the older command:
    git checkout -b <new-branch-name>
    ```

5.  **Rename the Current Branch:**
    *   Changes the name of the branch you are currently on.
    ```bash
    git branch -M <NewName> # Example: git branch -M main
    ```

6.  **Merge a Branch into the Current Branch:**
    *   Combines the history of the specified branch into the currently checked-out branch.
    ```bash
    # First, switch to the branch you want to merge INTO
    git switch main
    # Then, merge the other branch
    git merge <branch-to-merge>
    ```
    *   **Merge with `--no-ff`:** Creates a merge commit even if it could be a fast-forward merge. Useful for preserving the history of feature branches (see Gitflow).
        ```bash
        git merge --no-ff <feature-branch>
        ```

7.  **Show Merged Branches:**
    *   Lists branches whose changes are fully included in the current branch.
    ```bash
    git branch --merged
    ```

8.  **Show Unmerged Branches:**
    *   Lists branches that contain changes not yet merged into the current branch.
    ```bash
    git branch --no-merged
    ```

9.  **Delete a Branch:**
    *   Removes the branch pointer. **Safety:** Prevents deletion if the branch has unmerged changes.
    ```bash
    git branch -d <branch-name>
    ```
    *   **Force Delete:** Deletes the branch even if it has unmerged changes. Use with caution.
    ```bash
    git branch -D <branch-name>
    ```

## IX. Working with Remote Repositories

Collaborating with others and synchronizing repositories hosted elsewhere (e.g., GitHub, GitLab).

1.  **Clone a Remote Repository:**
    *   Downloads a repository, creates a local copy, sets up a remote named `origin` pointing to the source URL, and checks out the default branch.
    ```bash
    git clone <repository-url> <optional-local-directory-name>
    # Example: git clone https://github.com/user/repo.git my-project
    ```

2.  **Manage Remotes:**
    *   **List Remotes:** Shows the short names of configured remotes (e.g., `origin`).
        ```bash
        git remote
        ```
    *   **List Remotes with URLs:** Shows names and corresponding URLs.
        ```bash
        git remote -v
        ```
    *   **Add a New Remote:** Connects your local repository to another remote repository.
        ```bash
        git remote add <shortname> <url> # Example: git remote add upstream https://github.com/original-author/repo.git
        ```
    *   **Remove a Remote:**
        ```bash
        git remote remove <shortname>
        ```
    *   **Rename a Remote:**
        ```bash
        git remote rename <old-name> <new-name>
        ```

3.  **Fetch Changes from a Remote:**
    *   Downloads commits, files, and refs from a remote repository into your local `.git` directory, updating remote-tracking branches (e.g., `origin/main`). Does **not** merge changes into your working branches.
    ```bash
    git fetch <remote-name> # Example: git fetch origin
    git fetch --all # Fetch from all remotes
    ```

4.  **Merge Fetched Changes:**
    *   After fetching, you typically merge the changes from the remote-tracking branch into your local branch.
    ```bash
    # Assuming you are on the 'main' branch and fetched from 'origin'
    git merge origin/main
    ```

5.  **Pull Changes from a Remote:**
    *   A combination of `git fetch` followed by `git merge` (or `git rebase` if configured). Fetches changes and immediately attempts to integrate them into your current local branch.
    ```bash
    git pull <remote-name> <branch-name> # Example: git pull origin main
    # If tracking is set up, you can often just use:
    git pull
    ```

6.  **Push Changes to a Remote:**
    *   Uploads local branch commits to the corresponding branch on the remote repository.
    ```bash
    git push <remote-name> <local-branch-name>:<remote-branch-name>
    # Example: git push origin main:main
    # If the local and remote branch names are the same:
    git push origin main
    ```
    *   **Push a New Branch and Set Up Tracking:** The `-u` flag pushes the branch and sets the upstream relationship, so future `git pull` and `git push` commands (from that branch) don't need arguments.
        ```bash
        # Assuming you are on a new local branch named 'feature'
        git push -u origin feature # Pushes 'feature' to 'origin' and tracks origin/feature
        ```
    *   **Push Tags:** (See Section VII)

7.  **Delete a Remote Branch:**
    ```bash
    git push <remote-name> --delete <branch-name> # Example: git push origin --delete old-feature
    ```

## X. Securely Connecting to GitHub with SSH

Using SSH keys provides a secure way to interact with remote repositories like GitHub without needing to enter your username and password repeatedly.

### Why Use SSH with GitHub?

1.  **Secure Authentication:** Uses cryptographic keys instead of passwords.
2.  **Convenience:** Avoids password prompts for fetch, pull, push.
3.  **Improved Security:** Generally considered more secure than HTTPS password authentication.

### How SSH Works

SSH uses a key pair:
1.  **Public Key (`.pub`):** Stored on the service (GitHub). Identifies you.
2.  **Private Key:** Kept securely on your local machine. Proves your identity.

When connecting, your Git client uses the private key to authenticate against the public key stored on GitHub.

### Setting up SSH for GitHub

**Step 1: Check for Existing SSH Keys**
```bash
ls -al ~/.ssh
# Look for files like id_rsa, id_ed25519, id_ecdsa
```

**Step 2: Generate a New SSH Key (if needed)**
*   Recommended: Ed25519
    ```bash
    ssh-keygen -t ed25519 -C "your_email@example.com"
    ```
*   Alternative: RSA (if Ed25519 is not supported)
    ```bash
    ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
    ```
*   Follow the prompts. You can press Enter to accept default file locations (`~/.ssh/id_ed25519` or `~/.ssh/id_rsa`) and optionally set a passphrase for extra security.

**Step 3: Add SSH Key to the SSH Agent**
*   The SSH agent manages your keys and passphrases.
```bash
eval "$(ssh-agent -s)"       # Start the SSH agent in the background
ssh-add ~/.ssh/id_ed25519 # Add your private key (use id_rsa if you generated that type)
# Enter passphrase if you set one
```

**Step 4: Add the Public Key to GitHub**
1.  Copy the public key content to your clipboard:
    ```bash
    cat ~/.ssh/id_ed25519.pub
    # Or on macOS: pbcopy < ~/.ssh/id_ed25519.pub
    # Or on Windows (Git Bash): clip < ~/.ssh/id_ed25519.pub
    ```
2.  Go to your GitHub account **Settings**.
3.  Navigate to **SSH and GPG keys**.
4.  Click **New SSH key** or **Add SSH key**.
5.  Give it a descriptive **Title** (e.g., "My Laptop").
6.  Paste the copied public key into the **Key** field.
7.  Click **Add SSH key**.

**Step 5: Test the SSH Connection**
```bash
ssh -T git@github.com
```
*   You might see a warning about host authenticity. Type `yes` to continue.
*   If successful, you'll see a message like: `Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.`

### Configuring Git Repositories to Use SSH

*   **For new clones:** Use the SSH URL provided by GitHub (starts with `git@github.com:`).
    ```bash
    git clone git@github.com:<username>/<repo-name>.git
    ```
*   **For existing repositories using HTTPS:** Change the remote URL.
    1.  View current remote URL:
        ```bash
        git remote -v
        ```
    2.  Change the `origin` remote URL to SSH:
        ```bash
        git remote set-url origin git@github.com:<username>/<repo-name>.git
        ```

Now, Git operations like `fetch`, `pull`, and `push` will use the secure SSH connection.

## XI. Advanced Workflow: Gitflow Model

Gitflow is a popular branching model designed for projects with scheduled releases. It provides a robust framework for managing larger projects.

### Overview

*   Relies on a central repository (`origin`).
*   Uses two main branches with infinite lifetimes:
    *   `master` (or `main`): Represents production-ready, stable code. Tagged for releases.
    *   `develop`: Represents the latest integrated development changes for the next release. This is where features are merged.
*   Uses several types of temporary **supporting branches** for parallel development, release preparation, and maintenance.

![Gitflow Overall Model](./images/git-model@2x.png) *(Image reference - will not display in plain text)*

### Main Branches

![Main Branches](./images/main-branches@2x.png) *(Image reference)*

*   **`master` / `main`**:
    *   Should always reflect a production-ready state.
    *   Code is merged into `master` only from `release` branches or `hotfix` branches.
    *   Each commit on `master` should be tagged with a version number.
*   **`develop`**:
    *   Serves as the integration branch for features.
    *   Originates from `master`.
    *   All completed `feature` branches are merged back into `develop`.
    *   When `develop` reaches a stable point and is ready for release, a `release` branch is created from it.

### Supporting Branches

#### 1. Feature Branches (`feature/*`)

![Feature Branches](./images/fb@2x.png) *(Image reference)*

*   **Purpose**: Develop new features for upcoming releases.
*   **Branch From**: `develop`
*   **Merge Back Into**: `develop`
*   **Naming Convention**: `feature/<feature-name>` (e.g., `feature/user-authentication`)
*   **Workflow**:
    ```bash
    # Start a new feature
    git switch develop
    git switch -c feature/new-cool-feature develop

    # ... work on the feature, make commits ...

    # Feature complete, merge back into develop
    git switch develop
    git pull origin develop # Ensure develop is up-to-date
    # Use --no-ff to keep history of the feature branch existence
    git merge --no-ff feature/new-cool-feature
    git push origin develop

    # Delete the feature branch locally
    git branch -d feature/new-cool-feature
    # Optionally, delete the remote feature branch if it was pushed
    # git push origin --delete feature/new-cool-feature
    ```
    ![Merge without Fast-Forward](./images/merge-without-ff@2x.png) *(Image reference explaining `--no-ff`)*
    *   Using `--no-ff` (no fast-forward) creates a merge commit, even if the branches could be merged linearly. This preserves the historical context that these commits were developed on a separate feature branch.

#### 2. Release Branches (`release/*`)

*   **Purpose**: Prepare for a new production release. Allows for final testing, minor bug fixes, and preparing metadata (version numbers, build configs). No major new features should be added here.
*   **Branch From**: `develop` (when `develop` is deemed ready for release)
*   **Merge Back Into**: `master` (or `main`) AND `develop`
*   **Naming Convention**: `release/<version-number>` (e.g., `release/1.2.0`)
*   **Workflow**:
    ```bash
    # Create release branch from develop
    git switch develop
    git pull origin develop
    git switch -c release/1.2.0 develop

    # ... perform release tasks: bump version, fix minor bugs, documentation ...
    # Make commits on the release branch

    # Release is ready, finish it:
    # 1. Merge into master
    git switch master
    git pull origin master
    git merge --no-ff release/1.2.0
    git push origin master

    # 2. Tag the release on master
    git tag -a v1.2.0 -m "Release version 1.2.0"
    git push origin v1.2.0 # Push the tag

    # 3. Merge changes made in release branch back into develop
    git switch develop
    git pull origin develop
    git merge --no-ff release/1.2.0 # Ensure fixes made during release prep are in develop
    git push origin develop

    # 4. Delete the release branch
    git branch -d release/1.2.0
    # Optionally delete remote branch: git push origin --delete release/1.2.0
    ```

#### 3. Hotfix Branches (`hotfix/*`)

![Hotfix Branches](./images/hotfix-branches@2x.png) *(Image reference)*

*   **Purpose**: Address critical bugs found in the production version (`master`) that require an immediate fix.
*   **Branch From**: `master` (or `main`) from the corresponding tagged production version.
*   **Merge Back Into**: `master` AND `develop`
*   **Naming Convention**: `hotfix/<version-number>` (e.g., `hotfix/1.2.1`)
*   **Workflow**:
    ```bash
    # Start hotfix from the production tag on master
    git switch master
    git pull origin master
    # Optional: checkout the specific tag if needed: git checkout -b hotfix/1.2.1 v1.2.0
    git switch -c hotfix/1.2.1 master # Or from the tag

    # ... fix the critical bug, bump patch version ...
    # Make commits on the hotfix branch

    # Hotfix complete, finish it:
    # 1. Merge into master
    git switch master
    git pull origin master
    git merge --no-ff hotfix/1.2.1
    git push origin master

    # 2. Tag the new hotfix release on master
    git tag -a v1.2.1 -m "Hotfix version 1.2.1"
    git push origin v1.2.1

    # 3. Merge hotfix back into develop to ensure fix is included in future releases
    git switch develop
    git pull origin develop
    git merge --no-ff hotfix/1.2.1
    git push origin develop

    # 4. Delete the hotfix branch
    git branch -d hotfix/1.2.1
    # Optionally delete remote branch: git push origin --delete hotfix/1.2.1
    ```

### Summary of Gitflow Benefits

1.  **Parallel Development**: Feature branches isolate work.
2.  **Collaboration**: `develop` acts as an integration point.
3.  **Release Stability**: `release` branches allow stabilization before merging to `master`.
4.  **Production Readiness**: `master` always holds stable, released code.
5.  **Urgent Fixes**: `hotfix` branches allow quick patches without disrupting development.

## XII. Enhancing Workflow with VS Code Tools

Visual Studio Code offers excellent built-in Git support and powerful extensions to streamline version control.

1.  **Built-in Git Support:**
    *   Source Control view (Ctrl+Shift+G) for staging, committing, viewing changes, branch management, etc.
    *   Gutter indicators showing added, modified, or deleted lines.
    *   Integrated terminal (Ctrl+`) for running any Git command.

2.  **GitLens (Extension):**
    *   Supercharges built-in Git features.
    *   **Inline Blame Annotations:** See who last changed a line of code directly in the editor.
    *   **Code Lens:** Shows recent commit and author information above functions/classes.
    *   **Rich History View:** Explore file or repository history, compare commits/branches visually.
    *   **Powerful Comparison Tools:** Easily compare revisions.

3.  **Git Graph (Extension):**
    *   Provides a visual graph representation of the commit history.
    *   Allows easy understanding of branching and merging.
    *   Perform Git actions (checkout, merge, cherry-pick, etc.) directly from the graph.

4.  **GitHub Pull Requests and Issues (Extension by GitHub):**
    *   Manage GitHub pull requests and issues directly within VS Code.
    *   Review code, add comments, approve, and merge PRs.
    *   Create, view, and manage issues.

5.  **GitHub Copilot (Extension by GitHub):**
    *   AI pair programmer offering code suggestions and completions based on context.
    *   Can help write boilerplate code, tests, and documentation faster.

6.  **Live Share (Extension by Microsoft):**
    *   Enables real-time collaborative coding and debugging.
    *   Useful for pair programming, code reviews, and remote collaboration on Git-managed projects.

7.  **Azure Repos (Extension by Microsoft):**
    *   Integration for Azure DevOps Repos (Microsoft's Git hosting).
    *   Manage work items, pull requests, and repositories hosted on Azure DevOps.

8.  **VSCode Settings Sync (Built-in or Extension like Settings Sync):**
    *   Synchronize VS Code settings, extensions, and keybindings across multiple machines using GitHub Gist or other backends. Ensures a consistent development environment.

## XIII. Sources

1.  [git and github `ahmed samy`](https://www.youtube.com/watch?v=Q6G-J54vgKc&t=16s) - (Video tutorial reference)
2.  [Git workflow](https://www.youtube.com/watch?v=7OTrHx56GfE) - (Video tutorial reference)
3.  [Git Documentation](https://git-scm.com/doc) - Official Git documentation.
4.  [Gitflow Workflow by Atlassian](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) - Detailed explanation of the Gitflow model.
5.  [A successful Git branching model by Vincent Driessen](https://nvie.com/posts/a-successful-git-branching-model/) - The original blog post introducing Gitflow.

***