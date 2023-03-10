EC2P157B ;ALB/TXH - EC National Procedure Update; May 19, 2022@10:10
 ;;2.0;EVENT CAPTURE;**157**;May 8, 1996;Build 4
 ;
 ; This routine is used as a post-init in a KIDS build
 ; to add new procedure codes and change procedure names  
 ; in the EC National Procedure File (#725).
 ;
 ; Reference to $$FIND1^DIC supported by DBIA# 2051
 ; Reference to FILE^DICN supported by DBIA# 10009
 ; Reference to ^DIE supported by DBIA# 10018
 ; Reference to BMES^XPDUTL supported by DBIA# 10141
 ; Reference to MES^XPDUTL supported by DBIA# 10141
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
 N ECADD,ECBEG,ECEND,ECCODX,ECNAMX,ECSEQ,ECLIEN,ECSTR,ECCPTN,ECCNT1,ECCNT11
 ;
 D MES^XPDUTL("*** Adding new procedures to the EC NATIONAL PROCEDURE FILE (#725)...")
 ;
 S ECDINUM=$O(^EC(725,9999),-1),ECCOUNT=$P(^EC(725,0),U,4)
 S (ECCNT1,ECCNT11)=0
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
 D BMES^XPDUTL("    Total "_ECCNT1_" new codes have been added.")
 I ECCNT11>0 D MES^XPDUTL("    Total "_ECCNT11_" new codes have NOT added.")
 D MES^XPDUTL(" ")
 Q
 ;
FILPROC ;File national procedures
 ;
 I '$D(^EC(725,"D",ECCODE)) D
 .S ECDINUM=ECDINUM+1,DINUM=ECDINUM,DIC(0)="L",DLAYGO=725,DIC="^EC(725,"
 .S DIC("DR")="1////^S X=ECCODE;4///^S X=ECCPT"
 .D FILE^DICN
 .;
 .I +Y>0 D
 ..S ECCOUNT=ECCOUNT+1
 ..D MES^XPDUTL(" ")
 ..S ECSTR="    Entry #"_+Y_" for "_$P(Y,U,2)
 ..S ECSTR=ECSTR_$S(ECCPT'="":" [CPT: "_ECCPT_"]",1:"")_" ("_ECCODE_")"
 ..D MES^XPDUTL(ECSTR)
 ..D MES^XPDUTL("      ...successfully added.")
 ..S ECCNT1=ECCNT1+1
 .;
 .I Y=-1 D
 ..D MES^XPDUTL(" ")
 ..D BMES^XPDUTL("    ERROR when attempting to add "_ECNAME_" ("_ECCODE_")")
 ..S ECCNT11=ECCNT11+1
 ;
 I $D(^EC(725,"DL",ECCODE)) D
 .S ECLIEN=$O(^EC(725,"DL",ECCODE,""))
 .D BMES^XPDUTL(" ")
 .D MES^XPDUTL("    ** Your site has a local procedure (entry #"_ECLIEN_") in File #725")
 .D MES^XPDUTL("       which uses "_ECCODE_" as its National Number.")
 .D MES^XPDUTL("       Please inactivate this local procedure.")
 .D MES^XPDUTL(" ")
 .K Y
 Q
NEW ;national procedures to add;;descript^nation #^CPT code^beg seq^end seq
 ;;E-CONSULT NON-MD (5-10 MINS)^NU224^98970^^
 ;;E-CONSULT NON-MD (5-10 MINS)^NU225^98970^^
 ;;E-CONSULT NON-MD (5-10 MINS)^NU226^98970^^
 ;;PHONE CALL, NOC, 10M^NU227^^^
 ;;M&E-PROBLEM IMPROVED^NU504^^^
 ;;QUIT
 ;
NAMECHG ;* change national procedure names
 ;
 ;  ECXX is in format:
 ;   NATIONAL NUMBER^NEW NAME
 ;
 N ECX,ECXX,ECDA,DA,DR,DIC,DIE,X,Y,ECSTR,ECCNT4
 D MES^XPDUTL("*** Changing names in EC NATIONAL PROCEDURE File (#725)...")
 ;
 S ECCNT4=0
 F ECX=1:1 S ECXX=$P($T(CHNG+ECX),";;",2) Q:ECXX="QUIT"  D
 .I $D(^EC(725,"D",$P(ECXX,U,1))) D
 ..S ECDA=+$O(^EC(725,"D",$P(ECXX,U,1),0))
 ..I $D(^EC(725,ECDA,0)) D
 ...S DA=ECDA,DR=".01////^S X=$P(ECXX,U,2)",DIE="^EC(725," D ^DIE
 ...D MES^XPDUTL(" ")
 ...D MES^XPDUTL("    Entry #"_ECDA_" for "_$P(ECXX,U,1))
 ...D MES^XPDUTL("    ... field (#.01) updated to "_$P(ECXX,U,2)_".")
 ...S ECCNT4=ECCNT4+1
 .;
 .I '$D(^EC(725,"D",$P(ECXX,U,1))) D
 ..D MES^XPDUTL(" ")
 ..S ECSTR="Can't find entry for "_$P(ECXX,U,1)
 ..D BMES^XPDUTL(ECSTR_" ...field (#.01) not updated.")
 ;
 D BMES^XPDUTL("    Total "_ECCNT4_" names have been changed.")
 D MES^XPDUTL(" ")
 Q
 ;
CHNG ;name changes -national code #^new procedure name
 ;;NU133^PT ED GP, 2-5 PT, NOC 30M
 ;;NU134^PT ED GP, 6-10 PT, NOC 30M
 ;;NU135^PT ED GP, 11-20 PT, NOC 30M
 ;;NU136^PT ED GP, >20 PT, NOC 30M
 ;;NU381^DX-PN COMP INCONST, 0M
 ;;NU382^DX-PN ADM INCONST, 0M
 ;;NU502^M&E PROB UNRESOLVED  0M
 ;;NU510^M&E GOAL ACHIEVED,0M
 ;;NU511^M&E GOAL NOT ACHIEVED,0M
 ;;NU512^M&E GOAL,PROGRESS TOWARD, 0M
 ;;QUIT
