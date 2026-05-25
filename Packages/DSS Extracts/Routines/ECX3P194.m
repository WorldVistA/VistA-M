ECX3P194 ;MNTVBB/RD - NATIONAL CLINIC (#728.441) File Update; FEB 27, 2025@14:42
 ;;3.0;DSS EXTRACTS;**194**;Dec 22, 1997;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Post-init routine to deactivate SOGI entry in the NATIONAL CLINIC (#728.441)
 ; file to comply with Defending Women Executive Order.
 ;
 ; Reference(s) to ^%DT supported by ICR# 10003 
 ; Reference(s) to ^DIE supported by ICR# 10018
 ; Reference(s) to BMES^XPDUTL supported by ICR# 10141
 ; Reference(s) to MES^XPDUTL supported by ICR# 10141
 ;
 Q
 ;
POST ;routine entry point
 ;
 D BMES^XPDUTL("Update NATIONAL CLINIC (#728.441) file starts.")
 D INACT  ;inactivate existing clinic codes
 D BMES^XPDUTL("Update complete.")
 D MES^XPDUTL("")
 ;
 Q
 ;
INACT ;* inactivate national clinc codes
 ;
 ; ECXX is in format:
 ; CODE^INACTIVATION DATE
 ;
 N ECX,ECXX,ECXEXDT,ECXINDT,ECXDA,ECXCODE,ECXCNT,DIC,DIE,DA,DR,X,Y,%DT
 S ECXCNT=0
 D BMES^XPDUTL("*** Inactivating procedures in the EC NATIONAL PROCEDURE File (#728.441)")
 D MES^XPDUTL(" ")
 F ECX=1:1 K DD,DO,DA S ECXX=$P($T(OLD+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECXEXDT=$P(ECXX,U,2),X=ECXEXDT,%DT="X" D ^%DT S ECXINDT=$P(Y,".",1)
 .S ECXCODE=$P(ECXX,U)
 .D UPINACT
 .Q
 D BMES^XPDUTL("    Total "_ECXCNT_" CPT codes have been inactivated.")
 Q
 ;
UPINACT ;Update codes as inactive
 S ECXDA=+$O(^ECX(728.441,"B",ECXCODE,0))
 I $D(^ECX(728.441,ECXDA,0)) D
 .S DA=ECXDA,DR="3///^S X=ECXINDT",DIE="^ECX(728.441," D ^DIE
 .D MES^XPDUTL("    "_ECXCODE_" inactivated as of "_ECXEXDT_".")
 .S ECXCNT=ECXCNT+1
 Q
 ;
OLD ;codes to be inactivated - national clinic code^inact. date
 ;;SOGI^3/31/2025
 ;;QUIT
 ;
