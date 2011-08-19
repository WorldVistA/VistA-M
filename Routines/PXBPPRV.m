PXBPPRV ;ISL/JVS,ESW - PROMPT PROVIDER ; 7/12/07 11:14am
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**1,7,11,19,108,141,152,186**;Aug 12, 1996;Build 3
 ;
 ; VARIABLE LIST
 ; SELINE= Line number of selected item
 ;
PRV ;--PROVIDER
 I $D(PXBUT),$G(PXBUT) S PXBUT=0  ; patch *186*
 I $D(PXBNPRVL) W IOSC D LOC^PXBCC(2,0) W IOUON,"Previous Entry:   ",$G(PXBNPRVL(1)) F I=1:1:10 W " "
 I $D(PXBNPRVL) W IORC
 W IOUOFF
 N TIMED,EDATA,DIC,LINE,XFLAG,SELINE,UDATA,ECHO
 I '$D(^DISV(DUZ,"PXBPRV-4")) S ^DISV(DUZ,"PXBPRV-4")=" "
 I '$D(IOSC) D TERM^PXBCC
 S DOUBLEQQ=0
 S TIMED="I '$T!(DATA=""^"")"
P ;--Second Entry point
 W IOSC
 ;--DYNAMIC  HEADER--
 I '$D(CYCL) D
 .I PXBCNT=0,DOUBLEQQ=0,$G(WHAT)'["PRV" D LOC^PXBCC(1,10) W "...There are "_$G(PXBCNT)_" PROVIDER(S) associated with this encounter."
 .I PXBCNT=1,DOUBLEQQ=0,$G(WHAT)'["PRV" D LOC^PXBCC(1,10) W "...There is "_$G(PXBCNT)_" PROVIDER associated with this encounter."
 .I PXBCNT>1,DOUBLEQQ=0,$G(WHAT)'["PRV" D LOC^PXBCC(1,10) W "...There are "_$G(PXBCNT)_" PROVIDERS associated with this encounter."
 ;
 I $G(FROM)'="PL" D LOC^PXBCC(15,0)
 I $G(FROM)'["PRV" N PXBNPRVL
 I $D(FROM),FROM="PL" W IORC
 I $G(FROM)'="PL",PXBCNT>10&('$G(DOUBLEQQ)) W IOELEOL,!,"Enter '+' for next page, '-' for previous page."
 ;--Dynamic prompting for the provider--
 I '$D(^TMP("PXK",$J,"PRV")),'$D(FROM) W !,"Enter PROVIDER: " W IOELEOL
 I '$D(FROM),$D(^TMP("PXK",$J,"PRV")) W !,"Enter ",IOINHI,"NEXT",IOINLOW," PROVIDER: " W IOELEOL
 I $D(FROM),FROM="CPT",'$D(^TMP("PXK",$J,"PRV")) W IORC,!,"Enter PROVIDER associated with PROCEDURE: " W IOELEOL
 I $D(FROM),FROM="PRV" W !,"Enter PROVIDER: " W IOELEOL
 I $D(FROM),FROM="CPT",$D(^TMP("PXK",$J,"PRV")) W IORC,!,"Enter PROVIDER associated with PROCEDURES: " W IOELEOL
 I $D(FROM),FROM="PL"  W !,"Enter PROVIDER associated with PROBLEM: " W IOELEOL
 I $D(FROM),FROM="PL" S PXBDPRV="^"_$P($G(PRVDR("PRIMARY")),U)  ;;108
 ;I $D(PRVDR) S PXBDPRV="^"_$P(PRVDR("PRIMARY"),U) S:$G(PXBCNT)>1&($P($G(REQE),U)=0) D0=$P($G(PRVDR("PRIMARY")),U,3)
 I $D(PRVDR) S PXBDPRV="^"_$P(PRVDR("PRIMARY"),U),D0=$P($G(PRVDR("PRIMARY")),U,3)
 I $D(FROM),FROM="CPT",$P(REQI,U,1),$P(REQE,U,1)'["..." S $P(PXBDPRV,U,2)=$P(REQE,U,1)
 I $P($G(REQI),U,8)'="",$G(FROM)'="CPT" S D0=$P($G(^AUPNVCPT($P(REQI,U,8),12)),U,4),PXBDPRV="^"_$P(REQE,U)
 ; begin patch *186*
 ; W $P($G(PXBDPRV),"^",2) W:$D(PXBDPRV) " // ",IOELEOL
 W $P($G(PXBDPRV),"^",2) W:$D(PXBDPRV)&($G(PXBDPRV)'="^") " // ",IOELEOL
 ; end patch *186*
 ;
 R DATA:DTIME S (EDATA,ECHO)=DATA
P1 ;--Third entry point
 X TIMED I  S PXBUT=1 S:DATA="^" LEAVE=1 G PRVX
 I DATA?1.N1"E".NAP S DATA=" "_DATA
 I $L(DATA)>200 S (DATA,EDATA)=$E(DATA,1,199)
 I DATA?24.N S (DATA,EDATA)=$E(DATA,1,24)
 D CASE^PXBUTL
 ;---SPACE BAR
 I DATA=" ",$D(^DISV(DUZ,"PXBPRV-4")) S (DATA,EDATA)=^DISV(DUZ,"PXBPRV-4") W DATA
 ;-----------
 I DATA="^^" S PXBEXIT=0 G PRVX
 ;---I Prompt can jump to others put symbols in here
 I DATA["^P" G PRVX
 I DATA["^I" G PRVX
 ; PX*1.0*152 - need to flag if default has been chosen. PXBDPRV gets killed so can't be used as flag.
 N PXDEF152 S PXDEF152=0
 I DATA="",$D(PXBDPRV) S DATA=$P($G(PXBDPRV),"^",2),PXDEF152=1 I DATA="" S PXBUT=1 G PRVX
 I DATA="",'$D(PXBDPRV) S PXBUT=1 G PRVX
 ;
 I PXBCNT>10&((DATA="+")!(DATA="-")) D DPRV4^PXBDPRV(DATA) W IORC D WIN17^PXBCC(PXBCNT) G P
 ;
 K PRVN1 S VIEN=0 F I=1:1 S VIEN=$O(PXBSAM(VIEN)) Q:VIEN=""  S PRVN1=PXBSAM(VIEN),PRVN1($P(PRVN1,U,4))=PRVN1_"^"_VIEN
M ;--IF Multiple entries have been entered
 ;--CAN'T DO!!!!
 ;--IF Multiple deleting of entries
 D DELM^PXBPPRV1
 I $G(NF) G P1
 ;
LI ;--If picked a line number
 I (DATA>0)&(DATA<(PXBCNT+1))&($L(DATA)'>$L(PXBCNT)) S XFLAG=1 D REVPRV^PXBCC(DATA) S SELINE=DATA D
 .I $G(FROM)["PL" Q
 .I $G(FROM)["CPT"  K SELINE S DATA="NOT VALID" Q
 .F I=1:1:$L(DATA) W IOCUB,IOECH
 .S PRISEC=$P($G(PXBSAM(DATA)),U,2) S:PRISEC["PRI" FPRI=0
 .S DATA=$P($G(PXBSAM(DATA)),U,1)
 I $D(XFLAG),XFLAG=1 S Y=DATA G PFIN
 ;
 ;--If PRV is already in the file
 I DATA="" S PXBUT=1 G PRVX
 I $G(FROM)'="CPT",'$G(DOUBLEQQ),$D(PXBKY(DATA)) D
 .I PXBCNT>10 D DPRV4^PXBDPRV($O(PXBKY(DATA,0)))
 .K Q D TIMES^PXBUTL(DATA)
 .I Q=1 S LINE=$O(PXBKY(DATA,0)) S XFLAG=1 D:$G(FROM)'="PL" REVPRV^PXBCC(LINE) S PRISEC=$P($G(PXBSAM(LINE)),"^",2) I $P(PXBSAM(LINE),"^",2)["PRI" S FPRI=0
 .I Q>1 S NLINE=0 F  S NLINE=$O(Q(NLINE)) Q:NLINE=""  D REVPRV^PXBCC(NLINE)
 I $D(Q),Q>1 D WHICH^PXBPWCH G LI
 I $D(XFLAG),XFLAG=1 S Y=DATA S:"CPT:PRV"[FROM&($G(D0)>0) Y="`"_D0 G PFIN
 ;--Need to do a DIC lookup on data
 ;
 K FIRST
 I DATA'="??" D:DATA="?" EN1^PXBHLP0("PXB","PRV",1,"",1) G:DATA="^P" P I DATA="?" G P
 I DATA="??" S DOUBLEQQ=1 D EN1^PXBHLP0("PXB","PRV","",1,2) S:DATA="P" UDATA="^P" S:$L(DATA,"^")>1 (Y,DATA,EDATA)=$P(DATA,U,2) S:$G(UDATA)="" UDATA="^P" S:UDATA="^P" (DATA,EDATA,Y)=UDATA G:UDATA="^P" P1 G PFIN
 ;
 ;--If a "?" is NOT entered during lookup
 ;----PX*1.0*152
 ;----If PXDEF152 is 1 then the user has hit the enter key with a specific provider provided as the default.
 ;----There should be no need to prompt again.
 I PXDEF152 D
 .S X=DATA,DIC="^VA(200,",DIC(0)="O"
 .D ^DIC S VAL=Y
 .I Y<1 S PXDEF152=0
 ; begin patch *186*
 ; I 'PXDEF152 S FROM="PRV",(VAL,Y)=$$DOUBLE1^PXBGPRV2(FROM)
 I 'PXDEF152 N PXOFROM S PXOFROM=FROM D  S FROM=PXOFROM  ;save FROM
 . S FROM="PRV",(VAL,Y)=$$DOUBLE1^PXBGPRV2(FROM)
 . I Y<1,$G(ERROR)=1,$G(CYCL)=1 D
 . . D HELP1^PXBUTL1("CON") R X:DTIME
 . . I PXOFROM'="CPT" D LOC^PXBCC(3,1) W IOEDEOP D EN0^PXBDPRV K CYCL
 . . I PXOFROM="CPT" D LOC^PXBCC(4,1) W IOEDEOP N Y D HEADER^PXBMCPT2
 ; end patch *186*
 I Y<1 S DATA="^P",DOUBLEQQ=1 G P1
 ;S (X,DATA,EDATA)=$P(VAL,U,2),DIC="^VA(200,",DIC(0)="MZ" D ^DIC
 ; begin patch *186*
 ; S X="`"_+Y,(DATA,EDATA)=$P(VAL,U,2),DIC="^VA(200,",DIC(0)="MZ" D ^DIC
 ; I Y=-1 S PXBUT=1 G PRVX
 S DIC("S")="I $$ACTIVPRV^PXAPI(Y,$G(IDATE,DT))"
 S X="`"_+Y,(DATA,EDATA)=$P(VAL,U,2),DIC="^VA(200,",DIC(0)="MZ" D ^DIC
 I Y=-1 D  G PRVX
 . D LOC^PXBCC(16,0),HELP^PXBUTL0("PRVM")
 . D HELP1^PXBUTL1("CON") R X:DTIME
 . D LOC^PXBCC(3,1) W IOEDEOP
 . D LOC^PXBCC(15,0)
 . S DATA="^P",PXBUT=1,FIRST=1
 . D:FROM="CPT" HEADER^PXBMCPT2
 ; end patch *186*
 ;--If Y is good and already in file...
 ;I '$G(DOUBLEQQ),$D(Y),$D(PXBKY($P(Y,"^",2))) D
 I '$G(DOUBLEQQ),($P($G(Y),U)>0),$D(PRVN1($P(Y,U))) D
 .S LINE=$P(PRVN1($P(Y,U)),U,5)
 .S PRISEC=$P($G(PXBSAM(LINE)),"^",2) S:PRISEC["PRI" FPRI=0
 S PRV=Y(0)
 ;
PFIN ;--Finish the Provider
 I $L(Y,"^")'>1,$G(SELINE) S X="`"_$P(^AUPNVPRV($O(PXBSKY(SELINE,0)),0),"^",1),DIC="^VA(200,",DIC(0)="MZ" D ^DIC
 I $L(Y,"^")'>1,'$G(SELINE) S X=Y,DIC="^VA(200,",DIC(0)="MZ" D ^DIC
 I +Y<0 D HELP^PXBUTL0("PRVM") W IOCUU G P
 S PRV=Y(0)
 S PXBNPRV($P(PRV,U,1))=""
 S PXBNPRVL(1)=$P(PRV,U,1) S ^DISV(DUZ,"PXBPRV-4")=$P(PRV,U,1)
 I $D(PRVN1($P(Y,U))),$G(SELINE) S $P(REQI,U,7)=$O(PXBSKY(SELINE,0)),$P(REQI,U,2)=$P($G(PXBSAM(SELINE)),U,2)
 I $D(PRVN1($P(Y,U))),'$G(SELINE) S PRVN1=PRVN1($P(Y,U)) D
 .S $P(REQI,U,7)=$O(PXBSKY($P(PRVN1,U,5),0))
 .S PAT=$P(Y(0),U,1),ITEM=$P(PRVN1,U,5),$P(REQI,U,2)=$E($P(PRVN1,U,2),1),$P(REQE,U,2)=$P(PRVN1,U,2)
 S $P(REQI,U,1)=+Y
 I $P(REQI,U,2)']"" S $P(REQI,U,2)="S",$P(REQE,U,2)="SECONDARY"
 S $P(REQE,U,1)=$P(PRV,U,1)
 I '$D(REQI) S REQI=""
 ;---IF INACTIVE ISSUE A WARNING
 I DATA]"" D ACTIVE^PXBPPRV1 K DIR
PRVX ;--EXIT AND CLEAN UP
 K PRVN1,VIEN,D0
 I $G(WHAT)="INTV",DATA="^" S PXBEXIT="^^"
 I '$D(REQI) S REQI=""
 I '$D(REQE) S REQE=""
 I $P(REQE,U,1)="" S $P(REQE,U,1)="...No Provider Selected..."
 ; begin patch *186*
 ; I FROM="PRV",$L(EDATA)<40 D
 I "CPT:PL:PRV"[FROM,$L(EDATA)<40 D
 .F I=1:1:$L(ECHO) W IOCUB,IOELEOL
 .F I=1:1:$L(ECHO) W IOCUF
 .I $P(REQE,U,1)'["...No" W $P(REQE,U,1)
 Q
