PRCB1GE ;OI&T/PLT-LKG-YEAR TO DATE ACCRUAL EXTRACT ;11/5/21  10:09
V ;;5.1;IFCAP;**225**;Oct 20, 2000;Build 3
 ;Per VA Directive 6402, this routine should not be modified.
 QUIT  ;invalid entry
 ;
EN ;year to date detail accrual
 N PRCA,PRCRI,PRCDUZ,PRC,PRCTD,PRCF,%
 N A,B,C,E,X,Y
Q1 ;station
 S PRCF("X")="AS" D ^PRCFSITE G:'$G(%) EXIT
 S PRCRI(420)=+PRC("SITE")
Q4 ;prompt fiscal year
 S A=$$DATE^PRC0C("T","E"),PRCTD=$P(A,"^",1,2)
 S E="O^2:4^K:X'?2N&(X'?4N) X",Y(1)="Enter a fiscal year in format: YY OR YYYY. For example: 96 or 1996"
 D FT^PRC0A(.X,.Y,"For Fiscal Year",E,$P(PRCTD,"^"))
 G:X["^"!(X="")!(Y'?2.4N) EXIT
 S:Y?2N Y=$$YEAR^PRC0C(Y) I Y>PRCTD D EN^DDIOL("Too early to run this extract") G Q4
 S A=$$QTRDATE^PRC0D(Y,$S(+PRCTD=Y:$P(PRCTD,"^",2),1:4)),PRCA=A W "     Fiscal Year: ",$P(PRCA,"^")
 S $P(PRCA,"^",11)=$P(PRCA,"^",8)_"-"_PRC("SITE")
 I $O(^PRCH(440.6,"ST","N~",0)) D EN^DDIOL("Warning: An unregistered card exists in your file. Contact the P.C. Coordinator.")
Q5 ;
 D ACCR
 S:$D(ZTQUEUED) ZTREQ="@"
 ;
EXIT QUIT
 ;
 ;
ACCR ;start accrual
 N PRCDUZ,ZTRTN,ZTDESC,ZTSAVE,ZTIO,ZTSK
 S PRCDUZ=DUZ
 S ZTDESC="IFCAP YTD Detail Accrual for Fiscal Year: "_$P(PRCA,"^")
 S ZTIO=""
 S ZTRTN="TMEN^PRCB1GE1" F A="PRCA","PRCTD","PRCDUZ","DUZ*" S ZTSAVE(A)=""
 D ^%ZTLOAD
 D:$G(ZTSK) EN^DDIOL("Compilation is queued task #"_ZTSK,"","!!")
 QUIT
 ;
TASKED(PRCFY,PRCSITE) ; Module to task extraction from other application
 D EN^DDIOL("Generating YTD Accrual Data Extract...","","!!")
 N A,PRCTD,PRCA,PRCDUZ,ZTRTN,ZTDESC,ZTSAVE,ZTIO,ZTSK
 S PRCTD=$P($$DATE^PRC0C("T","E"),"^",1,2)
 S PRCA=$$QTRDATE^PRC0D(PRCFY,$S(+PRCTD=PRCFY:$P(PRCTD,"^",2),1:4))
 S $P(PRCA,"^",11)=$P(PRCA,"^",8)_"-"_PRCSITE
 S PRCDUZ=DUZ,ZTDESC="IFCAP YTD Detail Accrual for Fiscal Year: "_PRCFY
 S ZTIO="",ZTRTN="TMEN^PRCB1GE1"
 F A="PRCA","PRCTD","PRCDUZ","DUZ*" S ZTSAVE(A)=""
 D ^%ZTLOAD
 QUIT
