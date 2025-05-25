

aaronlim@Aarons-MacBook-Air ce-grp-1-vpc % git checkout main
touch test.txt
git add test.txt
git commit -m "testing direct push"
git push origin main

Switched to branch 'main'
Your branch is up to date with 'origin/main'.
[main 310c5a1] testing direct push
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 test.txt
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 8 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 313 bytes | 313.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
<!-- remote: error: GH013: Repository rule violations found for refs/heads/main.
remote: Review all repository rules at https://github.com/aalimsee/ce-grp-1-vpc/rules?ref=refs%2Fheads%2Fmain
remote: 
remote: - Changes must be made through a pull request.
remote: 
remote: - 2 of 2 required status checks are expected.
remote: 
To https://github.com/aalimsee/ce-grp-1-vpc.git
 ! [remote rejected] main -> main (push declined due to repository rule violations)
error: failed to push some refs to 'https://github.com/aalimsee/ce-grp-1-vpc.git' -->
aaronlim@Aarons-MacBook-Air ce-grp-1-vpc % git branch 
  dev
* main
aaronlim@Aarons-MacBook-Air ce-grp-1-vpc % git checkout dev
Switched to branch 'dev'
Your branch is up to date with 'origin/dev'.
aaronlim@Aarons-MacBook-Air ce-grp-1-vpc % git add .
aaronlim@Aarons-MacBook-Air ce-grp-1-vpc % git commit -m "test push to dev before PR to main"
[dev 785a0bb] test push to dev before PR to main
 1 file changed, 48 insertions(+)
 create mode 100644 Steps to setup PR to main control.md
aaronlim@Aarons-MacBook-Air ce-grp-1-vpc % git push origin dev
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 1022 bytes | 1022.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/aalimsee/ce-grp-1-vpc.git
   957cc0c..785a0bb  dev -> dev
aaronlim@Aarons-MacBook-Air ce-grp-1-vpc % 