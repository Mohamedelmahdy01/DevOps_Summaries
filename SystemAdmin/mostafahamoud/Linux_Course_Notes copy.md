https://www.youtube.com/watch?v=ooT5fCi37yM&list=PLLlr6jKKdyK1f8p8ajyYtXP9GxdFH7WIU&index=11

nautilus [path] : open folder 



adduser [-g <primarygroup>] <username>  : to add user "this command enable guest in root"

	-G secondary group 

	-a -G add secondary group 

usermod [option] <username>  :used to change the properties of a user (groups,id and login name) (https://ioflood.com/blog/usermod-linux-command/)

userdel <username> : delete user

userdel -r ahmed : Delete the user and his files



userdel ahmed + rm -rf /home/ahmed = userdel -r ahmed



groupadd <groupname> : create group

groupdel <groupname> : Delete group 





id <username> : display user id, group id and user groups

passwd <username> : Set or change a password

su - <username> : switch user

ls : display content in current folder 

ls -lh : : l-> long listing h-> human readable 

ls -lt : long list time 

ls -lr : long list reverse 

ls -r : reverse 

ls -R :  recursively

pwd : print working directory

cd : change directory

touch [path]<file name> : create empty file if it not exist, so if it exists ,touch command display last update

exit: exit form terminal = ctrl + D

ctrl + c : stoped application

Login history : display longin history "root"

ctrl + s lock screen

ctrl + q unlock screen

mkdir [path]<dirname>: create directory

cp [-r] [path]<filename> <newpath>: copy file (cp = copy, r = recursively )



mv [path]<filename> <newpath>[newfilename]: move file (mv = cut )

mv [path]<dirname> <newdirpath>[newdirname] : move directory[rename]

rm <filename>:  remove file

rmdir <dirname>: Remove empty directory

rm -r <dirname>: Remove the directory and its files

rm -rf dir1 : Remove the directory and its files at once root(rf = force and recursively)<<<dangerous command>>>

dangerous



groups      :owner/user   group  others

permission  :rwx          rwx    rwx    = 9 bit

Shortcut    :u            g      o     

 	ugo=a     

file types

	directory --> d

	file ---> -

	char device (file) --> c 

	block device (file) --> b

	link file --> L 

	pipe file -->p





symbolic method  rwx r-x r-- 

numeric  method   7   5   4

 



chmod <Group shortcuts><+|-><permission>: to add permission  

	+ add 

	- remove



examples

	- r-x --- ---  == 500

	chmod  u+w,u-rx <file name> == chmod u = w <file name> == chmod 2 <file name>

	- -w- --- --- 400



chmod a + x <file name> == chmod ogu + x <file name> == chmod + x <file name> == chmod 111 <file name>     



chmod -R 744 <dirname> : Change permission for a directory and its files

example 

	chmod -R 777 dir/



chown <ownername> <file/dir> : to change owner/user 

	chown ali /home/mohamed2/dir1/

chown :<groupname> <file/dir> : to change group

	chown :ahmed /home/mohamed2/dir1/

chown <ownername>:<groupname> <file/dir> 

	chown mohamed2:mohamed2 /home/mohamed2/dir1/





shells type 



	bach

	csh

	ksh

	zsh

$ ---> special 



$-------

	-----variable substitution	# $<variable name>

	-----command substitution 	# $(<command name)

	-----arithmetic operation 1 	# $[1+2]

	-----arithmetic operation 2 	# $((1+2))



#variable

age = 21

name = mohamed 

echo name is $name and age = $age 

echo $SHELL : print type of shell 



#command substitution

echo date new is $(date)

		 date is command



#arithmetic operation 1

echo " sum of 1 and 2 is $[1+2] : # sum of 1 and 2 is 3



#arithmetic operation 2

echo " sum of 1 and 2 is $((1+2)) : # sum of 1 and 2 is 3



/bin/<bach|csh|zsh|ksh>: switch between shells

exit : exit form shell



history : show the history of this user



!! : Execute the last command

!5 : Execution of the five orders

! -5 : Execute the five command from the back





ls var/spool 



^spool^log == ls var/log





last : display a list of loggings at machine 





===========================================



searching --

	-------->command 

		whatis <command>

		whereis <command>

	-------->file/dir

		locate <filename> : search in db

		updatedb: to update database (root mood)

		

		find [path] [-name | -type | -size |] <name | type |size > : In the path, find the file or folder [its name | its size |its type] 



examples

 



find /dev/ -type c

find / -name password

find /usr/ -iname   #iname = insensitive name

find /home/student/ -iname trash 



find <search path> -name <filename> -exec <command> {} [command path] \; : Find the filename and apply(-exec) the command to it

#result of (find /home/mohamed1/dedir/ -name newfile1) will be placed in {}



 examples 



find /home/mohamed1/dedir/ -name newfile1 -exec cp {} /home/mohamed1/dir1/ \; :Find the file and copy it to the new path

find /home/mohamed1/dedir/ -name newfile1 -exec rm {} \; find the file and remove it




shortcuts



crtl + c : terminate 

crtl + Z : pause 

--> bg : continue

ctrl + l : clear terminal 

reset : clear terminal and resets the terminal's settings to their default values

shift + pgup

shift + pgdn

ctrl + a : at the beginning

ctrl + e : to the end 

crtl + u : delete to  the beginning 

crtl + k :delete to the end 

ctrl + alt + <F1|F2|F3|F4|F5|F6> : switch between tty 

ctrl + s : lock screen

ctrl + q : unlock screen

ctrl + d == logout == exit : logout



reboot == shutdown -r now == systemctl reboot : reboot the machine

shutdown -h now == systemctl poweroff == poweroff : shutdown







command1 ; command2 نفذ الأول وبعدين التاني

command1 && command2 نفذ الأول والتاني

command1 || command2 نفذ الأول او التأني







=======help==========

#command syntax

 command [option] [argument]

	option : change command behavior 

	argument : data puss to command

1) manual pages == man pages #Divided into chapters (6 chapters)

 	man <command name : information about command 

	man man : information about man (man chapters)

	man -k "copy files" : search about copyfiles

		k search and display all result

		k (capital)search and display result one by one

	

