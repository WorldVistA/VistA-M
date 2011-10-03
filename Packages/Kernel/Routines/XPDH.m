XPDH ;SFISC/XAK,RSD - help for answering install questions ;03/27/2008  09:11
 ;;8.0;KERNEL;**58,95,108,399**;Jul 10, 1995;Build 12
REP ;changing your file name
 W !!?5,"If YES, then the incoming file name and Data Dictionary will"
 W !?5,"overwrite the existing file ",FLAG,"."
 W !!?5,"If NO, then the Install Process will abort.",!
 Q
DTA ;help for adding data
 W !!?5,"YES means that the data coming in with this INSTALL process"
 W !?5,"will ",FLAG," the data on file if a match is found."
 W !!?5,"Entries will be added if they do not match exactly"
 W !?5,"on Name and Identifiers."
 W !!?5,"NO means that everything will be left as is."
 Q
OPT ;disable options
 W !!?5,"YES means you want to mark Options and Protocols out of"
 W !?5,"order during the Install Process."
 W !!?5,"NO means no action will be taken."
 Q
RTN ;moving routines
 W !!?5,"YES means you want to update the routines on other CPUs"
 W !?5,"during the Install Process.  This will work only if Taskman"
 W !?5,"is running during the Install Process."
 W !!?5,"NO means that only routines on this CPU will be updated."
 Q
MSG ;creating a Packman message
 W !!?5,"YES means that you are going to send this Package over"
 W !?5,"the Network as a message."
 W !?5,"NO means that a Transport Global will be created."
 Q
MG ;adding Coordinator to a Mail Group
 W !!?5,"Enter the person responsible for maintaining the membership"
 W !?5,"of the incoming Mail Group.  The person must exist in the"
 W !?5,"New Person file, #200.  If the Mail Group exist, it will"
 W !?5,"default to the existing coordinator."
 Q
INHIBIT ;Inhibit logons during install
 W !!?5,"YES means that KIDS will set the Inhibit logon in each volume"
 W !?5,"set in file 14.5, preventing Users from loging on during the install."
 W !?5,"NO means that KIDS will not set the Inhibit flag."
 W !?5,"Users may be able to logon during the install."
 Q
MENU ;rebuild menu trees if an Option was added
 W !!?5,"YES means that KIDS will run the Menu Trees rebuild routines"
 W !?5,"as part of the installation at the end."
 W !?5,"NO means that the Menu Trees will not be rebuilt."
 W !?5,"It is highly recommended that you rebuild Menu Trees"
 W !?5,"immediately whenever KIDS adds an Option."
 Q
