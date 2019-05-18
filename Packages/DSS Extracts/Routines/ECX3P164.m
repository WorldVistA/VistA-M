ECX3P164 ;ALB/DE - DSS LOINC CODE UPDATE ; 4/18/16 10:00am
 ;;3.0;DSS EXTRACTS;**164**;Dec 22,1997;Build 2
 ;
 ;Post-init routine adding new entries to:
 ;LOINC Code(#727.29) file
 ;
 Q
 ;
POST ;Entry point
 ;Add new LOINC Codes
 D ADDLNC
 Q
 ;
ADDLNC ;Add LOINC Codes
 N ECXLINE,ECXSTR
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Adding entries to DSS LOINC (#727.29) File...")
 D MES^XPDUTL(" ")
 N DIC,DIE,DA,DLAYGO,DR,X,Y,ECXDN,ECXDTN,ECXLN,ECXDRU
 S DIC="^ECX(727.29,",DIC(0)="L",DLAYGO=727.29
 F ECXLINE=1:1 S ECXSTR=$P($T(ALOINC+ECXLINE),";;",2) Q:ECXSTR="EXIT"  D
 . S X=$P(ECXSTR,"^",1)
 . D ^DIC I Y<0 D  Q
 .. D BMES^XPDUTL("*****")
 .. D MES^XPDUTL("Unsuccessful entry of LOINC Code - "_X_".")
 .. D MES^XPDUTL("******")
 . S ECXDN=$P(ECXSTR,"^",2)
 . S ECXDTN=$P(ECXSTR,"^",3)
 . S ECXDRU=$P(ECXSTR,"^",4)
 . S ECXLN=$P(ECXSTR,"^",5)
 . S DA=+Y,DR=".02///"_ECXDN_";.03///"_ECXDTN_";.04///"_ECXDRU_";.05///"_ECXLN
 . S DIE=DIC D ^DIE
 . D BMES^XPDUTL(">>>...Code "_$P(ECXSTR,"^")_" added to the file.")
 K DA,DIC,DIE,DLAYGO,X,Y
 S DIK="^ECX(727.29,",DIK(1)=".02^AC" D ENALL^DIK
 K DIK
 Q
 ;
ALOINC ;LOINC CODE^LAR TEST #^DSS TEST NAME^REPORTING UNITS^LOINC NAME 
 ;;79190-5^0096^ZIKA PCR^DETECTED/Not Detected^ZIKV RNA XXX Ql PCR
 ;;EXIT
 Q