some shortcuts in man 

	n : next result

	N : previous result 

	g : top of the page

	G : bottom of the page 

	q : quit 



 

2) info pages 

	info 

	

3) /usr/share/doc

4) red hat docs

5) TLDP

6) community









 

  variables 

	environmental : capital letters

		env : show environmental variables 

	user defined variables : small letters

		set : show environmental and user defined variables 



echo $<varname> : print variables





[mohamed2@mohamed ~]

[user@machinename pwd] : Stored in PS1 variable



PS1='[\u@\h \w]' :  value  



nano <filename1> : If the file exists, it opens, and if it does not exist, it creates a file 



variables 

	system wide variables (global) 

		Stored in /etc/ <profile | bashrc>



	user specific variables 

		Stored in <~/ .bashprofile |  ~/ .bashrc>



alias <shortname>=<'longer command' | 'sequence of commands'> : an alias is a user-defined shorthand for a longer command or sequence of commands



alias -p : This option prints all the defined aliases is reusable format. 







examples

	alias ..='cd ..' 

	alias cls='clear'

	alias ll='ls -l'

		 

unalias [alias name] : Removing an existing alias is known as unaliasing





------------------------------------------------------------------------------------



redirection 

	default

		input keyboard (<)

		output screen (>)





> overwritten 

>> append



 ls > result.txt :save output at result file 

 ls install2 2> result.txt :save error at result file 





ls install.log install2 1>output.txt 2>error.txt : if (output)	

		save at output.txt

	    else if (error)

	   	save at error.txt



ls -l anaconda-ks.cfg meshwawgood 2&>result3.txt : save out.put and error at result3 file

ls -l anaconda-ks.cfg meshwawgood >>result3.txt 2>>result2.txt : save output and error at result3 file





cat result3.txt == cat < result3.txt Because the default input is from the file







tr 'a-z' 'A-Z' : transform form small  to capital letter 



tr 'a-z' 'A-Z' <.bashrc >.bashrc : Convert text in a Bash file from lowercase to uppercase and save the change





grep [--color | -n | --color -n ]<keyword> <filenamewithorwithoutphat>: Returns all lines that contain 'keyword'

