MPIFPST1 ;CMC/SF-MPI VISTA build post-init ;JAN 13, 2000
 ;;1.0; MASTER PATIENT INDEX VISTA ;**1**;30 Apr 99
 ;
EN ;This post init will correct any exiting problems with the setting of
 ; the ^DPT("AICNL" cross reference for local ICNs or the field Locally
 ; assigned ICN in the patient file for local ICNs.
 ;
 D BMES^XPDUTL("Updating 'AICNL' Cross Reference.  This may take some time")
 N EN,LOCAL,ICN,SITE
 S ICN=0,SITE=$P($$SITE^VASITE(),"^",3)
 F  S ICN=$O(^DPT("AICN",ICN)) Q:ICN=""  D
 .S EN=""
 .F  S EN=$O(^DPT("AICN",ICN,EN)) Q:EN=""  D
 ..I $E(ICN,1,3)=SITE D
 ...I $P($G(^DPT(EN,"MPI")),"^")=ICN S LOCAL=$$SETLOC^MPIF001(EN,1),^DPT("AICNL",1,EN)=""
 Q
 ;
