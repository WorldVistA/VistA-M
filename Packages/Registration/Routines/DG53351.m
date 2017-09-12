DG53351 ;ALB/JAN - Post-Install to clean Enrollment Status ; 6-22-2001
 ;;5.3;Registration;**351**;June 22, 2001
 ;
 ; This routine is a post-installation for patch DG*5.3*351
 ;
 ; The clean up is required as there are a number of multiple entries
 ; in the "AENRC" cross-reference of the PATIENT file (#2).  When
 ; appropriate, this field will be populated via a trigger on ENROLLMENT
 ; STATUS field (#.04) of the PATIENT ENROLLMENT file (#27.11).
 ;
 ; ^XTMP("DG-DTC") track number of records processed.
 ; ^XTMP("DG-AENRC") contains multiple entries in "AENRC" x-reference
 ;
POST ;
 ; Post-install set up checkpoint and tracking global...
 K ^XTMP("DG-DTC"),^XTMP("DG-AENRC")
 N %,I,X,X1,X2
 I $D(XPDNM) D
 . ; checkpoints
 .I $$VERCP^XPDUTL("STATUS")'>0 D
 ..S %=$$NEWCP^XPDUTL("STATUS","",0)
 .I $$VERCP^XPDUTL("DGDFN")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGDFN","",0)
 ;
 ; initialize tracking global (see text above for description)...
 F I="DTC","AENRC" D
 .I $D(^XTMP("DG-"_I)) Q
 .S X1=DT,X2=30 D C^%DTC
 .S ^XTMP("DG-"_I,0)=X_U_$$DT^XLFDT_"^DG*5.3*351 POST INSTALL "_$S(I="DTC":"record count",I="AENRC":"records corrected",1:"filing errors")
 I '$D(XPDNM) S ^XTMP("DG-DTC",1)=0
 ;
EN ; begin processing...
 N %
 ; check status and if root checkpoint has not completed start clean up
 I $D(XPDNM) S %=$$VERCP^XPDUTL("STATUS") I '$D(^XTMP("DG-DTC",1)) S ^XTMP("DG-DTC",1)=0
 I $G(%)="" S %=0
 I %=0 D EN1
 Q
 ;
EN1 ; begin cleanup
 D DGLOOP
 ; send mailman message to users with results
 D MAIL^DG53351M
 I $D(XPDNM) S %=$$COMCP^XPDUTL("STATUS"),%=$$COMCP^XPDUTL("DGDFN")
 D BMES^XPDUTL(" >> cleanup process completed "_$$FMTE^XLFDT($$NOW^XLFDT))
 K ^XTMP("DG-DTC"),^XTMP("DG-AENRC")
 Q
 ;
DGLOOP ;
 ; write message to installation device and to INSTALL file (#9.7)
 D BMES^XPDUTL("POST INSTALLATION PROCESSING")
 D MES^XPDUTL("----------------------------")
 D MES^XPDUTL("Once the post-install is completed, a mail message will")
 D MES^XPDUTL("be sent that will report the number of multiple entries")
 D MES^XPDUTL("of enrollment status that were cleaned up.")
 D BMES^XPDUTL("Beginning clean-up process "_$$FMTE^XLFDT($$NOW^XLFDT))
 ;
 ; process control body
 N DGDFN,IEN,STATUS,DGSTATUS
 ;
 ; start loop "AENRC" x-ref in PATIENT file to search for multiple
 ; entries of current enrollment status.
 I '$D(XPDNM) S STATUS=0
 I $D(XPDNM) S STATUS=$$PARCP^XPDUTL("STATUS"),DGDFN=$$PARCP^XPDUTL("DGDFN")
 ; loop "AENRC" x-ref and check for multiple entries
 N DGPAT,DGSSN,DGENR
 F  S STATUS=$O(^DPT("AENRC",STATUS)) Q:'STATUS  D
 .S DGDFN=0 F  S DGDFN=$O(^DPT("AENRC",STATUS,DGDFN)) Q:'DGDFN  D
 ..S DGSTATUS=$$STATUS^DGENA(DGDFN)
 ..I $G(DGSTATUS)="",$D(^DPT("AENRC",STATUS,DGDFN)) D
 ...S DGENR="NULL VALUE IN FILE #27.11" D KILL1
 ..I +$G(DGSTATUS),STATUS'=DGSTATUS,$D(^DPT("AENRC",DGSTATUS,DGDFN)) D
 ...S DGENR=$P($G(^DGEN(27.15,STATUS,0)),U) D KILL1
 ...S ^DPT("AENRC",DGSTATUS,DGDFN)=""
 ..I $D(XDPNM) S %=$$UPCP^XPDUTL("DGDFN")
 .I $D(XPDNM) S %=$$UPCP^XPDUTL("STATUS")
 Q
KILL1 ; Cleanup those entries in "AENRC" x-ref in the PATIENT file that have
 ; multiple entries
 S DGPAT=$P($G(^DPT(DGDFN,0)),U),DGSSN=$E($P($G(^DPT(DGDFN,0)),U,9),6,9)
 S ^XTMP("DG-AENRC",DGDFN,STATUS)=DGPAT_"^"_DGSSN_"^"_DGENR
 S ^XTMP("DG-DTC",1)=$G(^XTMP("DG-DTC",1))+1
 D KILL1^DGENDD(DGDFN)
 Q