grep 'root' /etc/passwd 

grep -i root /ect/passwd : insensitive 

grep -v root /ect/passwd : كل حاجه معدا root

grep -n root /ect/passwd : number of line

grep -ivn root /ect/passwd 

grep -R root /ect/ : search include directory (R = re)



tee :  used to split the output of a program so that it can be both displayed and saved in a file



pipe <|> 



example



find / -name passwd | grep [i | v | iv] 'bin' : Find all files named passwd and then return all lines containing "root" from the find command



i : unsensitive

v : Returns all lines that doesn't contain 'keyword'







less <filename> : display file page by page

more <filename> : display file page by page (When it reaches the end, the file closes on its own )





sort <filename> : sort lines in this file 

uniq : remove sequence redundance  



cat test |sort | uniq



cut -<f1|f2|.....> -d <الفاصل> <file> : display fieldnumber form file   

example cut -f1 -d : /ect/passwd



-d : delimeter 

	:

	" "

	;



head [-n numberoflines] <filename>: Display the number of lines from the beginning of the file (10 line by default)



tail [-n numberoflines] <filename>:Display the number of lines from the end of the file (10 line by default)



head -n 3 /ect/passwd |tail -n 1 == head -n +3 /ect/passwd : display line 3 form file



aspell check <filename>: check file





w :displays a list of all logged in to the server and what they are doing. 

This command is similar to who command, but ends up displaying more information about logged in users.

PTS : pseudo terminal screen   





soft link 

	: should use absolute path

	ln -s /root/file2 /tmp/myfile





hard link 

	ln file2 file3

	# It is no longer in common use

	hard link is not allowed for the directory





-----------------------------------------------------------------------------

The Master Boot Record (MBR) and inode number serve very different purposes in a computer's storage system. Here's a breakdown of each:



### Master Boot Record (MBR)



**Purpose:**

- The MBR is a special type of boot sector located at the very beginning of partitioned storage devices like hard drives or SSDs.

- It contains the information required to boot the operating system, including the partition table that describes the layout of the partitions on the storage device.



**Key Features:**

- **Location:** The first sector of a storage device (sector 0).

- **Size:** Typically 512 bytes.

- **Components:** 

  - Bootloader: A small program that loads the operating system's bootloader.

  - Partition Table (64 bytes): Contains entries for the primary partitions (up to 4 in a traditional MBR scheme). each one has 16 bytes

  - Magic Number: Used to validate the integrity of the MBR.



**Usage:**

- Essential for booting legacy BIOS systems.

- Defines the structure of the storage device and the location of the partitions.



### Inode Number



**Purpose:**

- An inode number is an identifier used by many Unix-like file systems to identify files and directories.

- Each inode contains metadata about a file or directory (e.g., permissions, ownership, size, timestamps, and disk block locations) but not the name or the actual data content.



**Key Features:**

- **Location:** Spread throughout the file system; each file and directory has an associated inode.

- **Components:** 

  - Metadata: Information about the file/directory.

  - Pointers: Addresses pointing to the actual data blocks on the disk.



**Usage:**

- Used internally by the file system to manage and locate files.

- Allows efficient file access and management by separating metadata from file names.



### Comparison



| Feature                | MBR                             | Inode Number                    |

|------------------------|---------------------------------|---------------------------------|

| **Purpose**            | Bootstrapping and partitioning  | File system metadata management |

| **Location**           | First sector of storage device  | Throughout the file system      |

| **Size**               | 512 bytes typically             | Varies                          |

| **Content**            | Bootloader, partition table     | File metadata, pointers         |

| **Relevance**          | Boot process, partition layout  | File access and management      |

| **Operating System**   | Legacy BIOS systems             | Unix-like file systems          |



In summary, the MBR is crucial for booting and partition management, while inode numbers are essential for file system organization and file management. 





lsblk : used to list information about all available block devices.



fdisk -l : list connected disks 



fdisk /dev/sda : 







partprobe /dev/sda : reload partition table



mkfs.<filesystem>  :create file system 



mounting 





df [-h] : disk free space {h = human readable format }





mount -t <fstype> <dev> <mountpoint>

mount -t ext4    /dev/sda1  /media



