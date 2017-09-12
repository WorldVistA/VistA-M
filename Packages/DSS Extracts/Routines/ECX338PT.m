ECX338PT ;ALB/JAM,TMD - PATCH ECX*3.0*38 Post-Init Rtn ; 8/6/01 12:31pm
 ;;3.0;DSS EXTRACTS;**38**;Jun 07, 2000
 ;
 ;post-init routine to add new entry to DSS LAB TESTS file (#727.2)
 ;
 D ADD7272
 Q
ADD7272 ;add entries to file #727.2
 ;ECXX is in format: ien;test^source
 N ECX,ECXX,DA,DIC,DINUM,DIE,DR,X,Y,TEST,SOURCE,CNT
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Adding entries to DSS LAB TESTS File (#727.2)...")
 D MES^XPDUTL(" ")
 S $P(^DD(727.21,.01,0),U,5)="",CNT=0
 F ECX=1:1 S ECXX=$P($T(NEW7272+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECXDA=$P(ECXX,";",1),ECXX=$P(ECXX,";",2)
 .Q:'$D(^ECX(727.2,1))
 .I $D(^ECX(727.2,1,1,0)),'$D(^ECX(727.2,1,1,ECXDA,0)) D
 ..S CNT=CNT+1
 ..S TEST=$P(ECXX,U,1),SOURCE=$P(ECXX,U,2)
 ..S DA(1)=1,DIC("P")=$P(^DD(727.2,1,0),U,2),DINUM=ECXDA
 ..S X=TEST,DIC="^ECX(727.2,1,1,",DLAYGO=727.21,DIC(0)="LX",DIC("DR")="2///^S X=SOURCE"
 ..K DD,DO D FILE^DICN K DLAYGO
 ..D MES^XPDUTL(" ")
 ..D MES^XPDUTL("    Adding "_TEST_" as entry #"_ECXDA_"... ok.")
 ..D MES^XPDUTL(" ")
 I CNT=0 D
 .D MES^XPDUTL("    Entries already exist -- nothing added.")
 .D MES^XPDUTL(" ")
 S $P(^DD(727.21,.01,0),U,5)="K X"
 Q
 ;
NEW7272 ;new records for file #727.2
 ;;50;HEMATOCRIT^B
 ;;QUIT
