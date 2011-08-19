PRCFDSC1 ;WISC@ALTOONA/CTB-PRINT CI REGISTRATION SCREEN ;9/22/94  15:31
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N PRCFA,I,X,Y,% S %=1
 I $D(^PRC(442,D0))<10 S %=0 Q
 F I=0,1 S PRCFA("PO",I)=$S($D(^PRC(442,D0,I))'["0":^(I),1:"")
 F I=0,1 I PRCFA("PO",I)="" S %=0 K PRCFA("PO") Q
 Q:$G(%)=0
 S X=$O(^PRC(442,D0,5,0)),PRCFA("PO",5)=$S(X'?1.N:"",$D(^PRC(442,D0,5,X,0))#10:^(0),1:"")
 S PRCFA("VE")=+PRCFA("PO",1) F I=0,3,7 S PRCFA("VE",I)=""
 I PRCFA("VE")>0,$D(^PRC(440,PRCFA("VE")))>9 F I=0,3,7 S PRCFA("VE",I)=$G(^PRC(440,PRCFA("VE"),I))
 S PRCFOUT="PRCFA(""ORD""," K PRCFA("ORD") S PRCFA("TMP",1)=$P(PRCFA("VE",0),"^",2,5),PRCFA("TMP",2)=$P(PRCFA("VE",0),"^",6,8) D ^PRCFDADD
 S PRCFOUT="PRCFA(""PAY""," K PRCFA("PAY") S PRCFA("TMP",1)=$P(PRCFA("VE",7),"^",3,6),PRCFA("TMP",2)=$P(PRCFA("VE",7),"^",7,9) D ^PRCFDADD
 S PRCFX(1,"Purchase Order #: ~!")=$P(PRCFA("PO",0),"^")
 S Y=$P(PRCFA("PO",1),"^",15) D D^PRCFQ S PRCFX(2,"PO Date: ~?40")=Y
 S X=$P(PRCFA("PO",1),"^",6),DD=442,F=6.4 D ^PRCFU1 S PRCFX(3,"FOB: ~!!?2")=Y
 S Y="UNKNOWN",X=$P(PRCFA("PO",0),"^",2) I X>0,$D(^PRCD(442.5,+X,0)),$P(^(0),"^")]"" S Y=$P(^(0),"^")
 S PRCFX(4,"Method of Payment: ~?35")=Y
 S X=PRCFA("PO",5) S Y=$P(X,"^")_$S($P(X,"^")>0:"% ",1:" ")_$P(X,"^",2),PRCFX(5,"Terms: ~!")=Y
 S Y="UNKNOWN",X=$P(PRCFA("PO",1),"^",10) I X>0,$D(^VA(200,+X,0)),$P(^(0),"^")]"" S Y=$P(^(0),"^")
 S PRCFX(6,"P/A: ~?40")=Y
 S Y=$S($P(PRCFA("PO",0),"^",3)]"":$P(PRCFA("PO",0),"^",3),1:"UNKNOWN"),PRCFX(7,"FCP: ~!?2")=Y
 S PRCFX(8,"Vendor: ~!!?10")=$P(PRCFA("VE",0),"^")
 S PRCFX(9,"FMS Vendor Code: ~!!?1")=$P(PRCFA("VE",3),U,4)
 S PRCFX(10,"Alternate Address Indicator: ~?40")=$P(PRCFA("VE",3),U,5)
 S PRCFX(11,"Ordering Address: ~!!")="",PRCFX(12,"Payment Address: ~?40")=""
 S N=13 F I=1:1:8 I $D(PRCFA("ORD",I))!($D(PRCFA("PAY",I))) S PRCFX(N,"~!")=$G(PRCFA("ORD",I)),PRCFX(N+1,"~?40")=$G(PRCFA("PAY",I)),N=N+2
 D ^PRCFSCR
