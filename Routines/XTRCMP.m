XTRCMP ;SF-ISC/RWF - Compare two routines. ;12/01/2005
 ;;7.3;TOOLKIT;**92**;Apr 25, 1995;Build 1
A ;Compare two routines in account
 N DIR,DIRUT,RTN1,RTN2,%N,XCNP,DIF,%DEBUG,XTEND,%ZIS,ZTDESC,ZTRTN,ZTSAVE
 N %,%1,%2,%3,%4,%H,%T,%Y,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z
 S U="^" S:'$D(DTIME) DTIME=$$DTIME^XUP($G(DUZ),$G(IOS))
 W !,"Compares two routines"
 S DIR("A")="First Routine" D RSEL G QUIT:$D(DIRUT) S RTN1=X,DIR("A")="Compare to Routine: " D RSEL G QUIT:$D(DIRUT) S RTN2=X
 S %ZIS="Q" D ^%ZIS G QUIT:POP
 I '$D(IO("Q")) W !,"Loading Routines." G CHECK
 S ZTRTN="CHECK^XTRCMP",ZTDESC="Routine Compare",ZTSAVE("RTN1")="",ZTSAVE("RTN2")=""
 D ^%ZTLOAD D HOME^%ZIS
 G QUIT
 ;
CHECK ;
 S DIF="^TMP($J,1," D LOAD(RTN1) S O=XCNP-1
 S DIF="^TMP($J,2," D LOAD(RTN2) S F=XCNP-1
 U IO W @IOF,!,RTN1,?(IOM\2),RTN2
 D LINE,^XMPC W !
 D ^%ZISC
 G QUIT
 ;
LOAD(X) ;Load Routine from Disk, Line count in XCNP.
 S XCNP=0 X ^%ZOSF("LOAD")
 Q
RSEL S DIR(0)="F^1:8^D TEST^XTRCMP(X)",DIR("?")="Routine name to do compare on."
 D ^DIR K DIR
 Q
TEST(X) ;Test if Routine is on Disk
 X ^%ZOSF("TEST") I '$T W !,"Routine ",X," missing." K X
 Q
END S XTEND=1
 Q
 ;
QUIT K ^TMP($J)
 Q
LINE S X="",$P(X,"-",IOM-3)="-" W !,X
 Q
 ;
TAPE ;Read a tape and compare to disk.
 N DIR,DIRUT,RTN1,RTN2,%N,XCNP,DIF,XTAPE,X1
 N %,%1,%2,%3,%4,%H,%T,%Y,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z
 S U="^"
 W !!,"Compares routines from tape/file with what's on disk."
 S %ZIS="",%ZIS("A")="Device with Routines: " D ^%ZIS Q:POP  S XTAPE=IO F I="IOT","IOST","IOST(0)","IOS" S XTAPE(I)=@I
 U XTAPE R X:10,Y:10 U IO(0) W !!,"Tape header",!,X,!,Y
 S DIR(0)="Y",DIR("A")="OK to continue",DIR("B")="Yes" D ^DIR K DIR G EXIT:$D(DIRUT)!('Y)
 S IO=IO(0),%ZIS="",%ZIS("A")="Output Report on Device: " D ^%ZIS G EXIT:POP
 U IO W !,"Compare of routines from file (",XTAPE,") and disk",!
 F X1=0:0 D TIN Q:X=""  D DIN I $D(X) D CMP("Tape")
 U IO W !,"DONE"
EXIT S IO=XTAPE F I="IOT","IOST","IOST(0)","IOS" S @I=XTAPE(I)
 D ^%ZISC
 K ^TMP($J)
 Q
 ;
TIN ;Read one routine from tape
 N I
 U XTAPE R RTN1:10 ;Read routine name
 ;Cache has more than just the name. 32 char max name.
 F I=2:1:32 Q:($E(RTN1,I)'?1AN)
 S RTN1=$E(RTN1,1,I-1)
 I (RTN1'?1.8AN)&(RTN1'?1"%".7AN) S X="" Q
 K ^TMP($J,1)
 F I=1:1 R X:10 Q:X=""  S ^TMP($J,1,I,0)=$TR(X,$C(9)," ")
 S X=RTN1,O=I-1 U IO
 Q
 ;
DIN X ^%ZOSF("TEST") I '$T U IO W !,"Routine ",X," not on disk" D LINE K X Q
 K ^TMP($J,2) S DIF="^TMP($J,2," D LOAD(X) S F=XCNP-1
 Q
 ;
CMP(S1) ;
 U IO W !,"Routine ",RTN1,!?3,S1,?IOM\2+3,"Disk"
 I $G(%DEBUG) F I=1,2 S ^TMP($J,2,I,0)=^TMP($J,1,I,0)
 D LINE,^XMPC
 Q
 ;
KIN(RN) ;KIDS routine in
 K ^TMP($J,1) S R=$NA(^XTMP("XPDI",XPDST,"RTN",RN))
 F I=1:1 Q:'$D(@R@(I))  S ^TMP($J,1,I,0)=@R@(I,0)
 S X=RN,O=I-1
 Q
 ;
XPD ;Compair a KIDS install to Disk
 N RTN1,RTN2,O,F,%N,XCNP
 ;Get the install
 S %="I '$P(^(0),U,9),$D(^XPD(9.7,""ASP"",Y,1,Y)),$D(^XTMP(""XPDI"",Y))",XPDST=$$LOOK^XPDI1(%)
 S XPDNM=$$GET1^DIQ(9.7,XPDST_",",.01)
 Q:'XPDST!$D(XPDQUIT)
 S %ZIS="M" D ^%ZIS Q:POP
 D XPDDO(XPDST)
 D ^%ZISC
 Q
 ;
XPDDO(XPDST) ;Do the KIDS compare
 N RTN1,RTN2,O,F,%N,XCNP,X
 U IO W !,"Compare of routines from KIDS ",XPDNM,", and disk",!
 S RTN1="" F  S RTN1=$O(^XTMP("XPDI",XPDST,"RTN",RTN1)) Q:RTN1=""  S X=^(RTN1) D
 . I X W:X=1 !!,"DELETE Routine: ",RTN1,! Q
 . D KIN(RTN1),DIN I $D(X) S F=XCNP-1 D CMP("KIDS")
 . Q
 Q
