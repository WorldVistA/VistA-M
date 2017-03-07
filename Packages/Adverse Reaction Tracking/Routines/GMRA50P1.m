GMRA50P1 ;VIP/WW - PATCH 50 POST INSTALL ; 19 Oct 2015
 ;;4.0;Adverse Reaction Tracking;**50**;Oct 19, 2015;Build 3
 ;
 ; This post-installation routine will add the mailgroup
 ; ADVERSE_ALLERGY_WARNING to receive Allergy/Adverse Reactions
 ; Without a VA Drug Class.
 ;
POST ; Entry point. Check for existance and create if not there.
 ;
 N FIND,MG
 ;
 S MG="ADVERSE_ALLERGY_WARNING"
 S FIND=$$FIND1^DIC(3.8,"","",MG)
 ;
 I FIND D  Q
  .D BMES^XPDUTL(">>> Mail group "_MG_" already exists...nothing added")
 ;
 S FIND=$$MG^XMBGRP(MG,0,0,1,,1,1)
 ;
 I FIND D  Q
  .D BMES^XPDUTL(">>> Mail group: "_MG_" added successfully!")
  .D BMES^XPDUTL("    Please add members as appropriate for those")
  .D MES^XPDUTL("    who should receive notice of VA Drug Class field")
  .D MES^XPDUTL("    is empty.")
 ;
 I 'FIND  D  Q
  .D BMES^XPDUTL(">>> NOTE:   Mail group: "_MG_" not added!!!")
  .D MES^XPDUTL("    ERROR:  "_FIND)
  .D BMES^XPDUTL("    Please check your file and type")
  .D MES^XPDUTL("    D EN^ESP116PT to try again.")
 ;
 Q
