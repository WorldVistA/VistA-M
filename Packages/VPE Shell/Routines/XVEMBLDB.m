XVEMBLDB ;DJB/VSHL**VPE Setup - Pages 4-7 ;2017-08-15  11:44 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; David Wicksell and Sam Habiel changed routine references to ^XV (c) 2010-2016
PAGE4 ;Instructions for upgrading VPE
 W @FF,!!?2,"U P G R A D E"
 W !!?2,"IF YOU CURRENTLY HAVE AN EARLIER VERSION OF VPE ON YOUR"
 W !?2,"SYSTEM, FOLLOW THESE INSTRUCTIONS TO UPGRADE SMOOTHLY."
 W !!?2,"1) Have all users save their QWIKs (Use ..QSAVE System QWIK)."
 W !?2,"2) Make sure all users have halted off VPE Shell."
 W !?2,"3) Delete routines ^XVEM*, ^XVEM*, and ^XVVM*."
 W !?2,"4) Kill global ^XVEMS."
 W !?2,"5) Load VPE_xx.MGR routines from the disk."
 W !?2,"6) DO ^XVEMBLD to install VPE."
 W !?2,"7) Load VPE_xx.PRD routines from the disk."
 W !?2,"8) DO ^XVVMINIT to install VPE Fileman files."
 W !?2,"9) Start VPE Shell and run ..QSAVE to restore your QWIKs."
 W !?1,"10) Run ..PARAM to adjust your parameters."
 W !!!!! D ASK^XVEMBLD
 Q
PAGE5 ;
 W @FF,!!?2,"D E I N S T A L L"
 W !!!?2,"To completely deinstall VPE do the following:"
 W !!?2,"1) GLOBALS:      MGR      KILL ^XVEMS"
 W !!?2,"2) ROUTINES:     MGR      DELETE ^XVEM*"
 W !?2,"                 MGR      DELETE ^XVEM*"
 W !?2,"                 PRD      DELETE ^XVVM*"
 W !?2,"3) FILES:        PRD      DELETE VPE* files in FM"
 W !!!!!!!!! D ASK^XVEMBLD
 Q
PAGE6 ;Modules list
 W @FF,!!?2,"V P E   M O D U L E S   L I S T"
 W !!?40,"ROUTINES",?58,"ACTION"
 W !?40,"--------",?54,"---------------"
 W !?4,"VGL...Global Lister/Editor..........^XVEMG*......DO ^XVEMG"
 W !?4,"VRR...Routine Reader................^XVEMR*......DO ^XVEMR"
 W !?4,"E.....Routine Editor.............................DO ^XVSE"
 W !?4,"VEDD..Electronic Data Dictionary....^XVEMD*......DO ^XVEMD"
 W !?4,"      VPE Shell.....................^XVEMS*......DO ^XV"
 W !!!!!!!!!!! D ASK^XVEMBLD
 Q
