ECX3P158 ;ALB/DE - ECX*3.0*158 Post-Init Rtn ; 5/7/15 10:00am
 ;;3.0;DSS EXTRACTS;**158**;Dec 22,1997;Build 2
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
 N ECXLINE,ECXSTR,ECXCNT
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Adding entries to DSS LOINC (#727.29) File...")
 D MES^XPDUTL(" ")
 S ECXCNT=0
 N DIC,DIE,DA,DLAYGO,DR,X,Y,ECXDN,ECXDTN,ECXLN,ECXDRU
 S DIC="^ECX(727.29,",DIC(0)="L",DLAYGO=727.29
 F ECXLINE=1:1 S ECXSTR=$P($T(ALOINC+ECXLINE),";;",2) Q:ECXSTR="EXIT"  D
 . S X=$P(ECXSTR,"^",1)
 . D ^DIC I Y<0 D  Q
 .. D BMES^XPDUTL("*****")
 .. D MES^XPDUTL("Unsuccessful entry of LOINC Code - "_X_".")
 .. D MES^XPDUTL("******")
 . S ECXCNT=ECXCNT+1
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
 ;;21639-0^0092^BRCA1^text^BRCA1 Gene Mut Tested Bld/T
 ;;21636-6^0092^BRCA1^text^BRCA1 Gene Mut Anal Bld/T
 ;;21637-4^0092^BRCA1^text^BRCA1 c 185 Del Ag Bld/T Ql
 ;;21638-2^0092^BRCA1^text^BRCA1 c 5382 Ins C Bld/T Ql
 ;;38530-2^0093^BRCA2^text^BCRA2 Gene Mut Anal Bld/T
 ;;38531-0^0093^BRCA2^text^BCRA2 Gene Mut Tested Bld/T
 ;;21640-8^0093^BRCA2^text^BRCA2 c 6174 Del T Bld/T Ql
 ;;50995-0^0094^BRCA1+BRCA2^text^BRCA1+BRCA2 gene Mut Anal Bld/T
 ;;59041-4^0094^BRCA1+BRCA2^text^BRCA1+BRCA2 gene Mut Tested Bld/T
 ;;10334-1^0095^CA 125^U/mL^Cancer Ag125 SerPl-aCnc
 ;;EXIT
 Q
