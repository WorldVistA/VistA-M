SR160UT2 ;BIR/ADM - PATCH SR*3*160 PRE-INSTALL ACTION ;03/6/07
 ;;3.0; Surgery ;**160**;24 Jun 93;Build 7
PRE ;pre-install action for SR*3*160
 ; delete data from file 136.5  and re-initialize file
 K ^SRO(136.5) S ^SRO(136.5,0)="PERIOPERATIVE OCCURRENCE CATEGORY^136.5I^^"
 ;delete DD for modified fields #102, #269, #414 and #364
 F DA=102,269,414,364 S DIK="^DD(130,",DA(1)=130 D ^DIK
 Q
