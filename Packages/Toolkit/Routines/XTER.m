XTER ;ISC-SF.SEA/JLI - Error Trap Display option [XUERTRAP] ;16 Jul 2003 10:15 am
 ;;8.0;KERNEL;**63,275**;Jul 10, 1995
 ;
 N %,%XTZDAT,XTX,XTPRNT,XTOUT,XTMES,DIR,I
 K XTX,^TMP($J,"XTER"),^TMP($J,"XTERSCR"),XTPRNT,XTMES
 S U="^"
 F I=0:0 S I=$O(^%ZTER(2,"AC",1,I)) Q:I'>0  S %=$P(^%ZTER(2,I,0),U),%=$S($G(^(2))]"":^(2),1:%),^TMP($J,"XTERSCR",%)=""
 S U="^",IOP="HOME" D ^%ZIS K IOP S:'$D(DTIME) DTIME=9999 S XTOUT=0
 W !!,"In response to the DATE prompt you can enter:" S XTF="" D 11 W !!
 ;
%XTZDAT U IO(0) S XTOUT=0 S:'($D(XTX)#2) XTX="T" S:XTX="^" XTX="" I 1 R:XTX="" !!,"Which date? > ",XTX:300 G END:'$T!(XTX="^")!(XTX=""),END:XTX="^Q"!(XTX="^q") S X=XTX,XTX="" G:X["?" DIS
 I "Ss"[X D SLIST^XTER2 G %XTZDAT
 S %XTZDAT=X D UDD^XTER2 I $D(XTERR),XTERR=1 D IR G %XTZDAT
 S %XTZDAT=$S(XTDTH<0:-XTDTH,1:XTDTH) K XTDTH G DO
DIS W !,"Errors have been logged on: "
 S XTFST=0,XTH=+$H,X=""
 S XTJJ=$O(^%ZTER(1,0)) Q:XTJJ'>0  F XTJ=$H:-1 Q:XTJJ>XTJ  I $D(^%ZTER(1,XTJ,0)) W $S(XTFST:", ",1:""),"T" S XTFST=1 W:XTJ'=XTH "-",XTH-XTJ W "(",$P(^%ZTER(1,XTJ,0),U,2),")"
 S XTF="3,4,11" D HELP
 G %XTZDAT
DO S XTNE=$D(^%ZTER(1,%XTZDAT)) I 'XTNE D E1 G %XTZDAT
 S XTNE=$P($G(^%ZTER(1,%XTZDAT,0)),U,2) D E1 S XTX="??"
XTERR S:'($D(XTX)#2) XTX="" S:XTX="^" XTX="" I 1 R:XTX="" !!,"Which error? >  ",XTX:300 G END:'$T!(XTX="^Q")!(XTX="^q"),%XTZDAT:XTX'?1N.N&($E(XTX)'="?") S X=XTX,XTX=""
 I X?1"???".E S XTD=0 D LST^XTER1A G XTERR
 I X?1"??".E S XTD=1 D LST^XTER1A G XTERR
 I X="?" D E1 S XTF="1,2,6,5,12,16" D HELP G XTERR
 I (X="?L")!(X="?l") D ALL^XUTMKE1 G XTERR
 I X'?1N.N D E1,IR G XTERR
 S %XTZNUM=X
 K %XTZLIN I '($D(^%ZTER(1,%XTZDAT,1,%XTZNUM,0))#2) W !,"Error not on File." W:%XTZNUM>$P(^%ZTER(1,%XTZDAT,0),U,2) "  Last error logged is ",$P(^%ZTER(1,%XTZDAT,0),U,2),"." G XTERR
 G ^XTER1
IR W !!,"Incorrect response - enter '?' for more information" Q
HELP ;
 W !!,"Enter:" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
1 W !?5,"^Q to EXIT" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
2 W !?5,"'^' to return to the last question" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
3 W !?5,"'^Q'  or  '^'  or <RETURN> to quit" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
4 W !?5,"Date as 'DD' or 'MM/DD' or 'MM/DD/YY' or 'T'  or 'T-1'",!?15,"(note: 'T' as in Today)" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
12 W !?5,"??? to list all errors with $ZE, $I, $J, and Time" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
6 W !?5,"Number of error desired" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
7 W !?5,"^L to obtain a list of all symbols" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
8 X ^%ZOSF("PROGMODE") W:Y !?5,"^R to restore the symbol table and ... and enter direct mode" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
9 W !?5,"$ to get a display of the $ system variables" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
10 W !?5,"Leading character(s) of symbol(s) you wish to examine" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
11 W !?5,"'S' to specify text to be matched in error or routine name" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
5 W !?5,"?? to list only those errors which are NOT SCREENED with $ZE, $I, $J,",!?15,"and Time" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
13 W !?5,"^P to select a printer and print this error" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
14 W !?5,"^M to capture the current error in a mail message" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
15 W !?5,"^I to obtain information on key package variables" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
16 W !?5,"?L to obtain a list of error screens that are in place" S XTFI=$P(XTF,","),XTF=$P(XTF,",",2,99) G:XTFI="" EHELP G @XTFI
EHELP K XTF,XTFI
 Q
E1 W !,$S(XTNE:XTNE,1:"No")," error",$S(XTNE>1:"s",1:"")," logged on ",XTDTE
 Q
END D ^%ZISC
 K %XT,%XTZE,%XTZ,%XTJOB,%XTZH,%XTIO,%XTUCI,%XTERR,%XTZDAT,%XTZNUM,%XTZLIN,%XTZO,XTA,XTB,XTC,XTD,%XTX,%XTY,XTFST,XTH,%XTZGR,XTJJ,%,%H
 K %XTA,%XTB,%XTC,%XTF,%XTG,%XTI,%XTJ,%XTL,%XTD,%XTM,%XTN,XTI,XTJ,XTK,XTDTE,XTOUT,XTX,XTNE,XTP,XTQ,XTSYM,XTZ,%XTZZZ,XTERR,X,Y,%XTYL,%XTZH1,C,XTBLNK,XTDV1,XTA1,XTC1,XTMES,XTPRNT
 ; GT.M doesn't have a vendor-specific error trap lister
 N XTROU S XTROU=$G(^%ZOSF("OS"))  Q:XTROU=""  Q:XTROU["GT.M"
 I XTROU["OpenM" W !,"Use SYSLOG in the %SYS namespace" Q
 W !! S DIR(0)="Y",DIR("A")="Do you want to check the OPERATING SYSTEM ERROR TRAP too",DIR("B")="NO" D ^DIR K DIR Q:'Y
 S XTROU=U_$S(XTROU["DTM":"%errdump",1:"%ER") D:XTROU'="" @XTROU
 Q
 ;
MORE S XTOUT=0 I $D(IOST)#2,IOST["C-" R !?15,"Enter '^' to quit listing, <RETURN> to continue...",XTX:DTIME S:'$T XTX="^" I XTX="^" S XTOUT=1 Q
 Q
