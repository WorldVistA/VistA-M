GMRVXCH0 ;HIRMFO/RM,YH-CONVERT QUALIFIER/CATEGORY FILES ;4/22/97
 ;;4.0;Vitals/Measurements;;Apr 25, 1997
EN ; Driver to run both qualifier and Category Conversions
 ;
 ; Check to see if Conversion run
 Q:+$G(^GMRD(120.57,1,"PHASEI"))>0
 D BMES^XPDUTL("Running Qualifier/Category Conversion...")
 ;
 ; Build conversion tables (Char. and Cat.).
 D ^GMRVXCHT
 ;
 ; Move data from 120.53 to 120.52 file.
 D MOVE53^GMRVXCH2
 ;
 ; Kill off data in 120.53 file.
 S GMRVZERO=$P($G(^GMRD(120.53,0)),"^",1,2)
 I GMRVZERO="" S GMRVZERO="GMRV VITAL CATEGORY^120.53"
 K ^GMRD(120.53) S ^GMRD(120.53,0)=GMRVZERO
 ;
 ; Kill of xrefs in 120.52 and 120.53 files.
 F GMRVFILE=120.52,120.53 D
 .  S DA(1)="" F  S DA(1)=$O(^GMRD(GMRVFILE,DA(1))) Q:DA(1)=""  D
 .  .  I DA(1)>0 S DA="A" F  S DA=$O(^GMRD(GMRVFILE,DA(1),1,DA)) Q:DA=""  K ^GMRD(GMRVFILE,DA(1),1,DA)
 .  .  I DA(1)'>0,DA(1)'=0 K ^GMRD(GMRVFILE,DA(1))
 .  .  Q
 .  Q
 ;
 ; Build GMRV Vital Category file from ^TMP($J,"GMRVCAT")
 D CONV53^GMRVXCH3
 ;
 ; Convert GMRV Vital Qualifier entries from ^TMP($J,"GMRVCHAR")
 D CONV52^GMRVXCH2
 ;
 ; Update Conversion Flag in 120.57 file.
 S DIK="^GMRD(120.52," D IXALL^DIK
 S DIK="^GMRD(120.53," D IXALL^DIK
 S $P(^GMRD(120.57,1,"PHASEI"),"^")=1
 ;
 ; Clean up and quit
 K ^TMP($J,"GMRVCHAR"),^TMP($J,"GMRVCAT"),DA,GMRVFILE,GMRVZERO
 Q
EN1 ; Post-init tasks for Qualifier and Category Conversions
 ; Add new qualifier/categories and re-index 120.52 and 120.53 files in post-init.
 ;
 Q:+$G(^GMRD(120.57,1,"PHASEII"))>0
 D ADDCAT^GMRVXCH1 D BMES^XPDUTL("Re-indexing 120.53 file...")
 S DIK="^GMRD(120.53," D IXALL^DIK
 D ADDCHAR^GMRVXCH1 D BMES^XPDUTL("Re-indexing 120.52 file...")
 S DIK="^GMRD(120.52," D IXALL^DIK
 ;CONVERT DEFAULT TEXT TO POINTER TO 120.52 IN 120.53 FILE
 K DIK D DEFAULT^GMRVXCH3
 Q