e2label <dev> <lable> : Set a label for the partition



blkid : Display universal unique identifier (UUID)for partitions



mount UUID=<UUIDforpartition>

unmount ~  ~   ~



umount <dev|point|lable>





mount -a : mount all device 





nano/etc/fstab





--------------11-process_managment-------------





ps : list current terminal process 



ps [a] : list all process 

 

ps aux : display all process at system with details  

kill <proc number>  : stop process in background 



kill -9 <proc number> : kill process force 



kill -l : view all kill options 



ps -ef : display all process at system with details +PPID 



pstree : view all process as a tree 



pgrep <procname> : display process id



pkill <procname> : kill process using process name



<program name> & Running in the background



jops : display process Running in the foreground



fg %<procnumber> :Running in the foreground

bg %<procnumber> :Running in the background





-------------------------------12-------------------------------------





killall <procname>: kill all process 



nice value form -20(highest priority) to 19(lowest priority) default value 0



nice -n <-20:19> <process> : set nice value (priority)

renice -n <-20:19> <process> : set nice value (priority) 



top : view load on the machine





=========search============

 searching on {5,6,7.txt}

grep on {8,9,10.txt} 





cut -f 1,3 -d : /ect/passwd : Get fields 1,3 and the separator between them : 



cut -f 3 -d : /ect/passwd | sort -n 



cut -f 7 -d : /ect/passwd | uniq 

cut -f 7 -d : /ect/passwd | sort | uniq



vim : advanced text editor 



the vim has three modes.



insert , command , exec

i : go to insert mode 

esc : exit from insert mode

<:> : go to exec mode

w :  write 

q  : quit

wq : write and quit

q! : quit without write

u : undo

yy : copy 

<n>yy: copy n of line 

dd : cut 

b : paste 

gg: go to the begging

G : go to the end

/<keyword> : to search 

%s/sync/replicate : replace sync  with replicate ( s = substitute = بدل )

%s/sync/replicate/g : replace all



r <file name> : read file and copy text to vim



 

!<command> : to execute a command out of vim and return  



.!<command> : execute a command in vim 



  

====================14-Understanding boot process===================



