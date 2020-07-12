XVEMBLDB ;DJB/VSHL**VPE Setup - Pages 4-7 ;Aug 26, 2019@15:15
 ;;15.2;VICTORY PROG ENVIRONMENT;;Aug 27, 2019
 ; Original Code authored by David J. Bolduc 1985-2005
 ; David Wicksell and Sam Habiel changed routine references to ^XV (c) 2010-2016
 ; Sam Habiel fixed outdated VPE Upgrade/Uninstall (c) 2019
PAGE4 ;Instructions for upgrading VPE
 W @FF,!!?2,"U P G R A D E"
 W !!?2,"IF YOU CURRENTLY HAVE AN EARLIER VERSION OF VPE ON YOUR"
 W !?2,"SYSTEM, FOLLOW THESE INSTRUCTIONS TO UPGRADE SMOOTHLY."
 W !
 W !?2,"Outside of VPE, run UPGRADE^XV"
 W !!!!! D ASK^XVEMBLD
 Q
PAGE5 ;
 W @FF,!!?2,"U N I N S T A L L"
 W !!!?2,"To completely uninstall VPE do the following:"
 W !!?2,"1) Remove Globals and Files by running RESET^XV outside of VPE"
 W !!?2,"2) ROUTINES:    DELETE XVEM*, XVS*, XVVM*, XV"
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
