XMCTLK ;(WASH ISC)/CAP-TalkMan ;04/18/2002  07:29
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; TALK   XMTALK
 I '$D(DUZ) W !,$C(7),"You don't have a DUZ." Q
 N XMABORT,XMDUZ,XMV
 D INIT
 S XMABORT=0
 D HELP(.XMABORT) Q:XMABORT
GO K XMG0
GO1 K %ZIS
 S %ZIS=""
 D ^%ZIS Q:POP
 I '$D(XMDUZ) Q:'$D(DUZ)  D INIT
 I IO=IO(0) D ^%ZISC W !,"YOU MUST CHOOSE ANOTHER DEVICE" Q
ENT ;
 N XMZ,XMSUB,TN,TL,TP,TK
 W @IOF,"<<<< You are now talking through device ",IO," >>>>"
 X ^%ZOSF("NBRK"),^("PRIINQ") S XMP=Y,X=Y+3,XME0(0)="S R=0,XME0=$$TSTAMP^XMXUTIL1" S:X>10 X=10
 X ^%ZOSF("PRIORITY")
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP=""
 S X="ABEND^XMCTLK",@^%ZOSF("TRAP")
 W !,"===== Enter <control>A to stop. =====",$C(7),!
 S XM="",D="",XMD0=0,A=""
 S XMB0=^%ZOSF("EOFF"),XMB0("RM")="S X=0 "_^("RM"),XMC0=^("EON"),XMF0=^("TYPE-AHEAD"),XMA=^("TRMRD") F I="TRMON","TRMOFF","NBRK" S XMG0(I)=^(I)
 S TN=$P($H,",",2),TL=TN,(TP,TK)=0 ; Times & Timed reads Port/Keyboard
 D T
 S D=""
 U IO
 G G
 ;
 ;MAIN LOOP / DIALOG OCCURS HERE
R ;
 W:$D(XMC("TALKMODE")) *17
 U IO
 R A#150:$S($G(R)>20:1,1:0)
 W:$D(XMC("TALKMODE")) *19
 S D=D_A
 X XMA
 S TN=$P($H,",",2)
 S:(TN-TL>5) TP=1 ;ihs Time Now TP adjustment
 S R=$G(R)+1
 I Y>0 D T0 U IO(0) W A,*Y S TP=0,TL=TN X XME0(0) G R
 D T0
 U IO(0)
 W A
 I $L(A) S TP=0,TL=TN X XME0(0) D T0 G R
S ;
 S Y=0
 U IO(0)
 R A:TK S TK=0 E  U IO W A S:$L(A) TP=0,TL=TN G R:$L(A),Q:$$TSTAMP^XMXUTIL1-XME0>$S($D(DTIME):DTIME,1:300),R ;ihs timer adjustment
 X XMA
 G Q:Y=1
 S:Y=27 TK=1
 S TP=0
 I Y=13,$D(XMG0("EON")) S TP=0 U IO(0) W ! ;ihs timer adjustment
 U IO
 W A,*Y
 W:$D(XMG0("EON"))&(Y=13) !
 S:$L(A) TP=0
 X XME0(0)
 G R
Q ;
 U IO(0)
 W $C(7)
 H 1
 W $C(7)
 X XMC0,XMF0,XMG0("TRMOFF"),XMG0("NBRK")
 K DIR
 S DIR("T")=9
 S DIR(0)="S^E:END TalkMan session;C:begin CAPTURE TalkMan dialog in message;N:do NOT end TalkMan session.;K:KERMIT Transfer Files"
 S DIR("B")="N"
 S DIR("??")="XMTALK"
 I '$D(XMDUZ) S $P(DIR(0),";",2,3)=$P(DIR(0),";",3) G D
 I $D(XMSUB) S $P(DIR(0),";",2)="S:STOP capture"