1-post (power on-self test

2-BIOS ===>find bootable devices and compare it to its settings



3-load iPL (initial program loader) --> load/start ==> Boot loader 



grub (grand unified  boot loader ) : its boot loader in Linux 



4- Grub load /start boot loader 



5-boot loader --> load kernel --->kernel

6- kernel --> start systemd / init



7- systemd /init --> call services/daemons 







 BL ---

	-->1st stage : call 2nd stage (store in MBR) 

	-->2nd stage : store in drive (/boot/) 



kernel--

	-->kernel -

	-->initramfs  



services name  d ديما بينتهي ب 

	sshd 

	cornd

	





systemctl status <<service-name>> : بيعرض حالة البروسيس 



systemctl start <<service-name>> : run process 



systemctl  stop <<service-name>>: 



systemctl is-active <<service-name>> : show if its active or inactive 



systemctl is-enabled <<service-name>> : show if its enabled  or disable



systemctl restart <<service-name>> : restart service 

systemctl reload <<service-name>> : reread configuration file  



systemctl mask <<service-name>> : mask the service  

systemctl unmask <<service-name>> : unmask the service 







init runlevels 

0- power off/ halt

1- single user mode 

2- multi user -GUI -NFS

3- command line interface -GUI

4- unused

5- Multi user + GUI

6 - reboot





systemd target 



-Multi user.target =level3

-graphical.target =level5

-tescue.target =level1

-reboot =level6

-power off =level0





systemctl get-default : show default target 



systemctl set-default <target> : changing default target (reboot the machine to apply the modifications)

 

runlevel : display Current and previous runlevel

 

systemctl : isolate <target> : = systemctl  set-default <target> without need to reboot the machine 



systemctl 



ls /etc/systemd : systemd command file (soft link)

ls /usr/lib/systemd : systemd command file 



telinit is equivalent to init 



systemctl list-units : display services and status 

systemctl list-units | grep -i failed : display failed service 



systemctl lest-unit-files : display files of services 



  

 ----------------------15--------------------

 



ls -l /boot/ : 

=======
https://www.youtube.com/watch?v=ooT5fCi37yM&list=PLLlr6jKKdyK1f8p8ajyYtXP9GxdFH7WIU&index=11

nautilus [path] : open folder 



adduser [-g <primarygroup>] <username>  : to add user "this command enable guest in root"

	-G secondary group 

	-a -G add secondary group 

usermod [option] <username>  :used to change the properties of a user (groups,id and login name) (https://ioflood.com/blog/usermod-linux-command/)

userdel <username> : delete user

userdel -r ahmed : Delete the user and his files



userdel ahmed + rm -rf /home/ahmed = userdel -r ahmed



groupadd <groupname> : create group

groupdel <groupname> : Delete group 





id <username> : display user id, group id and user groups

passwd <username> : Set or change a password

su - <username> : switch user

ls : display content in current folder 

ls -lh : : l-> long listing h-> human readable 

ls -lt : long list time 

ls -lr : long list reverse 

ls -r : reverse 

ls -R :  recursively

pwd : print working directory

cd : change directory

touch [path]<file name> : create empty file if it not exist, so if it exists ,touch command display last update

exit: exit form terminal = ctrl + D

ctrl + c : stoped application

Login history : display longin history "root"

ctrl + s lock screen

ctrl + q unlock screen

mkdir [path]<dirname>: create directory

cp [-r] [path]<filename> <newpath>: copy file (cp = copy, r = recursively )



mv [path]<filename> <newpath>[newfilename]: move file (mv = cut )

mv [path]<dirname> <newdirpath>[newdirname] : move directory[rename]

rm <filename>:  remove file

rmdir <dirname>: Remove empty directory

rm -r <dirname>: Remove the directory and its files

rm -rf dir1 : Remove the directory and its files at once root(rf = force and recursively)<<<dangerous command>>>

dangerous



groups      :owner/user   group  others

permission  :rwx          rwx    rwx    = 9 bit

Shortcut    :u            g      o     

 	ugo=a     

file types

	directory --> d

	file ---> -

	char device (file) --> c 

	block device (file) --> b

	link file --> L 

	pipe file -->p





symbolic method  rwx r-x r-- 

numeric  method   7   5   4

 



chmod <Group shortcuts><+|-><permission>: to add permission  

	+ add 

	- remove



examples

	- r-x --- ---  == 500

	chmod  u+w,u-rx <file name> == chmod u = w <file name> == chmod 2 <file name>

	- -w- --- --- 400



chmod a + x <file name> == chmod ogu + x <file name> == chmod + x <file name> == chmod 111 <file name>     



chmod -R 744 <dirname> : Change permission for a directory and its files

example 

	chmod -R 777 dir/



chown <ownername> <file/dir> : to change owner/user 

	chown ali /home/mohamed2/dir1/

chown :<groupname> <file/dir> : to change group

	chown :ahmed /home/mohamed2/dir1/

chown <ownername>:<groupname> <file/dir> 

	chown mohamed2:mohamed2 /home/mohamed2/dir1/





shells type 



	bach

	csh

	ksh

	zsh

$ ---> special 



$-------

	-----variable substitution	# $<variable name>

	-----command substitution 	# $(<command name)

	-----arithmetic operation 1 	# $[1+2]

	-----arithmetic operation 2 	# $((1+2))



#variable

age = 21

name = mohamed 

echo name is $name and age = $age 

echo $SHELL : print type of shell 



#command substitution

echo date new is $(date)

		 date is command



#arithmetic operation 1

echo " sum of 1 and 2 is $[1+2] : # sum of 1 and 2 is 3



#arithmetic operation 2

echo " sum of 1 and 2 is $((1+2)) : # sum of 1 and 2 is 3



/bin/<bach|csh|zsh|ksh>: switch between shells

exit : exit form shell



history : show the history of this user



!! : Execute the last command

!5 : Execution of the five orders

! -5 : Execute the five command from the back





ls var/spool 



^spool^log == ls var/log





last : display a list of loggings at machine 





===========================================



searching --

	-------->command 

		whatis <command>

		whereis <command>

	-------->file/dir

		locate <filename> : search in db

		updatedb: to update database (root mood)

		

		find [path] [-name | -type | -size |] <name | type |size > : In the path, find the file or folder [its name | its size |its type] 



examples

 



find /dev/ -type c

find / -name password

find /usr/ -iname   #iname = insensitive name

find /home/student/ -iname trash 



find <search path> -name <filename> -exec <command> {} [command path] \; : Find the filename and apply(-exec) the command to it

#result of (find /home/mohamed1/dedir/ -name newfile1) will be placed in {}



 examples 



find /home/mohamed1/dedir/ -name newfile1 -exec cp {} /home/mohamed1/dir1/ \; :Find the file and copy it to the new path

find /home/mohamed1/dedir/ -name newfile1 -exec rm {} \; find the file and remove it




shortcuts



crtl + c : terminate 

crtl + Z : pause 

--> bg : continue

ctrl + l : clear terminal 

reset : clear terminal and resets the terminal's settings to their default values

shift + pgup

shift + pgdn

ctrl + a : at the beginning

ctrl + e : to the end 

crtl + u : delete to  the beginning 

crtl + k :delete to the end 

ctrl + alt + <F1|F2|F3|F4|F5|F6> : switch between tty 

ctrl + s : lock screen

ctrl + q : unlock screen

ctrl + d == logout == exit : logout



reboot == shutdown -r now == systemctl reboot : reboot the machine

shutdown -h now == systemctl poweroff == poweroff : shutdown







command1 ; command2 نفذ الأول وبعدين التاني

command1 && command2 نفذ الأول والتاني

command1 || command2 نفذ الأول او التأني







=======help==========

#command syntax

 command [option] [argument]

	option : change command behavior 

	argument : data puss to command

1) manual pages == man pages #Divided into chapters (6 chapters)

 	man <command name : information about command 

	man man : information about man (man chapters)

	man -k "copy files" : search about copyfiles

		k search and display all result

		k (capital)search and display result one by one

	

some shortcuts in man 

	n : next result

	N : previous result 

	g : top of the page

	G : bottom of the page 

	q : quit 



 

2) info pages 

	info 

	

