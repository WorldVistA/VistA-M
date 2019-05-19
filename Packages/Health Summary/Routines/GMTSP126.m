GMTSP126 ;HPSC/MWA Health Summary Spinal Cord Dysfunction Decommission Routine ; 11/13/18 3:42pm
 ;;2.7;Health Summary;**126**;Oct 20, 1995;Build 3
 ;
EN ; entry point
 N DA,DIK,SCDIEN,I
 S SCDIEN=$O(^GMT(142.1,"B","SPINAL CORD DYSFUNCTION",""))
 I SCDIEN D
 . ;find types with scd comp
 .S I="" F  S I=$O(^GMT(142,"AE",SCDIEN,I)) Q:'I  D
 ..S DIK="^GMT(142,"_I_",1,",DA(1)=I,DA=$O(^GMT(142,"AE",SCDIEN,I,""))
 ..D ^DIK ; delete component off type "stucture" multiple
 .S DIK="^GMT(142.1,",DA=SCDIEN
 .D ^DIK ;delete component itself
 S SCDIEN=$O(^GMT(142,"B","SPINAL CORD DYSFUNCTION",""))
 I SCDIEN D
 .S DIK="^GMT(142,",DA=SCDIEN
 .D ^DIK ;delete component itself
 K DA,DIK
 Q
