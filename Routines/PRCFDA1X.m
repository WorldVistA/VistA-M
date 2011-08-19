PRCFDA1X ;WISC@ALTOONA/CTB-PROCESS PAYMENT TO CAPPS ;11/30/93  11:45 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 I $D(PRC("SITE")),PRC("SITE")]"",$D(^PRC(411,PRC("SITE"),0)) S PRC("PARAM")=^(0)
 F I=0,1,2 S P(I)=$S($D(^PRCF(421.5,PRCF("CIDA"),I)):^(I),1:"")
 S PRCFX(1,"~")="CAPPS PAYMENT TRANSACTION",PRCFX(1.5,"Invoice ID#: ~?38")=$P(P(0),"^")
 S X=$P(P(0),"^",27),DD=421.5,F=.6 D ^PRCFU1 S PRCFX(2,"Document Type: ~!!")=$S(%:Y,1:"")
 S PRCFX(3,"Document Locator Number: ~?38")=$P(P(0),"^",2)
 S PRCFX(4,"Invoice Number: ")=$P(P(0),"^",3)
 S Y=$P(P(0),"^",4) D D^PRCFQ S PRCFX(5,"Date of Invoice: ~?38")=Y
 S Y=$P(P(0),"^",5) D D^PRCFQ S PRCFX(5.5,"Date Invoice Received: ")=Y
 S Y=$P(P(0),"^",21) D D^PRCFQ S PRCFX(5.7,"Date Goods/Services Received: ~?38")=Y
 S X=$P(P(0),"^",6),DD=421.5,F=4 D ^PRCFU1 S PRCFX(5.8,"Product Type: ~!")=$S(%:Y,1:"")
 S XX=$P(P(0),"^",8),PRCFX(6,"Vendor: ~!!")=$S(+XX=0:"",'$D(^PRC(440,XX,0))#2:"",1:$P(^(0),"^")) K XX
 S PRCFX(7,"FMS Vendor ID#: ~!")=$P(P(0),"^",10)
 S PRCFX(8,"Vendor Stub Name: ")=$P(P(0),"^",9)
 S PRCFX(9,"Total Payment: $ ~!!")=$J($P(P(0),"^",15)/100,0,2)
 S PRCFX(10,"Shipping: $ ")=$J($P(P(0),"^",14)/100,0,2)
 S PRCFX(11,"Discount %: ~!")=$S(+$P(P(0),"^",11)=0:"NET "_$P(P(1),"^",10),1:+$P(P(0),"^",11)_"% "_$P(P(0),"^",12)_" Days, NET "_$P(P(1),"^",10))
 S:$P(P(0),"^",26)]"" PRCFX(11.5,"Discount Amount: ")=$J($P(P(0),"^",26),0,2)
 S X=$P(P(0),"^",23),DD=421.5,F=20 D ^PRCFU1 S PRCFX(19,"Interest Indicator: ~!!")=$S(%:Y,1:"")
 S X=$P(P(0),"^",22),DD=421.5,F=19 D ^PRCFU1 S PRCFX(20,"Money Management Status: ")=$S(%:Y,1:"")
 S X=$P(P(0),"^",16),DD=421.5,F=14 D ^PRCFU1 S PRCFX(14,"Liquidation Code: ~!")=$S(%:Y,1:"")
 S PRCFX(15,"Sub-Account #1: ~!")=$P(P(0),"^",17) S PRCFX(16,"Liquidation Amt #1: $ ~?38")=$J($P(P(0),"^",19)/100,0,2)
 S PRCFX(17,"Sub-Account #2: ~!")=$P(P(0),"^",18) S PRCFX(18,"Liquidation Amt #2: $ ~?38")=$J($P(P(0),"^",20)/100,0,2)
 D ^PRCFSCR S %A="Are you ready to release this invoice to CAPPS",%B="",%=1 D ^PRCFYN
 I %'=1 S X="  <Action Terminated>*" D MSG^PRCFQ G OUT
 S PRCFA("TTF")="900.00",PRCFASYS="CAP" D TT^PRCFAC
 I %'=1 S X="Unable to select CAPPS transaction type 900.00.  Please try again." D MSG^PRCFQ G OUT
 I ^PRCF(421.5,PRCF("CIDA"),2),$P($P(^(2),"^",3),"-",2)]"" S PRCFA("REF")=$P($P(^(2),"^",3),"-",2)
 D NEWCS^PRCFAC I '$D(DA) S X="No new FMS document created - Files inaccessible at this time.*" D MSG^PRCFQ G OUT
 S X="Transferring invoice data to CAPPS transmittal document.*" D MSG^PRCFQ
 K F,T F I=0,1,2 S F(I)=$S($D(^PRCF(421.5,PRCF("CIDA"),I)):^(I),1:"")
 F I=0,1,6,100 S T(I)=$S($D(^PRCF(423,PRCFA("CSDA"),I)):^(I),1:"")
 S $P(T(100),"^",1,6)="C^"_$P(F(0),"^",2,6)
 S $P(T(100),"^",11,16)=$P(F(0),"^",11,16)
 S $P(T(100),"^",17,23)=$P(F(0),"^",17,23)
 F I=16,17,18 S $P(T(100),"^",I+12)=$P(F(1),"^",I)
 S $P(T(1),"^",18)=$P(F(0),"^",9),$P(T(6),"^",7)=$P(F(0),"^",10),$P(T(100),"^",27)=$P(F(0),"^",26)
 S $P(T(1),"^",8)=$P(F(0),"^",17),$P(T(1),"^",10)=$P(F(0),"^",18)
 S $P(T(100),"^",26)=$P(F(2),"^",2),$P(T(1),"^",16)="~"
 F I=0,1,6,100 S ^PRCF(423,PRCFA("CSDA"),I)=T(I)
 K F,T S PRCF("OUT")=""
 S PRCFA("PAYMENT")="" D ^PRCFACXM K PRCFA("PAYMENT")
 I $D(PRCFDEL)!$D(PRCFA("CSHOLD")) S X="Transmittal document was "_$S($D(PRCFDEL):"DELETED",1:"NOT TRANSMITTED")_".  All further action on this invoice is suspended.*"
 I  D MSG^PRCFQ K PRCFDEL,PRCFA("CSHOLD") S X=$P(^PRCF(421.5,PRCF("CIDA"),2),"^") I 1
 E  D
 .S DA=PRCF("CIDA"),MESSAGE=""
 .D REMOVE^PRCFDES2(DA),ENCODE^PRCFDES2(DA,DUZ,.MESSAGE)
 .K MESSAGE S X=20
 .Q
 K PRCF("OUT") D STATUS^PRCFDE1
X D OUT^PRCFDE K PRCFASYS G ^PRCFDA
OUT D OUT^PRCFDE K PRCFASYS Q
