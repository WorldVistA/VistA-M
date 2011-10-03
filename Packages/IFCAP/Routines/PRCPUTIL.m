PRCPUTIL ;(WIRMFO)/DXH,DGL - GIP utilities ; 10.7.99
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
QTY ; utility to maintain the quantities for selected Inventory Points
 ;  as they are replenished via receipts against a Purchase Order
 ;  line item which they are sharing with other Inventory Points
 ;  PRC*5*197
 ;       da(3)=>p.o.
 ;       da(2)=>item
 ;       da(1)=>date received
 ;       da=>inventory point
 N QTY,PRCP,PRCPDA
 S PRCP("IP")=$P(^PRC(442,DA(3),2,DA(2),3,DA(1),1,DA,0),U)
 S (QTY,PRCPDA)=0 F  S PRCPDA=$O(^PRC(442,DA(3),2,DA(2),3,PRCPDA)) Q:'PRCPDA  S PRCP("DT")=$O(^(PRCPDA,1,"B",PRCP("IP"),0)) D:PRCP("DT")
 . S QTY=QTY+$P(^PRC(442,DA(3),2,DA(2),3,PRCPDA,1,PRCP("DT"),0),U,2)
 S PRCP("LP")=$O(^PRC(442,DA(3),2,DA(2),5,"B",PRCP("IP"),0)) S:PRCP("LP") $P(^PRC(442,DA(3),2,DA(2),5,PRCP("LP"),0),U,4)=QTY
 Q
 ;
DISPIP(FCPDA) ; display inv pts for FCP
 I '$D(^PRC(420,+$G(PRC("SITE")),1,+FCPDA,7,0)) Q
 N I
 S I=0
 F  S I=$O(^PRC(420,"AF",+$G(PRC("SITE")),+FCPDA,I)) Q:'I   W !,?10,$P($G(^PRCP(445,I,0)),U,1)
 Q
 ;
DISPFCP(IP) ; display FCP for inv pt
 Q:'$O(^PRC(420,"AE",+PRC("SITE"),IP,0))
 N FCP
 S (FCP,CNT)=0
 W !!,"To make a change, first select the existing control point and 'unlink' it.",!,"Then select a new one if you want to."
 W !!,"Current selection:"
 F  S FCP=$O(^PRC(420,"AE",+PRC("SITE"),IP,FCP)) Q:'FCP  W:CNT ! W ?20,$P($G(^PRC(420,+PRC("SITE"),1,FCP,0)),U) S CNT=CNT+1
 Q
 ;
 ;PRCPUTIL
