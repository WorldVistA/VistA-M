XVEMBLDL ;DJB/VSHL**VPE Setup - Load Editor & Shell ;2017-08-15  11:44 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
TOP ;
 D SHELL
 I FLAGQ D  G EX
 . W !!,"VPE Shell global not loaded."
 W !!,"VPE Programmer Shell successfully loaded."
 W !,"Initialization finished."
 W !!,"NOTE: To start the VPE Shell, type:  D ^XV"
 R !!,"<RETURN> to continue..",XX:300
 D DISCLAIM^XVEMKU1
EX ;
 Q
 ;===================================================================
SHELL ;Load VPE Shell Global - ^XVEMS
 S FLAGQ=0
 D YESNO^XVEMBLD("Load VPE Shell global: YES// ")
 Q:FLAGQ
 D ALL^XVEMSG
 Q
 ;
