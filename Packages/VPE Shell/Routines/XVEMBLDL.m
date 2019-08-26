XVEMBLDL ;DJB/VSHL**VPE Setup - Load Editor & Shell ; 6/12/19 11:05am
 ;;15.1;VICTORY PROG ENVIRONMENT;;Jun 19, 2019
 ; Original Code authored by David J. Bolduc 1985-2005
 ; Sam habiel OLD EP (c) 2019.
 ;
TOP ;
 D SHELL
 I FLAGQ D  G EX
 . W !!,"VPE Shell global not loaded."
 W !!,"VPE Programmer Shell successfully loaded."
 W !,"Initialization finished."
 W !!,"NOTE: To start the VPE Shell, type:  D ^XV"
 D OLD
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
OLD ; Old VPE Warning
 I $D(^%ZVEMS) D
 . W !!
 . W "Old VPE (v12) seems to be installed here",!
 . W "Old VPE can still be used by running X ^%ZVEMS",!
 . W "New VPE can be invoked by running D ^XV",!
 Q
