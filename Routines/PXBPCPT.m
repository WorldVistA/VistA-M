PXBPCPT ;ISL/JVS,ESW - PROMPT CPT ;3/18/05 12:55pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**11,73,89,112,121,132,149,124,190**;Aug 12, 1996;Build 9
 ;
 ;
 ;
CPT ;--CPT CODE
 ;SELINE=LINE NUMBER OF SELECTED ITEM
 N TIMED,PXBUT,EDATA,DIC,LINE,XFLAG,SELINE
 N I,X,Y,Q,DOUBLEQQ,NF,BAD,OK,CPT,PXEDIT
 I '$D(^DISV(DUZ,"PXBCPT-1")) S ^DISV(DUZ,"PXBCPT-1")=" "
 I '$D(IOSC) D TERM^PXBCC
 S DOUBLEQQ=0,PXEDIT=""
 S TIMED="I '$T!(DATA[""^"")!(DATA="""")"
 S DIC("S")="I $$CPTSCREN^PXBUTL(Y,IDATE)"
C ;--SECOND ENTRY POINT
 W IOSC
 ;---DYNAMIC  HEADER-----------------
 I '$D(CYCL) D
 .I PXBCNT=0,DOUBLEQQ=0 D LOC^PXBCC(2,10) W IOUON,"...There are "_$G(PXBCNT)_" PROCEDURES associated with this encounter.",IOUOFF,IOELEOL
 .I PXBCNT=1,DOUBLEQQ=0 D LOC^PXBCC(2,10) W IOUON,"...There is "_$G(PXBCNT)_" PROCEDURE associated with this encounter.",IOUOFF,IOELEOL
 .I PXBCNT>1,DOUBLEQQ=0 D LOC^PXBCC(2,10) W IOUON,"...There are "_$G(PXBCNT)_" PROCEDURES associated with this encounter.",IOUOFF,IOELEOL
 ;
 D LOC^PXBCC(15,0)
 ;I PXBCNT>30 
 ;W IOCUU,IOELEOL,
 W:PXTLNS>10 !,"Enter '+' for next page, '-' for last page." ;,IORC
 D WIN17^PXBCC(PXBCNT)
 I '$D(^TMP("PXK",$J,"CPT")) W !,"Enter PROCEDURE (CPT CODE): "
 I $D(^TMP("PXK",$J,"CPT")) W !,"Enter ",IOINHI,"NEXT",IOINLOW," PROCEDURE (CPT CODE): "
 W IOELEOL R DATA:DTIME S EDATA=DATA
C1 ;----Third entry point
 X TIMED I  S PXBUT=1 S:DATA="^^" PXBEXIT=0 S:DATA="^^^" PXBRRR="" G CPTX
 I DATA?1.N1"E".NAP S DATA=" "_DATA
 I $L(DATA)>200 S (DATA,EDATA)=$E(DATA,1,199)
 I DATA?24.N S (DATA,EDATA)=$E(DATA,1,24)
 ; ----- Check & remove control character PX*190 -----
 S ZZDATA=""
 S ZDATA="" F J=1:1:$L(DATA) S ZDATA=$E(DATA,J)  D
 .I $A(ZDATA)>31,($A(ZDATA)'=127) S ZZDATA=ZZDATA_ZDATA
 I $L(ZZDATA)=0 W $C(7),"??" D HELP^PXBUTL0("CPTM") G C
 S (DATA,EDATA)=ZZDATA
 K ZZDATA,ZDATA,J
 ; 
 D CASE^PXBUTL
 ;----SPACE BAR---
 I DATA=" ",$D(^DISV(DUZ,"PXBCPT-1")) S DATA=^DISV(DUZ,"PXBCPT-1") W DATA
 ;---------------
 I DATA["^P" G CPTX
 I DATA["^C" G CPTX
 ;
 I ((DATA="+")!(DATA="-")) D DISCPT4^PXBDCPT(DATA) G C
 ;
M ;--------If Multiple entries have been entered
 D ADDM^PXBPCPT1
 I $G(NF) G C1
 ;
DEL ;--------If Multiple deleting
 D DELM^PXBPCPT1
 I DATA["^C" G CPTX
 I $G(NF) G C1
 ;
 D MOD
 ;
LI ;--------If picked a line number display 
 ;
 I (DATA>0)&(DATA<(PXBCNT+1))&($L(DATA)'>$L(PXBCNT)) D
 .S XFLAG=1
 .D DISCPT4^PXBDCPT(PXBSAM(DATA,"LINE"))
 .D REVCPT^PXBCC(DATA,1)
 .S SELINE=DATA
 .F I=1:1:$L(DATA) W IOCUB,IOECH
 .S CPTQUA=$P($G(PXBSAM(DATA)),"^",2)
 .S DATA=$P($G(PXBSAM(DATA)),"^",1)
 .;I $G(Q)'>1 W DATA
 I $D(XFLAG),XFLAG=1 S Y=DATA G FIN
 ;
 ;
 ;--------If CPT is already in the file
 I $D(PXBKY(DATA)) D  I +PXEDIT<0 S DATA="^C" G C1
 .D DISCPT4^PXBDCPT(PXBSAM($O(PXBKY(DATA,0)),"LINE"))
 .K Q
 .D TIMES^PXBUTL(DATA)
 .S PXEDIT=$$MULTI(DATA) Q:+PXEDIT<0
 .I Q=1 D
 ..S LINE=$O(PXBKY(DATA,0))
 ..S XFLAG=1
 ..Q:PXEDIT="A"
 ..D REVCPT^PXBCC(LINE,1)
 ..S CPTQUA=$P($G(PXBSAM(LINE)),"^",2)
 ..S SELINE=$O(Q(0))
 .I Q>1,PXEDIT="E" D
 ..N PXPG
 ..S NLINE=0
 ..S PXPG=+$G(^TMP("PXBDCPT",$J,"START"))+10
 ..F  S NLINE=$O(Q(NLINE)) Q:NLINE=""  Q:PXBSAM(NLINE,"LINE")>PXPG  D
 ...D REVCPT^PXBCC(NLINE,1)
 I '$G(Q) K SELINE
 I PXEDIT="E",$D(Q),Q>1 D  G:DATA="^C" C1 G LI
 .D WHICH^PXBPWCH S:DATA["^" DATA="^C"
 I $D(XFLAG),XFLAG=1 S Y=DATA G FIN
 ;
 ;--------Need to do a DIC lookup on data
 I DATA'="??" D  G:DATA="^C" C I DATA="?" G C
 .D:DATA="?" EN1^PXBHLP0("PXB","CPT",1,"",1)
 I DATA="??" D  G:UDATA="^C" C1 G FIN
 .S DOUBLEQQ=1
 .D EN1^PXBHLP0("PXB","CPT","",1,2)
 .I $L(DATA,"^")>1 D
 ..S DATA=+$P(DATA,"^",2)_$S($P(DATA,U,3)]"":"-"_$P(DATA,U,3),1:"")
 ..D MOD
 ..S Y=DATA
 .S:$G(UDATA)="" UDATA="^C"
 .S:UDATA="^C" (DATA,EDATA,Y)=UDATA
 ;
 ;--If a "?" is NOT entered during lookup
 S FROM="CPT",(VAL,Y)=$P($P($$DOUBLE1^PXBGCPT2(FROM),"^",2),"--",1)
 S (X,DATA,EDATA)=VAL,DIC=81,DIC(0)="MZ",DIC("S")="I $P($$CPT^ICPTCOD(Y,IDATE),U,7)" D ^DIC
 I Y<1 S DATA="^C" G C1
 ;
 ;--If Y is good and already in file...
 I $D(Y),$D(PXBKY(Y)) W IORC,IOCUU,IOEDEOP,! D
 .D DISCPT4^PXBDCPT($O(PXBKY($P(Y,"^",2),0)))
 .S LINE=$O(PXBKY($P(Y,"^",2),0)) D REVCPT^PXBCC(LINE,1)
 .S CPTQUA=$P($G(PXBSAM(LINE)),"^",2)
 ;
 ;
FIN ;--FINISH CPT
 I $G(SELINE) S $P(REQE,"^",1)=$P($G(PXBSAM(SELINE)),"^",3)
 I $P(REQE,"^",1)="" S $P(REQE,"^",1)="...No Provider Selected..."
 I $L(Y,"^")'>1 S X=Y,DIC=81,DIC(0)="ZM",DIC("S")="I $P($$CPT^ICPTCOD(Y,IDATE),U,7)" D ^DIC
 I Y<0 D HELP^PXBUTL0("CPTM") G C
 S OK=$$CPTOK^PXBUTL(+Y,IDATE) D  G:+OK=0 C
 .I +OK=0 W IOCUF,IOCUF,IORVON,"INACTIVE!--",IORVOFF D HELP1^PXBUTL1("CPTI") ;--HELP
 S CPT=Y(0)
 N PXINF S PXINF=$$CPT^ICPTCOD(+Y,IDATE),$P(CPT,U,2)=$P(PXINF,U,3)
 S ^DISV(DUZ,"PXBCPT-1")=$P(CPT,"^",1)
 I $D(PXBNCPT) S PXBNCPTF=1
 I $D(PXBKY(Y(0,0))),$G(SELINE) D
 .S $P(REQI,"^",8)=$O(PXBSKY(SELINE,0))
 .S PREDOC=$P(PXBSAM(SELINE),"^",3)
 .I $D(PXBPRV($P(REQE,"^",1),$P(CPT,"^",1))) D
 ..Q:$P(REQI,"^",8)]""
 ..S $P(REQI,"^",8)=$O(PXBPRV($P(REQE,"^",1),$P(CPT,"^",1),0))
 .I $D(PXBPRV($P(REQE,"^",1))) D
 ..S CPTQUA=$P(PXBSAM($O(PXBPRV($P(REQE,"^",1),$P(CPT,"^",1),$O(PXBPRV($P(REQE,"^",1),$P(CPT,"^",1),0)),0))),"^",2)
 I $D(PXBKY(Y(0,0))),'$G(SELINE) D
 .;S $P(REQI,"^",8)=$O(PXBSKY($O(PXBKY(Y(0,0),0)),0))
 .S PREDOC=$P(PXBSAM($O(PXBKY(Y(0,0),0))),"^",3)
 .I $D(PXBPRV($P(REQE,"^",1),$P(CPT,"^",1))) D
 ..S $P(REQI,"^",8)=$O(PXBPRV($P(REQE,"^",1),$P(CPT,"^",1),0))
 .I $D(PXBPRV($P(REQE,"^",1),$P(CPT,"^",1))) D
 ..S CPTQUA=$P(PXBSAM($O(PXBPRV($P(REQE,"^",1),$P(CPT,"^",1),$O(PXBPRV($P(REQE,"^",1),$P(CPT,"^",1),0)),0))),"^",2)
 S $P(REQI,"^",3)=+Y
 S $P(REQE,"^",3)=$P(CPT,"^",1)_"-- "_$P(CPT,"^",2)
 S PXBNCPT($P(CPT,"^",1))=$P(REQI,"^",8)
 S:$P(REQI,"^",8)]"" PXBNCPT($P(CPT,"^",1),$P(REQI,"^",8))=""
 ;PX124 adds to REQ*
REST I $P(REQI,U,8) D
 .N CTR,VAL,IEN
 .S IEN=$P(REQI,U,8)
 .S $P(REQI,U,13,19)=$P($G(^AUPNVCPT(IEN,0)),U,9,15)
 .S $P(REQI,U,12)=$P($G(^AUPNVCPT(IEN,0)),U,5)
 .F CTR=12:1:19 D
 ..S VAL=$P(REQI,U,CTR)
 ..S:VAL VAL=$$ICDDX^ICDCODE(VAL,IDATE),$P(REQE,U,CTR)=$P($G(VAL),U,2)_" --"_$P($G(VAL),U,4)
 .S VAL=$P($G(^AUPNVCPT(IEN,12)),U,2),$P(REQI,U,22)=VAL
 .S:VAL $P(REQE,U,22)=$P($G(^VA(200,VAL,0)),U,1)
 ;
CPTX ;--CPT Exit and cleanup
 I $P(REQE,"^",1)="" S $P(REQE,"^",1)="...No Provider Selected..."
 I $G(WHAT)="INTV",DATA="^" S PXBEXIT="^^"
 I $D(PXBRRR) S DATA="^"
 I $D(PREDOC) D
 .I PREDOC]""&($P(REQE,"^",1)'[PREDOC) W !,IOINHI,"--WARNING!",IOINLOW," Currently stored Provider of service:-",IOINHI,PREDOC,IOINLOW D
 ..I '$D(PXBPRV($P(REQE,"^",1),$P(CPT,"^",1))) S $P(REQI,"^",8)=""
 K PXBDPRV,PREDOC
 W IOEDEOP
 Q
MOD ;---Separate CPT modifiers from CPT codes in entry string, if entered
 I DATA?1.N1"-".NE D
 .S PXMODSTR=$P(DATA,"-",2)
 .S (DATA,EDATA)=$P(DATA,"-",1)
 Q
 ;
MULTI(CPTCD) ;--Prompt user to Edit existing CPT code or Add as new entry
 ;
 N DIR,DA,X,Y
 S DIR(0)="SB^E:EDIT;A:ADD"
 S DIR("A")="Do you wish to (E)dit or (A)dd"
 ;PX*2.0*132
 I (($E(CPTCD)?1N)&($D(^IBE(357.69,+CPTCD))))!(($E(CPTCD)?1A)&($D(^IBE(357.69,CPTCD)))) D
 .S DIR(0)="SB^E:EDIT",DIR("A")="You may only (E)dit this code, no duplicate E&M codes allowed."
 S DIR("A",1)="CPT "_CPTCD_" already on file for this Encounter"
 D ^DIR
 I Y']""!(Y="^") Q -1
 Q Y
