ICD1824A ;;ALB/EG/JAT - FY 2007 UPDATE; 6/19/05 4:08pm ; 6/24/05 3:29pm
 ;;18.0;DRG Grouper;**24**;Oct 13,2000;Build 5
 ;
 Q
 ;
ADDDRG ; add new DRGs
 N DIC,X,Y,DINUM,LINE,ICDDRG,DA,DRGX,DRGY,MDC,SURG,ROUTINE,ICDIEN
 D BMES^XPDUTL(">>> Adding New DRGs - Please verify that 20 were added")
 ; create top-level record (relative weights & average length of stay (ALOS) will be added later)
 F LINE=1:1 S X=$T(ADD+LINE) S ICDDRG=$P(X,";;",2) Q:ICDDRG="EXIT"  D
    .S DIC="^ICD(",DIC(0)="L"
    .S MDC=$P(ICDDRG,U,2) I MDC="PRE" S MDC=98
    .S SURG=$P(ICDDRG,U,3)
    .S DIC("DR")="5///^S X=MDC;.06///^S X=SURG"
    .S X="DRG",X=X_$P(ICDDRG,U)
    .; check for duplicates in case install is being rerun
    .I $D(^ICD($P(ICDDRG,U),0)) Q
    .K DO D FILE^DICN
    .K DIC,DA
    .;create 80.21A subfile
    .S DA(1)=$P(ICDDRG,U)
    .S DIC="^ICD("_DA(1)_",1,"
    .S DIC(0)="L"
    .S X=$P(ICDDRG,U,4)
    .K DO D FILE^DICN
    .;create 80.266 subfile
    .K DIC,DA
    .S DA(1)=$P(ICDDRG,U)
    .S DIC="^ICD("_DA(1)_",66,"
    .S DIC(0)="L"
    .I SURG="" S SURG=0
    .S DIC("DR")=".03///1;.05///^S X=MDC;.06///^S X=SURG"
    .S X=3061001
    .K DO D FILE^DICN
    .; create 80.271 subfile
    .K DIC,DA
    .S DA(1)=$P(ICDDRG,U)
    .S DIC="^ICD("_DA(1)_",2,"
    .S DIC(0)="L"
    .S ROUTINE="ICDTLB6C"
    .S DIC("DR")="1///^S X=ROUTINE"
    .S X=3061001
    .K DO D FILE^DICN
    .; create 80.268 and 80.2681 subfiles
    .K DIC,DA
    .N FDA
    .S ICDIEN=$P(ICDDRG,U)
    .S FDA(1820,80.2,"?1,",.01)=ICDIEN
    .S FDA(1820,80.268,"+2,?1,",.01)=3061001
    .D UPDATE^DIE("","FDA(1820)") K FDA(1820)
    .S FDA(1820,80.2,"?1,",.01)=ICDIEN
    .S FDA(1820,80.268,"?2,?1,",.01)=3061001
    .S FDA(1820,80.2681,"+3,?2,?1,",.01)=$P(ICDDRG,U,4)
    .D UPDATE^DIE("","FDA(1820)")
    .; displays listing
    .S DRGX=$P(ICDDRG,U),DRGY=$P(ICDDRG,U,4)
    .D MES^XPDUTL("  DRG"_DRGX_"     "_DRGY)
    .Q
 ; now update entire file for weights & versioning
 D UPDTDRG^ICD1824B
 ; inactivate some DRGs
 D INACTDRG^ICD1824B
 ; modify some DRG titles
 D DRGTITLE^ICD1824B
 Q
 ;
