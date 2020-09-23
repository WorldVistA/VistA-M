EC2P150C ;ALB/TXH - EC National Procedure Update; Apr 27, 2020@14:16
 ;;2.0;EVENT CAPTURE;**150**;May 8, 1996;Build 5
 ;
 ;This routine is used as a post-init in a KIDS build
 ;to inactivate national procedure codes and update 
 ;CPT codes in the EC National Procedure file (#725).
 ;
 Q
 ;
INACT ;* inactivate national procedures
 ;
 ;Read inactive codes from XTMP
 N ECX,ECXX,ECEXDT,ECINDT,ECDA,DIC,DIE,DA,DR,X,Y,%DT,ECBEG,ECEND,ECADD
 N ECSEQ,ECCODE,ECCODX,ECCNT2,ECCNT22
 S (ECCNT2,ECCNT22)=0
 D BMES^XPDUTL("*** Inactivating procedures in the EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 S ECX=0 K DD,DO,DA F  S ECX=$O(^XTMP("ECDATA",ECX)) Q:ECX=""  D
 .S ECXX=$G(^XTMP("ECDATA",ECX))
 .S ECEXDT=$P(ECXX,U,2),X=ECEXDT,%DT="X" D ^%DT S ECINDT=$P(Y,".",1)
 .S ECCODE=$P(ECXX,U),ECBEG=$P(ECXX,U,3),ECEND=$P(ECXX,U,4),ECCODX=ECCODE
 .I ECBEG="" D UPINACT Q
 .F ECSEQ=ECBEG:1:ECEND D
 ..S ECADD="000"_ECSEQ,ECADD=$E(ECADD,$L(ECADD)-2,$L(ECADD))
 ..S ECCODE=ECCODX_ECADD
 ..D UPINACT
 D BMES^XPDUTL("    Total "_ECCNT2_" codes have been inactivated.")
 Q
 ;
UPINACT ;Update codes as inactive
 S ECDA=+$O(^EC(725,"D",ECCODE,0))
 I $D(^EC(725,ECDA,0)) D
 .S DA=ECDA,DR="2///^S X=ECINDT",DIE="^EC(725," D ^DIE
 .D MES^XPDUTL("    "_ECCODE_" inactivated as of "_ECEXDT_".")
 .S ECCNT2=ECCNT2+1
 Q
 ;
CPTCHG ;* change cpt codes
 ;
 ;  ECXX is in format:
 ;  NATIONAL NUMBER^NEW CPT^FIRST NATIONAL NUMBER SEQUENCE^LAST NATIONAL
 ;  NUMBER SEQUENCE
 ;
 N ECX,ECXX,ECCPT,DIC,DIE,DA,DR,X,Y,ECBEG,ECEND,ECADD,ECSEQ,ECSTR,ECCPTIEN
 D MES^XPDUTL("*** Changing CPT Codes in EC NATIONAL PROCEDURE file (#725)")
 D MES^XPDUTL(" ")
 ;
 N ECCNT3,ECCNT33 S (ECCNT3,ECCNT33)=0
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
 ;
 S ECXX=""
 F  S ECXX=$O(ECCPT(ECXX)) Q:ECXX=""  D
 .S ECX=$O(^EC(725,"D",ECXX,0))
 .Q:+ECX=0
 .I '$D(^EC(725,ECX,0))!(+ECX=0) D  Q
 ..D MES^XPDUTL(" ")
 ..D MES^XPDUTL("    Can't find entry for "_ECXX_",CPT code not updated.")
 ..S ECCNT33=ECCNT33+1
 .S ECCPT=$P(ECCPT(ECXX),U),DA=ECX,DR="4///"_ECCPT,DIE="^EC(725," D ^DIE
 .S ECSTR="    Entry #"_ECX_" for "_ECXX
 .D MES^XPDUTL(ECSTR_" updated to use CPT code "_$P(ECCPT(ECXX),U,2))
 .S ECCNT3=ECCNT3+1
 ;
 D BMES^XPDUTL("    Total "_ECCNT3_" CPT codes have been updated.")
 I ECCNT33>0 D MES^XPDUTL("    Total "_ECCNT33_" CPT codes did NOT get updated.")
 Q
 ;
CPT ;cpt codes to be changed - national #^new CPT code
 ;;SW006^96159^^
 ;;SW160^96168^^
 ;;SW162^96168^^
 ;;SW163^96171^^
 ;;NU181^99454^^
 ;;SW019^96165^^
 ;;SW181^98970^^
 ;;QUIT
