EC2P146C ;ALB/DBE - EC National Procedure Update;11/28/18 12:00pm
 ;;2.0;EVENT CAPTURE;**146**;8 May 96;Build 4
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
 D BMES^XPDUTL("Inactivating procedures in the EC NATIONAL PROCEDURE File (#725)...")
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
 .D MES^XPDUTL("   "_ECCODE_" inactivated as of "_ECEXDT_".")
 Q
 ;
OLD ;national procedures to be inactivated - national code #^inact. date
 ;;SN101^4/1/2019
 ;;SN102^4/1/2019
 ;;SN103^4/1/2019
 ;;SN104^4/1/2019
 ;;SN105^4/1/2019
 ;;SN106^4/1/2019
 ;;SN107^4/1/2019
 ;;SN108^4/1/2019
 ;;SN109^4/1/2019
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
 D MES^XPDUTL("Changing CPT Codes in EC NATIONAL PROCEDURE file (#725)")
 D MES^XPDUTL(" ")
 F ECX=1:1 S ECXX=$P($T(CPT+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECBEG=$P(ECXX,U,3),ECEND=$P(ECXX,U,4),ECCPTIEN=$P(ECXX,U,2)
 .S ECCPTIEN=$S(ECCPTIEN="":"@",1:$$FIND1^DIC(81,"","X",ECCPTIEN))
 .I ECCPTIEN'="@",+ECCPTIEN<1 D  Q
 ..S ECSTR=$P(ECXX,U)_":  CPT code "_$P(ECXX,U,2)_" is invalid."
 ..D MES^XPDUTL(" ")
 ..D MES^XPDUTL("   "_ECSTR)
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
 ..D MES^XPDUTL("   Can't find entry for "_ECXX_",CPT code not updated.")
 .S ECCPT=$P(ECCPT(ECXX),U),DA=ECX,DR="4///"_ECCPT,DIE="^EC(725," D ^DIE
 .D MES^XPDUTL(" ")
 .S ECSTR="   Entry #"_ECX_" for "_ECXX
 .D MES^XPDUTL(ECSTR_" updated to use CPT code "_$P(ECCPT(ECXX),U,2))
 Q
 ;
CPT ;cpt codes to be changed - national #^new CPT code
 ;;QUIT
