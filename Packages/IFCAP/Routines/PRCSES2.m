PRCSES2 ;SF-ISC/KSS/LJP-X-REF SET STATEMENT FOR ITEM QTY ;9/17/92  3:40 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q:'$D(^PRCS(410,DA(1),"IT",DA,0))  Q:'$P(^(0),U,2)
 S E=0,E(1)="" S:'$D(^PRCS(410,DA(1),4)) ^(4)=""
 F E(0)=1:1 S E=$O(^PRCS(410,DA(1),"IT",E)) S:E?1N.N E(1)=E(1)+($P(^(E,0),U,2)*$P(^(0),U,7)) I E'?1N.N D PR1 K E Q
 K E Q
PR1 S ^PRCS(410,DA(1),4)=E(1)_U_$P(^PRCS(410,DA(1),4),U,2,99),E=DA,E(2)=DA(1),X=E(1),DA=DA(1) D PR2 S DA=E,DA(1)=E(2) Q
PR2 Q:$P(^PRCS(410,DA,4),U,3)'=""  S $P(^(4),U,8)=X D TRANS^PRCSES Q
OBL ;copy or null fields for 1358 adj in file 410
 N A,GOFLAG
 S A=+$G(^PRCS(410,DA,0))
 K PRCS(2) S (PRCS(1),PRCSI,GOFLAG)=0
 F PRCSI=0:0 S PRCS(1)=$O(^PRCS(410,"D",PRCX442,PRCS(1))) Q:PRCS(1)'>0  D  I GOFLAG S PRCS(2)="" Q
 .; additional checks added for checking FORM TYPE and FY
 .; X1 = FY from newly created adjustment
 .; x2 = FY from record being checked
 .S X2=$P($P(^PRCS(410,PRCS(1),0),U),"-",2)
 .S X2=$$YEAR^PRC0C(X2),X2=$P(X2,U)
 .S X2=$$DATE^PRC0C(X2,"E"),X2=$P(X2,U,7)
 .S X1=$P($P(^PRCS(410,DA,0),U),"-",2)
 .S X1=$$YEAR^PRC0C(X1),X1=$P(X1,U)
 .S X1=$$DATE^PRC0C(X1,"E"),X1=$P(X1,U,7)
 .D ^%DTC
 .I $D(^PRCS(410,PRCS(1),0)),$P(^(0),U,2)="O",+^(0)=A,$P(^(0),U,4)=1,X<1865 S GOFLAG=1
 .Q
 I '$D(PRCS(2)) K PRCS(1),PRCSI Q
 I $D(^PRCS(410,PRCS(1),11)),$P(^(11),U)]"" S ^PRCS(410,DA,11)=$P(^PRCS(410,PRCS(1),11),U),^PRCS(410,"J",$P(^(11),U),DA)=""
 I $D(^PRCS(410,PRCS(1),2)) S $P(^PRCS(410,DA,2),U)=$P(^PRCS(410,PRCS(1),2),U),^PRCS(410,"E",$E($P(^(2),U),1,30),DA)="" S:$D(^PRCS(410,PRCS(1),3)) $P(^PRCS(410,DA,3),U,4)=$P(^PRCS(410,PRCS(1),3),U,4)
 S:$P(^PRCS(410,PRCS(1),0),U,4)=1 PRCS58=1
 I $D(^PRCS(410,PRCS(1),3)) S $P(^PRCS(410,DA,3),U,2,3)=$P(^(3),U,2,3),^PRCS(410,"AC",$P(^(3),U,3),DA)=""
 I $D(^PRCS(410,PRCS(1),3)),$P(^(3),U,6)]"" S $P(^PRCS(410,DA,3),U,6)=$P(^(3),U,6),^PRCS(410,"AD",$P(^(3),U,6),DA)=""
 I $D(^PRCS(410,PRCS(1),3)),$P(^(3),U,8)]"" S $P(^PRCS(410,DA,3),U,8)=$P(^(3),U,8),^PRCS(410,"AP",$P(^(3),U,8),DA)=""
 K PRCS(1),PRCS(2),PRCSI Q
