EC725CH7 ;ALB/GTS/JAP - EC National Procedure Update; 10/28/98
 ;;2.0; EVENT CAPTURE ;**16**;8 May 96
 ;
 ;this routine is used as a post-init in KIDS build 
 ;to modify the the EC National Procedure file #725
 ;
INACT ;* inactivate national procedures
 ;
 ;  ECXX is in format:
 ;   NATIONAL NUMBER^INACTIVATION DATE
 ;
 N ECX,ECXX,ECEXDT,ECINDT,ECDA,DIC,DIE,DA,DR,X,Y,%DT
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Inactivating procedures EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 F ECX=1:1 K DD,DO,DA S ECXX=$P($T(OLD+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECEXDT=$P(ECXX,U,2)
 .S X=ECEXDT
 .S %DT="X" D ^%DT
 .S ECINDT=$P(Y,".",1)
 .S ECDA=+$O(^EC(725,"D",$P(ECXX,U,1),0))
 .I $D(^EC(725,ECDA,0)) D
 ..S DA=ECDA,DR="2////^S X=ECINDT",DIE="^EC(725," D ^DIE
 ..D MES^XPDUTL(" ")
 ..D BMES^XPDUTL("   "_$P(ECXX,U,1)_" inactivated as of "_ECEXDT_".")
 Q
 ;
OLD ;national procedures to be inactivated
 ;;SP002^1/1/1999
 ;;SP122^1/1/1999
 ;;SP135^1/1/1999
 ;;SP136^1/1/1999
 ;;SP138^1/1/1999
 ;;SP141^1/1/1999
 ;;SP146^1/1/1999
 ;;SP151^1/1/1999
 ;;SP156^1/1/1999
 ;;SP161^1/1/1999
 ;;SP169^1/1/1999
 ;;SP232^1/1/1999
 ;;SP240^1/1/1999
 ;;SP243^1/1/1999
 ;;SP244^1/1/1999
 ;;SP250^1/1/1999
 ;;SP251^1/1/1999
 ;;SP252^1/1/1999
 ;;QUIT
 ;
CPTCHG ;* change cpt codes
 ;
 ;  ECXX is in format:
 ;  NATIONAL NUMBER^NEW CPT
 ;
 N ECX,ECXX,CPT,DIC,DIE,DA,DR,X,Y
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Changing CPT Codes in EC NATIONAL PROCEDURE file (#725)...")
 D MES^XPDUTL(" ")
 F ECX=1:1 S ECXX=$P($T(CPT+ECX),";;",2) Q:ECXX="QUIT"  S CPT($P(ECXX,U,1))=$P(ECXX,U,2)
 S ECXX=""
 F  S ECXX=$O(CPT(ECXX)) Q:ECXX=""  D
 .S ECX=$O(^EC(725,"D",ECXX,0))
 .Q:+ECX=0
 .Q:'$D(^EC(725,ECX,0))
 .S CPT=CPT(ECXX)
 .S DA=ECX,DR="4////"_CPT,DIE="^EC(725," D ^DIE
 .D MES^XPDUTL(" ")
 .D BMES^XPDUTL("   Entry #"_ECX_" for "_ECXX)
 .D BMES^XPDUTL("   ...updated to use CPT code "_CPT_".")
 Q
 ;
CPT ;cpt codes to be changed
 ;;SP037^97703
 ;;SP038^97703
 ;;QUIT
