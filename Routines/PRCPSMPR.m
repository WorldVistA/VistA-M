PRCPSMPR ;WISC/RFJ-receiving code sheets to isms                    ;28 May 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DQ ;  create/trans receiving code sheets to isms
 ;  poda=internal entry number for purchase order
 ;  partlda=internal entry number for partial
 N %,AVGCOST,COUNT,D,DATEDA,DATEDATA,DATEREC,I,ITEMDA,LASTCOST,LIDA,LINEDATA,NSN,PARTDATA,PARTIAL,PODATA,QTY,TOTCOST,UI,X,Y
 S PODATA=$G(^PRC(442,PODA,0)) Q:PODATA=""
 S PARTDATA=$G(^PRC(442,PODA,11,PARTLDA,0)) Q:PARTDATA=""
 S DATEREC=$P(PARTDATA,"^"),PARTIAL=$S($P(PARTDATA,"^",9)="F":"F",1:"P")
 ;  start gathering items received
 S COUNT=1 K ^TMP($J,"STRING")
 S LIDA=0 F  S LIDA=$O(^PRC(442,PODA,2,"AB",DATEREC,LIDA)) Q:'LIDA  S DATEDA=0 F  S DATEDA=$O(^PRC(442,PODA,2,"AB",DATEREC,LIDA,DATEDA)) Q:'DATEDA  S DATEDATA=$G(^PRC(442,PODA,2,LIDA,3,DATEDA,0)) I DATEDATA'="" D
 .   S LINEDATA=$G(^PRC(442,PODA,2,LIDA,0)) Q:LINEDATA=""
 .   S ITEMDA=+$P(LINEDATA,"^",5),NSN=$TR($$NSN^PRCPUX1(ITEMDA),"-"),UI=$TR($$UNITCODE^PRCPUX1($P(LINEDATA,"^",3)),"?")
 .   ;  determine quantity and total cost
 .   S QTY=$P(DATEDATA,"^",2),TOTCOST=$P(DATEDATA,"^",3)-$P(DATEDATA,"^",5)
 .   ;  lookup in transaction register for qty received and units
 .   S %=0 F  S %=$O(^PRCP(445.2,"C",$P(PODATA,"^"),%)) Q:'%  S D=$G(^PRCP(445.2,+%,0)) I $P(D,"^",5)=ITEMDA,$P(D,"^",2)=("RC"_$G(ORDERNO)) S X1=$P($P(D,"^",6),"/",2),X2=+$P(D,"^",7) S:$L(X1)=2 UI=X1 S:X2 QTY=X2 Q
 .   S TOTCOST=$TR($J(TOTCOST,0,2),"."),%=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0)),LASTCOST=$TR($J($P(%,"^",15),0,4),"."),AVGCOST=$TR($J($P(%,"^",22),0,4),".")
 .   S ^TMP($J,"STRING",COUNT)="PL^"_NSN_"^"_UI_"^"_QTY_"00^"_TOTCOST_"^"_LASTCOST_"^"_AVGCOST_"^"_PARTIAL_"^"_$P(LINEDATA,"^")_"^|",COUNT=COUNT+1
 I COUNT=1 Q
 ;
 ;  prcpwait used in routine prcpsmsp when retransmitting
 ;  isms code sheets
 I '$G(PRCPWAIT) D CODESHT^PRCPSMGO(PRC("SITE"),"REP",$P($P(PODATA,"^"),"-",2))
 Q
