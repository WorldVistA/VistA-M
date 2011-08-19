EC725U44 ;ALB/GTS/JAP/GT - EC National Procedure Update; 10/17/2006
 ;;2.0; EVENT CAPTURE ;**89**;8 May 96;Build 3
 ;
 ;this routine is used as a post-init in a KIDS build 
 ;to modify the EC National Procedure file #725
 ;
ADDPROC ;* add national procedures
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
FILPROC ;File national procedures
 I '$D(^EC(725,"D",CODE)) D
 .S ECDINUM=ECDINUM+1,DINUM=ECDINUM,DIC(0)="L",DLAYGO=725,DIC="^EC(725,"
 .S DIC("DR")="1////^S X=CODE;4////^S X=CPT"
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
 ;;OPT ASSMNT ONLY,1ST 10M^NU158^99211^
 ;;OPT ASSMNT ONLY,EA AD'L10M^NU159^^
 ;;IP INTERDISC IND VISIT,EA15M^NU160^^
 ;;QUIT
NAMECHG ;* change national procedure names
 ;
 ;  ECXX is in format:
 ;   NATIONAL NUMBER^NEW NAME
 ;
 N ECX,ECXX,ECDA,DA,DR,DIC,DIE,X,Y,STR
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Changing names in EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 F ECX=1:1 S ECXX=$P($T(CHNG+ECX),";;",2) Q:ECXX="QUIT"  D
 .I $D(^EC(725,"D",$P(ECXX,U,1))) D
 ..S ECDA=+$O(^EC(725,"D",$P(ECXX,U,1),0))
 ..I $D(^EC(725,ECDA,0)) D
 ...S DA=ECDA,DR=".01////^S X=$P(ECXX,U,2)",DIE="^EC(725," D ^DIE
 ...D MES^XPDUTL(" ")
 ...D MES^XPDUTL("   Entry #"_ECDA_" for "_$P(ECXX,U,1))
 ...D BMES^XPDUTL("      ... field (#.01) updated to  "_$P(ECXX,U,2)_".")
 .I '$D(^EC(725,"D",$P(ECXX,U,1))) D
 ..D MES^XPDUTL(" ")
 ..S STR="Can't find entry for "_$P(ECXX,U,1)
 ..D BMES^XPDUTL(STR_" ...field (#.01) not updated.")
 Q
 ;
CHNG ;name changes -national code #^new procedure name
 ;;NU014^MDS CARE PLAN DOC,5M
 ;;NU025^OPT INTERDISC GP,2-5PT,EA15M
 ;;NU026^OPT INTERDISC GP,6-10PT,EA15M
 ;;NU027^OPT INTERDISC GP,11-20PT,EA15M
 ;;NU028^OPT INTERDIS GP,>20PT,EA15M
 ;;NU033^IP GROUP,2-5PT,EA,30M
 ;;NU034^IP GROUP,6-10PT,EA,30M
 ;;NU035^IP GROUP,11-20PT,EA,30M
 ;;NU036^IP GROUP,>20PT,EA30M
 ;;NU042^OPT INTERDISC IND VISIT,EA15M
 ;;QUIT
