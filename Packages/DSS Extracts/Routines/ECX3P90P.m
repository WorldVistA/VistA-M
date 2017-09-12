ECX3P90P ;ALB/JAP - National Clinic Update ;DEC 06, 2005
 ;;3.0;DSS EXTRACTS;**90**;Dec 22, 1997
 ;
ADD7272 ;** Add entries to file #727.2
 ;ECXX is in format: ien;test^source
 N ECX,ECXX,DA,DIC,DIE,DR,DINUM,X,Y,TEST,SOURCE
 D CLEAN2
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Adding entries to DSS LAB TESTS File (#727.2)...")
 D MES^XPDUTL(" ")
 S $P(^DD(727.21,.01,0),U,5)=""
 F ECX=1:1 S ECXX=$P($T(NEW7272+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECXDA=$P(ECXX,";",1),ECXX=$P(ECXX,";",2)
 .Q:'$D(^ECX(727.2,1))
 .I $D(^ECX(727.2,1,1,0)),'$D(^ECX(727.2,1,1,ECXDA,0)) D
 ..S TEST=$P(ECXX,U,1),SOURCE=$P(ECXX,U,2)
 ..S DA(1)=1,DIC("P")=$P(^DD(727.2,1,0),U,2),DINUM=ECXDA
 ..S X=TEST,DIC="^ECX(727.2,1,1,",DLAYGO=727.21,DIC(0)="LX",DIC("DR")="2///^S X=SOURCE"
 ..K DD,DO D FILE^DICN K DLAYGO
 ..D MESS
 S $P(^DD(727.21,.01,0),U,5)="K X"
 Q
 ;
MESS ;** Add message
 N ECXADMSG
 S ECXADMSG=" "_TEST
 D MES^XPDUTL(ECXADMSG)
 S ECXADMSG="     added as record #"_ECXDA_"."
 D MES^XPDUTL(ECXADMSG)
 D MES^XPDUTL(" ")
 Q
 ;
MESS2 ;** Add message
 N ECXADMSG
 S ECXADMSG=" "_A1_" - "_A3
 D MES^XPDUTL(ECXADMSG)
 S ECXADMSG="     added as record #"_ECXDA_"."
 D MES^XPDUTL(ECXADMSG)
 D MES^XPDUTL(" ")
 Q
 ;
CLEAN2 ;delete records added to file #727.2
 N ECX,X,Y,DA,DIK,DIC,JJ,SS
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" This subroutine will delete those entries in file #727.2,")
 D MES^XPDUTL(" DSS LAB TESTS File, which were added by patch ECX*3.0*87.")
 D MES^XPDUTL(" ")
 ;I $E(IOST)="C" D  Q:'Y
 ;.S SS=22-$Y F JJ=1:1:SS W !
 ;.K X,Y
 ;.S DIR(0)="E" W ! D ^DIR K DIR
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Deleting...")
 D MES^XPDUTL(" ")
 F ECX=60:1:71 D
 .S DA=ECX,DA(1)=1,DIK="^ECX(727.2,1,1,"
 .D ^DIK
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Done.")
 D MES^XPDUTL(" ")
 Q
 ;
NEW7272 ;new records for file #727.2
 ;;60;BILIRUBIN, DIRECT^B
 ;;61;C REACTIVE PROTEIN^B
 ;;62;C REACTIVE PROTEIN HS^B
 ;;63;CALCIUM SERUM^B
 ;;64;CARBON DIOXIDE^B
 ;;65;CHLORIDE^B
 ;;66;CREATININE EGFR^B
 ;;67;B NATRIURETIC PEPTIDE^B
 ;;68;O2 SATURATION^B
 ;;69;PO2^B
 ;;70;PCO2^B
 ;;71;TOTAL PROTEIN^B
 ;;QUIT