ADD ;New DRGs
 ;;560^1^^BACTERIAL & TUBERCULOUS INFECTIONS OF NERVOUS SYSTEM
 ;;561^1^^NON-BACTERIAL INFECTIONS OF NERVOUS SYSTEM EXCEPT VIRAL MENINGITIS
 ;;562^1^^SEIZURE AGE > 17 W CC
 ;;563^1^^SEIZURE AGE > 17 W/O CC
 ;;564^1^^HEADACHES AGE >17
 ;;565^4^^RESPIRATORY SYSTEM DIAGNOSIS WITH VENTILATOR SUPPORT 96+ HOURS
 ;;566^6^^RESPIRATORY SYSTEM DIAGNOSIS WITH VENTILATOR SUPPORT < 96 HOURS
 ;;567^6^1^STOMACH, ESOPHAGEAL & DUODENAL PROC AGE > 17 W CC W MAJOR GI DX
 ;;568^6^1^STOMACH, ESOPHAGEAL & DUODENAL PROCEDURES PROC AGE > 17 W CC W/O MAJOR GI DX
 ;;569^6^1^MAJOR SMALL & LARGE BOWEL PROCEDURES W CC W MAJOR GI DX
 ;;570^6^1^MAJOR SMALL & LARGE BOWEL PROCEDURES W CC W/O MAJOR GI DX
 ;;571^6^1^MAJOR ESOPHAGEAL DISORDERS
 ;;572^8^^MAJOR GASTROINTESTINAL DISORDERS AND PERITONEAL INFECTIONS
 ;;573^11^1^MAJOR BLADDER PROCEDURES
 ;;574^16^^MAJOR HEMATOLOGIC/IMMUNOLOGIC DIAG EXC SICKLE CELL CRISIS & COAGUL
 ;;575^18^^SEPTICEMIA W MV96+ HOURS  AGE  >17
 ;;576^18^^SEPTICEMIA W/O MV96+ HOURS AGE  >17
 ;;577^1^1^CAROTID ARTERY STENT PROCEDURE
 ;;578^18^1^INFECTIOUS & PARASITIC DISEASES W OR PROCEDURE
 ;;579^18^1^POSTOPERATIVE OR POST-TRAUMATIC INFECTIONS W OR PROCEDURE
 ;;EXIT
 ;       
