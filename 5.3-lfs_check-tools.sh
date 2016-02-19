#!/bin/bash
echo ""
echo "### ---------------------------"
echo "###        CHECK TOOLS      ###"
echo "###        CHAPTER 5.3      ###"
echo "### Check tools for compilation"
echo "### Must be run as \"lfs\" user"
echo "### ---------------------------"

echo ""
echo "... Loading commun functions and variables"
if [ ! -f ./script-all_commun-functions.sh ]
then
  echo "!! Fatal Error 1: './script-all_commun-functions.sh' not found."
  exit 1
fi
source ./script-all_commun-functions.sh

if [ ! -f ./script-all_commun-variables.sh ]
then
  echo "!! Fatal Error 1: './script-all_commun-variables.sh' not found."
  exit 1
fi
source ./script-all_commun-variables.sh

echo ""
echo "... Validating the environment"
check_partitions
is_user lfs

echo ""
echo "... Checking symlinked tools for compilation"

echo ".... 1/7 Looking for /bin/sh"
if [ $( readlink -f /bin/sh ) != "/bin/bash"   ]
then
  echo "!! Fatal Error 3: /bin/sh is not symlinked to /bin/bash"
  exit 3
else
  echo "-> Correct"
fi

echo ".... 2/7 Looking for /usr/bin/awk"
if [ $( readlink -f /usr/bin/awk ) != "/etc/alternatives/awk"   ]
then
  echo "!! Fatal Error 3: /usr/bin/awk is not symlinked to /etc/alternatives/awk"
  exit 3
else
  echo "-> Correct"
fi

echo ".... 3/7 Looking for /etc/alternatives/awk"
if [ $( readlink -f /etc/alternatives/awk ) != "/usr/bin/gawk"   ]
then
  echo "!! Fatal Error 3: /etc/alternatives/awk is not symlinked to /usr/bin/gawk"
  exit 3
else
  echo "-> Correct"
fi

echo ".... 4/7 Looking for /usr/bin/gawk"
if [ -f /usr/bin/gawk ]
then
  echo "!! Fatal Error 1: '/usr/bin/gawk' not found."
  exit 1
else
  echo "-> Correct"
fi

echo ".... 5/7 Looking for /usr/bin/yacc"
if [ $( readlink -f /usr/bin/yacc ) != "/etc/alternatives/yacc"   ]
then
  echo "!! Fatal Error 3: /usr/bin/yacc is not symlinked to /etc/alternatives/yacc"
  exit 3
else
  echo "-> Correct"
fi

echo ".... 6/7 Looking for /etc/alternatives/yacc"
if [ $( readlink -f /etc/alternatives/yacc ) != "/usr/bin/bison.yacc"   ]
then
  echo "!! Fatal Error 3: /etc/alternatives/yacc is not symlinked to /usr/bin/bison.yacc"
  exit 3
else
  echo "-> Correct"
fi

echo ".... 7/7 Looking for /usr/bin/bison.yacc"
if [ -f /usr/bin/bison.yacc ]
then
  echo "!! Fatal Error 1: '/usr/bin/bison.yacc' not found."
  exit 1
else
  echo "-> Correct"
fi

echo ""
echo "######### END OF CHAPTER 5.3 ########"
echo "///// HUMAN REQUIRED \\\\\\\\\\\\\\\\\\\\"
echo "### Please run the next step:"
echo "### ./5.X-lfs_empty-skeleton.sh"
echo ""

exit 0
