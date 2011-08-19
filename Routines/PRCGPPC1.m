PRCGPPC1 ;WIRMFO@ALTOONA/CTB/WIRMFO/RHD - ARCHIVING & PURGING ENTRY POINTS ;12/10/97  10:55 AM
V ;;5.1;IFCAP;**95**;Oct 20, 2000
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;MUST BE CALLED FROM SPECIFIC ENTRY POINT
P4429(PO) ;given the external PO number, delete all entries in 442.9
 ;PO1 - full external PO number with a period and partial number
 ;DA  - record number for 442.9
 QUIT:PO=""
 N DIK,DA,PO1
 S PO1=PO_"."
 S DIK="^PRC(442.9,"
 F  S PO1=$O(^PRC(442.9,"B",PO1)) Q:PO1=""!($P(PO1,".")'=PO)  D
 . F  S DA=$O(^PRC(442.9,"B",PO1,0)) Q:'DA  D ^DIK
 . QUIT
 QUIT
P441(PRCHDA) ;given the internal PO number, delete its entries in file 441
 ;this gets the FCP and repetitive item number(s) for the PO, and
 ;deletes the PO from the item(s) in 441
 Q:'PRCHDA!('$D(^PRC(442,PRCHDA,0)))
 N PRCHFCP,PRCHITEM,X,DIK,DA
 S X=^PRC(442,PRCHDA,0),PRCHFCP=+$P(X,"^",1)_$P($P(X,"^",3)," ",1)
 Q:PRCHFCP=""
 S PRCHITEM=""
 F  S PRCHITEM=$O(^PRC(442,PRCHDA,2,"AE",PRCHITEM)) Q:'PRCHITEM  D
 .S DA=PRCHDA,DA(1)=PRCHFCP,DA(2)=PRCHITEM,DIK="^PRC(441,"_DA(2)_",4,"_DA(1)_",1,"
 .D ^DIK
 Q
DL424(PRC442) N PRC424,DA,DIK
 S PRC424=0 F  S PRC424=$O(^PRC(424,"C",PRC442,PRC424)) Q:PRC424'?1.N  D
 .D DL424D1 S DIK="^PRC(424,",DA=PRC424 D ^DIK
 .QUIT
 Q
DL424D1 ;
 N PRC424D1,DA,DIK
 S PRC424D1=0
 F  S PRC424D1=$O(^PRC(424.1,"C",PRC424,PRC424D1)) Q:PRC424D1'?1.N  D
 .S DA=PRC424D1,DIK="^PRC(424.1," D ^DIK
 .Q
 Q
