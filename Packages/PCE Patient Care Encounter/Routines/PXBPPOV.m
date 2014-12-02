PXBPPOV ;ISL/JVS - PROMPT POV ;24 Sep 2013  11:19 AM
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**11,28,92,121,149,124,170,182,199**;Aug 12, 1996;Build 51
 ;
 ; VARIABLE LIST
 ; SELINE= Line number of selected item
 ;
POV ;--DIAGNOSIS
 N PXACS,PXACSREC,PXDXDATE,PXICDDATA,PXICDROW
 S PXICDROW=15
 S PXDXDATE=$$CSDATE^PXDXUTL(PXBVST)
 S PXACSREC=$$ACTDT^PXDXUTL(PXDXDATE),PXACS=$P(PXACSREC,U,3)
 I PXACS["-" S PXACS=$P(PXACS,"-",1,2)
 I $D(PXBNPOVL) D LOC^PXBCC(2,0) W IOUON,"Previous Entry:   ",$G(PXBNPOVL(1)) F I=1:1:10 W " "
 W IOUOFF
 N CNT,DIC,EDATA,FPL,LINE,PXBEDIS,SELINE,TIMED,XFLAG
 I '$D(^DISV(DUZ,"PXBPOV-3")) S ^DISV(DUZ,"PXBPOV-3")="   "
 I '$D(IOSC) D TERM^PXBCC
 S DOUBLEQQ=0
 S TIMED="I '$T!(DATA=""^"")"
 S DIC("S")="I $P($$ICDDATA^ICDXCODE(""DIAG"",Y,PXDXDATE,""E""),U,10)"
P ;--Second Entry point
 W IOSC K FPL,EDATA,DATA
 ;---DYNAMIC HEADER---
 I '$D(CYCL) D
 .S CNT=+$O(PXBSAM(""),-1)
 .I CNT=0,DOUBLEQQ=0 D LOC^PXBCC(1,10) W "...There are 0 ",PXACS," CODES associated with this encounter."
 .I CNT=1,DOUBLEQQ=0 D LOC^PXBCC(1,10) W "...There is 1 ",PXACS," CODE associated with this encounter."
 .I CNT>1,DOUBLEQQ=0 D LOC^PXBCC(1,10) W "...There are ",CNT," ",PXACS," CODES associated with this encounter."
 D LOC^PXBCC(PXICDROW,0)
 I PXBCNT>10&('$G(DOUBLEQQ)) W !,"Enter '+' for next page, '-' for previous page."
 I '$D(^TMP("PXK",$J,"POV")) W !,"Enter ",PXACS," Diagnosis : ",$G(PXBDPOV) W:$D(PXBDPOV) " //" W IOELEOL
 I $D(^TMP("PXK",$J,"POV")) W !,"Enter ",IOINHI,"NEXT",IOINLOW," ",PXACS," Diagnosis : "_$G(PXBDPOV) W:$D(PXBDPOV) " //" W IOELEOL
 R DATA:DTIME S EDATA=DATA
P1 ;--Third entry point
 X TIMED I  S PXBUT=1,LEAVE=1,DATA="^" G POVX
 I DATA?1.N1"E".NAP S DATA=" "_DATA
 I DATA?24.N S (DATA,EDATA)=$E(DATA,1,24)
 I $L(DATA)>200 S (DATA,EDATA)=$E(DATA,1,199)
 D CASE^PXBUTL
 ;----SPACE BAR---
 I DATA=" ",$D(^DISV(DUZ,"PXBPOV-3")) S DATA=^DISV(DUZ,"PXBPOV-3") W DATA
 ;-----------------
 I DATA="^^" S PXBEXIT=0 G POVX
 ;---I Prompt can jump to others put symbols in here
 I DATA["^P" G POVX
 ;------PXBDPOV=DEFAULT POV---PX*1.0*182 - added variable EDATA
 I DATA="",$D(PXBDPOV) S DATA=$P($G(PXBDPOV),"--",1),EDATA=DATA
 I DATA="",'$D(PXBDPOV) S PXBUT=1,PXBSPL="",LEAVE=1 G POVX
 I PXBCNT>10&((DATA="+")!(DATA="-")) D DPOV4^PXBDPOV(DATA) G P
 ;
M ;--------IF Multiple entries have been entered
 D ADDM^PXBPPOV1
 I $G(NF) G P1
 ;
 ;--------IF Multiple deleting of entries
 D DELM^PXBPPOV1
 I $G(NF) G P1
 ;
LI ;--------If picked a line number
 I (DATA>0)&(DATA<(PXBCNT+1))&($L(DATA)'>$L(PXBCNT))&($D(PXBSAM(DATA))) D:PXBCNT>10 DPOV4^PXBDPOV(PXBSAM(DATA,"LINE")) S XFLAG=1 D REVPOV(DATA) S SELINE=DATA D
 .F I=1:1:$L(DATA) W IOCUB,IOECH
 .S PRISEC=$P($G(PXBSAM(DATA)),"^",4) S:PRISEC["PRI" FPRI=0
 .S DATA=$P($G(PXBSAM(DATA)),"^",1)
 I $D(XFLAG),XFLAG=1 S (Y,EDATA)=DATA G PFIN
LI1 ;
 ;--------If POV is already in the file
 I '$G(DOUBLEQQ),$D(PXBKY(DATA)) D
 .I PXBCNT>10 D DPOV4^PXBDPOV(PXBSAM($O(PXBKY(DATA,0)),"LINE"))
 .K Q D TIMES^PXBUTL(DATA)
 .I Q=1 S LINE=$O(PXBKY(DATA,0)) S XFLAG=1 D REVPOV(LINE) S PRISEC=$P($G(PXBSAM(LINE)),"^",2) S:PRISEC["PRI" FPRI=0
 .I Q>1 S NLINE=0 F  S NLINE=$O(Q(NLINE)) Q:NLINE=""  D REVPOV(NLINE)
 I $D(Q),Q>1 D WHICH^PXBPWCH G LI
 I $D(XFLAG),XFLAG=1 S Y=DATA G PFIN
 ;
 ;--------Need to do a DIC lookup on data
 I DATA'="??" D:DATA="?" EN1^PXBHLP0("PXB","POV",1,"",1) G:DATA="^P" P1 I DATA="?" G P
 I DATA="??" S DOUBLEQQ=1 D EN1^PXBHLP0("PXB","POV","",1,2) S:$L(DATA,"^")>1 (Y,DATA,EDATA)=$P($P(DATA,"^",2),"--",1) G:Y>1 PFIN G:Y?1A1.ANP PFIN I DATA<1 S DATA="^P" G P1
 ;
 ;--If a "?" is NOT entered during lookup
 D CLEAR^VALM1,FULL^VALM1   ; call to clear screen --  added in *199
 W "Searching for diagnosis codes...",! ; added in *199
 K X,DIC
 S X=EDATA
 S PXACSREC=$$ACTDT^PXDXUTL(PXDXDATE),PXACS=$P(PXACSREC,U,3)
 I DATA="???",$P(PXACSREC,U,1)'="ICD" D  G P1
 . D CLEAR^VALM1 S PXPAUSE=1 D QM3^PXDSLK S DATA="^P"
 I $P(PXACSREC,U,1)'="ICD" D
 . S PXDATE=PXDXDATE,PXDEF=$G(X),PXAGAIN=0 D ^PXDSLK I PXXX=-1 S Y=-1 Q
 . S Y($P(PXACSREC,U,2))=$P($P(PXXX,U,1),";",2)
 . S Y=$P(PXXX,";",1)_U_$P(PXXX,U,2)
 I $P(PXACSREC,U,1)="ICD" D
 . K DIC D CONFIG^LEXSET($P(PXACSREC,U,1),,PXDXDATE)
 . S DIC("A")="Select "_PXACS_" Diagnosis: "
 . S DIC="^LEX(757.01,",DIC(0)=$S('$L(X):"A",1:"")_"EQM"
 . D ^DIC
 I $G(X)="@" Q
 I Y=-1 S DATA="^P" G P1
 S WHAT=$G(Y($P(PXACSREC,U,2)))
 S (DATA,EDATA)=WHAT K Y
 S PXICDDATA=$$ICDDATA^ICDXCODE("DIAG",WHAT,PXDXDATE,"E")
 S Y=$S($P(PXICDDATA,U,10)=0:-1,1:$P(PXICDDATA,U,1,2))
 S Y(0)=$P(PXICDDATA,U,2,99)
 ;
 ;--If Y is good and already in file...
 I '$G(DOUBLEQQ),$D(Y),$D(PXBKY($P(Y,"^",2))) D
 .S LINE=$O(PXBKY($P(Y,"^",2),0)) ;---D REVPOV^PXBCC(LINE)
 .S PRISEC=$P($G(PXBSAM(LINE)),"^",4) S:PRISEC["PRI" FPRI=0
 S POV=Y(0)
 ;
PFIN ;--Finish the DIAGNOSIS
 I $L(Y,"^")'>1 S X=Y,DIC=80,DIC(0)="IZM",DIC("S")="I $P($$ICDDATA^ICDXCODE(""DIAG"",Y,PXDXDATE,$$IE^ICDEX(Y)),U,10)" D ^DIC
 I +Y<0 D HELP1^PXBUTL1("POV") S PXICDROW=19 G P
 S POV=Y(0)
 ;get the correct diagnosis descriptor
 N DXINF S DXINF=$$ICDDATA^ICDXCODE("DIAG",+Y,PXDXDATE,"I"),$P(POV,U,3)=$P(DXINF,U,4)
 S PXBNPOV($P(POV,"^",1))=""
 S PXBNPOVL(1)=$P(POV,"^",1) S ^DISV(DUZ,"PXBPOV-3")=DATA
 I $D(PXBKY($P(Y(0),"^"))),$G(SELINE) S $P(REQI,"^",9)=$O(PXBSKY(SELINE,0))
 I $D(PXBKY($P(Y(0),"^"))),'$G(SELINE) S $P(REQI,"^",9)=$O(PXBSKY($O(PXBKY($P(Y(0),"^"),0)),0))
 I +Y>0 S PXBEDIS=$P(DXINF,U,4)
 S $P(REQI,"^",5)=+Y,$P(REQI,"^",6)="S"
 S $P(REQE,"^",5)=$P(POV,"^",1)_" --"_$G(PXBEDIS),$P(REQE,"^",6)="SECONDARY"
POVX ;--EXIT AND CLEAN UP
 I $G(WHAT)="INTV",DATA="^" S PXBEXIT="^^"
 I '$D(REQE) S REQE=""
 I $P(REQE,"^",5)="" S $P(REQE,"^",5)="...No Diagnosis Selected..."
 W !! S VALMBCK="R"  ; added in *199 to improve display
 Q
REVPOV(LINE) ;--NEW Reverse video API for POV since Long Descriptions are
 ; multiple lines
 Q:$G(NOREV)=1
 N ENTRY,XLINE,COL
 S ENTRY=$G(PXBSAM(LINE)),XLINE=PXBSAM(LINE,"LINE")#11
 S XLINE=XLINE+(PXBSAM(LINE,"LINE")\11)
 S:XLINE=11 XLINE=1 S XLINE=XLINE+4
 S COL=4
 D LOC^PXBCC(XLINE,COL)
 W IORVON,$J($P($P(ENTRY,"^",1),".",1),4),".",$P($P(ENTRY,"^",1),".",2),IORVOFF
 D LOC^PXBCC(18,1)
 Q
 ;
