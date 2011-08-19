XMP2A ;(WASH ISC)/GM/CAP-PackMan Install ;12/04/2002  13:47
 ;;8.0;MailMan;**10**;Jun 28, 2002
ENH I $P(XMR,U,7)]"" D  G:$D(XMPKIDS) 2
 .;check if KIDS format
 .I $P(XMR,U,7)["K",$$CHECK1("I $E(XMB0,1,5)=""$KID """) S XMPKIDS=1 Q
 .I $P(XMR,U,7)["X",$$CHECK1("I $E(XMB0,1,11)=""$TXT $KIDS """) S XMPKIDS=1 Q
 ;check if KIDS but Message Type field got lost
 I $P(XMR,U,7)="",$$CHECK1("I $E(XMB0,1,5)=""$KID """) S XMPKIDS=1 G 2
 G 1:$S('$D(DUZ(0)):1,DUZ(0)="@":0,$D(^XUSEC("XUPROGMODE",DUZ)):0,1:1)
 W !!,$C(7),"Warning:  Installing this message will cause a permanent update of globals"
 W !,"and routines"_$S($P(XMR,U,7)["X":" and run the INIT",1:"")_"." D  Q:'Y
 .N DIR,DIRUT
 .S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you really want to do this"
 .D ^DIR
1 D CHECK D:Y<0  G:'Y Q
 .N DIR,DIRUT
 .S DIR(0)="Y",DIR("B")="NO",DIR("A")="This doesn't appear to be an installable message, do you wish to continue"
 .D ^DIR
2 S XMPASS=1,XMA0=^XMB(3.9,XMZ,0) I $L(XMB0),$L($P(XMA0,U,10)),$D(^("K")) D ^XMPSEC G 3:$S('$D(DUZ(0)):0,DUZ(0)="@":1,$D(^XUSEC("XUPROGMODE",DUZ)):1,1:0)
 I $P(XMB0," at ",3)["on" S XMPASS=0 D FAIL^XMPSEC
 I $S('$D(DUZ(0)):1,DUZ(0)="@":0,$D(^XUSEC("XUPROGMODE",DUZ)):0,1:1) G Q
3 G X:XMP2="R",ENI^XMP2:XMPASS'=0
 W !,"This message may not be installed !!" G Q
X G Z:'$D(XMP2),Z:XMP2'="R" K DIR
 S DIR("A")="ROUTINE(S)",DIR(0)="FO^2:30",DIR("?")="^D HLP^XMP2A"
Y D ^DIR K DIRUT G Z:$D(DTOUT)!$D(DUOUT) G:X="" Q:$O(XMP2(""))="",ENI^XMP2
 I X'?1.A.AN.1"*" W $C(7)," ???" G Y
 S XMP2(X)="" G Y
Z G Q^XMP2
Q K DIR G Q^XMP2
ENTT ;LIST/PRINT TEXT ONLY
 N XMI,XMTEXT,XMABORT,XMPAGE
 S XMI=.999999,XMABORT=0,XMPAGE=1
 F  S XMI=$O(^XMB(3.9,XMZ,2,XMI)) Q:'XMI  S XMTEXT=^(XMI,0) D  Q:XMABORT
 . I $E(XMTEXT,1,8)="$END TXT" S XMABORT=1 Q
 . F  D  Q:$L(XMTEXT)<IOM!XMABORT!(IOM<2)  S XMTEXT=$E(XMTEXT,IOM,999)
 . . I $Y+3+($E($G(IOST),1,2)="C-")>IOSL D  Q:XMABORT
 . . . I $E($G(IOST),1,2)="C-" W ! D PAGE^XMXUTIL(.XMABORT) Q:XMABORT
 . . . W @IOF Q:$E($G(IOST),1,2)="C-"
 . . . D PAGE2HDR^XMJMP1(XMSUBJ,XMZSTR,.XMPAGE)
 . . E  W !
 . . W $S(IOM>1:$E(XMTEXT,1,IOM-1),1:XMTEXT)
 Q
ENTR ;INSTALL SELECTED ROUTINE(S) [IN XMP2 ARRAY]
 F I=0:0 S XCN=$O(^XMB(3.9,XMZ,2,XCN)) Q:XCN=""  S X=^(XCN,0) I $E(X)="$" S Y=$P(X," ",2),J="" F I=0:0 S J=$O(XMP2(J)),K=$L(J)-1 Q:J=""  I $S(J=Y:1,J'?.AN1"*":0,$E(J,1,K)=$E(Y,1,K):1,1:0) D S1^XMP2
 Q
HLP ;Routine selection
 W !!,"Choose routines that you wish to install from this message by entering",!,"single names or a series (XMP2*=all routines that begin with 'XMP2')."
 W !,"The message is not checked to see if there are any matches to your input.",!,"It may be helpful to request a SUMMARY of the message first."
 W !,"Only routines selected for installation are backed up.",!!
 Q
CHECK ;check text header
 S %="I $E(XMB0,1,5)=""$TXT "",$P(XMB0,""Created ""_$S(XMB0[""BACKUP"":""on "",1:""by ""),2)?1E.E1"" at "".E1"" at "".E",%=$$CHECK1(%)
 S Y=$S(%:%,1:-1)
 Q
CHECK1(XMCHK) ;Check text header meets condition XMCHK
 ;returns line number of text header or 0, XMB0=text header
 N XMCNT,XMFLAG
 S XMFLAG=0,XMCNT=.999,XMB0=""
 F  S XMCNT=$O(^XMB(3.9,XMZ,2,XMCNT)) Q:'XMCNT  S XMB0=$G(^(XMCNT,0)) D  Q:'XMCNT
 .X XMCHK I  S XMFLAG=XMCNT,XMCNT=""
 Q XMFLAG
