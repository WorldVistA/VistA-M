XVEMGM1 ;DJB/VGL**Main Menu cont. ;2017-08-15  12:40 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; New Error trap in PIECE+2 (c) 2016 Sam Habiel
 ;
PIECE ;List pieces
 NEW FLAG,FLAGXREF S FLAG=0
 I $D(XVSIMERR2) S $EC=",U-SIM-ERROR,"
 I '$D(^TMP("XVV","VGL"_GLS,$J,Z1)) D MSG^XVEMGUM(1,1) Q
 I ^TMP("XVV","VGL"_GLS,$J,Z1)']"" D MSG^XVEMGUM(1,1) Q  ;Node was deleted with ES (edit subscript).
 Q:'$$CHECKFM^XVEMGMC()
 S XVVX=^TMP("XVV","VGL"_GLS,$J,Z1)
 I XVVX'?.E1"(".E D MSG^XVEMGUM(2,1) Q
 D SUBSET^XVEMGI1(XVVX) I SUBNUM="NOFM" D MSG^XVEMGUM(3,1) Q
 D CHKNODE^XVEMGMC Q:FLAGQ  D ENDSCR^XVEMKT2
 D @$S(FLAG="ZERO":"ZERO^XVEMGPS",FLAG="WP":"WP^XVEMGPS",FLAG="XREF":"XREF^XVEMGPS",1:"^XVEMGP")
 Q
ALT ;Alternate Session
 D SYMTAB^XVEMKST("C","VGL",GLS) ;Clear symbol table
 D START^XVEMG
 D SYMTAB^XVEMKST("R","VGL",GLS) ;Restore symbol table
 Q
MORE ;
 W !?2,"VEDD ......: Victory Electonic Data Dictionary"
 W !?2,"ER ........: EDITOR - Edit range of nodes"
 W !?2,"ES ........: EDITOR - Edit node's subscript"
 W !?2,"EV ........: EDITOR - Edit node's value"
 W !?2,"SA ........: SAve code so it can be UNsaved into a routine"
 W !?2,"SC ........: Strip control characters from a node. Control"
 W !?2,"             characters will appear as 'c' in reverse video."
 W !?2,"UN ........: UNsave code that's been previously SAved"
 W !?2,"<ESC>H ....: Scroll Help"
 W !!?2,"Call VGL at R^XVEMG to display subscript ""constants"" in reverse video."
 D PAUSE^XVEMKC(2)
 Q
CHECK() ;0=Quit 1=Ok   Check: A,C,ES,EV
 I ",C,ES,EV,"[(","_Z1_","),$G(DUZ(0))'["@" D MSG^XVEMGUM(4,1) Q 0
 I ",C,ES,EV,"[(","_Z1_","),$G(VGLREV) D MSG^XVEMGUM(5,1) Q 0
 I ",ES,EV,"[(","_Z1_","),$G(FLAGVPE)["VRR"!($G(FLAGVPE)["VEDD") D MSG^XVEMGUM(6,1) Q 0
 I ",ES,EV,"[(","_Z1_","),GLS>1 D MSG^XVEMGUM(7,1) Q 0
 I Z1="C",XVVT("STATUS")["SEARCH" D MSG^XVEMGUM(8,1) Q 0
 I Z1="C",'$D(^TMP("XVV","VGL"_GLS,$J)) D MSG^XVEMGUM(9,1) Q 0
 I Z1="A",GLS>1 D MSG^XVEMGUM(10,1) Q 0
 I Z1="A",$G(FLAGVPE)["VRR"!($G(FLAGVPE)["VEDD") D MSG^XVEMGUM(11,1) Q 0
 Q 1