3) /usr/share/doc

4) red hat docs

5) TLDP

6) community









 

  variables 

	environmental : capital letters

		env : show environmental variables 

	user defined variables : small letters

		set : show environmental and user defined variables 



echo $<varname> : print variables





[mohamed2@mohamed ~]

[user@machinename pwd] : Stored in PS1 variable



PS1='[\u@\h \w]' :  value  



nano <filename1> : If the file exists, it opens, and if it does not exist, it creates a file 



variables 

	system wide variables (global) 

		Stored in /etc/ <profile | bashrc>



	user specific variables 

		Stored in <~/ .bashprofile |  ~/ .bashrc>



alias <shortname>=<'longer command' | 'sequence of commands'> : an alias is a user-defined shorthand for a longer command or sequence of commands



alias -p : This option prints all the defined aliases is reusable format. 







examples

	alias ..='cd ..' 

	alias cls='clear'

	alias ll='ls -l'

		 

unalias [alias name] : Removing an existing alias is known as unaliasing





------------------------------------------------------------------------------------



redirection 

	default

		input keyboard (<)

		output screen (>)





> overwritten 

>> append



 ls > result.txt :save output at result file 

 ls install2 2> result.txt :save error at result file 





ls install.log install2 1>output.txt 2>error.txt : if (output)	

		save at output.txt

	    else if (error)

	   	save at error.txt



ls -l anaconda-ks.cfg meshwawgood 2&>result3.txt : save out.put and error at result3 file

ls -l anaconda-ks.cfg meshwawgood >>result3.txt 2>>result2.txt : save output and error at result3 file





cat result3.txt == cat < result3.txt Because the default input is from the file







tr 'a-z' 'A-Z' : transform form small  to capital letter 



tr 'a-z' 'A-Z' <.bashrc >.bashrc : Convert text in a Bash file from lowercase to uppercase and save the change





grep [--color | -n | --color -n ]<keyword> <filenamewithorwithoutphat>: Returns all lines that contain 'keyword'

grep 'root' /etc/passwd 

grep -i root /ect/passwd : insensitive 

