PRCFDSUS ;WISC@ALTOONA/CTB-SUSPENSION LETTER ;7/12/94  8:31 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;GENERATES SUSPENSION LETTER TO PRINTER IN PRCFD("PRINTER") (OPTIONAL)
 ;REQUIRES VARIABLE PRCF("CIDA")=INTERNAL NUMBER IN FILE 421.5
 S ZTSAVE("PRCF(""CIDA"")")="",ZTSAVE("PRCF(""CHECK"")")=""
 S ZTDESC="PAYMENT SUSPENSION LETTER",ZTRTN="DQ^PRCFDSUS"
 I $P($G(^PRCF(421.5,PRCF("CIDA"),0)),U,8)="" D VENED^PRCFDCI
 S:$D(PRCFD("PRINTER")) ZTIO=PRCFD("PRINTER") D ^PRCFQ Q
DQ D:$D(ZTQUEUED) KILL^%ZTLOAD
 N I,N,X,Y,Z I '$G(PRCF("CIDA")) S ERR=1 G ERR
 I $P($G(^PRCF(421.5,PRCF("CIDA"),0)),U,8)="" S ERR=2 G ERR
 S PRVEN=$P(^PRCF(421.5,PRCF("CIDA"),0),"^",8)
 I '$D(^PRC(440,PRVEN,0)) S ERR=3 G ERR
 I '$D(^PRC(440,PRVEN,7)) S ERR=4 G ERR
 S PRVEN(0)=^PRC(440,PRVEN,7),PRVEN=PRVEN_"^"_$P(^PRC(440,PRVEN,0),"^")
 S %=0 F I=7,8,9 I $P(PRVEN(0),"^",I)="" S %=1 Q
 I % S ERR=4 G ERR
 I IOM<80!(IOM>102) S ERR=5 G ERR
 S DIWL=$S(IOM=80:10,1:12),DIWR=$S(IOM=80:70,1:84),PRCTR=DIWR-DIWL\2
 D NOW^PRCFQ W @IOF,!!!,?(DIWR-$L(Y)-1),Y,!!!!!!!!!!
 W ?DIWL S X=$P(PRVEN,"^",2) D LC W X
 F I=3,4,5,6 I $P(PRVEN(0),"^",I)]"" S X=$P(PRVEN(0),"^",I) D LC W !?DIWL,X
 W !?DIWL S X=$P(PRVEN(0),"^",7) D LC S Y=X_", ",X=$P(^DIC(5,$P(PRVEN(0),"^",8),0),"^") D LC S Y=Y_X_"  "_$P(PRVEN(0),"^",9) W Y K X,Y
 W !! I $P(PRVEN(0),"^")]"" W ?DIWL,"ATTN: " S X=$P(PRVEN(0),"^") D LC W X
 W !! S DIWF="W"
 F I=0,1 S PRCI(I)=^PRCF(421.5,PRCF("CIDA"),I)
 S PRCINV=$P(PRCI(0),"^",3),X=$P(PRCI(0),"^",15)/100,X2="2$" D COMMA^%DTC S PRCPAID=X,X=$P(PRCI(1),"^",8)/100,X2="2$" D COMMA^%DTC S PRCCLAIM=X
 S X=$P(PRCI(1),"^",8)-$P(PRCI(0),"^",15)/100,X2="2$" D COMMA^%DTC S PRCDED=X
 S X="Your recent claim voucher - Invoice Number "_PRCINV_" - has been "
 I PRCF("CHECK") S X=X_"approved, and a check will be forwarded promptly."
 E  S X=X_"disapproved and no check will be issued."
 D DIWP^PRCUTL($G(DA)),^DIWW W !
 S X="As explained below it was necessary to make a deduction from the amount claimed.  If a credit memo is issued to clear your accounting records of this overcharge, DO NOT send us a copy." D DIWP^PRCUTL($G(DA)),^DIWW W !
 S X="Should you submit a reclaim voucher, please return this letter with it and also enclose a supporting statement or additional evidence substantiating your claim." D DIWP^PRCUTL($G(DA)),^DIWW
 W ! S $P(LINE,"_",DIWR-DIWL+1)="" W ?DIWL,LINE
 W !?DIWL,"Amount Claimed: ",?(PRCTR-2),"| Amount Deducted: ",?(PRCTR+21),"| Amount Approved:",!,?(PRCTR-2),"|",?(PRCTR+21),"|",!?DIWL,PRCCLAIM,?(PRCTR-2),"| ",PRCDED,?(PRCTR+21),"| ",PRCPAID
 ;F I=$X:-1:1 W @IOBS
 W !?DIWL,LINE,!!!
 F PRCX=0:0 S PRCX=$O(^PRCF(421.5,PRCF("CIDA"),4,PRCX)) Q:PRCX=""  S X=$S($D(^(PRCX,0)):^(0),1:"") D DIWP^PRCUTL($G(DA))
 D ^DIWW W !!?DIWL,"Sincerely,",!!!!
 S N="" F I=1:1 S N=$O(^PRC(411,$P(PRCI(1),"^",2),4,"B",N)) Q:N=""  I N["FISCAL" S N=$O(^(N,0)) Q
 D ADDR S $P(^PRCF(421.5,PRCF("CIDA"),1),"^",4)=DT
OUT K ADD,DIW,DIWF,DIWL,DIRW,DIWT,DN,ERR,PRCCLAIM,PRCDED,PRCF("CHECK"),PRCI,PRCINV,PRCTR,PRCX,PRIOP,PRVEN,X2,Z,ZTDESC,ZTRTN,ZTSAVE Q
ADDR Q:N=""  S ADD=^PRC(411,$P(PRCI(1),"^",2),4,N,0)
 F I=1:1:4 S X=$P(ADD,"^",I) I X]"" S Y="" D VA D:Y="" LC W !?DIWL,X
 S X=$P(ADD,"^",5) D LC S Y=X,X=$P(^DIC(5,$P(ADD,"^",6),0),"^") D LC
 S Y=Y_", "_X_"  "_$P(ADD,"^",7) W !?DIWL,Y
 Q
