XVEMBLDA ;DJB/VSHL**VPE Setup - Pages 1-3 ;2017-08-15  11:44 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; Sam Habiel changed PAGE3 to include Cache and GT.M (c) 2016.
 ; 
 ;
PAGE1 ;
 W @FF S START=10,END=START+4
 F I=START:1:END W !?I,"\" W:I=(END-2) "____" W:I=(END-1) "db" W ?(END*2+1-I),"/" W:I=(END-1) "  I  C  T  O  R  Y    S  O  F  T  W  A  R  E"
 W !!!?19,"** VICTORY  PROGRAMMER  ENVIROMENT **"
 W !!!?2,"WELCOME to the Victory Programmer Environment. VPE consists of a number"
 W !!?2,"of integrated programmer utilities that will increase your productivity"
 W !!?2,"and dramatically decrease the number of key strokes required to complete"
 W !!?2,"your normal tasks."
 W !!!! D ASK^XVEMBLD
 Q
PAGE2 ;
 W @FF,!!?2,"V I C T O R Y   P R O G R A M M E R   E N V I R O N M E N T"
 W !!!?2,"GLOBAL LISTER/EDITOR"
 W !?2,"Use to view your globals. Has extensive support for VA FILEMAN files."
 W !!?2,"ROUTINE READER/EDITOR"
 W !?2,"Use to read and edit routines. Allows branching to other routines to"
 W !?2,"follow the flow of the code or capture code for importing into the"
 W !?2,"current routine."
 W !!?2,"ELECTRONIC DATA DICTIONARY"
 W !?2,"Easy to use utility for viewing the data dictionaries of VA FILEMAN files."
 W !!?2,"PROGRAMMER VSHELL"
 W !?2,"A replacement for conventional 'Programmer's Mode'. Provides a safe,"
 W !?2,"productive environment for M programmers. You will wonder how you ever"
 W !?2,"got along without it."
 W !! D ASK^XVEMBLD
 Q
PAGE3 ; VEN/SMH - Global protection warning doesn't apply
 W @FF ; ,!!?2,"G L O B A L   P R O T E C T I O N"
 ; W !!!?2,"If you receive 'Protection Errors' when you first start the VSHELL,"
 ; W !?2,"check that the following globals are set correctly:"
 ; W !!?5,"^%ZOSF   System-RWD   World-R     Group-R     User-RWD"
 ; W !!?5,"^XVEMS  System-RWD   World-RWD   Group-RWD   User-RWD"
 W !!!?2,"If you have the VA KERNEL software on your system, you should confirm"
 W !?2,"that node ^%ZOSF(""OS"") is set correctly. The 2nd piece of this node"
 W !?2,"should be the number of your Mumps system. See node ^DD(""OS"")."
 W !?5,"DSM=2  MSM=8  DTM=9  VAXDSM=16  Cache=18 GT.M/Unix=19"
 W !!!!! D ASK^XVEMBLD
 Q