grep -v root /ect/passwd : كل حاجه معدا root

grep -n root /ect/passwd : number of line

grep -ivn root /ect/passwd 

grep -R root /ect/ : search include directory (R = re)



tee :  used to split the output of a program so that it can be both displayed and saved in a file



pipe <|> 



example



find / -name passwd | grep [i | v | iv] 'bin' : Find all files named passwd and then return all lines containing "root" from the find command



i : unsensitive

v : Returns all lines that doesn't contain 'keyword'







less <filename> : display file page by page

more <filename> : display file page by page (When it reaches the end, the file closes on its own )





sort <filename> : sort lines in this file 

uniq : remove sequence redundance  



cat test |sort | uniq



cut -<f1|f2|.....> -d <الفاصل> <file> : display fieldnumber form file   

example cut -f1 -d : /ect/passwd



-d : delimeter 

	:

	" "

	;



head [-n numberoflines] <filename>: Display the number of lines from the beginning of the file (10 line by default)



tail [-n numberoflines] <filename>:Display the number of lines from the end of the file (10 line by default)



head -n 3 /ect/passwd |tail -n 1 == head -n +3 /ect/passwd : display line 3 form file



aspell check <filename>: check file





w :displays a list of all logged in to the server and what they are doing. 

This command is similar to who command, but ends up displaying more information about logged in users.

PTS : pseudo terminal screen   





soft link 

	: should use absolute path

	ln -s /root/file2 /tmp/myfile





hard link 

	ln file2 file3

	# It is no longer in common use

	hard link is not allowed for the directory





-----------------------------------------------------------------------------

The Master Boot Record (MBR) and inode number serve very different purposes in a computer's storage system. Here's a breakdown of each:



### Master Boot Record (MBR)



**Purpose:**

- The MBR is a special type of boot sector located at the very beginning of partitioned storage devices like hard drives or SSDs.

- It contains the information required to boot the operating system, including the partition table that describes the layout of the partitions on the storage device.



**Key Features:**

- **Location:** The first sector of a storage device (sector 0).

- **Size:** Typically 512 bytes.

- **Components:** 

  - Bootloader: A small program that loads the operating system's bootloader.

  - Partition Table (64 bytes): Contains entries for the primary partitions (up to 4 in a traditional MBR scheme). each one has 16 bytes

  - Magic Number: Used to validate the integrity of the MBR.



**Usage:**

- Essential for booting legacy BIOS systems.

- Defines the structure of the storage device and the location of the partitions.



### Inode Number



**Purpose:**

- An inode number is an identifier used by many Unix-like file systems to identify files and directories.

- Each inode contains metadata about a file or directory (e.g., permissions, ownership, size, timestamps, and disk block locations) but not the name or the actual data content.



**Key Features:**

- **Location:** Spread throughout the file system; each file and directory has an associated inode.

- **Components:** 

  - Metadata: Information about the file/directory.

  - Pointers: Addresses pointing to the actual data blocks on the disk.



**Usage:**

- Used internally by the file system to manage and locate files.

- Allows efficient file access and management by separating metadata from file names.



### Comparison



| Feature                | MBR                             | Inode Number                    |

|------------------------|---------------------------------|---------------------------------|

| **Purpose**            | Bootstrapping and partitioning  | File system metadata management |

| **Location**           | First sector of storage device  | Throughout the file system      |

| **Size**               | 512 bytes typically             | Varies                          |

| **Content**            | Bootloader, partition table     | File metadata, pointers         |

| **Relevance**          | Boot process, partition layout  | File access and management      |

| **Operating System**   | Legacy BIOS systems             | Unix-like file systems          |



In summary, the MBR is crucial for booting and partition management, while inode numbers are essential for file system organization and file management. 





lsblk : used to list information about all available block devices.



fdisk -l : list connected disks 



fdisk /dev/sda : 







partprobe /dev/sda : reload partition table



mkfs.<filesystem>  :create file system 



mounting 





df [-h] : disk free space {h = human readable format }





mount -t <fstype> <dev> <mountpoint>

mount -t ext4    /dev/sda1  /media



e2label <dev> <lable> : Set a label for the partition



blkid : Display universal unique identifier (UUID)for partitions



