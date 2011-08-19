PRCB1G ;WISC/PLT-IFCAP CURRENT DETAIL OCCRUAL ;12/2/97  14:03
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
EN ;year to date detail accrual
 N PRCA,PRCB,PRCQCD,PRCOPT,PRCRI,PRCDI,PRCDUZ,PRC,PRCDES,PRCTD
 N A,B,C
Q1 ;station
 S PRCF("X")="AS" D ^PRCFSITE G:'% EXIT
 S PRCRI(420)=+PRC("SITE"),PRCOPT=1
Q4 ;prompt fiscal year
 S A=$$DATE^PRC0C("T","E"),PRCTD=$P(A,"^",1,2)
 S E="O^2:4^K:X'?2N&(X'?4N) X",Y(1)="Enter a fiscal year in format: YY OR YYYY. For example: 96 or 1996"
 D FT^PRC0A(.X,.Y,"For Fiscal Year",E,$P(PRCTD,"^"))
 G:X["^"!(X="")!(Y'?2.4N) EXIT
 S:Y?2N Y=$$YEAR^PRC0C(Y) I Y>PRCTD D EN^DDIOL("Too early to run this report") G Q4
 S A=$$QTRDATE^PRC0D(Y,$S(+PRCTD=Y:$P(PRCTD,"^",2),1:4)),PRCA=A W "     Fiscal Year: ",$P(PRCA,"^")
 S $P(PRCA,"^",11)=$P(PRCA,"^",8)_"-"_PRC("SITE")
 I $O(^PRCH(440.6,"ST","N~",0)) D EN^DDIOL("Warning: An unregistered card exists in your file. Contact the P.C. Coordinator.")
Q5 D YN^PRC0A(.X,.Y,"Ready to Print","O","NO")
 I X["^"!(X="")!'Y G Q4
 D ACCR
 D EN^DDIOL(" "),EN^DDIOL(" ") G Q4
 ;
EXIT QUIT
 ;
 ;
ACCR ;start accrual
 N PRCDUZ
 S PRCDUZ=DUZ
 S ZTDESC="IFCAP YTD Detail Accrual for Fiscal Year: "_$P(PRCA,"^")
 S PRCDES=ZTDESC
 S ZTRTN="TMEN^PRCB1G1" F A="PRCOPT","PRCA","PRCTD","PRCDUZ","PRCDES","DUZ*" S ZTSAVE(A)=""
 D ^PRCFQ
 QUIT
 ;
