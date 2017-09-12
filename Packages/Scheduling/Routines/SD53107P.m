SD53107P ;ALB/REV - PST-INST SD*5.3*107 UPDATE ^SC("TEAM" XREF 3/10/97 
 ;;5.3;SCHEDULING;**107**;AUG 13, 1993
EN ;
 N SCCLTM,DIK
 D BMES^XPDUTL("Beginning cleanup of team cross-reference in")
 D MES^XPDUTL("Hospital Location file . . .")
 D KILLOLD
 D ADDNEW
 D BMES^XPDUTL("Cross-references corrected!")
 Q
 ;
KILLOLD ;  if team in SC("TEAM" not in 404.51, kill the XREF entry
 D BMES^XPDUTL("Removing invalid cross-references.")
 S SCCLTM=""
 F  S SCCLTM=$O(^SC("TEAM",SCCLTM)) Q:SCCLTM=""  D
 .I '$D(^SCTM(404.51,"B",SCCLTM)) K ^SC("TEAM",SCCLTM)
 Q
 ;
ADDNEW ;  make sure each team with assoc clinics has an SC("TEAM" xref
 D BMES^XPDUTL("Updating cross-references from TEAM file.")
 S DIK="^SCTM(404.51,",DIK(1)=".01^ASCTEAM" D ENALL^DIK
 Q
 ;
