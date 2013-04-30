ORCPRE ; SLC/MKB - CPRS pre-init ;3/26/97  13:41
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
EN ; -- preinit cleanup
 D PREORB^ORB3C1 Q:$$VERSION^XPDUTL("OR")'<3
 ; -- Remove unused fields from #100
 N DA,DIK,DIU,ORU,DR,DIE
 S DIK="^DD(100,",DA(1)=100
 F DA=16,14,1.1,9,21.1,33.1,40,42,43,44,45,35 D ^DIK ; 0,3,4.1,5-nodes
 F DA=.02,4,6,23,.68 D ^DIK ; rebuild def'n w/o xrefs
 F DA=.61,.62,.63,.64,.65,.66,.67,.68,.69,.691,.6911,.6912,.6913 D ^DIK ; 6-node
 F DIU=100.008,100.09 S DIU(0)="S" D EN^DIU2
 S DIK="^DD(100.045,",DA(1)=100.045,DA=.04 D ^DIK
 ; -- Start over with Order Status, Nature of Order files
 F DIU=100.01,100.02 S DIU(0)="DT" D EN^DIU2
 ; -- Setup Display Group, Print Fields, Print Formats files
 D PRE^ORSET98,22
 Q
 ;
22 ;Clean out print file entries above 1000
 X ^%ZOSF("UCI") Q:Y="OEX,OER"
 N DIK,ORK,DA
 S DIK="^ORD(100.22,"
 ;F ORK=1000:0 S ORK=$O(^ORD(100.22,ORK)) Q:ORK<1  S DA=ORK D ^DIK
 ;S DIK="^ORD(100.23,"
 ;F ORK=1000:0 S ORK=$O(^ORD(100.23,ORK)) Q:ORK<1  S DA=ORK D ^DIK
 Q
