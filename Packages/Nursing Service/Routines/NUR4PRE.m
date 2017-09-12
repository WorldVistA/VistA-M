NUR4PRE ;HIRMFO/FT-NUR*4*4 Pre-init ; 8/14/97 12:31
 ;;4.0;NURSING SERVICE;**4**;Apr 25, 1997
 D BMES^XPDUTL("Changing Menu Text value for [NURCPE-VIT CAT/QUAL TABLE] option.")
 S DA=$O(^DIC(19,"B","NURCPE-VIT CAT/QUAL TABLE",0)) Q:DA'>0  D
 .S DIE="^DIC(19,",DR="1///"_"Display Vitals Category/Qualifier/Synonym Table" D ^DIE
 .Q
 K DA,DIE,DR
 Q
