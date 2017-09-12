DG53P379 ;ALB/RPM,RBS - Patch DG*5.3*379 Install Utility Routine ; 2/4/02 12:38pm
 ;;5.3;Registration;**379**;Aug 13, 1993
 ;
 ; This routine will provide the following:
 ; 1. The MST HISTORY file (#29.11) will have a new field added.
 ;    - Field (#6) - Site Determining Status
 ; 2. Create a New-Style compound Cross-Reference "APDT" in the MST
 ;    HISTORY file (#29.11) using Fields (#.01) and (#2).
 ; 3. Setup TaskMan Job for background processing
 ; 4. The most current patient MST info will be queued for
 ;    transmission to the HEC via the Enrollment HL7 Z07 processing.
 ;   * NOTE:  ALPHA Test Sites will not re-send HL7 msg's to the HEC.
 ; 5. Generate a mail message to the User that ran the install.
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 Q:+XPDABORT
 ;
 ; Check for the initial CPRS Synchronization run date
 D CPRS(.XPDABORT)
 ;
 I XPDABORT="" K XPDABORT
 Q
 ;
PRE ;Main entry point for Pre-init items.
 ;
 Q
 ;
POST ;Main entry point for Post-init items.
 ;
 D POST1         ;remove traditional APDT xref from .01 & 2
 D POST2         ;re-create "APDT" cross reference
 D POST3         ;Setup TaskMan Job
 ;               ;enter local station number in new SITE field (#6)
 Q
 ;
POST1 ;Delete the broken "APDT" traditional MUMPS xref from the data
 ; dictionary.
 ;Kill the "APDT" index from the MST HISTORY file(#29.11) to prepare
 ; for the 'new' style "APDT" xref and re-index.
 ;
 ;Check Data Dictionary to see if already changed to New Style xref
 I '$D(^DD(29.11,.01,1,2)),'$D(^DD(29.11,2,1,1)) D  Q
 .D BMES^XPDUTL(" NO Traditional 'APDT' x-ref found in the MST HISTORY file(#29.11) to Delete.")
 ;
 D BMES^XPDUTL(" Deleting the Traditional 'APDT' cross reference from the")
 D MES^XPDUTL(" MST HISTORY file(#29.11) to prepare for the 'New Style'")
 D MES^XPDUTL(" 'APDT' cross reference installation.")
 D DELIX^DDMOD(29.11,.01,2)
 D DELIX^DDMOD(29.11,2,1)
 I '$D(^DD(29.11,.01,1,2)),'$D(^DD(29.11,2,1,1)) D
 .K ^DGMS(29.11,"APDT")  ;FileMan won't kill all of "APDT" nodes.
 .D BMES^XPDUTL(" Traditional 'APDT' cross reference successfully removed.")
 Q
 ;
POST2 ;This POST install routine will re-create the "APDT" cross
 ; reference by re-indexing field .01.
 ;
 I $D(^DGMS(29.11,"APDT")) D  Q   ;don't re-index if found
 .D BMES^XPDUTL(" NO re-indexing necessary for the MST HISTORY file(#29.11) 'APDT' x-ref.")
 ;
 N DIK,X
 D BMES^XPDUTL(" Please be patient while I re-create the 'APDT' cross reference.")
 S DIK="^DGMS(29.11,",DIK(1)=".01^APDT"
 D ENALL^DIK
 I $D(^DGMS(29.11,"APDT")) D  Q
 .D BMES^XPDUTL(" The MST HISTORY file(#29.11) 'APDT' x-ref was successfully re-created.")
 Q
 ;
POST3 ;Set up TaskMan to process in the background
 ;
 N DGDFN,ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK
 S ZTRTN="SCAN^DG53P379"
 S ZTDESC="Process MST records for DG*5.3*379"
 ;Queue Task to start in 60 seconds
 S ZTDTH=$$SCH^XLFDT("60S",$$NOW^XLFDT)
 S ZTIO=""
 I $G(^XTMP("DG53P379","LASTDFN"))>0 D
 . S DGDFN=^XTMP("DG53P379","LASTDFN"),ZTSAVE("DGDFN")=""
 D ^%ZTLOAD
 D BMES^XPDUTL("*****")
 D
 . I $D(ZTSK)[0 D  Q
 . . D MES^XPDUTL("TaskMan run to Process MST records for DG*5.3*379 was not started.")
 . . D MES^XPDUTL("Re-run Post Install routine POST3^DG53P379.")
 . I $D(ZTSK("D")) D
 . . I '$D(DGDFN) D  Q
 . . . D MES^XPDUTL("Task will start at "_$$HTE^XLFDT(ZTSK("D")))
 . . D MES^XPDUTL("Task will re-start with DFN: "_DGDFN_" at "_$$HTE^XLFDT(ZTSK("D")))
 D MES^XPDUTL("*****")
 Q
 ;
SCAN ;This POST install routine will load the local site's station number
 ; as a pointer to the INSTITUTION file (#4) in the SITE field (#6) of
 ;  the MST HISTORY file (#29.11).
 ;
 N DGDAT,DGFDA,DGERR,DGMSG
 N DGSTART                ;Job start date/time
 N DGQUIT                 ;Job control flag
 N DGIEN                  ;MST HISTORY file IEN
 N DGOSITE                ;existing SITE field data
 N DGSITE                 ;SITE value to be stuffed
 N DGCNT                  ;counter of records
 N DGTCNT                 ;number of patients scanned
 ;
 I +$G(DGDFN)'>0 S DGDFN=0
 S DGSTART=$$NOW^XLFDT,ZTREQ="@"  ;START dt/delete task when finished
 S (DGCNT,DGTCNT,DGQUIT,DGMSG)=0
 S ^XTMP("DG53P379",0)=$$FMADD^XLFDT(""_DT_"",60)_U_DT_U_"MST BASELINE SEEDING"
 ;
 S DGSITE=$P($$SITE^VASITE,U)
 I +DGSITE'>0 D  Q                ;*** ERROR CONDITION ***
 .S DGMSG=2
 .S DGMSG(1)=" Invalid Station number - Stopping Taskman Job"
 .S DGMSG(2)=" Re-run Post Install routine POST3^DG53P379."
 .D MSG(DGSTART,DGTCNT,DGCNT,.DGMSG)
 ;
 F  S DGDFN=$O(^DGMS(29.11,"APDT",DGDFN)) Q:'DGDFN  D  Q:DGQUIT
 .S DGTCNT=DGTCNT+1
 .I DGTCNT#60=0,$$S^%ZTLOAD D  Q
 ..S DGMSG=2
 ..S DGMSG(1)=" Patch DG*5.3*379 MST Task "_ZTSK_" Stopped by User"
 ..S DGMSG(2)=" Re-run Post Install routine POST3^DG53P379."
 ..D MSG(DGSTART,DGTCNT,DGCNT,.DGMSG)
 ..S (ZTSTOP,DGQUIT)=1
 .S DGDAT=0
 .F  S DGDAT=$O(^DGMS(29.11,"APDT",DGDFN,DGDAT)) Q:'DGDAT  D
 ..S DGIEN=0
 ..F  S DGIEN=$O(^DGMS(29.11,"APDT",DGDFN,DGDAT,DGIEN)) Q:'DGIEN  D
 ...K DGERR,DGFDA
 ...S DGOSITE=$$GET1^DIQ(29.11,DGIEN_",",6,"I","",.DGERR)
 ...Q:$D(DGERR)
 ...I DGOSITE=""  D                    ;site FIELD not setup ***
 ....S DGFDA(29.11,DGIEN_",",6)=DGSITE
 ....D FILE^DIE("I","DGFDA","DGERR")   ;file site pointer to (#29.11)
 .; *** Don't re-queue entry for HEC HL7 if Alpha Test Site:  ***
 .;     (437) FARGO VAMRO
 .;     (537) CHICAGO HCS
 .;     (612) NORTHERN CALIFORNIA HCS
 .I ",437,537,612,"'[(","_$P($$SITE^VASITE,U,3)_",") D XMIT(DGDFN)
 .S ^XTMP("DG53P379","LASTDFN")=DGDFN
 ;
 I 'DGQUIT D MSG(DGSTART,DGTCNT,DGCNT,"")  ;create mailman msg to user
 Q
 ;
XMIT(DGDFN) ; Queue entry to ^IVM(301.5,#) for HEC HL7 processing
 ;Call API routine to determine the most current MST Status data for
 ; each veteran in the (#29.11) file.
 ;Queue entry for HL7 Z07 message to be sent to the HEC.
 ; Input:
 ;       DGDFN - IEN of PATIENT file (#2)
 ; Output:
 ;        Queue entry to ^IVM(301.5,#) file
 N DGMST               ;MST data from MST HISTORY file (#29.11)
 S DGMST=$$GETSTAT^DGMSTAPI(DGDFN)
 Q:+DGMST<1
 S DGCNT=DGCNT+1
 D SEND^DGMSTL1(DGDFN,"Z07")
 Q
 ;
MSG(DGSTART,DGTCNT,DGCNT,DGMESS) ; Send e-mail to user
 ;Generate a mailman message with total number of patients scanned
 ; and total patients queued for transmission to the HEC.
 ;  Input:
 ;        DGSTART - Job start d/t
 ;        DGTCNT  - Total records scanned
 ;        DGCNT   - Total records queued
 ;        DGMESS  - error message (if any...)
 ;  Output:
 ;         User e-mail message
 ;
 N DIFROM,DGSITE,DGMAIL,DGI
 N XMY,XMDUZ,XMSUB,XMTEXT,XMDUN,XMZ
 S DGSITE=$$SITE^VASITE
 I +DGSITE'>0 S DGSITE="NO SITE#"
 S XMDUZ=.5,(XMY(DUZ),XMY(XMDUZ))=""
 S XMSUB="Patch DG*5.3*379 MST Baseline ("_$P(DGSITE,U,3)_")"
 S XMTEXT="DGMAIL("
 S DGMAIL(1)=""
 S DGMAIL(2)="                 Facility Name: "_$P(DGSITE,U,2)
 S DGMAIL(3)="                Station Number: "_$P(DGSITE,U,3)
 S DGMAIL(4)=""
 S DGMAIL(5)="Date/Time Baseline job started: "_$$FMTE^XLFDT(DGSTART)
 S DGMAIL(6)="Date/Time Baseline job stopped: "_$$HTE^XLFDT($H)
 S DGMAIL(7)=""
 S DGMAIL(8)="Total patient's scanned in MST HISTORY file: "_DGTCNT
 S DGMAIL(9)="Total patient's queued for HEC transmission: "_DGCNT
 S DGMAIL(10)=""
 I $G(DGMESS) D
 .S DGMAIL(11)="             * * *  E R R O R    E N C O U N T E R E D  * * *"
 .S DGMAIL(12)=""
 . F DGI=1:1:DGMESS D
 . . S DGMAIL(12+DGI)="*** "_$E($G(DGMESS(DGI)),1,65)
 ;
 D ^XMD
 Q
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
 ;
CPRS(XPDABORT) ; Check for the CPRS initial MST Synchronization run date
 ;
 I '+$$GSYINFO^PXRMMST("I") D
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("The CPRS initial MST Synchronization has not been run.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2  ;Abort all transport globals in distribution but leave
 Q              ; them in ^XTMP().
