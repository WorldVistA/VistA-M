ECX140PT ;ALB/AG - ECX*3.0*140 Post-Init Rtn; 02/10/09 ; 5/29/12 9:30am
 ;;3.0;DSS EXTRACTS;**140**;Dec 22,1997;Build 6
 ;
 ;Post-init routine adding new entries to:
 ;
 ;LOINC Code(#727.29) file
 ;
 ;
 ;
 Q
POST ;
 ;Add new LOINC Codes Entry Point
 D ADDLNC
 Q
 ;
ADDLNC ;Add LOINC Codes
 N ECXLINE,ECXSTR,ECXCNT
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Adding entries to DSS LOINC File (#727.29)...")
 D MES^XPDUTL(" ")
 S ECXCNT=0
 N DIC,DIE,DA,DLAYGO,DR,X,Y,ECXDN,ECXDTN,ECXLN,ECXDRU
 S DIC="^ECX(727.29,",DIC(0)="L",DLAYGO=727.29
 F ECXLINE=1:1 S ECXSTR=$P($T(ALOINC+ECXLINE),";;",2) Q:ECXSTR="EXIT"  D
 .S X=$P(ECXSTR,"^",1)
 .D ^DIC I Y<0 D  Q
 ..D BMES^XPDUTL("*****")
 ..D MES^XPDUTL("Unsuccessful entry of LOINC Code - "_X_".")
 ..D MES^XPDUTL("******")
 .S ECXCNT=ECXCNT+1
 .S ECXDN=$P(ECXSTR,"^",2)
 .S ECXDTN=$P(ECXSTR,"^",3)
 .S ECXDRU=$P(ECXSTR,"^",4)
 .S ECXLN=$P(ECXSTR,"^",5)
 .S DA=+Y,DR=".02///"_ECXDN_";.03///"_ECXDTN_";.04///"_ECXDRU_";.05///"_ECXLN
 .S DIE=DIC D ^DIE
 .D BMES^XPDUTL(">>>.....Code "_$P(ECXSTR,"^")_" is added to the file.")
 K DA,DIC,DIE,DLAYGO,X,Y
 S DIK="^ECX(727.29,",DIK(1)=".02^AC" D ENALL^DIK
 K DIK
 Q
 ;
ALOINC ;LOINC CODE^LAR TEST #^DSS TEST NAME^REPORTING UNITS^LOINC NAME
 ;;11065-0^0005^BUN^mg/dl^BUN pre dialysis SerPl-mCnc
 ;;11064-3^0005^BUN^mg/dl^BUN p dialysis SerPl-mCnc
 ;;2282-2^0025^Folic Acid/ Folate^ng/ml^Folate Bld-mCnc
 ;;2283-0^0025^Folic Acid/ Folate^ng/ml^Folate RBC-mCnc
 ;;EXIT
 Q
