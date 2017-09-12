DG53358 ;ALB/AEG - DG*5.3*358 POST INSTALL TO MAIL MSG ;3-5-2001
 ;;5.3;Registration;**358**;3-5-2001
 ;
 ; This routine is a post-installation for patch DG*5.3*358
 ;
 ; This routine will perform a number of database clean-up 
 ; functions.  The primary functionality will cleanup 
 ; inconsistent data between the CURRENT MEANS TEST STATUS
 ; field (#.14) of the PATIENT file (#2) and the STATUS 
 ; field (#.03) of the ANNUAL MEANS TEST file (#408.31).  In
 ; all instances, data in file #408.31 is considered correct
 ; as the Patient file is populated via a trigger on .03 field
 ; of file 408.31.
 ;
 ; The second issue being cleaned up deals with those patients
 ; that have expired and a Means test in the status of No Longer
 ; Required or Required.  In both instances it is possible to 
 ; to have a test on file dated after the patient has expired.
 ; In this instance, these tests are not valid and will be
 ; purged.  In the instance where the test date is on or before
 ; the date of death the NLR status tests' status will be 
 ; recalculated and set to it's previous value. In the case of 
 ; REQUIRED status and date of test is on or before DOD these
 ; will be reported to need completion to the user running this
 ; task.
 ;
EN ; Main entry point for post-installation.
 D INIT
 Q
INIT ; Initialize tracking global and associated checkpoints.
 K ^TMP($J),^XTMP("DG-BADEN"),^XTMP("DG-BADST"),^XTMP("DG-DGDOA")
 N %,I,X,X1,X2
 ; Create Checkpoints
 I $D(XPDNM) D
 .I $$VERCP^XPDUTL("DGDFN")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGDFN","",0)
 .I $$VERCP^XPDUTL("MTIEN")'>0 D
 ..S %=$$NEWCP^XPDUTL("MTIEN","",0)
 .I $$VERCP^XPDUTL("DGDOA")'>0 D
 ..S %=$$NEWCP^XPDUTL("DGDOA","",0)
 ;
 ; initialize tracking global(s)
 F I="BADEN","BADST","DGDOA" D
 .I $D(^XTMP("DG-"_I)) Q
 .S X1=DT,X2=30 D C^%DTC
 .S ^XTMP("DG-"_I,0)=X_U_$$DT^XLFDT_"^DG*5.3*358 POST INSTALL "
 .S ^XTMP("DG_"_I,0)=^XTMP("DG-"_I,0)_$S(I="BADEN":"No means test on file",I="BADST":"Records corrected",1:"errors")
 I '$D(XPDNM) S (^XTMP("DG-BADEN",1),^XTMP("DG-BADST",1),^XTMP("DG-DGDOA",1))=0
 ; check status and if root checkpoint has not completed start clean up
 I $D(XPDNM) S %=$$VERCP^XPDUTL("DGDFN")  D
 .I '$D(^XTMP("DG-BADEN",1)) S ^XTMP("DG-BADEN",1)=0
 .I '$D(^XTMP("DG-BADST",1)) S ^XTMP("DG-BADST",1)=0
 .I '$D(^XTMP("DG-DGDOA",1)) S ^XTMP("DG-DGDOA",1)=0
 I $G(%)="" S %=0
 I %=0 D EN1
 Q
EN1 ; Control logic flow and implement cleanup in phases
 D LOOP,PAT,BADEN
 D DOAN^DG53358A
 D DOAR^DG53358A
 I $D(XPDNM) D
 .S %=$$COMCP^XPDUTL("DGDFN")
 .S %=$$COMCP^XPDUTL("MTIEN")
 .S %=$$COMCP^XPDUTL("DGDOA")
 Q
LOOP ; Start loop in patient file to search for records with status
 ; inconsistency problems as well as DOD issues.
 ;
 D BMES^XPDUTL("POST INSTALLATION PROCESSING")
 D MES^XPDUTL("------------------------------")
 D MES^XPDUTL("Once the post installation has completed, six mail messages")
 D MES^XPDUTL("will be generated to report the number of inconsistencies")
 D MES^XPDUTL("corrected as well as the Means Tests requiring completion.")
 D BMES^XPDUTL("PHASE I - Search engine started at "_$$FMTE^XLFDT($$NOW^XLFDT))
 D BMES^XPDUTL("Each "_"'.'"_" represents approximately 200 records ")
 N DGDFN,MTIEN,DGMTDT,DGCNT,DGDOA
 S (DGDFN,MTIEN,DGMTDT)=""
 S DGDFN=0 F DGCNT=1:1 S DGDFN=$O(^DPT(DGDFN)) Q:'+DGDFN  D
 .I '$D(ZTQUEUED) W:'(DGCNT#200) "."
 .; If patient does NOT have a date of death process
 .D
 ..N DPTSTAT,DGMTSTAT,DGMTDT
 ..; If a MT is on file, check the status field (.03) against the
 ..; current MT status field (.14) in patient file.  They should match.
 ..S MTIEN=$$LST^DGMTU(DGDFN,"",1)
 ..I +$G(MTIEN) D
 ...S DPTSTAT=$P($G(^DPT(DGDFN,0)),U,14),DGMTSTAT=$P($G(^DGMT(408.31,+MTIEN,0)),U,3)
 ...D:DPTSTAT'=DGMTSTAT
 ....S ^TMP($J,"BADST",DGDFN,+MTIEN)=DPTSTAT_U_DGMTSTAT
 ....; increment the counter for this inconsistency type
 ....S ^XTMP("DG-BADST",1)=$G(^XTMP("DG-BADST",1))+1
 ....Q
 ...Q
 ..; update checkpoint
 ..I $D(XPDNM) S %=$$UPCP^XPDUTL("MTIEN",+MTIEN)
 ..; If no means test is on file but the current means test status field
 ..; is populated, there is a consistency problem.  Store this info. to
 ..; to be used for later cleanup.
 ..I '+$G(MTIEN) D
 ...S DPTSTAT=$P($G(^DPT(DGDFN,0)),U,14)
 ...I +DPTSTAT D
 ....S ^TMP($J,"BADEN",DGDFN,DPTSTAT)=""
 ....; Increment Counter
 ....S ^XTMP("DG-BADEN",1)=$G(^XTMP("DG-BADEN",1))+1
 ....Q
 ...Q
 ..Q
 .I $D(XPDNM) S %=$$UPCP^XPDUTL("DGDFN",DGDFN)
 .; Process if a date of death exists.
 .N DGDT,DGIDT,DGMTI,DGMTST,DGNODE
 .D:$P($G(^DPT(DGDFN,.35)),U)'=""
 ..S DGDOA=$P($G(^DPT(DGDFN,.35)),U)
 ..S DGDT="",DGIDT=$S($G(DGDT)>0:-DGDT,1:-DT) S:'$P(DGIDT,".",2) DGIDT=DGIDT_.2359
 ..F  S DGIDT=+$O(^DGMT(408.31,"AID",1,DGDFN,DGIDT)) Q:'DGIDT  D
 ...F DGMTI=0:0 S DGMTI=$O(^DGMT(408.31,"AID",1,DGDFN,DGIDT,DGMTI)) Q:'DGMTI  D
 ....S DGNODE=$G(^DGMT(408.31,DGMTI,0)),DGMTST=$P(DGNODE,U,3)
 ....Q:$P($G(DGNODE),U,19)'=1
 ....I DGNODE,$G(^("PRIM")) S MTIEN=DGMTI_"^"_$P(DGNODE,U)_"^"_$$MTS^DGMTU(DGDFN,DGMTST)_"^"_$P(DGNODE,U,23)
 ....; Process NO LONGER REQUIRED status expired patients
 ....I $G(MTIEN),$P(MTIEN,U,4)="N" D
 .....S ^TMP($J,"DGDOA-N",DGDFN,$P(MTIEN,U,2),DGDOA)=$G(MTIEN)
 .....; Increment NLR counter
 .....S ^XTMP("DG-DGDOA",1)=$G(^XTMP("DG-DGDOA",1))+1
 .....I $D(XPDNM) S %=$$UPCP^XPDUTL("DGDOA",DGDOA)
 ....; Process REQUIRED status expired patients.
 ....I $G(MTIEN),$P(MTIEN,U,4)="R" D
 .....S ^TMP($J,"DGDOA-R",DGDFN,$P(MTIEN,U,2),DGDOA)=$G(MTIEN)
 .....S ^XTMP("DG-DGDOA",1)=$G(^XTMP("DG-DGDOA",1))+1
 .....I $D(XPDNM) S %=$$UPCP^XPDUTL("DGDOA",DGDOA)
 ....I $D(XPDNM) S %=$$UPCP^XPDUTL("MTIEN",+MTIEN)
 .I $D(XPDNM) S %=$$UPCP^XPDUTL("DGDFN",DGDFN)
 I $D(XPDNM) S %=$$UPCP^XPDUTL("DGDFN",DGDFN)
 D BMES^XPDUTL("Total Records reviewed - "_(DGCNT-1))
 D MES^XPDUTL("PHASE I search of the patient file completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 Q
PAT ; Use data we stored in ^TMP($J,"BADST" node and clean up the data
 I '$D(^TMP($J,"BADST")) D  Q
 .D BMES^XPDUTL("PHASE II of processing has no inconsistent data to correct")
 .D MBDST^DG53358M
 .D MES^XPDUTL("PHASE II processing completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 I $D(^TMP($J,"BADST")) D
 .D BMES^XPDUTL("PHASE II of the cleanup processing started on "_$$FMTE^XLFDT($$NOW^XLFDT))
 .D BMES^XPDUTL("This phase of the process will cleanup those entries in the patient file")
 .D MES^XPDUTL("that have inconsistent status entries in the CURRENT MEANS")
 .D MES^XPDUTL("TEST STATUS field (#.14) of the PATIENT file (#2) ")
 .N DGDFN,MTIEN,DGCNT,DGMTSTAT
 .S (DGDFN,MTIEN)=""
 .F DGCNT=1:1 S DGDFN=$O(^TMP($J,"BADST",DGDFN)) Q:'+DGDFN  S MTIEN="" F  S MTIEN=$O(^TMP($J,"BADST",DGDFN,MTIEN)) Q:MTIEN=""  D
 ..I '$D(ZTQUEUED) W:'(DGCNT#100) "."
 ..S DPTSTAT=$P($G(^TMP($J,"BADST",DGDFN,MTIEN)),U,1)
 ..I DPTSTAT'="",DGDFN S X=DPTSTAT,DA=DGDFN D
 ...; Kill 'ACS' x-ref entry using ^DD kill logic
 ...X ^DD(2,.14,1,1,2)
 ...; Set corresponding data field to null
 ...S $P(^DPT(DGDFN,0),U,14)=""
 ...I $D(XPDNM) S %=$$UPCP^XPDUTL("DGDFN",DGDFN)
 ..;
 ..; Update file 408.31 status field (#.03) so that 'M' trigger fires 
 ..; correctly to populate field #.14 of patient file.  DIE call used
 ..; vs. DBS call so that trigger fires correctly.
 ..S DGMTSTAT=$P($G(^TMP($J,"BADST",DGDFN,MTIEN)),U,2)
 ..I DGMTSTAT'="",MTIEN D
 ...S DA=MTIEN,DIE="^DGMT(408.31,",DR=".03////"_DGMTSTAT
 ...L +^DGMT(408.31,MTIEN):1
 ...D ^DIE
 ...L -^DGMT(408.31,MTIEN):1
 ...I $D(XPDNM) S %=$$UPCP^XPDUTL("MTIEN",MTIEN)
 ...S ^TMP($J,"PAT",$P($G(^DPT(DGDFN,0)),U,1)_U,MTIEN)=DGDFN_U_DPTSTAT_U_MTIEN_U_DGMTSTAT
 ...K ^TMP($J,"BADST",DGDFN,MTIEN)
 ..K DA,DR,DIE
 ..Q
 .Q
 D MBDST^DG53358M
 D MES^XPDUTL("PHASE II processing completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 Q
BADEN ; Cleanup those entries in the patient file where the current means
 ; test status field (#.14) is populated; however, there is not a means
 ; test on file for the patient.
 N DGDFN,DGCNT
 I '$D(^TMP($J,"BADEN")) D  Q
 .D BMES^XPDUTL("PHASE III of processing has no inconsistent data to correct")
 .D BADEN^DG53358M
 .D MES^XPDUTL("PHASE III processing completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 I $D(^TMP($J,"BADEN")) D
 .D BMES^XPDUTL("Updating records in the patient file that don't have a corresponding")
 .D MES^XPDUTL("means test. ")
 .S DGDFN="" F DGCNT=1:1 S DGDFN=$O(^TMP($J,"BADEN",DGDFN)) Q:'+DGDFN  S MTIEN="" F  S MTIEN=$O(^TMP($J,"BADEN",DGDFN,MTIEN)) Q:MTIEN=""  D
 ..I '$D(ZTQUEUED) W:'(DGCNT#100) "."
 ..S X=MTIEN,DA=DGDFN
 ..; Kill 'ACS' x-ref using DD logic
 ..X ^DD(2,.14,1,1,2)
 ..; Set data node to null
 ..S $P(^DPT(DGDFN,0),U,14)=""
 ..I $D(XPDNM) D
 ...S %=$$UPCP^XPDUTL("DGDFN",DGDFN)
 ...S %=$$UPCP^XPDUTL("MTIEN",MTIEN)
 ...Q
 ..Q
 .Q
 D MES^XPDUTL("PHASE III processing completed on "_$$FMTE^XLFDT($$NOW^XLFDT))
 D BADEN^DG53358M
 Q
