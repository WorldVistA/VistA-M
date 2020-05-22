EC2P149B ;ALB/DBE - EC National Procedure Update; Feb 05, 2020@13:46
 ;;2.0;EVENT CAPTURE;**149**;May 8, 1996;Build 2
 ;
 ;This routine is used as a post-init in a KIDS build
 ;to modify the EC National Procedure file (#725)
 ;
 Q
 ;
ADDPROC ;* add national procedures
 ;
 ;  ECXX is in format:
 ;   NAME^NATIONAL NUMBER^CPT CODE^FIRST NATIONAL NUMBER SEQUENCE
 ;   LAST NATIONAL NUMBER SEQUENCE
 ;
 N ECX,ECXX,ECDINUM,ECNAME,ECCODE,ECCPT,ECCOUNT,X,Y,DIC,DIE,DA,DR,DLAYGO,DINUM
 N ECADD,ECBEG,ECEND,ECCODX,ECNAMX,ECSEQ,ECLIEN,ECSTR,ECCPTN
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Adding new procedures to the EC NATIONAL PROCEDURE File (#725)...")
 S ECDINUM=$O(^EC(725,9999),-1),ECCOUNT=$P(^EC(725,0),U,4)
 F ECX=1:1 S ECXX=$P($T(NEW+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECNAME=$P(ECXX,U,1),ECCODE=$P(ECXX,U,2),ECCPTN=$P(ECXX,U,3),ECCODX=ECCODE
 .S ECCPT=""
 .I ECCPTN'="" S ECCPT=$$FIND1^DIC(81,"","X",ECCPTN) I +ECCPT<1 D  Q
 ..S ECSTR="   CPT code "_ECCPTN_" not a valid code in CPT File."
 ..D MES^XPDUTL(" ")
 ..D MES^XPDUTL("   ["_ECCODE_"] "_ECSTR)
 .S ECBEG=$P(ECXX,U,4),ECEND=$P(ECXX,U,5),ECNAMX=ECNAME
 .I ECBEG="" S X=ECNAME D FILPROC Q
 .F ECSEQ=ECBEG:1:ECEND D
 ..S ECADD="000"_ECSEQ,ECADD=$E(ECADD,$L(ECADD)-2,$L(ECADD))
 ..I $E(ECCODX,1,3)'="RCM" S ECNAME=ECNAMX_ECSEQ,X=ECNAME,ECCODE=ECCODX_ECADD
 ..E  S ECNAME=ECNAMX_$E(ECADD,2,99),X=ECNAME,ECCODE=ECCODX_$E(ECADD,2,99)
 ..D FILPROC
 S $P(^EC(725,0),U,4)=ECCOUNT,X=$O(^EC(725,999999),-1),$P(^EC(725,0),U,3)=X
 Q
 ;
FILPROC ;File national procedures
 I '$D(^EC(725,"D",ECCODE)) D
 .S ECDINUM=ECDINUM+1,DINUM=ECDINUM,DIC(0)="L",DLAYGO=725,DIC="^EC(725,"
 .S DIC("DR")="1////^S X=ECCODE;4///^S X=ECCPT"
 .D FILE^DICN
 .I +Y>0 D
 ..S ECCOUNT=ECCOUNT+1
 ..D MES^XPDUTL(" ")
 ..S ECSTR="   Entry #"_+Y_" for "_$P(Y,U,2)
 ..S ECSTR=ECSTR_$S(ECCPT'="":" [CPT: "_ECCPT_"]",1:"")_" ("_ECCODE_")"
 ..D BMES^XPDUTL(ECSTR)
 ..D MES^XPDUTL("      ...successfully added.")
 .I Y=-1 D
 ..D MES^XPDUTL(" ")
 ..D BMES^XPDUTL("ERROR when attempting to add "_ECNAME_" ("_ECCODE_")")
 I $D(^EC(725,"DL",ECCODE)) D
 .S ECLIEN=$O(^EC(725,"DL",ECCODE,""))
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL("   Your site has a local procedure (entry #"_ECLIEN_") in File #725")
 .D MES^XPDUTL("   which uses "_ECCODE_" as its National Number.")
 .D MES^XPDUTL("   Please inactivate this local procedure.")
 .D MES^XPDUTL(" ")
 .K Y
 Q
NEW ;national procedures to add;;descript^nation #^CPT code^beg seq^end seq
 ;;HOSPICE SERVICE^CH126^G9473
 ;;SM EVAL MD (5-10 MINS)^SM007^99421
 ;;SM EVAL MD (11-20 MINS)^SM008^99422
 ;;SM EVAL MD (GT 21 MINS)^SM009^99423
 ;;SM EVAL NON-MD (5-10 MINS)^SM010^98970
 ;;SM EVAL NON-MD (11-20 MINS)^SM011^98971
 ;;SM EVAL NON-MD (GT 21 MINS)^SM012^98972
 ;;QUIT
 ;
NAMECHG ;* change national procedure names
 ;
 ;  ECXX is in format:
 ;   NATIONAL NUMBER^NEW NAME
 ;
 N ECX,ECXX,ECDA,DA,DR,DIC,DIE,X,Y,ECSTR
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
 ..S ECSTR="Can't find entry for "_$P(ECXX,U,1)
 ..D BMES^XPDUTL(ECSTR_" ...field (#.01) not updated.")
 Q
 ;
CHNG ;name changes -national code #^new procedure name
 ;;CH100^RITE/SACRMNT/ORDNCE
 ;;CH103^WORSHIP
 ;;CH109^FUNERAL/MEM SERVICE&GRAVE
 ;;CH110^IND CARE/COUNSEL
 ;;CH114^FAM CARE/COUNSEL
 ;;CH118^GROUP SMALL
 ;;CH122^SPIRITUAL ASSESSMENT
 ;;CH125^GROUP IDT MTG
 ;;QUIT
