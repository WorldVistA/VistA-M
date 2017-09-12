ENXHIPR ;WISC/SAB-PRE INIT ;4/1/97
 ;;7.0;ENGINEERING;**28**;Aug 17, 1993
 N ENDA,ENY
 D MES^XPDUTL("  Performing Pre-Init...")
 ; This patch renames field #74 from A/E SITE SURVEY to A/E SITE VISITS.
 ; It also adds a new field #72.3 called A/E SITE SURVEY.
 ; This pre-init routine will move any existing data values from #74
 ; to #72.3. This should only be done once so the pre-init checks
 ; that field #74 has not yet been renamed before moving data.
 I $$GET1^DID(6925,74,"","LABEL")="A/E SITE SURVEY" D
 . D MES^XPDUTL("    Moving A/E SITE SURVEY data to new location...")
 . S ENDA=0 F  S ENDA=$O(^ENG("PROJ",ENDA)) Q:'ENDA  D
 . . S ENY=$G(^ENG("PROJ",ENDA,5))
 . . I $P(ENY,U,5)]"",$P(ENY,U,10)="" D
 . . . S $P(ENY,U,10)=$P(ENY,U,5)
 . . . S $P(ENY,U,5)=""
 . . . S ^ENG("PROJ",ENDA,5)=ENY
 . . S ENY=$G(^ENG("PROJ",ENDA,64))
 . . I $P(ENY,U,5)]"",$P(ENY,U,10)="" D
 . . . S $P(ENY,U,10)=$P(ENY,U,5)
 . . . S $P(ENY,U,5)=""
 . . . S ^ENG("PROJ",ENDA,64)=ENY
 D MES^XPDUTL("  Completed Pre-Init")
 Q
 ;ENXHIPR
