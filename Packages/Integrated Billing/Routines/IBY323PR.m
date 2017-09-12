IBY323PR ;ALB/OEC - IB*2*323 PRE-INSTALL ; 3/1/06 9:23am
 ;;2.0;INTEGRATED BILLING;**323**;21-MAR-94
 ;
DELENT ; Delete entries in file 364.7 to be included in build
 ;
 D BMES^XPDUTL("Deleting entries in file 364.7 included in build IB*2.0*323...")
 ;
 S DIK="^IBA(364.7,",DA=472 D ^DIK
 Q
 ;
