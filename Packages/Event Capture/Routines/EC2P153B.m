EC2P153B ;ALB/TXH - EC National Procedure Update; Feb 04, 2021@13:51
 ;;2.0;EVENT CAPTURE;**153**;May 8, 1996;Build 2
 ;
 ; This routine is used as a post-init in a KIDS build
 ; to add new procedure codes and change procedure names  
 ; in the EC National Procedure file (#725).
 ;
 ; Reference to $$FIND1^DIC supported by ICR# 2051
 ; Reference to FILE^DICN supported by ICE # 10009
 ; Reference to ^DIE supported by ICR# 10018
 ; Reference to BMES^XPDUTL supported by ICR# 10141
 ; Reference to MES^XPDUTL supported by ICR# 10141
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
 D MES^XPDUTL("*** Adding new procedures to the EC NATIONAL PROCEDURE File (#725)...")
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
 ;;SW006^HEALTH BEH INTV IND EA15M
 ;;SW019^HEALTH BEH INTV GRP EA15M
 ;;SW036^MutiFamGrpPsyTher wPT
 ;;SW172^BEH HEALTH IND COUNS/TRMT
 ;;NU014^MDS CARE PLAN EA 5M
 ;;NU170^GLUC FINGER STICK 2M
 ;;NU177^CGM VA EQ Train 30M
 ;;NU184^TELERETNL SCN 30M
 ;;NU190^HT INIT. SCREENING 30M
 ;;NU191^HT TECH/ED INSTALL 0M
 ;;NU192^HT ASSESS TX PLAN EA 15M
 ;;NU193^HT PHONE ASSESS TX21-30M
 ;;NU204^HT PHONE INIT SCRN21-30M
 ;;NU215^Dx-Malnutr disorders 0M
 ;;NU300^Dx-Energy Balance 0M
 ;;NU301^Dx-Oral/Nutr Support 0M
 ;;NU302^Dx-Fluid Intake 0M
 ;;NU303^Dx-Bioactive Substance 0M
 ;;NU304^Dx-Nutrient Intake 0M
 ;;NU305^Dx-Functional 0M
 ;;NU306^Dx-Biochemical 0M
 ;;NU307^Dx-Weight 0M
 ;;NU308^Dx-Knowledge/Beliefs 0M
 ;;NU309^Dx-Activity & Fxn 0M
 ;;NU310^Dx-Food Safety&Access 0M
 ;;NU400^IN-Meals/Snacks 0M
 ;;NU401^IN-EN or PN 0M
 ;;NU402^IN-Suppl 0M
 ;;NU403^IN-Feeding Assist 0M
 ;;NU404^IN-Feeding Envir 0M
 ;;NU405^IN-Med Mgmt 0M
 ;;NU406^IN-Nutr Educ 0M
 ;;NU407^IN-Nutr Counse 0M
 ;;NU408^IN-Coord of Care 0M
 ;;NU409^IN-Pop Action 0M
 ;;NU410^IN-NO PROB 0M
 ;;NU500^M&E-Prob Resolved 0M
 ;;NU502^M&E PROB ACTIVE 0M
 ;;NU503^M&E PROB DISCONT 0M
 ;;NU600^HYPOGLYCEMIA 0M
 ;;QUIT
