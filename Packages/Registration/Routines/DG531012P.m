DG531012P ;OIT/KCL - POST-INSTALL ROUTINE FOR DG*5.3*1012 ;5/1/2020
 ;;5.3;Registration;**1012**;Aug 13,1993;Build 5
 ;
 ;no direct entry
 Q
 ;
POST ;Main entry point for post-install item(s)
 ;
 D POST1
 Q
 ;
POST1 ;Queue off job to file HISTORIC KATRINA ERI
 ;
 ;Queue off a job to file HISTORIC KATRINA ERI for patients(DFNs) temporarily
 ;stored in the ^XTMP("DG531011P") global by patch DG*5.3*1011.
 ;
 ; External References:
 ;  ICR#   TYPE  DESCRIPTION
 ;  -----  ----  -----------
 ;  10063  Sup   ^%ZTLOAD
 ;  10141  Sup   ^XPDUTL:BMES, MES, PATCH
 ;  10103  Sup   NOW^XLFDT
 ;
 ;new ^%ZTLOAD input vars
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK,ZTSAVE
 ;
 D BMES^XPDUTL(">>> Patients (DFNs) temporarily stored in ^XTMP(""DG531011P"") global")
 D MES^XPDUTL("    by patch DG*5.3*1011 had an Emergency Response Indicator (ERI)")
 D MES^XPDUTL("    of 'HURRICANE KATRINA'. For historical purposes, this data will")
 D MES^XPDUTL("    now be filed back into the patient's record. It will be stored in")
 D MES^XPDUTL("    the HISTORIC KATRINA ERI (#.182) field of the PATIENT (#2) file.")
 ;
 ;quit if patch previously installed
 I $$PATCH^XPDUTL("DG*5.3*1012") D BMES^XPDUTL("    - Not needed since patch DG*5.3*1012 has been installed previously.") Q
 ;
 ;quit if ^xtmp global does not exist
 I '$D(^XTMP("DG531011P")) D BMES^XPDUTL("    - Not needed since ^XTMP(""DG531011P"") global does not exist.") Q
 ;
 ;queue off job to file HISTORIC KATRINA ERI
 S ZTRTN="FILEHERI^DG531012P" ;DO "LABEL^ROUTINE"
 S ZTDESC="DG*5.3*1012 Post-Install Process (File HISTORIC KATRINA ERI)" ;task description
 S ZTDTH=$$NOW^XLFDT ;start time
 S ZTIO="" ;device the task should use, NULL=no device is used
 S ZTSAVE=("DUZ")="" ;save installer DUZ for job
 D ^%ZTLOAD
 ;
 ;if job successfully queued
 I $G(ZTSK) D
 . D BMES^XPDUTL("    - File HISTORIC KATRINA ERI job has been queued.")
 . D MES^XPDUTL("      The task number is: "_$G(ZTSK)_".")
 . D BMES^XPDUTL("    - A MailMan message containing job results will be sent")
 . D MES^XPDUTL("      to the patch installer.")
 ;
 ;if job not successfully queued
 I '$G(ZTSK) D
 . D BMES^XPDUTL("    *********************************************************")
 . D MES^XPDUTL("    *                !!!! WARNING !!!!                      *")
 . D MES^XPDUTL("    *                                                       *")
 . D MES^XPDUTL("    * Job to file HISTORIC KATRINA ERI could not be queued. *")
 . D MES^XPDUTL("    * Please log YOUR IT Services ticket for assistance.    *")
 . D MES^XPDUTL("    *                                                       *")
 . D MES^XPDUTL("    *********************************************************")
 Q
 ;
