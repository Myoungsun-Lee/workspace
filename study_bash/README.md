In git repository.

====================================================
  git-reset-branch.sh [branch_name] [continue_tag] 
====================================================
  - Run in root directory.(The upper directory than your git directory)
  - Search the "branch_name" recursively in remote.
  - Don't need to input full name.
  - If you enter the 'y', then it just checkout that branch.
  - "continue_tag" make the shell progress continuouly. It's available only "1", and defalut "0".
  - If you turn on "continue mode", then you have to enter any key every directory. 
  - "Continue mode" is useful when you want to go to next step after you check every directory is completed. 
  - e.g.1.
    |  git-reset-branch.sh RELEASE
    |  Welcome!!!
    |  !!!!! We are in gst-plugins-base/
    |  ===branch list===
    |  BRANCH-RELEASE-0_10_19
    |  BRANCH-RELEASE-0_3_3
    |  BRANCH-RELEASE-0_3_4
    |  BRANCH-RELEASE-0_4_0
    |  BRANCH-RELEASE-0_4_1
    |  BRANCH-RELEASE-0_4_2
    |  BRANCH-RELEASE-0_5_0
    |  BRANCH-RELEASE-0_5_1
    |  BRANCH-RELEASE-0_5_2
    |  BRANCH-RELEASE-0_7_4
    |  BRANCH-RELEASE-0_7_5
    |  BRANCH-RELEASE-0_8_2
    |  BRANCH_RELEASE-0_7_2
    |  =================
    |  Do you want to checkout BRANCH-RELEASE-0_10_19?[y/n]
    |  n
    |  Do you want to checkout BRANCH-RELEASE-0_3_3?[y/n]
    |  y
    |  ...Changing branch to BRANCH-RELEASE-0_3_3
    |  Checking out files: 100% (1115/1115), done.
    |  Branch BRANCH-RELEASE-0_3_3 set up to track remote branch BRANCH-RELEASE-0_3_3 from origin.
    |  Switched to a new branch 'BRANCH-RELEASE-0_3_3'
    |  gst-plugins-base/ completed to change branch
    |  
    |  go to next directory
    |

  - e.g.2.
    |  git-reset-branch.sh RELEASE 1
    |  Welcome!!!
    |  Please enter any key to continue...
    |  
    |  !!!!! We are in gst-libav/
    |  ===branch list===
    |  BRANCH-RELEASE-0_3_3
    |  BRANCH-RELEASE-0_3_4
    |  BRANCH-RELEASE-0_4_0
    |  BRANCH-RELEASE-0_4_1
    |  BRANCH-RELEASE-0_4_2
    |  BRANCH-RELEASE-0_5_0
    |  BRANCH-RELEASE-0_5_1
    |  BRANCH-RELEASE-0_5_2
    |  BRANCH-RELEASE-0_7_4
    |  BRANCH_RELEASE-0_7_2
    |  =================
    |  Do you want to checkout BRANCH-RELEASE-0_3_3?[y/n]
    |  n
    | 
    |  .....
    |
    |  go to next directory
    |  Please enter any key to continue...

=================
  git-update.sh
=================
  - Run in root directory.
  - It just updates all branches recursively. 