PRO ;-update operation/procedure codes
 ; from Table 6B in Fed Reg - assumes new codes already added by Lexicon
 D BMES^XPDUTL(">>>Modifying new op/pro codes - file 80.1")
 N LINE,X,ICDPROC,ENTRY,DA,DIE,DR,IDENT,MDC24,SUBLINE,DATA,FDA
 F LINE=1:1 S X=$T(REV+LINE) S ICDPROC=$P(X,";;",2) Q:ICDPROC="EXIT"  D
 .Q:ICDPROC["+"
 .S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",0))
 .I ENTRY D
 ..;check for possible inactive dupe
 ..I $P($G(^ICD0(ENTRY,0)),U,9)=1 S ENTRY=+$O(^ICD0("BA",$P(ICDPROC,U)_" ",ENTRY)) I 'ENTRY Q
 ..S DA=ENTRY,DIE="^ICD0("
 ..;the "O" (not zero) is from the OR column in Table 6B (a "Y" there), rest is as needed  
 ..S IDENT=$P(ICDPROC,U,2)
 ..S MDC24=$P(ICDPROC,U,3)
 ..S DR="2///^S X=IDENT;5///^S X=MDC24"
 ..I IDENT=""&(MDC24="") Q
 ..D ^DIE
 ..; check if already created in case patch being re-installed
 ..Q:$D(^ICD0(ENTRY,2,"B",3061001))
 ..;add 80.171, 80.1711 and 80.17111 records
 ..F SUBLINE=1:1 S X=$T(REV+LINE+SUBLINE) S DATA=$P(X,";;",2) Q:DATA'["+"  D
 ...I SUBLINE=1 D
 ....S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ....S FDA(1820,80.171,"+2,?1,",.01)=3061001
 ....D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 ...S DATA=$E(DATA,2,99)
 ...S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ...S FDA(1820,80.171,"?2,?1,",.01)=3061001
 ...S FDA(1820,80.1711,"+3,?2,?1,",.01)=$P(DATA,U)
 ...D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 ...S FDA(1820,80.1,"?1,",.01)="`"_ENTRY
 ...S FDA(1820,80.171,"?2,?1,",.01)=3061001
 ...S FDA(1820,80.1711,"?3,?2,?1,",.01)=$P(DATA,U)
 ...S FDA(1820,80.17111,"+4,?3,?2,?1,",.01)=$P(DATA,U,2)
 ...I $P(DATA,U,3) S FDA(1820,80.17111,"+5,?3,?2,?1,",.01)=$P(DATA,U,3)
 ...I $P(DATA,U,4) S FDA(1820,80.17111,"+6,?3,?2,?1,",.01)=$P(DATA,U,4)
 ...I $P(DATA,U,5) S FDA(1820,80.17111,"+7,?3,?2,?1,",.01)=$P(DATA,U,5)
 ...I $P(DATA,U,6) S FDA(1820,80.17111,"+8,?3,?2,?1,",.01)=$P(DATA,U,6)
 ...I $P(DATA,U,7) S FDA(1820,80.17111,"+9,?3,?2,?1,",.01)=$P(DATA,U,7)
 ...D UPDATE^DIE("","FDA(1820)") K FDA(1820)
 Q
 ; 
REV ;
 ;;00.44^^
 ;;00.56^Op^
 ;;+5^117^120
 ;;00.57^O^
 ;;+5^118^120
 ;;00.77^^
 ;;00.85^OM^2
 ;;+8^471^544
 ;;+21^442^443
 ;;+24^485
 ;;00.86^OM^2
 ;;+8^471^544
 ;;+10^292^293
 ;;+21^442^443
 ;;+24^485
 ;;00.87^OM^2
 ;;+8^471^544
 ;;+10^292^293
 ;;+21^442^443
 ;;+24^485
 ;;01.28^OQ^1
 ;;+1^1^2^3^543
 ;;+17^406^407^539^540
 ;;+21^442^443
 ;;+24^484
 ;;13.90^O^3
 ;;+2^39
 ;;+21^442^443
 ;;+24^486
 ;;13.91^O^3
 ;;+2^39
 ;;+21^442^443
 ;;+24^486
 ;;32.23^O^
 ;;+4^75
 ;;+17^406^407^539^540
 ;;32.24^O^
 ;;+4^76^7
 ;;32.25^O^
 ;;+4^75
 ;;+17^406^407^539^540
 ;;32.26^O^
 ;;+4^75
 ;;33.71^N^
 ;;+17^412
 ;;33.78^N^
 ;;+17^412
 ;;33.79^N^
 ;;+17^412
 ;;35.55^Oo^
 ;;+5^108
 ;;36.33^Oo^
 ;;+5^108
 ;;36.34^Oo^
 ;;+5^108
 ;;37.20^^
 ;;39.74^OQ^3
 ;;+1^1^2^3^543
 ;;+21^442^443
 ;;+24^486
 ;;50.23^O^
 ;;+6^170^171
 ;;+7^191^192
 ;;50.24^O^
 ;;+6^170^171
 ;;+7^191^192
 ;;50.25^O^
 ;;+6^170^171
 ;;+7^191^192
 ;;50.26^O^
 ;;+6^170^171
 ;;+7^191^192
 ;;55.32^O^
 ;;+11^303^304^305
 ;;55.33^O^
 ;;+11^303^304^305
 ;;55.34^O^
 ;;+11^303^304^305
 ;;55.35^O^
 ;;+11^303^304^305
 ;;68.41^O^
 ;;+13^354^355^357^358^359
 ;;+14^375
 ;;68.49^O^
 ;;+13^354^355^357^358^359
 ;;+14^375
 ;;68.61^O^
 ;;+13^353
 ;;+14^375
 ;;68.69^O^
 ;;+13^353
 ;;+14^375
 ;;68.71^O^
 ;;+13^353
 ;;+14^375
 ;;68.79^O^
 ;;+13^353
 ;;+14^375
 ;;EXIT