FILEHERI ;File Historical Emergency Response Indicator Job
 ;
 ;Patients (DFNs) temporarily stored in ^XTMP("DG531011P") global by patch DG*5.3*1011 had
 ;an Emergency Response Indicator (ERI) of 'HURRICANE KATRINA'. For historical purposes,
 ;this data will now be filed back into the patient's record. It will be stored in the 
 ;new HISTORIC KATRINA ERI (#.182) field of the PATIENT (#2) file. A MailMan message will
 ;be sent to the patch installer (DUZ) with the results of the job.
 ;
 ; External References:
 ;  ICR#   TYPE  DESCRIPTION
 ;  -----  ----  -----------
 ;  2053   Sup   FILE^DIE
 ;
 ;new vars
 N DGCNT1,DGCNT2,DGCNT3,DGERR,DGFDA,DGDFN,DGIENS,DGSUB1,DGSUB2
 ;
 ;init vars
 S (DGCNT1,DGCNT2,DGCNT3,DGSUB1,DGSUB2)=0
 K ^TMP("DG531012P") ;temp global used to store any filing errors
 ;
 ;get $j subscript ^xtmp global
 S DGSUB1=+$O(^XTMP("DG531011P",DGSUB1))
 ;
 ;loop through ^xtmp global to retrieve patients (DFNs) that had a HURRICANE KATRINA indicator
 F  S DGSUB2=$O(^XTMP("DG531011P",DGSUB1,"DFN",DGSUB2)) Q:'DGSUB2  D
 . ;
 . ;count records processed
 . S DGCNT1=DGCNT1+1
 . ;
 . ;get DFN of patient record in PATIENT (#2) file
 . S DGDFN=+$G(^XTMP("DG531011P",DGSUB1,"DFN",DGSUB2))
 . ;
 . ;file 'HURRICANE KATRINA' indicator into patient's record - file into 
 . ;the HISTORIC KATRINA ERI (#.182) field of PATIENT (#2) file
 . S DGIENS=DGDFN_","         ;FileMan IENs string
 . S DGFDA(2,DGIENS,.182)="K" ;FDA array for FILE^DIE
 . D FILE^DIE("","DGFDA","DGERR")
 . ;shouldn't happen, but if filing error returned from FILE^DIE call then record it
 . I $D(DGERR) D  Q
 . . S DGCNT3=DGCNT3+1 ;total records not updated
 . . ;save DFN & error msg into ^tmp global, 1st piece=DFN & 2nd piece=error msg
 . . S ^TMP("DG531012P",$J,"ERRORS",DGCNT3)=DGDFN_"^"_$G(DGERR("DIERR",1,"TEXT",1))
 . . K DGERR
 . ;otherwise, filing was successful
 . S DGCNT2=DGCNT2+1 ;total records successfully updated
 . ;
 ;send msg with results
 D SENDMSG($G(DGCNT1),$G(DGCNT2),$G(DGCNT3),$G(DUZ))
 Q
 ;
 ;
SENDMSG(DGCNT1,DGCNT2,DGCNT3,DGDUZ) ;Send MailMan Message
 ;
 ;This procedure will create and send a MailMan message to the patch installer.
 ;The message will contain results from running the DG*5.3*1012 post-install.
 ;
 ;  Input:
 ;   DGCNT1 - Total records processed in ^XTMP("DG531011P") global.
 ;   DGCNT2 - Total records successfully updated in PATIENT (#2) file.
 ;   DGCNT3 - Total records not successfully updated in PATIENT (#2) file.
 ;    DGDUZ - Patch installer DUZ.
 ;
 ; Output: None
 ;
 ; External References:
 ;  ICR#   TYPE  DESCRIPTION
 ;  -----  ----  -----------
 ;  10070  Sup   ^XMD
 ;
 ;new vars
 N DIFROM ;when invoking ^XMD in post-init routine of the KIDS build, the calling routine must NEW the DIFROM variable
 N XMSUB,XMTEXT,XMY ;input vars for ^XMD call
 N DGERROUT,DGI,DGLN,DGTEXT ;local vars
 ;
 ;construct mailman msg
 S XMSUB="DG*5.3*1012 Post-Install Job Results" ;msg subject
 S (XMY(.5),XMY($G(DGDUZ)))="" ;msg addressee array
 S XMTEXT="DGTEXT(" ;array containing the text of msg
 S DGLN=1 ;msg line #
 S DGTEXT(DGLN)="DG*5.3*1012 post-install job results."
 S DGLN=DGLN+1,DGTEXT(DGLN)=""
 ;
 ;if no filing errors
 S DGLN=DGLN+1,DGTEXT(DGLN)="Job was successful and no other action is required."
 ;
 ;if filing errors
 I $G(DGCNT3)>0 S DGTEXT(DGLN)="WARNING - Job was not successful!"
 ;
 ;total records processed and total records updated
 S DGLN=DGLN+1,DGTEXT(DGLN)=""
 S DGLN=DGLN+1,DGTEXT(DGLN)=" - Total records in ^XTMP(""DG531011P"") global: "_$G(DGCNT1)
 S DGLN=DGLN+1,DGTEXT(DGLN)=" - Total records updated in PATIENT (#2) file: "_$G(DGCNT2)
 ;
 ;if filing errors occurred, list them
 I $G(DGCNT3)>0 D
 . S DGLN=DGLN+1,DGTEXT(DGLN)=""
 . S DGLN=DGLN+1,DGTEXT(DGLN)="Filing errors were encountered while running DG*5.3*1012 post-install job!"
 . S DGLN=DGLN+1,DGTEXT(DGLN)=""
 . S DGLN=DGLN+1,DGTEXT(DGLN)="Please log YOUR IT Services ticket for assistance with resolving these errors."
 . S DGLN=DGLN+1,DGTEXT(DGLN)=""
 . S DGLN=DGLN+1,DGTEXT(DGLN)="Patient DFN         Error"
 . S DGLN=DGLN+1,DGTEXT(DGLN)="-------------------------------------------------"
 . ;loop through errors in ^tmp global and get DFN(s) with error msg
 . S DGI=0
 . F  S DGI=$O(^TMP("DG531012P",$J,"ERRORS",DGI)) Q:'DGI  D
 . . S DGERROUT=$G(^TMP("DG531012P",$J,"ERRORS",DGI))
 . . S DGLN=DGLN+1,DGTEXT(DGLN)=$E($P($G(DGERROUT),U)_"               ",1,20)_$P($G(DGERROUT),U,2)
 . ;
 . ;cleanup ^temp error global
 . K ^TMP("DG531012P")
 ;
 ;send mailman msg
 D ^XMD
 ;
 Q
