XVEMBLDB ;DJB/VSHL**VPE Setup - Pages 4-7 ; 6/12/19 9:33am
 ;;15.1;VICTORY PROG ENVIRONMENT;;Jun 19, 2019
 ; Original Code authored by David J. Bolduc 1985-2005
 ; David Wicksell and Sam Habiel changed routine references to ^XV (c) 2010-2016
 ; Sam Habiel fixed outdated VPE Upgrade/Uninstall (c) 2019
PAGE4 ;Instructions for upgrading VPE
 W @FF,!!?2,"U P G R A D E"
 W !!?2,"IF YOU CURRENTLY HAVE AN EARLIER VERSION OF VPE ON YOUR"
 W !?2,"SYSTEM, FOLLOW THESE INSTRUCTIONS TO UPGRADE SMOOTHLY."
 W !
 W !?2,"1) Merge User QWIKS from ^XVEMS(""QU"") to a scratch global."
 W !?2,"2) Make sure all users have halted off VPE Shell."
 W !?2,"3) Delete routines XVEM*, XVS*, XVVM*, and XV"
 W !?2,"4) Kill global ^XVEMS."
 W !?2,"5) Load VPE_XXPX.RSA routines from the disk."
 W !?2,"6) DO ^XV to install and start VPE"
 W !?2,"7) Merge Saved user QWIKS from scratch global to ^XVEMS(""QU"")."
 W !?2,"8) Run ..PARAM to adjust your parameters."
 W !!!!! D ASK^XVEMBLD
 Q
PAGE5 ;
 W @FF,!!?2,"U N I N S T A L L"
 W !!!?2,"To completely deinstall VPE do the following:"
 W !!?2,"1) GLOBALS:     KILL ^XVEMS"
 W !!?2,"2) ROUTINES:    DELETE XVEM*, XVS*, XVVM*, XV"
 W !!?2,"3) FILES:       DELETE VPE* files in FM"
 W !?2," (19200.11,19200.111,19200.112,19200.113,19200.114)"
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
