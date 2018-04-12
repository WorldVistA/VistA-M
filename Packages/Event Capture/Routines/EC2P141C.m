EC2P141C ;ALB/DE - EC National Procedure Update ; 11/9/17 11:00am
 ;;2.0;EVENT CAPTURE;**141**;8 May 96;Build 4
 ;
 ;this routine is used as a post-init in a KIDS build
 ;to modify the EC National Procedure file (#725)
 ;
 Q
 ;
INACT ;* inactivate national procedures
 ;
 ;  ECXX is in format:
 ;   NATIONAL NUMBER^INACTIVATION DATE^FIRST NATIONAL NUMBER SEQUENCE^
 ;   LAST NATIONAL NUMBER SEQUENCE
 ;
 N ECX,ECXX,ECEXDT,ECINDT,ECDA,DIC,DIE,DA,DR,X,Y,%DT,ECBEG,ECEND,ECADD
 N ECSEQ,ECCODE,ECCODX
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Inactivating procedures EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 F ECX=1:1 K DD,DO,DA S ECXX=$P($T(OLD+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECEXDT=$P(ECXX,U,2),X=ECEXDT,%DT="X" D ^%DT S ECINDT=$P(Y,".",1)
 .S ECCODE=$P(ECXX,U),ECBEG=$P(ECXX,U,3),ECEND=$P(ECXX,U,4),ECCODX=ECCODE
 .I ECBEG="" D UPINACT Q
 .F ECSEQ=ECBEG:1:ECEND D
 ..S ECADD="000"_ECSEQ,ECADD=$E(ECADD,$L(ECADD)-2,$L(ECADD))
 ..S ECCODE=ECCODX_ECADD
 ..D UPINACT
 Q
UPINACT ;Update codes as inactive
 ;
 S ECDA=+$O(^EC(725,"D",ECCODE,0))
 I $D(^EC(725,ECDA,0)) D
 .S DA=ECDA,DR="2///^S X=ECINDT",DIE="^EC(725," D ^DIE
 .D MES^XPDUTL(" ")
 .D BMES^XPDUTL("   "_ECCODE_" inactivated as of "_ECEXDT_".")
 Q
 ;
OLD ;national procedures to be inactivated - national code #^inact. date
 ;;NU002^4/1/2018
 ;;NU003^4/1/2018
 ;;NU004^4/1/2018
 ;;NU005^4/1/2018
 ;;NU188^4/1/2018
 ;;SW124^4/1/2018
 ;;QUIT
 ;
CPTCHG ;* change cpt codes
 ;
 ;  ECXX is in format:
 ;  NATIONAL NUMBER^NEW CPT^FIRST NATIONAL NUMBER SEQUENCE^LAST NATIONAL
 ;  NUMBER SEQUENCE
 ;
 N ECX,ECXX,ECCPT,DIC,DIE,DA,DR,X,Y,ECBEG,ECEND,ECADD,ECSEQ,ECSTR,ECCPTIEN
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Changing CPT Codes in EC NATIONAL PROCEDURE file (#725)")
 D MES^XPDUTL(" ")
 F ECX=1:1 S ECXX=$P($T(CPT+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECBEG=$P(ECXX,U,3),ECEND=$P(ECXX,U,4),ECCPTIEN=$P(ECXX,U,2)
 .S ECCPTIEN=$S(ECCPTIEN="":"@",1:$$FIND1^DIC(81,"","X",ECCPTIEN))
 .I ECCPTIEN'="@",+ECCPTIEN<1 D  Q
 ..S ECSTR=$P(ECXX,U)_":  CPT code "_$P(ECXX,U,2)_" is invalid."
 ..D MES^XPDUTL(" ")
 ..D BMES^XPDUTL("   "_ECSTR)
 .I ECBEG="" S ECCPT($P(ECXX,U))=ECCPTIEN_U_$P(ECXX,U,2) Q
 .F ECSEQ=ECBEG:1:ECEND D
 ..S ECADD="000"_ECSEQ,ECADD=$E(ECADD,$L(ECADD)-2,$L(ECADD))
 ..S ECCPT($P(ECXX,U)_ECADD)=ECCPTIEN_U_$P(ECXX,U,2)
 S ECXX=""
 F  S ECXX=$O(ECCPT(ECXX)) Q:ECXX=""  D
 .S ECX=$O(^EC(725,"D",ECXX,0))
 .Q:+ECX=0
 .I '$D(^EC(725,ECX,0))!(+ECX=0) D  Q
 ..D MES^XPDUTL(" ")
 ..D BMES^XPDUTL("   Can't find entry for "_ECXX_",CPT code not updated.")
 .S ECCPT=$P(ECCPT(ECXX),U),DA=ECX,DR="4///"_ECCPT,DIE="^EC(725," D ^DIE
 .D MES^XPDUTL(" ")
 .S ECSTR="   Entry #"_ECX_" for "_ECXX
 .D BMES^XPDUTL(ECSTR_" updated to use CPT code "_$P(ECCPT(ECXX),U,2))
 Q
 ;
CPT ;cpt codes to be changed - national #^new CPT code
 ;;SW122^99497
 ;;SW075^96160
 ;;QUIT
