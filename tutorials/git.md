# Git sheet

## Working copy

Remove all locally deleted files

    git rm $(git ls-files --deleted)

## Log / show

Display all changes from file/folder

    git log -p <file-or-folder>

Change file modes to git ones.

    git diff --summary | grep --color 'mode change 100755 => 100644' | cut -d' ' -f7- | xargs -d'\n' chmod +x
    git diff --summary | grep --color 'mode change 100644 => 100755' | cut -d' ' -f7- | xargs -d'\n' chmod -x


## BRANCHING

Create branches

    git br <name>
    git co <name>

Sometime branch do not track exactly the origin/branch, use tracking.

    git br -t develop origin/develop

Delete local branch

    git br -d <branch>

Delete remote branch

    git push --delete origin <branch>


clear if invalid

    git fetch --prune origin

Reallocate/move branch pointer to different commit

    git update-ref -m "<branch> to <commit>" refs/heads/<branch> <commit>
    # or
    git branch -f <branch> <commit>

Get current branch

    git rev-parse --abbrev-ref HEAD
    

Get last commit sha1 of a branch

    git fetch # to update repo
    # origin
    git ls-remote origin <branch>

Commits list yet to be applied to current branch

    git checkout <branch1>
    git cherry -v <branch2>

## BISECT

    git bisect start

    # select initial range

    git bisect good <revision>
    git bisect bad <revision>

    # git will move you to the middle
    # mark the current revision as good/bad until the end (revision not needed)

    # git bisect good
    # git bisect bad

    # finish the bisect
    git bisect end


## Stash

Create stash

    git stash

Create stash with a message

    git stash save "message"

List stash

    git stash list

Show changes from a stash

    git show stash@{0}

Restore (pop) a stash

    git stash pop


## PATCHES

Create a single commit patch

    git format-patch -1 <sha>

Create a range of commit patch

    # X is a number!
    git format-patch -X <sha> --stdout > X-last-commits.patch

Create a patch from two revisions

    git diff <sha1>..<sha2> > diff.patch

Create a patch from current working copy

    git diff > file.patch
    # include staged changes ?
    git diff --cached > file.patch
    # include binaries? maybe: --full-index
    git diff --binary > file.patch

Apply a patch

    patch -p1 < file.patch # After apply remember to commit :)
    #or
    git apply -v file.patch

Apply a patch created using format-patch

    git am patch1.patch

## TAGS

Remove tag

    TAG="xxxx"
    git tag -d ${TAG}
    git push origin :refs/tags/${TAG}

Move tag

    TAG="xxxx"
    git tag -f -a ${TAG}
    git push -f --tags

Closest tag

    git describe --tags `git rev-list --tags --max-count=1`


# History operations


Fix last commit, adding new changes / change message

     git commit --amend

Reset/revert last commit 

    # put it back in the working copy
    git reset --soft HEAD~1
    # discarding changes
    git reset --hard HEAD~1
    # preserving local changes in index
    git reset --mixed HEAD~1


[rewrite author & email](https://help.github.com/articles/changing-author-info)


## Rebase and conflicts

To put branch1 above branch2

    git co branch1
    git rebase branch2

Resolve collisions

    git co --theirs <file> # branch1/<file> is the good one
    git co --ours <file> # branch2/<file> is the good one

When status is clean (all added successfully)

    git rebase --continue

If the current commit is not needed

    git rebase --skip

Call Houston otherwise

    git rebase --abort


Resolve all conflicts at once

    for FILE in `git status | grep "both modified" | awk '{print $4;}'`
    do
      echo $FILE
      git co --theirs $FILE # or --ours
      git add $FILE
    done


Use this with caution.

    git push


    # it may happen that...
    # ! [rejected]        XXX -> XXX (non-fast-forward)
    # Are you sure that your branch has the good history... is the real one
    # You, are... continue
    git push --delete origin branch1
    git push -u origin branch1


## Sync Fork

When you see in github `This branch is x commits behind xx:xx`

    git remote add upstream https://github.com/<user>/<repo>
    git fetch upstream

    git checkout <branch>
    git merge upstream/<branch>


## Display Merge diff


    git show <sha1>

> commit 0e1329e551a5700614a2a34d8101e92fd9f2cad6 (HEAD, master)
> Merge: fc17405 ee2de56

And you see this is shit, Thanks for the information Git!
git diff of merge sha1s (reversed) to see the real merge

    git diff ee2de56..fc17405
    git diff --name-only ee2de56..fc17405


## History. Edit an incorrect commit message

    git rebase -i HEAD~<number>

Change pick to reword, (vi) `:wq`, edit each message and save.


## History. Edit an incorrect commit message with a pattern

Use sed/regex

    git filter-branch -f --msg-filter "sed 's/xxx/yyy/'" <commit>..HEAD


## git flow init (error)

This maybe needed, depends on how your repo is cloned

    git br -t develop origin/develop
    git br -t master origin/master
    git flow init



## Get the git root directory

    git rev-parse --show-toplevel