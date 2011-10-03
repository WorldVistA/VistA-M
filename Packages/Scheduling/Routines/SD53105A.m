SD53105A ;ALB/JRP - XMIT, DELETE, AND ERROR FILE CLEAN UP;12-MAR-1997
 ;;5.3;Scheduling;**105**;Aug 13, 1993
 ;
SCAN ;Entry point to scan only (prints what would have been deleted)
 N ZTRTN,ZTDESC
 D INTRO
 W !
 W !,"You are running this routine in scan mode, which will only identify"
 W !,"the problems corrected.  Please select a device (queueing allowed) so"
 W !,"that a listing of what would have been done can be obtained."
 W !!
 S ZTRTN="EN^SD53105A(1)"
 S ZTDESC="ACRP cleanup of files 409.73, 409.74, and 409.75"
 D EN^XUTMDEVQ(ZTRTN,ZTDESC)
 Q
 ;
FIX ;Entry point to schedule clean up
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,TXT
 D INTRO
 W !
 W !,"Please enter the date/time that you would like this clean up queued to"
 W !,"run.  A summary of what was done will be sent to you and the"
 W !,"recipients of the SCDX AMBCARE TO NPCDB SUMMARY bulletin."
 W !!
 S ZTRTN="EN^SD53105A(0)"
 S ZTDESC="ACRP cleanup of files 409.73, 409.74, and 409.75"
 S ZTDTH=""
 S ZTIO=""
 D ^%ZTLOAD
 W:(+$G(ZTSK)) !,"Scheduled as task number ",ZTSK
 W:('$G(ZTSK)) !,"** Unable to schedule correction **"
 Q
 ;
INTRO ;Print intro text
 W !!,"This routine will clean up dangling pointers and orphan entries within"
 W !,"the ACRP transmission files.  The following actions/checks will be"
 W !,"performed:"
 W !
 W !,"(1) Entries in the Transmitted Outpatient Encounter file (409.73)"
 W !,"    that do not have a valid pointer to the Outpatient Encounter"
 W !,"    file (#409.68) or the Deleted Outpatient Encounter file"
 W !,"    (#409.74) are deleted."
 W !
 W !,"(2) Entries in the Transmitted Outpatient Encounter file that have"
 W !,"    been rejected by the Austin Automation Center and do not have an"
 W !,"    entry in the Transmitted Outpatient Encounter Error file"
 W !,"    (#409.75) are marked for re-transmission."
 W !
 W !,"(3) Entries in the Deleted Outpatient Encounter file that do not"
 W !,"    have a corresponding entry in the Transmitted Outpatient"
 W !,"    Encounter file are deleted."
 W !
 W !,"(4) Entries in the Transmitted Outpatient Encounter Error file that"
 W !,"    do not have a valid pointer to the Transmitted Outpatient"
 W !,"    Encounter file are deleted."
 Q
 ;
EN(SCANMODE) ;Main entry point
 ; Routine deletes entries in the Transmitted Outpatient Encounter file
 ; (409.73) that do not have a valid pointer to the Outpatient Encounter
 ; file (#409.68) or the Deleted Outpatient Encounter file (#409.74).
 ;
 ; Routine marks entries in the Transmitted Outpatient Encounter file
 ; that have been rejected by the Austin Automation Center and do not
 ; have an entry in the Transmitted Outpatient Encounter Error file
 ; (#409.75) for re-transmission.
 ;
 ; Routine deletes entries in the Deleted Outpatient Encounter file that
 ; do not have a corresponding entry in the Transmitted Outpatient
 ; Encounter file.
 ;
 ; Routine deletes entries in the Transmitted Outpatient Encounter Error
 ; file that do not have a valid pointer to the Transmitted Outpatient
 ; Encounter file.
 ;
 ;Input  : SCANMODE - Flag denoting if routine should only scan
 ;                    for errors and not fix them
 ;                    0 = No - scan and fix (default)
 ;                    1 = Yes - scan but don't fix
 ;Output : None
 ;Notes  : A completion/summary bulletin will be sent to the current
 ;         user and the recipients of the SCDX AMBCARE TO NPCDB SUMMARY
 ;         bulletin.  This bulletin will not be sent if in scan mode.
 ;
 ;Declare variables
 N XMITPTR,XMITTOT,XMITDEL,XMITXMIT,ENCPTR,DELPTR,DELTOT,DELDEL,ERRPTR
 N ERRTOT,ERRDEL,NODE,TMP,DIK,DA,X,Y
 S SCANMODE=+$G(SCANMODE)
 ;Initialize counters
 S (XMITTOT,XMITDELE,XMITDELD,XMITXMIT,DELTOT,DELDEL,ERRTOT,ERRDEL)=0
 ;Initialize summary location
 K ^TMP($J,"SD53105A")
 S ^TMP($J,"SD53105A","XMIT")="^^^"
 S ^TMP($J,"SD53105A","DEL")="^"
 S ^TMP($J,"SD53105A","ERR")="^"
 S ^TMP($J,"SD53105A","STOP")=0
 ;Remember starting time
 S ^TMP($J,"SD53105A","TIME")=$$NOW^XLFDT()
 I (SCANMODE) D
 .W !
 .W !,"Scanning of the Transmitted Outpatient Encounter, Deleted Outpatient"
 .W !,"Encounter, and Transmitted Outpatient Encounter Error files for known"
 .W !,"problems started on "_$$FMTE^XLFDT($$NOW^XLFDT())
 .W !
 ;Loop through Transmitted Outpatient Encounter file (#409.73)
 I (SCANMODE) D
 .W !!
 .W !,"The following entries in the Transmitted Outpatient Encounter"
 .W !,"file (#409.73) will be acted upon when run in fix mode"
 .W !,$$REPEAT^SCDXUTL1("=",70)
 S XMITPTR=0
 F  S XMITPTR=+$O(^SD(409.73,XMITPTR)) Q:('XMITPTR)  D  Q:($G(ZTSTOP))
 .;Increment total entries checked
 .S XMITTOT=XMITTOT+1
 .;Grab zero node
 .S NODE=$G(^SD(409.73,XMITPTR,0))
 .;Get Outpatient Encounter & Deleted Outpatient Encounter pointers
 .S ENCPTR=+$P(NODE,"^",2)
 .S DELPTR=+$P(NODE,"^",3)
 .;Validate pointer to Outpatient Encounter
 .I (ENCPTR) D
 ..Q:($D(^SCE(ENCPTR,0)))
 ..;Invalid - delete entry and increment deletion count
 ..S:('SCANMODE) TMP=$$DELXMIT^SCDXFU03(XMITPTR,0)
 ..W:(SCANMODE) !,"^SD(409.73,",XMITPTR,",0) has bad pointer to Outpatient Encounter file"
 ..S XMITDELE=XMITDELE+1
 .;Validate pointer to Deleted Outpatient Encounter
 .I (DELPTR) D
 ..Q:($D(^SD(409.74,DELPTR,0)))
 ..;Invalid - delete entry and increment deletion count
 ..S:('SCANMODE) TMP=$$DELXMIT^SCDXFU03(XMITPTR,0)
 ..W:(SCANMODE) !,"^SD(409.73,",XMITPTR,",0) has bad pointer to Deleted Outpatient Encounter file"
 ..S XMITDELD=XMITDELD+1
 .;Check for rejection without entry in Transmitted Outpatient Encounter
 .; Error file (#409.75)
 .S TMP=$G(^SD(409.73,XMITPTR,1))
 .I ($P(TMP,"^",5)="R") D:('$D(^SD(409.75,"B",XMITPTR)))
 ..;Mark for retransmission
 ..D:('SCANMODE) STREEVNT^SCDXFU01(XMITPTR)
 ..D:('SCANMODE) XMITFLAG^SCDXFU01(XMITPTR)
 ..W:(SCANMODE) !,"^SD(409.73,",XMITPTR,",0) rejected with no reason on file (entry in 409.75)"
 ..;Increment retransmission counter
 ..S XMITXMIT=XMITXMIT+1
 .;Check for request to stop
 .S:($$S^%ZTLOAD("Last entry in Transmitted Outpatient Encounter file checked >> "_XMITPTR)) ZTSTOP=1
 ;Remember totals
 S ^TMP($J,"SD53105A","XMIT")=XMITTOT_"^"_XMITDELE_"^"_XMITDELD_"^"_XMITXMIT
 I (SCANMODE) D
 .W !
 .W !,XMITTOT," entries where checked"
 .W !,?2,XMITXMIT," would have been marked for retransmission"
 .W !,?2,(XMITDELE+XMITDELD)," would have been deleted"
 .W !,?4,(XMITDELE)," have bad Outpatient Encounter pointers"
 .W !,?4,(XMITDELD)," have bad Deleted Outpatient Encounter pointers"
 ;Asked to stop
 I $G(ZTSTOP) G EN1
 ;Loop through Deleted Outpatient Encounter file (#409.74)
 I (SCANMODE) D
 .W !!!
 .W !,"The following entries in the Deleted Outpatient Encounter"
 .W !,"file (#409.74) will be deleted when run in fix mode"
 .W !,$$REPEAT^SCDXUTL1("=",70)
 S DELPTR=0
 F  S DELPTR=+$O(^SD(409.74,DELPTR)) Q:('DELPTR)  D  Q:($G(ZTSTOP))
 .;Increment total entries checked
 .S DELTOT=DELTOT+1
 .;Check for entry in Transmitted Outpatient Encounter file
 .I ('$D(^SD(409.73,"ADEL",DELPTR))) D
 ..;Not found - delete entry and increment deletion count
 ..I ('SCANMODE) S DA=DELPTR,DIK="^SD(409.74," D ^DIK K DA,DIK,X,Y
 ..W:(SCANMODE) !,"^SD(409.74,",DELPTR,",0) not in Transmitted Outpatient Encounter file"
 ..S DELDEL=DELDEL+1
 .;Check for request to stop
 .S:($$S^%ZTLOAD("Last entry in Deleted Outpatient Encounter file checked >> "_DELPTR)) ZTSTOP=1
 ;Remember totals
 S ^TMP($J,"SD53105A","DEL")=DELTOT_"^"_DELDEL
 W:(SCANMODE) !!,DELTOT," entries where checked and ",DELDEL," would have been deleted"
 ;Asked to stop
 I $G(ZTSTOP) G EN1
 ;Loop through Transmitted Outpatient Encounter Error file (#409.75)
 I (SCANMODE) D
 .W !!!
 .W !,"The following entries in the Transmitted Outpatient Encounter"
 .W !,"Error file (#409.75) will be deleted when run in fix mode"
 .W !,$$REPEAT^SCDXUTL1("=",70)
 S ERRPTR=0
 F  S ERRPTR=+$O(^SD(409.75,ERRPTR)) Q:('ERRPTR)  D  Q:($G(ZTSTOP))
 .;Increment total entries checked
 .S ERRTOT=ERRTOT+1
 .;Get pointer to Transmitted Outpatient Encounter file
 .S XMITPTR=+$G(^SD(409.75,ERRPTR,0))
 .;Validate pointer
 .I ('$D(^SD(409.73,XMITPTR,0))) D
 ..;Invalid - delete entry and increment deletion count
 ..S:('SCANMODE) TMP=$$DELERR^SCDXFU02(ERRPTR)
 ..W:(SCANMODE) !,"^SD(409.75,",ERRPTR,",0) has bad pointer to Transmitted Outpatient Encounter file"
 ..S ERRDEL=ERRDEL+1
 .;Check for request to stop
 .S:($$S^%ZTLOAD("Last entry in Transmitted Outpatient Encounter Error file checked >> "_ERRPTR)) ZTSTOP=1
 ;Remember totals
 S ^TMP($J,"SD53105A","ERR")=ERRTOT_"^"_ERRDEL
 W:(SCANMODE) !!,ERRTOT," entries where checked and ",ERRDEL," would have been deleted"
EN1 ;Remember ending time
 S $P(^TMP($J,"SD53105A","TIME"),"^",2)=$$NOW^XLFDT()
 I (SCANMODE) D
 .W !!!,"Scan ended on ",$$FMTE^XLFDT($$NOW^XLFDT())
 .W !!!,"Use the entry point FIX^SD53105A to run in fix mode"
 .W !,"Use the entry point SCAN^SD53105A to re-run in scan mode"
 ;Remember if requested to stop
 S ^TMP($J,"SD53105A","STOP")=+$G(ZTSTOP)
 ;Send completion/summary bulletin
 D:('SCANMODE) BULL1^SD53105C
 ;Done - clean up and quit
 K ^TMP($J,"SD53105A")
 S:($D(ZTQUEUED)) ZTREQ="@"
 Q
