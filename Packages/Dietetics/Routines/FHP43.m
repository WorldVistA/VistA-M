FHP43 ;EPIP/WLE - Remove three data dictionary fields for file 115 ;6/5/2018 3:45 PM
 ;;5.5;DIETETICS;**43**;Jan 28, 2005;Build 66
 ; Post install routine for patch FH*5.5*43 to remove fields created in a previous version at test sites
 ; Copy the old data at ^FHPT(IEN,662910) to ^FHPT(IEN,22)
 ; then remove the old data and node
EN ;
 I '$$VFIELD^DILFD(115,662910.01) Q  ; The fields do not exist so no reason to continue
 D BMES^XPDUTL("If NUTRITION PERSON FILE #115 has existing tray tickets flags. The data will be moved to a new node.")
 S IEN="" F  S IEN=$O(^FHPT(IEN)) Q:IEN=""  D
  .I $D(^FHPT(IEN,662910)) S ^FHPT(IEN,22)=^FHPT(IEN,662910) K ^FHPT(IEN,662910)
 D BMES^XPDUTL("If NUTRITION PERSON FILE #115 had data it has been moved to the new node.")
 ;
 ; delete the old fields in file 115 
 S DIK="^DD(115,",DA=662910.01,DA(1)=115
 D ^DIK
 S DIK="^DD(115,",DA=662910.02,DA(1)=115
 D ^DIK
 S DIK="^DD(115,",DA=662910.03,DA(1)=115
 D ^DIK
 K DIK,DA,DA(1)
 Q
