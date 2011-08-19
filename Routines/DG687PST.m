DG687PST ;BAY/JAT;cleanup of "AADA" crossref on file 45
 ;;5.3;Registration;**687*;Aug 13,1993
 ;
 ; This is a post-init routine for DG*5.3*687
 ; The purpose is to cleanup the "AADA" crossreference on field #70
 ; of the Patient Treatment file (#45).  Any entries for which 
 ; there is no PTF zero node is to be deleted.
 ;
EN ;
 D BMES^XPDUTL("Deleting bogus ""AADA"" cross references")
 N DGDTE,DGPTIEN,CNT
 S DGDTE=0
 S CNT=0
 F  S DGDTE=$O(^DGPT("AADA",DGDTE)) Q:'DGDTE  D
 .S DGPTIEN=0
 .F  S DGPTIEN=$O(^DGPT("AADA",DGDTE,DGPTIEN)) Q:'DGPTIEN  D 
 ..I '$D(^DGPT(DGPTIEN,0)) D
 ...S CNT=CNT+1
 ...K ^DGPT("AADA",DGDTE,DGPTIEN)
 Q
