ECX3P143 ;ALB/DAN - Patch 143 Post-install ;12/5/12  13:06
 ;;3.0;DSS EXTRACTS;**143**;Dec 22, 1997;Build 4
 ;
POST ;Clean up BCMA EXTRACT file
 N FIEN
 D BMES^XPDUTL("Removing existing entries from BCMA EXTRACT file (#727.833)")
 K ^ECX(727.833) ;remove all existing entries
 S ^ECX(727.833,0)="BCMA EXTRACT^727.833^^" ;reset zero node
 ;Search for extracts in the DSS EXTRACT LOG and set purge date
 S FIEN=0 F  S FIEN=$O(^ECX(727,"D","BAR CODE MEDICATION ADM",FIEN)) Q:'+FIEN  S ^ECX(727,FIEN,"PURG")=$$DT^XLFDT
 D BMES^XPDUTL("All existing entries have been removed from the BCMA EXTRACT file (#727.833)")
 Q
