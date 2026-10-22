# Dotfiles

Personal Linux configuration managed with **Git** and **GNU Stow**.

Git tracks changes. Stow creates symbolic links from the home directory to files in this repository. Applications continue reading their usual configuration paths; the source files live here.

## Repository layout

```text
~/dotfiles/
├── bash/
│   └── .bashrc
├── tmux/
│   └── .tmux.conf
└── nvim/
    └── .config/
        └── nvim/
            └── init.lua
```

Each top-level directory is a **Stow package**. Its contents mirror the paths relative to `$HOME`.

For example, `~/dotfiles/nvim/.config/nvim/init.lua` is linked at `~/.config/nvim/init.lua`.

## Set up on another Linux machine

1. Install `git` and `stow` using that distribution's package manager. Install Neovim, tmux, and Bash as needed. For example, Debian/Ubuntu uses `sudo apt install git stow`; Fedora uses `sudo dnf install git stow`.
2. Clone the repo into your home directory:

   ```bash
   git clone <YOUR-REPOSITORY-URL> ~/dotfiles
   cd ~/dotfiles
   ```

3. **Inspect the files** before using them. Your Bash and Neovim settings may reference packages, fonts, plugins, executables, or paths not present on the new machine (for example, `/opt/nvim/bin`, `clip.exe`, or WSL-specific programs).
4. Check for existing configuration files before linking:

   ```bash
   ls -la ~/.bashrc ~/.tmux.conf ~/.config/nvim/init.lua
   ```

   Back up any existing files you intend to replace. For instance:

   ```bash
   mkdir -p ~/dotfiles-backup
   mv ~/.tmux.conf ~/dotfiles-backup/.tmux.conf
   ```

   Do **not** blindly overwrite existing files. On a new Linux installation, consider merging useful lines from the distribution's default `.bashrc` rather than simply discarding it. Backups with the same name may already exist; choose unique names when needed.
5. Do a dry run for only the packages you want:

   ```bash
   stow -n -v -t ~ tmux nvim
   ```

6. If there are no unexpected conflicts, install those links:

   ```bash
   stow -v -t ~ tmux nvim
   ```

   Add `bash` after reviewing and backing up the new machine's `.bashrc`:

   ```bash
   stow -n -v -t ~ bash
   stow -v -t ~ bash
   ```

7. Verify and test:

   ```bash
   ls -l ~/.bashrc ~/.tmux.conf ~/.config/nvim/init.lua
   ```

   Open a **new shell** to test Bash startup, then launch `tmux` and `nvim`. Keep an existing working shell open until you're satisfied that the new `.bashrc` works.

## Add another dotfile

Suppose you want to manage `~/.config/example/config.toml`.

1. Create the package directory, mirroring the path under home:

   ```bash
   mkdir -p ~/dotfiles/example/.config/example
   ```

2. **Copy** the working configuration into the package:

   ```bash
   cp ~/.config/example/config.toml ~/dotfiles/example/.config/example/config.toml
   ```

3. After confirming the copy, move the original to a backup location (use a unique backup name if necessary):

   ```bash
   mkdir -p ~/dotfiles-backup
   mv ~/.config/example/config.toml ~/dotfiles-backup/example-config.toml
   ```

4. Preview, then link:

   ```bash
   cd ~/dotfiles
   stow -n -v -t ~ example
   stow -v -t ~ example
   ```

5. Verify the link and commit the new package:

   ```bash
   ls -l ~/.config/example/config.toml
   git add example/
   git commit -m "Track example configuration"
   ```

**Why copy first?** Stow normally refuses to overwrite files it does not manage. Copying and backing up before linking avoids losing a working setup.

## Everyday workflow

Edit the **usual** location, such as `~/.tmux.conf` or `~/.config/nvim/init.lua`. The symlink leads to the Git-tracked file in `~/dotfiles`.

Review and save changes:

```bash
cd ~/dotfiles
git status
git diff
git add bash/ tmux/ nvim/   # stage only what you intend
git commit -m "Describe configuration change"
git push                     # once a remote has been configured
```

On another machine, update the repository:

```bash
cd ~/dotfiles
git pull
```

Existing symlinks ordinarily remain valid. Install newly added packages with `stow -n -v -t ~ <package>` followed by `stow -v -t ~ <package>`.

## Unlink or re-link a package

```bash
cd ~/dotfiles
stow -n -v -D -t ~ tmux   # preview unlink
stow -D -t ~ tmux         # remove Stow-managed links
stow -v -t ~ tmux         # create links again
```

`stow -D` removes managed links; it does **not** delete the files in `~/dotfiles` or restore your backed-up originals automatically.

## Notes for portability

- **Keep platform-specific settings conditional.** WSL commands such as `clip.exe` may not exist on native Linux. An installation at `/opt/nvim/bin` may not exist either.
- **Don't version secrets.** Review changes for passwords, API keys, tokens, SSH private keys, and machine-specific sensitive information before committing or pushing.
- **Neovim plugins and local state:** This repository initially tracks `init.lua`, not automatically every file under `~/.config/nvim`, downloaded plugins, caches, or editor state. Track additional hand-maintained config files intentionally.
- **Avoid accidental Stow conflicts.** Always use `stow -n -v` when introducing a package to an unfamiliar machine.
- **Use feature branches or Git history** to experiment with changes and roll back configuration mistakes.
- **Cross-machine differences:** If Fedora and Ubuntu eventually need different settings, keep shared configuration in this repository and separate host-specific settings rather than overwriting each other's files.

## Handy Stow commands

```bash
stow -n -v -t ~ tmux       # preview adding tmux links
stow -v -t ~ tmux          # add tmux links
stow -n -v -D -t ~ tmux    # preview removing them
stow -D -t ~ tmux          # remove them
stow -v -R -t ~ tmux       # restow (reconcile links)
```

**Rule of thumb:** Git versions the configuration files; Stow puts links to them where programs expect to find them.