mount UUID=<UUIDforpartition>

unmount ~  ~   ~



umount <dev|point|lable>





mount -a : mount all device 





nano/etc/fstab





--------------11-process_managment-------------





ps : list current terminal process 



ps [a] : list all process 

 

ps aux : display all process at system with details  

kill <proc number>  : stop process in background 



kill -9 <proc number> : kill process force 



kill -l : view all kill options 



ps -ef : display all process at system with details +PPID 



pstree : view all process as a tree 



pgrep <procname> : display process id



pkill <procname> : kill process using process name



<program name> & Running in the background



jops : display process Running in the foreground



fg %<procnumber> :Running in the foreground

bg %<procnumber> :Running in the background





-------------------------------12-------------------------------------





killall <procname>: kill all process 



nice value form -20(highest priority) to 19(lowest priority) default value 0



nice -n <-20:19> <process> : set nice value (priority)

renice -n <-20:19> <process> : set nice value (priority) 



top : view load on the machine





=========search============

 searching on {5,6,7.txt}

grep on {8,9,10.txt} 





cut -f 1,3 -d : /ect/passwd : Get fields 1,3 and the separator between them : 



cut -f 3 -d : /ect/passwd | sort -n 



cut -f 7 -d : /ect/passwd | uniq 

cut -f 7 -d : /ect/passwd | sort | uniq



vim : advanced text editor 



the vim has three modes.



insert , command , exec

i : go to insert mode 

esc : exit from insert mode

<:> : go to exec mode

w :  write 

q  : quit

wq : write and quit

q! : quit without write

u : undo

yy : copy 

<n>yy: copy n of line 

dd : cut 

b : paste 

gg: go to the begging

G : go to the end

/<keyword> : to search 

%s/sync/replicate : replace sync  with replicate ( s = substitute = بدل )

%s/sync/replicate/g : replace all



r <file name> : read file and copy text to vim



 

!<command> : to execute a command out of vim and return  



.!<command> : execute a command in vim 



  

====================14-Understanding boot process===================



1-post (power on-self test

2-BIOS ===>find bootable devices and compare it to its settings



3-load iPL (initial program loader) --> load/start ==> Boot loader 



grub (grand unified  boot loader ) : its boot loader in Linux 



4- Grub load /start boot loader 



5-boot loader --> load kernel --->kernel

6- kernel --> start systemd / init



7- systemd /init --> call services/daemons 







 BL ---

	-->1st stage : call 2nd stage (store in MBR) 

	-->2nd stage : store in drive (/boot/) 



kernel--

	-->kernel -

	-->initramfs  



services name  d ديما بينتهي ب 

	sshd 

	cornd

	





systemctl status <<service-name>> : بيعرض حالة البروسيس 



systemctl start <<service-name>> : run process 



systemctl  stop <<service-name>>: 



systemctl is-active <<service-name>> : show if its active or inactive 



systemctl is-enabled <<service-name>> : show if its enabled  or disable



systemctl restart <<service-name>> : restart service 

systemctl reload <<service-name>> : reread configuration file  



systemctl mask <<service-name>> : mask the service  

systemctl unmask <<service-name>> : unmask the service 







init runlevels 

0- power off/ halt

1- single user mode 

2- multi user -GUI -NFS

3- command line interface -GUI

4- unused

5- Multi user + GUI

6 - reboot





systemd target 



-Multi user.target =level3

-graphical.target =level5

-tescue.target =level1

-reboot =level6

-power off =level0





systemctl get-default : show default target 



systemctl set-default <target> : changing default target (reboot the machine to apply the modifications)

 

runlevel : display Current and previous runlevel

 

systemctl : isolate <target> : = systemctl  set-default <target> without need to reboot the machine 



systemctl 



ls /etc/systemd : systemd command file (soft link)

ls /usr/lib/systemd : systemd command file 



telinit is equivalent to init 



systemctl list-units : display services and status 

systemctl list-units | grep -i failed : display failed service 



systemctl lest-unit-files : display files of services 



  

 ----------------------15--------------------

 



ls -l /boot/ : 

>>>>>>> 0cc62acef8126efc964bc44b2282d7b8e2b0f07b
