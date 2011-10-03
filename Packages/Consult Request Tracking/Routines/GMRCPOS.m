GMRCPOS ;SLC/DLT - Consult postinit file maintenance ;10/28/98  14:31
 ;;3.0;CONSULT/REQUEST TRACKING;**1**;DEC 27, 1997
EN ; -- postinit
 N DA,DIK,ACTION,SITE
 ; Move the PREINIT actions from temporary storage in XTMP("GMRC"
 ; to the CONSULTS PARAMETERS FILE 123.9 for future clean-up
 S DA(1)=$O(^GMR(123.9,0)) I 'DA(1) S SITE=+$$SITE^VASITE,^GMR(123.9,1,0)=SITE,^GMR(123.9,"B",SITE,1)="",DA(1)=1
 ;
 S:'$D(^GMR(123.9,DA(1),"OLD",0)) ^GMR(123.9,DA(1),"OLD",0)="^123.9999^"
 S ACTION=0 F  S ACTION=$O(^XTMP("GMRC","PREINIT",ACTION)) Q:'ACTION  D
 .S ^GMR(123.9,DA(1),"OLD",+ACTION,0)=$P($G(^XTMP("GMRC","PREINIT",ACTION)),U,1,3)
 .S $P(^GMR(123.9,DA(1),"OLD",0),U,3)=$P(^GMR(123.9,DA(1),"OLD",0),U,3)+1
 .S $P(^GMR(123.9,DA(1),"OLD",0),U,4)=+ACTION
 ;
 ; -- Re-index Request Action Types in 123.1
 S DIK="^GMR(123.1," D IXALL^DIK
 ; -- Re-index old Request Action Types in 123.9
 S DA(1)=$O(^GMR(123.9,0)) Q:'DA(1)
 S DIK="^GMR(123.9,"_DA(1)_",""OLD"",",DIK(1)=.01
 D ENALL^DIK ;only executes the SET logic
 ; -- RJS -- RECREATE 63 CHARACTER 'B' CROSS REFERENCE
 S DIK="^GMR(123.5,",DIK(1)=".01^B"
 D ENALL^DIK ;only executes the SET logic
 ; -- CREATE NEW CROSS REFERENCE FOR APC and AC on sub-file (10th node)
 K DA S DIK(1)="10^APC^AC",DA(1)=0
 F  S DA(1)=$O(^GMR(123.5,DA(1))) Q:'DA(1)  D
 . S DIK="^GMR(123.5,"_DA(1)_",10,"
 . S DIK(1)=".01^APC^AC" D ENALL^DIK
 Q
