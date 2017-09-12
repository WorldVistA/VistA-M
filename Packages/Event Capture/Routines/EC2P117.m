EC2P117 ;ALB/DE - EC National Update ; 10/4/12 11:00am
 ;;2.0;EVENT CAPTURE;**117**;;Build 6
 ;
 ;this routine is used as a post-init in a KIDS build
 ;to modify the EC National Procedure file #725
 ;and the Medical Specialty file #723
 ;
 Q
 ;
START ; entry point for post-init
 ;
 D ADDPROC
 D ADDSPEC
 Q
 ;
ADDPROC ;* add procedure to national procedure file
 ;
 ;  Some routine structure is left in place, in the event, additional EC National
 ;  Procedures are desired before the patch is released.
 ;
 ;  ECXX is in format:
 ;   NAME^NATIONAL NUMBER^CPT CODE^FIRST NATIONAL NUMBER SEQUENCE
 ;   LAST NATIONAL NUMBER SEQUENCE
 ;
 N ECX,ECXX,ECDINUM,NAME,CODE,CPT,COUNT,X,Y,DIC,DIE,DA,DR,DLAYGO,DINUM
 N ECADD,ECBEG,ECEND,CODX,NAMX,ECSEQ,LIEN,STR,CPTN,STR
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Adding new procedures to EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 S ECDINUM=$O(^EC(725,9999),-1),COUNT=$P(^EC(725,0),U,4)
 F ECX=1:1 S ECXX=$P($T(NEW+ECX),";;",2) Q:ECXX="QUIT"  D
 .S NAME=$P(ECXX,U,1),CODE=$P(ECXX,U,2),CPTN=$P(ECXX,U,3),CODX=CODE
 .S CPT=""
 .I CPTN'="" S CPT=$$FIND1^DIC(81,"","X",CPTN) I +CPT<1 D  Q
 ..S STR="   CPT code "_CPTN_" not a valid code in CPT File."
 ..D MES^XPDUTL(" ")
 ..D BMES^XPDUTL("   ["_CODE_"] "_STR)
 .S ECBEG=$P(ECXX,U,4),ECEND=$P(ECXX,U,5),NAMX=NAME
 .I ECBEG="" S X=NAME D FILPROC Q
 .F ECSEQ=ECBEG:1:ECEND D
 ..S ECADD="000"_ECSEQ,ECADD=$E(ECADD,$L(ECADD)-2,$L(ECADD))
 ..;S NAME=NAMX_ECADD,X=NAME,CODE=CODX_ECADD
 ..I $E(CODX,1,3)'="RCM" S NAME=NAMX_ECSEQ,X=NAME,CODE=CODX_ECADD
 ..E  S NAME=NAMX_$E(ECADD,2,99),X=NAME,CODE=CODX_$E(ECADD,2,99)
 ..D FILPROC
 S $P(^EC(725,0),U,4)=COUNT,X=$O(^EC(725,999999),-1),$P(^EC(725,0),U,3)=X
 Q
 ;
FILPROC ;file national procedures
 I '$D(^EC(725,"D",CODE)) D
 .S ECDINUM=ECDINUM+1,DINUM=ECDINUM,DIC(0)="L",DLAYGO=725,DIC="^EC(725,"
 .S DIC("DR")="1////^S X=CODE;4///^S X=CPT"
 .D FILE^DICN
 .I +Y>0 D
 ..S COUNT=COUNT+1
 ..D MES^XPDUTL(" ")
 ..S STR="   Entry #"_+Y_" for "_$P(Y,U,2)
 ..S STR=STR_$S(CPT'="":" [CPT: "_CPT_"]",1:"")_" ("_CODE_")"
 ..D BMES^XPDUTL(STR_"  ...successfully added.")
 .I Y=-1 D
 ..D MES^XPDUTL(" ")
 ..D BMES^XPDUTL("ERROR when attempting to add "_NAME_" ("_CODE_")")
 I $D(^EC(725,"DL",CODE)) D
 .S LIEN=$O(^EC(725,"DL",CODE,""))
 .D MES^XPDUTL(" ")
 .D BMES^XPDUTL("   Your site has a local procedure (entry #"_LIEN_") in File #725")
 .D BMES^XPDUTL("   which uses "_CODE_" as its National Number.")
 .D BMES^XPDUTL("   Please inactivate this local procedure.")
 .K Y
 Q
NEW ;national procedures to add;;descript^nation #^CPT code^beg seq^end seq
 ;;TELE ICU MONITOR PT SITE^TC001
 ;;QUIT
 ;
ADDSPEC ;add "PTSD" to medical specialty file
 ;
 N ECEXIST,ECFLAG,DIC,DA,DLAYGO,X,Y
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Adding new entry to the MEDICAL SPECIALTY File (#723)...")
 D MES^XPDUTL(" ")
 S (ECEXIST,ECFLAG)=0
 S ECEXIST=0 F  S ECEXIST=$O(^ECC(723,ECEXIST)) Q:ECEXIST'>0  I ^ECC(723,ECEXIST,0)="PTSD" S ECFLAG=1 Q
 I ECFLAG D  Q
  .D MES^XPDUTL(" ")
  .D BMES^XPDUTL("PTSD already exists")
  .D MES^XPDUTL(" ")
 S X="PTSD",DIC="^ECC(723,",DIC(0)="L",DLAYGO=723
 D FILE^DICN
 I +Y>0 D  Q
  .D MES^XPDUTL(" ")
  .D BMES^XPDUTL("   Entry #"_+Y_" for "_$P(Y,U,2)_"  ...successfully added.")
 I +Y=-1 D
  .D MES^XPDUTL(" ")
  .D BMES^XPDUTL("ERROR when attempting to add PTSD")
 Q
