FH55P8 ;Hines OIFO/RTK - POST-INIT FOR PATCH FH*5.5*8 ;1/18/2007
 ;;5.5;DIETETICS;**8**;Jan 28, 2005;Build 28
 ;
ITEM1 ;Convert existing CLINICIAN field entries into new multiple field
 D BMES^XPDUTL("Expand CLINICIAN field of NUTRITION LOCATION (#119.6)")
 D MES^XPDUTL(" file to a multiple and convert existing data...")
 F FHLIEN=0:0 S FHLIEN=$O(^FH(119.6,FHLIEN)) Q:FHLIEN'>0  D
 .S FHCFLG=0,FHLCLN=$P($G(^FH(119.6,FHLIEN,0)),U,2)
 .I FHLCLN="" Q
 .F FHCMIEN=0:0 S FHCMIEN=$O(^FH(119.6,FHLIEN,2,FHCMIEN)) Q:FHCMIEN'>0  D
 ..S FHCMLT=$P($G(^FH(119.6,FHLIEN,2,FHCMIEN,0)),U,1)
 ..I FHCMLT=FHLCLN S FHCFLG=1
 .I FHCFLG=1 Q  ;already in CLINICIAN(S) multiple, don't add
 .S X=+FHLCLN K DIC,DO S DA(1)=FHLIEN,DIC="^FH(119.6,"_DA(1)_",2,"
 .S DIC(0)="L" D FILE^DICN I Y=-1 Q
ITEM2 ;Set Allergy-type Food Preferences pointers to corresponding Allergy
 D BMES^XPDUTL("Map ALLERGY - TYPE entries in Food Preferences (#115.2)")
 D MES^XPDUTL(" file to corresponding GMR Allergies entries...")
 D MAP^FHSELA1
ITEM3 ;Update Patient FP's based on any pre-existing Patient Food-type Allergies
 D BMES^XPDUTL("Updating Patient Food Preferences based on pre-existing")
 D MES^XPDUTL(" Allergy data...")
 S FHPST8=1 D UPDATE^FHSELA1
ITEM4 ;
 K ^FH(114,"D")
 ;Set new AB cross-reference on Recipe (#114) file, Embedded Recipe mult
 F FHINIEN=0:0 S FHINIEN=$O(^FH(114,FHINIEN)) Q:FHINIEN'>0  D
 .I $O(^FH(114,FHINIEN,"R",0)) S DIK="^FH(114,FHINIEN,""R"",",DIK(1)=".01^AB",DA(1)=FHINIEN D ENALL^DIK
 K DA,X,Y,FHCFLG,FHLCLN,FHLIEN,FHCMIEN,FHCMLT,FHINIEN Q
