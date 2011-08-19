PSGWXREF ;BHAM ISC/CML-Background job to re-index the "AMIS" xref for inventories, on-demands, and returns ; 08 Dec 93 / 9:03 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 ;ODT=ON-DEMAND DATE TIME;ADA=AOU INTERNAL #;DDA=ITEM INTERNAL #;ODA=ON-DEMAND INTERNAL #;RET=RETURN INTERNAL #;INV=INVENTORY INTERNAL #
 W !!,"This option will re-index the ""AMIS"" cross-reference for Inventories, On-Demand",!,"Requests, and Returns for a date range beginning with the START DATE you specify",!,"to the time the job runs."
 W !!?34,"** WARNING **",!?22,"Since this option is CPU intensive,",!?17,"it should be QUEUED to run in the ""off"" hours!",!!
ASK1 W ! S %DT("A")="Select START DATE for re-index: ",%DT(0)="-NOW",%DT="AETX" D ^%DT G:Y<0 QUIT S START=Y
ASK2 X ^DD("DD") W !!,"The ""AMIS"" cross-reference will now be re-indexed starting from ",Y,"."
 F JJ=0:0 W !!,"Are you SURE that is what you want to do" S %=2 D YN^DICN Q:%  D HELP
 G:%'=1 QUIT S ZTIO="",ZTRTN="START^PSGWXREF",ZTDESC="Re-index AR/WS 'AMIS' xref" S:$D(START) ZTSAVE("START")=""
 D ^%ZTLOAD,HOME^%ZIS I $D(ZTSK) W !!,"""AMIS"" cross reference re-indexing queued!" K ZTSK
 G QUIT
START ; Entry point from queue
 ; Delete existing "AMIS" xref
 L +^PSI(58.5,"AMIS")
 S SUB1="" F JJ=0:0 S SUB1=$O(^PSI(58.5,"AMIS",SUB1)) Q:SUB1=""  F KDT=START-.000001:0 S KDT=$O(^PSI(58.5,"AMIS",SUB1,KDT)) Q:'KDT  K ^(KDT)
 D INV,OND,RET
QUIT K %,%DT,%I,%H,ZTSK,ZTIO,JJ,ODT,ADA,DDA,ODA,DA,RET,INV,ANS,START,SUB1,KDT,QD,X,Y L -^PSI(58.5,"AMIS")
 S:$D(ZTQUEUED) ZTREQ="@" Q
INV ; Re-index Inventories
 F ADA=0:0 S ADA=$O(^PSI(58.1,ADA)) Q:'ADA  F DDA=0:0 S DDA=$O(^PSI(58.1,ADA,1,DDA)) Q:'DDA  F INV=0:0 S INV=$O(^PSI(58.1,ADA,1,DDA,1,INV)) Q:'INV  I $D(^PSI(58.19,INV,0)),$P(^(0),"^")'<START D SETINV
 Q
SETINV ;
 S QD=$P(^PSI(58.1,ADA,1,DDA,1,INV,0),"^",5),DA(2)=ADA,DA(1)=DDA,DA=INV,X=QD I X D QD^PSGWUTL
 Q
OND ; Re-index On-Demands
 F ODT=START-.000001:0 S ODT=$O(^PSI(58.1,"OND",ODT)) Q:'ODT  F ADA=0:0 S ADA=$O(^PSI(58.1,"OND",ODT,ADA)) Q:'ADA  F DDA=0:0 S DDA=$O(^PSI(58.1,"OND",ODT,ADA,DDA)) Q:'DDA  S ODA=$O(^PSI(58.1,"OND",ODT,ADA,DDA,0)) D SETOND
 Q
SETOND S QD=$P(^PSI(58.1,ADA,1,DDA,5,ODA,0),"^",2),DA(2)=ADA,DA(1)=DDA,DA=ODA,X=QD I X D OD^PSGWUTL
 Q
RET ; Re-index Returns
 F ADA=0:0 S ADA=$O(^PSI(58.1,ADA)) Q:'ADA  F DDA=0:0 S DDA=$O(^PSI(58.1,ADA,1,DDA)) Q:'DDA  F RET=0:0 S RET=$O(^PSI(58.1,ADA,1,DDA,3,RET)) Q:'RET  I $P(^(RET,0),"^")'<START D SETRET
 Q
SETRET ;
 S QD=$P(^PSI(58.1,ADA,1,DDA,3,RET,0),"^",2),DA(2)=ADA,DA(1)=DDA,DA=RET,X=QD I X D RET^PSGWUTL
 Q
HELP ;
 W !?5,"Enter 'YES' if you are satisfied with the selected date range.",!?5,"Enter 'NO' or '^' if you wish to abort the re-indexing." Q