VA I "VAMC"[$P(X," ") S Y=$P(X," "),X=$P(X," ",2,99) D LC S X=Y_" "_X
 Q
LC F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)
 Q
ERR ;
 W !,"CERTIFIED INVOICE SUSPENSION LETTER ERROR REPORT",!!
 I ERR>1 W !?2,"Invoice Tracking ID # ",PRCF("CIDA"),":",!
 W !?2,$P($T(E+ERR),";",3),"."
 W !!! G OUT
E ;
 ;;No Invoice Tracking ID # - could not locate Invoice record
 ;;The Vendor has not been identified in this Invoice Tracking record
 ;;The Vendor record is missing or incorrectly identified in the Vendor file
 ;;The Vendor payment address is missing or incomplete
 ;;Printer right margin should be set between 80 and 102 for Suspension Letter
 ;;PRINTER MARGIN INAPPROPRIATE FOR SUSPENSION LETTER, RIGHT MARGIN SHOULD BE BETWEEN 80 AND 102 CHARACTERS
REP ;REPRINT SUSPENSION LETTER
 S PRCFD("PAY")="",DIC=421.5,DIC(0)="AEMNZ",DIC("S")="I $P(^(0),U,3)]"""""
 D ^DIC K DIC I Y<0 K PRCFD Q
 S PRCF("CIDA")=+Y,DIE="^PRCF(421.5,",DR="25//YES;23",DA=PRCF("CIDA") D ^DIE
 I $P($G(^PRCF(421.5,PRCF("CIDA"),0)),U,15) S PRCF("CHECK")=1 G RP
 S %A(1)="     The Invoice Tracking record for this claim voucher does not show"
 S %A(2)="     an amount approved for payment.  Does this mean that the claim voucher"
 S %A(3)="     has been disapproved and that no check will be issued",%=2,%A=" ",B=""
 D ^PRCFYN G ROUT:%<0 S PRCF("CHECK")=$S(%=1:0,1:1)
RP S %A="Are you ready to print the letter",%B="",%=1 D ^PRCFYN
ROUT I %'=1 S X=" Option Terminated.*" D MSG^PRCFQ G OUT^PRCFDE
 D V G REP
