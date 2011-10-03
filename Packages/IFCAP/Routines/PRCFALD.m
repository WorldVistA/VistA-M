PRCFALD ;WISC@ALTOONA/CTB-ROUTINE TO CREATE CURRENT YEAR YALD CODE ;10 Sep 89/3:08 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;VARIABLES ; PRC("CP")= CONTROL POINT NUMBER
 ;PRC("SITE")=STATION NUMBER
 ;PRC("FY")= CURRENT FISCAL YEAR
 ;APPROPRIATE YALD RETURNED IN PRCFA("YALD")
 ; "x" indicates current FY
 ; "y" indicates second FY
 K X,Y S PRCFA("YALD")=""
 I $D(PRC("CP")),$D(PRC("SITE")),PRC("CP")]"",PRC("SITE")]"",$D(^PRC(420,PRC("SITE"),1,PRC("CP"),0)) S X=^(0) S X=$P(^(0),U,2) K:X="" X
 I '$D(X) W $C(7),"ALD Code missing from Control Point File",!,"  PLEASE NOTIFY YOU COORDINATOR",! Q
 I '$D(^PRCD(420.3,X,0)) W "Invalid ALD Code "_X_" in Control Point "_PRC("CP")_" for station "_PRC("SITE")_".",!,"   PLEASE NOTIFY YOUR COORDINATOR",$C(7),! Q
 I $D(X),$D(^PRCD(420.3,X,0)) S X=$P(^PRCD(420.3,X,0),"^",4)
 D SE S PRCFA("YALD")=Y
 S:$D(PRCFA("YALD")) PRCFA("YALD")=$E(PRCFA("YALD"),1,2)_"."_$E(PRCFA("YALD"),3)_"."_$E(PRCFA("YALD"),4)
 S:'$D(PRCFA("YALD")) PRCFA("YALD")=""
SE Q:'$D(X)  S %X=X D:%X["x" X D:%X["y" Y S Y=%X K %X Q
X S %X=$P(%X,"x")_$E(PRC("FY"),2)_$P(%X,"x",2,99) Q
Y S %X=$P(%X,"y")_($E(PRC("FY"),2)+1)#10_$P(%X,"y",2,99) Q
DDATE ; PROMPT FOR 92160 DELIVERY DATE
 W !,"The first position indicates contract length and the second indicates",!,"contract beginning month.  Each position should be coded with an alpha",!,",character 'A' through 'M', omitting 'I'."
 W !!,"The values will be as follows:"
 S $P(LN,"_",65)="" W !,LN K LN S $P(LN,"-",65)=""
 W !?3,"MONTH",?15,"|",?27,"MONTH",?39,"|",?45,"LENGTH",!,LN
 W !?6,"A",?15,"|",?25,"October",?39,"|",?47,"01"
 W !?6,"B",?15,"|",?25,"November",?39,"|",?47,"02"
 W !?6,"C",?15,"|",?25,"December",?39,"|",?47,"03"
 W !?6,"D",?15,"|",?25,"January",?39,"|",?47,"04"
 W !?6,"E",?15,"|",?25,"February",?39,"|",?47,"05"
 W !?6,"F",?15,"|",?25,"March",?39,"|",?47,"06"
 W !?6,"G",?15,"|",?25,"April",?39,"|",?47,"07"
 W !?6,"H",?15,"|",?25,"May",?39,"|",?47,"08"
 W !?6,"J",?15,"|",?25,"June",?39,"|",?47,"09"
 W !?6,"K",?15,"|",?25,"July",?39,"|",?47,"10"
 W !?6,"L",?15,"|",?25,"August",?39,"|",?47,"11"
 W !?6,"M",?15,"|",?25,"September",?39,"|",?47,"12"
 W !,LN K LN W !,"[Example: CA = 3 month contract beginning in October.]" Q