D ;
 S XMA0=D
 D ^DIR S:$D(DTOUT) X="^" I '$D(X) W " ???? " G D
 S D=XMA0
 I "N"[X D T S A=" <Continue in TalkMan Mode >" D T0 W !,A,! G G
 ;
 ;Using Kermit !
 I "K"=X D  G G
 . N X
 . I $G(^DIC(15,0,"VR"))'>7.1 W !," <No Kermit use yet. The correct Kernel tools version is not installed !>",! Q
 . D KERM^XTKERMIT,T
 . W !," <Continue in TalkMan Mode >",!
 . D U
 . S D="",Y=1
 I "S"=X K XMSUB W ! G G
 G DQ:"^E"[$E(X)
 I $D(XMZ) W ! S XMSUB=1 G G
 S XMD0=0
 K %I,%H
 S XMSUB=XMDUN_" DIALOG CAPTURE "_$$HTE^XLFDT($H,5)
 D GET^XMA2
 W !
 G G
 ;
G ;RETURN TO TALKMAN MODE
 U IO
 X XMB0("RM"),XMB0,XMF0,XMG0("NBRK"),XMG0("TRMON")
 X:$D(XMG0("EON")) XMC0
 D T
 X XME0(0)
 G R
 ;
ABEND ;Handle abnormal end
 D ^%ZISC
 U IO(0)
 W $C(7)
 H 1
 W $C(7)
 X XMC0,XMF0,XMG0("TRMOFF"),XMG0("NBRK")
 G DQ
 ;
 ;END TALKMAN SESSION
DQ ;
 W $C(7),!!,"End of Talkman session."
 W !,"You are back at your starting place.",!
 H 1
 W $C(7)
 W !!
 U IO
 W *17
 X XMG0("TRMOFF")
 D ^%ZISC,HOME^%ZIS
 D N
 G QQ:'$D(XMZ),QQ:'XMZ
 I 'XMD0 D KILLMSG^XMXUTIL(XMZ) G QQ
 I $P(XMD0,U,2,999)'="" S XMSUB=1,Y=999,D=$P(XMD0,U,2,999) D T0
 S XMD0=+XMD0
 I XMD0 D NOW^%DTC D  K %I,%H G QQ
 . S ^XMB(3.9,XMZ,2,0)="^3.92A^"_XMD0_U_XMD0_U_%
 . K XMY,^TMP("XMY",$J),^TMP("XMY0",$J)
 . S XMY($G(XMDUZ,DUZ))=""
 . D ENT1^XMD W !,"TalkMan dialog capture being delivered now."
 D KILLMSG^XMXUTIL(XMZ)
QQ ;
 W !
 D CHK^XM
 W !
 S X=XMP
 X ^%ZOSF("PRIORITY")
 K %,X1,X2,XMA0,XMB0,XMC0,XMD0,XME0,XMF0,XMG0,XMA,XMP,XMSUB,DIR
 S XMZ=0
 Q
N ;
 U IO(0)
 X XMC0
 I $D(DUZ) S X=$G(^VA(200,DUZ,200)) Q:X#10'=1  Q:$P(^(200),U,9)="Y"
 S A="NO-TYPE-AHEAD" Q:'$D(^%ZOSF(A))  X ^(A)
 Q
T ;
 U IO(0)
 S X=0
 X ^%ZOSF("RM"),XMF0,XMB0,XMG0("TRMON"),XMG0("NBRK")
 I $D(XMG0("EON")) X XMC0
 Q
T0 ;
 I '$D(XMSUB)!(D=""&(Y'=9)) S D="" Q
 I D'?.ANP F I=1:1 I $E(D,I)?1C S D=$E(D,1,I-1)_$S($A(D,I)=9:"",1:" ")_$E(D,I+1,999) Q:$E(D,I,999)?.ANP  S I=I-1
T1 ;
 I Y'=13&($L(D)<81)!(Y>0&(D="")) S XMD0=+XMD0_U_D Q:Y'=9  S D=$E(D_"         ",1,$L(D)\9+1*9),$P(XMD0,U,2)=D Q
 I D="" S D=" "
 S XMD0=XMD0+1,^XMB(3.9,XMZ,2,XMD0,0)=$E(D,1,80),D=$E(D,81,999)
 G T1
U ;
 S XME0=$$TSTAMP^XMXUTIL1
 Q
 ;
 ;GET INITIAL VALUES
ECHO ;ENTRY TO ECHO
 K XMG0
 S XMG0("EON")=1
 G GO1
INIT ;
 D INIT^XMVVITAE
 K XMA0,XMB0,XMC0,XMD0,XME0,XMF0
 G H^XUS:'$D(XMDUZ),H^XUS:'$D(XMDUN) K XMZ
 Q
HELP(XMABORT) ;
 N DIR,X,Y
 S DIR(0)="Y"
 S DIR("A")="Do you want help"
 S DIR("B")="NO"
 D ^DIR I $D(DIRUT) S XMABORT=1 Q
 Q:'Y
 S XQH=$S($G(DUZ(0))="@":"XMTALK",$D(^XUSEC("XMMGR",DUZ)):"XMTALK",1:"XMTALK-USER")
 D EN^XQH
 Q
TALK ; Talk mode entry
 I '$D(DUZ) W !,$C(7),"You don't have a DUZ." Q
 N XMC,XMDUZ,XMV,XMOKTYPE,XMINST,XMSITE,XMIO,XMB,XMABORT
 N XMLER,XMLINE,XMCNT,DIC,XMA0,XMB0,XMC0,XMD0,XME0,XMF0,XMG0
 D INIT^XMVVITAE
 S XMC("TALKMODE")=1,XMABORT=0
 D HELP(.XMABORT) Q:XMABORT
 ;Ask Domain / get defaults
 ;S (XMOKTYPE("SMTP"),XMOKTYPE("TELNET"))=""
 S XMOKTYPE("TELNET")=""
 D ASK^XMCXU(.XMINST,.XMSITE,.XMB,.XMABORT,"I $P(^(0),U,2)[""T""",.XMOKTYPE) Q:XMABORT
 S XMIO=$P(XMB("SCR REC"),U,5)
 S XM=""
 W !,"Attempting to connect...."
 S XMDUZO=XMDUZ
 D ENT^XMC1
 S XMDUZ=XMDUZO K XMDUZO
 I ER D  Q
 . D ^%ZISC
 . W !,$C(7),"Could not connect to ",XMSITE,"."
 . W !,"You are back at ",^XMB("NETNAME"),"."
 . D KILL^XMC
 U IO(0)
 D ENT
 D KILL^XMC
 Q
