PXBPSTP ;ISL/JVS - PROMPT FOR STOP CODE ;7/24/96  09:55
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**11**;Aug 12, 1996
 ;
 ; VARIABLE LIST
 ; SELINE= LILine number of selected item
 ;
STP ;-----First Stop Code Entry point
 I $D(PXBNSTPL) D LOC^PXBCC(2,0) W IOUON,"Previous Entry:   ",$G(PXBNSTPL(1)) F I=1:1:10 W " "
 W IOUOFF
 N TIMED,EDATA,DIC,LINE,XFLAG,SELINE,NOT,STOPC,STOPI
 I '$D(IOSC) D TERM^PXBCC
 S DOUBLEQQ=0,TIMED="I '$T!(DATA=""^"")",FROM="STP"
 I $P($G(^AUPNVSIT(PXBVST,0)),"^",22)&($P(^SC($P(^AUPNVSIT(PXBVST,0),"^",22),0),"^",7)) D
 .S STOPC=$P(^DIC(40.7,$P(^SC($P(^AUPNVSIT(PXBVST,0),"^",22),0),"^",7),0),"^",2)
 .S STOPI=$P(^SC($P(^AUPNVSIT(PXBVST,0),"^",22),0),"^",7)
 S DIC("S")="I '$P(^DIC(40.7,Y,0),""^"",3)!($P(^DIC(40.7,Y,0),""^"",3)>$P(IDATE,""."",1))&($G(STOPI)'=Y)"
 ;
 ;
 D LOC^PXBCC(15,0)
S ;-----Second Stop Code Entry point
 D WIN17^PXBCC(PXBCNT)
 I PXBCNT>10 W !,"Enter '+' for next page, '-' for previous page."
 I '$D(PXKSTP) W !,"Enter a STOP CODE: " W IOELEOL
 I $D(PXKSTP) W !,"Enter ",IOINHI,"NEXT",IOINLOW," STOP CODE: " W IOELEOL
 R DATA:DTIME S EDATA=DATA
 ;
 ;
S1 ;-----Third Stop Code Entry point
 X TIMED I  S PXBUT=1 S:DATA="^" LEAVE=1 G STPX
 I DATA?1.N1"E".NAP S DATA=" "_DATA
 I $L(DATA)>200 S (DATA,EDATA)=$E(DATA,1,199)
 I DATA?24.N S (DATA,EDATA)=$E(DATA,1,24)
 D CASE^PXBUTL
 I DATA=$G(STOPC),DATA'="" W !,"You cannot select main STOP CODE "_$G(STOPC) G S
 ;---SPACE BAR--
 I DATA=" ",$D(^DISV(DUZ,"PXBPOV-6")) S (DATA,EDATA)=^DISV(DUZ,"PXBPOV-6") W DATA
 I DATA="^^" S PXBEXIT=0 G STPX
S2 ;-----Fourth Stop Code Entry point
 W IOEDEOP
 ;-----If this Prompt can jump to other prompts put symbols in here
 I DATA["^S" S PXBDIC=1 G STPX
 I DATA="" S PXBUT=1 G STPX
 ;
 ;
 I PXBCNT>10&((DATA="+")!(DATA="-")) D DSTP4^PXBDSTP(DATA) W IORC D WIN17^PXBCC(PXBCNT) G S
 ;
 ;
M ;-----IF Multiple entries can be added
 D ADDM^PXBPSTP1
 I $G(NF) G S1
 ;-----IF Multiple entries can be deleted
 D DELM^PXBPSTP1
 I $G(NF) G S1
 ;
LI ;-----If picked a line number--no for it reason at this time
 ;I (DATA>0)&(DATA<(PXBCNT+1))&($L(DATA)'>$L(PXBCNT)) S XFLAG=1 D:PXBCNT>10 DSTP4^PXBDSTP(DATA) S SELINE=DATA,HERE=1 D
 ;.F I=1:1:$L(DATA) W IOCUB,IOECH
 ;.S DATA=$P($G(PXBSAM(DATA)),"^",1)
 ;I $D(XFLAG),XFLAG=1 S Y=DATA K XFLAG G SFIN
 ;
 ;
 ;-----If Stop Code selected is already in the file
 I '$G(DOUBLEQQ),$D(PXBKY(DATA)) D
 .S HERE=1
 .I PXBCNT>10 D DSTP4^PXBDSTP($O(PXBKY(DATA,0)))
 .K Q D TIMES^PXBUTL(DATA)
 .I Q=1 S LINE=$O(PXBKY(DATA,0)) S XFLAG=1 D REVSTP^PXBCC(LINE)
 .I Q>1 S NLINE=0 F  S NLINE=$O(Q(NLINE)) Q:NLINE=""  D REVSTP^PXBCC(NLINE)
 I $D(Q),Q>1 D WHICH^PXBPWCH G LI
 I $D(XFLAG),XFLAG=1 S Y=DATA G SFIN
 ;
 ;
 ;-----If it is Needed to do a DIC lookup on data
 I '$D(PXBWIN) D WIN17^PXBCC(PXBCNT)
 ;
 ;-----If a ?? is entered by the user
 I DATA'="??" D:DATA="?" EN1^PXBHLP0("PXB","STP",1,"",1) G:DATA="^S" S1 I DATA="?" G S
 I DATA="??" S DOUBLEQQ=1 D EN1^PXBHLP0("PXB","STP","",1,2) S:$L(DATA,"^")>1 (Y,DATA,EDATA)=$P($P(DATA,"^",2),"--",1) G:Y>0 SFIN I DATA<1 S DATA="^S" G S2
 ;
 ;
 ;-----If a "?" is NOT entered and needs a lookup
 S (VAL,Y)=$$DOUBLE1^PXBGSTP2(WHAT) I Y<1 S DATA="^S" G S2
 S (X,DATA,EDATA)=$P($P(VAL,"^",2),"--",1),DIC=40.7,DIC(0)="MZ" D ^DIC
 ;
 ;
 ;
SFIN ;-----Finish up the Variables of the STOP CODE
 I $G(HERE) K HERE G STP
 I $L(Y,"^")'>1 S X=Y,DIC=40.7,DIC(0)="ZM" D ^DIC
 I +Y<0 D CPTMNO^PXBUTL0 G S ;-HELP MESSAGE'CPTM'IS OK
 S STP=Y(0)
 S PXBNSTP($P(Y(0),"^",2))=""
 S PXBNSTP($P(Y(0),"^",1))=""
 S PXBNSTPL(1)=$P(STP,"^",2) S ^DISV(DUZ,"PXBPOV-6")=$P(STP,"^",2)
 I $D(PXBKY($P(Y(0),"^"))),$G(SELINE) S $P(REQI,"^",11)=$O(PXBSKY(SELINE,0))
 I $D(PXBKY($P(Y(0),"^"))),'$G(SELINE) S $P(REQI,"^",11)=$O(PXBSKY($O(PXBKY($P(Y(0),"^"),0)),0))
 S $P(REQI,"^",10)=+Y
 S $P(REQE,"^",10)=$P(STP,"^",2)
 ;-----If the Stop code is inactive issur a warning
 I DATA]"" S NOT=$$ACTIVE^PXBPSTP1(REQI,REQE) I $G(NOT) K NOT D RSET^PXBDREQ("STP") G S
 I $D(PXBKY($P(STP,"^",2))) W "--"_$P(PXBSAM($O(PXBKY($P(STP,"^",2),0))),"^",2)
STPX ;-----Exit the routine and clean up the variabLES
 I $G(WHAT)="INTV",DATA="^" S PXBEXIT="^^"
 I '$D(REQE) S REQE=""
 Q
