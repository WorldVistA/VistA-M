ECX333PT ;ALB/JAM - PATCH ECX*3.0*33 Post-Init Rtn ; 06/07/00
 ;;3.0;DSS EXTRACTS;**33**;Jun 07, 2000
 ;
 ;post-init routine to add new entries to file 727.831 and add LAR codes
 ;
 D DOMADD
 D ADD7272
 Q
DOMADD ;* add entries to file 727.831
 ;
 ;  ECXX is in format:
 ;   TREATING SPECIALTY IEN TO ADD^DSS DOM CODE^IN/OUT CODE
 ;
 N ECX,ECXX,LOC,CODE,INOUT,X,Y,DIC,DA,DR,DLAYGO,DINUM
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Adding entries to DOM PRRTP SAARTP ETC File (#727.831)...")
 F ECX=1:1 S ECXX=$P($T(NEW+ECX),";;",2) Q:ECXX="QUIT"  D
 .S LOC=$P(ECXX,U),CODE=$P(ECXX,U,2),INOUT=$P(ECXX,U,3)
 .I '$D(^ECX(727.831,LOC)) D  Q
 ..S X=LOC,DINUM=X,DIC(0)="L",DLAYGO=727.831,DIC="^ECX(727.831,"
 ..S DIC("DR")="2////^S X=CODE;3////^S X=INOUT"
 ..D FILE^DICN I +Y>0 D  Q
 ...D BMES^XPDUTL("  Treating Specialty "_LOC_"  ...successfully added.")
 ..D BMES^XPDUTL("ERROR when attempting to add Treating Specialty "_LOC)
 .D BMES^XPDUTL("  Treating Specialty "_LOC_" already added.")
 Q
NEW ;treating speciality ien to add^dss dom code^in/out code
 ;;25^P^3
 ;;26^T^3
 ;;27^S^3
 ;;28^H^3
 ;;29^A^3
 ;;37^D^3
 ;;38^B^3
 ;;39^C^3
 ;;85^D^3
 ;;86^D^3
 ;;87^D^3
 ;;88^D^3
 ;;QUIT
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
 ;;41;HEPATITIS A AB^B
 ;;42;HEPATITIS A IGM AB^B
 ;;43;HEPATITIS A, IGG AB^B
 ;;44;BILIRUBIN, TOTAL^B
 ;;45;ALT (TRANSFERASE ALANINE AMINO)^B
 ;;46;HEPATITIS B CORE AB^B
 ;;47;HEPATITIS B E AG^B
 ;;48;PHOSPHATASE ALKALINE^B
 ;;49;ALBUMIN^B
 ;;QUIT
