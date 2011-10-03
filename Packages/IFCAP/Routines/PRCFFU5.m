PRCFFU5 ;WISC/SJG-OBLIGATION PROCESSING UTILITIES ;
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 QUIT
FMSFCP(REQST,SPFCP,MP) ;
 ; REQST - 2237 Request
 ; MP - Method of Processing
 ; SPFCP - Supply Fund Control Point
 ; FLAG - Flag to indicate if CP has been updated
 ;      - Flag = "Y" when FCP has been updated
 ;      - Flag = "N" when FCP has not been updated
 ;
 N FLAG S FLAG="N"
 ; if supp fund, if meth of proc=cert, if 2237 req on PO, then flag="Y"
 ; if supp fund, if meth of proc=cert, if no 2237 req on PO, then flag ="N"
 I SPFCP=2,MP=2 S FLAG=$S($G(REQST):"Y",1:"N")
 ;
 ; if supp fund, if meth of proc'=cert, if 2237 request on PO, then flag="N" 
 I SPFCP=2,MP'=2,$G(REQST) S FLAG="N"
 ;
 ; if not supp fund, if 2237 request on PO, then flag="Y"
 ; if not supp fund, if 2237 request not on PO, then flag="N"
 I SPFCP'=2 S FLAG=$S($G(REQST):"Y",1:"N")
 QUIT FLAG
 ;
ASKSITE(FLAG) ; Interface with GECS to prompt for station/fcp
 N X,Y S ERROR=0
 D ^PRCSUT
 I '$D(PRC("SITE")) S ERROR=1 G EXIT
 I '$D(PRC("CP")) S ERROR=1 G EXIT
 S BUDSTR=$$ACC^PRC0C(PRC("SITE"),$P(PRC("CP")," ",1))
EXIT QUIT
 ;
NODE22 ; Called from PRCH58OB to build Node 22 for 1358 Obligations
 K PRCTMP
 N DA S DIC=442,DA=+PO,DIQ="PRCTMP(",DR="3;3.4;4;4.4;13;13.05" D EN^DIQ1 K DIC,DIQ,DR
 K NODE S NODE=$G(^PRC(442,DA,22,0)) I NODE="" S ^PRC(442,DA,22,0)="^"_$P(^DD(442,41,0),U,2)
 S STR="3;3.4^4;4.4^13.05;13"
 F CTR=1:1:3 D
 .K SUBSTR
 .S SUBSTR=$P(STR,U,CTR)
 .S BOC=+$G(PRCTMP(442,DA,$P(SUBSTR,";",1)))
 .S AMT=$G(PRCTMP(442,DA,$P(SUBSTR,";",2)))
 .I BOC D
 ..S DA(1)=DA
 ..S DIC="^PRC(442,"_DA(1)_",22,",DIC(0)="L",X=BOC
 ..K DD,DO D FILE^DICN
 ..N DA S FMSL=CTR,DIE=DIC,DA=+Y,DR="1////^S X=AMT;2////^S X=FMSL" D ^DIE
 ..K X,Y,DIE,DIC,DR
 K PRCTMP,FMSL,NODE,STR,SUBSTR
 QUIT
BBFY(PO) ; Get FMS Beginning Budget Fiscal Year
 K PRCTEMP
 N DA,BBFY S DIC=442,DA=+PO,DIQ="PRCTEMP(",DIQ(0)="IEN",DR=26
 D EN^DIQ1 K DIC,DIQ,DR
 S BBFY=$G(PRCTEMP(442,+PO,26,"E")),BBFY=$TR(BBFY," ")
 K PRCTEMP
 Q BBFY
 ;
DELSCH(XDATE) ; Get the Delivery Date from the latest of either the P.O. 
 ; Delivery Date or the latest date in the Delivery Schedule
 N LOOP,LOOP1,LOOP2
 S DELSCH(9999999-DELDATE)="^^"_XDATE
 I $D(^PRC(442.8,"AC",PRCFA("REF"))) D
 .S LOOP=0 F  S LOOP=$O(^PRC(442.8,"AC",PRCFA("REF"),LOOP)) Q:LOOP'>0  D
 ..S LOOP1=0 F  S LOOP1=$O(^PRC(442.8,"AC",PRCFA("REF"),LOOP,LOOP1)) Q:LOOP1'>0  D
 ...S DELSCH("A",LOOP1)=^PRC(442.8,LOOP1,0)
 ...S YDATE=$P(DELSCH("A",LOOP1),U,3),DELSCH(9999999-YDATE)=DELSCH("A",LOOP1)
 S LOOP2="" S DELSCHL=$O(DELSCH(LOOP2))
 S XDATE=$P(DELSCH(DELSCHL),U,3)
 K DELSCH,DELSCHL
 Q XDATE
 ;
UPPER(X) ; Convert to 'UPPER' case
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
LOWER(X) ; Convert to 'lower' case
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
