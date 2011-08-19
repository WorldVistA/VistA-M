PRCHRP1 ;WISC/KMB-PURCHASE CARD TRANS. STATUS ;9/25/96
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
OBL ;
 W @IOF W !!,"NOTE - You cannot use the PURCHASE CARD HOLDER field for lookups.",!! S PRCF("X")="S" D ^PRCFSITE G EXIT:'$D(PRC("SITE"))
 S DIC("A")="P.O./REQ. NO.: ",DIC(0)="AEMQZ",D="C",DIC("S")="I $P(^(0),""^"",2)=25",DIC="^PRC(442,"
 W !! D IX^DIC K DIC G EXIT:+Y<0  S (DA,ZIP)=+Y
 ;
 D DETAIL1
 W !,"Do you wish to print this report" S %=1 D YN^DICN I %'=1 G OBL
 S %ZIS("B")="",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="DETAIL^PRCHRP1",ZTSAVE("ZIP")="" D ^%ZTLOAD,^%ZISC G OBL
 D DETAIL,^%ZISC H 3 G OBL
DETAIL ;
 U IO
DETAIL1 ;
 S R=$G(^PRC(442,ZIP,0)),S=$G(^PRC(442,ZIP,1)),T=$G(^PRC(442,ZIP,23))
 W !,"Transaction Number: ",$P(R,"^"),?40,"FCP: ",$E($P(R,"^",3),1,30)
 S PP=$P($G(^PRC(442,ZIP,7)),"^") W !,"Transaction Status: ",$P($G(^PRCD(442.3,+PP,0)),"^")
 S Y=$P(S,"^",15),YY=$P(R,"^",10)
 D DD^%DT W !,"Date of Request: ",Y S Y=$P(R,"^",10) D DD^%DT W ?40,"Date Required: ",Y
 S VRR=$P($G(^PRC(440,+$P(S,"^"),0)),"^") I VRR="SIMPLIFIED",$P($G(^PRC(442,ZIP,24)),"^",2)'="" S VRR=$P($G(^PRC(442,ZIP,24)),"^",2)
 W !,"Vendor: ",VRR
 W !,"Committed (Estimated) Cost: ",$J($P(R,"^",15),0,2) S Y=YY D DD^%DT W ?40,"Date Committed: ",Y
 W !,"Purchase Card Amount: ",$J($P(R,"^",15),0,2) S YY=$P($G(^PRC(442,ZIP,12)),"^",3) S Y=YY D DD^%DT W ?40,"Date Signed: ",Y
 W !,"Transaction Amount: ",$J($P(R,"^",15),0,2),?40,"Accounting Data: ",$P(R,"^",4)
 ;
 W !!,"Originator of Request: ",$P($G(^VA(200,+$P(S,"^",10),0)),"^")
 W !,"Requesting Service: ",$P($G(^DIC(49,+$P(S,"^",2),0)),"^")
 K ^UTILITY($J,"W") S DIWL=1,DIWR=62,DIWF="",PRCSDY=8,PRCSI=0
 F PRCSJ=1:1 S PRCSI=$O(^PRC(442,ZIP,4,PRCSI)) Q:'PRCSI  S X=^(PRCSI,0) D DIWP^PRCUTL($G(DA))
 S I=$S($D(^UTILITY($J,"W",DIWL)):+^(DIWL),1:0)
 I I F J=1:1:I W ! W:J=1 "Comments:" W ?15,^UTILITY($J,"W",DIWL,J,0) S PRCSDY=PRCSDY+1
 W !,"Delivery Location: ",$P(S,"^",11)
 S SORT=$P(T,"^",13) I SORT'="" S PZ1=$P(SORT,";"),PZ2=$P(SORT,";",2),PZ3="^"_PZ2_PZ1_",0)" S SORT=$G(@PZ3) S SORT=$P(SORT,"^")
 W !,"Sort Group: ",SORT
 D CCDATA
 W ! QUIT
ITEM ;
 S COUNT=$P(R,"^",14) Q:COUNT=""
 D HEADER
 F FF=1:1:COUNT D
 .S QQ=$G(^PRC(442,ZIP,2,FF,0)) Q:QQ=""
 .W !,$P(QQ,"^",6),?12,"|",?50,"|",$P(QQ,"^",2),?60,"|",$P($G(^PRC(420.5,+$P(QQ,"^",3),0)),"^"),?70,"|",$P(QQ,"^",9)
 .S C1=0 I $G(^PRC(442,ZIP,2,FF,1,0))'="" F J=1:1 K ^UTILITY($J,"W") S C1=$O(^PRC(442,ZIP,2,FF,1,C1)) Q:+C1=0  D
 ..N L1,L2,L3 S DIWL=14,DIWR=48,DIWF=""
 ..S X=^PRC(442,ZIP,2,FF,1,C1,0) S:J=1 X=$P(^PRC(442,ZIP,2,FF,1,0),"^")_" "_X D DIWP^PRCUTL($G(ZIP))
 ..S Z=^UTILITY($J,"W",DIWL) W !
 ..I Z>1 F J=1:1:(Z-1) W !,?12,"|",^UTILITY($J,"W",DIWL,J,0),?50,"|",?60,"|",?70,"|" D:$Y>61 HEADER W !,?12,"|",?50,"|",?60,"|",?70,"|"
 ..I Z>1 W !,?12,"|",^UTILITY($J,"W",DIWL,Z,0),?50,"|",?60,"|",?70,"|" D:$Y>61 HEADER W !,?12,"|",?50,"|",?60,"|",?70,"|"
 ..I Z<2 W ?12,"|",^UTILITY($J,"W",DIWL,1,0),?50,"|",?60,"|",?70,"|" D:$Y>61 HEADER W !,?12,"|",?50,"|",?60,"|",?70,"|"
 QUIT
CCDATA ;
 S CCREC="" F  S CCREC=$O(^PRCH(440.6,"PO",ZIP,CCREC)) Q:CCREC=""  D
 .S CCSTR=$G(^PRCH(440.6,CCREC,0)) S Y=$P(CCSTR,"^",7) D DD^%DT W !,"Transaction date: ",Y,?35,"Credit card ref.#: ",$P(CCSTR,"^")
 .W !,"Amount: ",$P(CCSTR,"^",14)
 QUIT
EXIT K DA,PRCRI,CCREC,CCSTR,SORT,VRR,COUNT,FF,I,J,R,S,T,QQ,Y,YY,PP,PZ1,PZ2,PZ3,SORT,PRCSJ,PRCSI,PRCSDY,ZIP
 QUIT
HEADER ;
 I IO=IO(0) H 5
 W @IOF
 W !,?30,"ITEM INFORMATION"
 W !,"Transaction Number: ",$P(R,"^"),?40,"FCP: ",$E($P(R,"^",3),1,30),!
 F I=1:1:8 W "----------"
 W !,"STOCK NUMBER",?14,"ITEM DESCRIPTION",?51,"QUANTITY",?64,"U/I",?71,"UNIT COST",!
 F I=1:1:8 W "----------"
 Q
