#!/bin/sh


#Version: v1.01 Last modified 2020-7-30:16:02
#Bugfixed 2020-7-30:
#1.If there is a symbolic link change from a file or a file change from a symbolic link.There will be an error that the patch can't regnized this kind of modification.
#2.fixed a file name or a directory have blank space.


if [ "$#" != "2" ]; then
	echo "./git_diff.sh <start hash> <end hash>"
	exit 1
fi

g_start_hash=$1
g_end_hash=$2

g_work_dir=$(pwd)

if [ ! -d "$g_work_dir/.git" ]; then
	echo "Not a git respository."
	exit 1
fi

commit_id=$(git log -1 | head -n 1)
commit_id=${commit_id#* }
commit_id=${commit_id% *}
head_hash=$commit_id
if [ "${#head_hash}" != "40" ]; then
	echo "Error(4)"
	exit 1
fi
echo "current head: $head_hash"

cleanup()
{
	cd "$g_work_dir"
	git reset --hard $head_hash
}

#lfs settings file .gitattributes ignored? 0:No lfs settings file 1:There is a lfs settings file
g_ignore_lfs_setting=0

get_files()
{
	file_dir=$1
	
	echo -e "Processing :\c"
	
	while read one_line; do
		
		file_status=${one_line:0:1}
		file=${one_line:2}
		
		if [[ "$file_status" != "A" && "$file_status" != "D" && "$file_status" != "M" && "$file_status" != "T" ]]; then
			echo "Error(5)"
			echo "unknown: $one_line"
			cleanup
			exit 1
		fi

		#We copy files or symbolic links only.
		if [[ ! -f "$file" && ! -L "$file" ]]; then
			#It must not be a file or a symbolic link if exist.
			if [ -e "$file" ]; then
				echo -e "\n$file is not a file or a symbolic link. \033[31mIgnored\033[0m"
			fi
			continue
		elif [ -L "$file" ]; then
			echo -e "\nWarning: $file is a linux symbolic link"
		fi
		
		#Ignore the lfs setting file
		if [ "$file" == ".gitattributes" ]; then
		    g_ignore_lfs_setting=1;
		    continue
		fi

		echo -e ".\c"

		dir=$(dirname "$file")
		mkdir -p "$file_dir"/"$dir"
		cp -rfp "$file"  "$file_dir"/"$dir"

	done < "$g_work_dir"/git_diff_dir/name_status.txt\
	
	echo ""
}

##########################################start to generate patch
echo -e "\nStart to generate patch.\n"
rm -rf "$g_work_dir"/git_diff_dir
mkdir "$g_work_dir"/git_diff_dir

git config --global core.quotepath false
git diff --no-renames --name-status $g_start_hash $g_end_hash > $g_work_dir/git_diff_dir/name_status.txt

if [ $? -ne 0 ]; then
    echo -e "\nGenerating patch failed. Bad GIT HASH, please check....."
    rm -rf "$g_work_dir"/git_diff_dir
    exit 1
else
    git reset --hard $g_start_hash
    mkdir "$g_work_dir"/git_diff_dir/a
    get_files "$g_work_dir"/git_diff_dir/a
	
	echo ""
    git reset --hard $g_end_hash
    mkdir "$g_work_dir"/git_diff_dir/b
    get_files "$g_work_dir"/git_diff_dir/b

    mv "$g_work_dir"/.git "$g_work_dir"/.git_hide
    cd "$g_work_dir"/git_diff_dir

    git diff --binary --src-prefix= --dst-prefix= a/ b/ > "$g_work_dir"/git_diff_${g_start_hash}_${g_end_hash}.patch
    
    mv "$g_work_dir"/.git_hide "$g_work_dir"/.git
    
    rm -rf "$g_work_dir"/git_diff_dir
	
    if [ $g_ignore_lfs_setting -eq 1 ]; then
	     echo -e "\nIgnored lfs settings file : .gitattributes"
    fi
    echo -e "\nPatch: ${g_work_dir}/git_diff_${g_start_hash}_${g_end_hash}.patch\n"
    cleanup
fi
