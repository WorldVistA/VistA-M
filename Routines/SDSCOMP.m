SDSCOMP ;ALB/JAM/RBS - ASCD Compile list of encounters for Service Connection Review ; 3/12/07 4:36pm
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 ; Routine should be called at specified tags only.
 Q
 ;
AUTODT ; Called by option "SDSC NIGHTLY COMPILE"
 ; - Compile ASCD Encounters on a Nightly Basis
 ;   (Rated Disabilities/ICDs for Prior Day Encounters)
 ;
 N SDSCTDT,SDEDT,DIC,DA
 ; nightly compile is for previous day only
 S SDSCTDT=$$FMADD^XLFDT(DT,-1)
 ; Set variable 'SDEDT' (loop end point) to same date
 S SDEDT=SDSCTDT
 ; Setup list of service connected eligibility codes.
 D ELIG
 G TASK1
 ;
GETDATE ; Entry point for edit or report - Get START and END dates
 S SDSCBDT=$O(^SDSC(409.48,"AE",""))\1,SDSCEDT=DT
 ;  If no records currently available, display message.
 I SDSCBDT=0 D EN^DDIOL("NO RECORDS ON FILE - RUN COMPILE",,"!!?10") HANG 3 S (SDSCTDT,SDEDT)="" Q
 ;
GETDATE1 ; Entry point for SDSC COMPILE option - Get START and END dates
 ; Output:
 ;   Set var 'SDSCTDT' (loop start point) to a user selected date.
 N DIR,X,Y,X1,X2
 S DIR(0)="DA^"_SDSCBDT_":"_DT_":EX"
 S DIR("A")="Please enter START date: "
 ;S DIR("B")=$$FMTE^XLFDT(SDSCBDT,"1Z")
 S DIR("?")="This START date cannot precede "_$$FMTE^XLFDT(SDSCBDT,"1Z")
 ;
 ; This check works for the "SDSC COMPILE" only.
 ;   - Compile does not setup SDSCEDT var
 I SDSCBDT]"",SDSCEDT']"" D
 . S DIR("B")=$$FMTE^XLFDT(SDSCBDT,"1Z")
 . S DIR("?")="This START date cannot precede the default SDSC SITE PARAMETER days"
 ;
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S (SDSCTDT,SDEDT)="" Q
 S:Y>0 SDSCTDT=Y
 ; check if start date has changed
 I SDSCTDT'=SDSCBDT S SDSCBDT=SDSCTDT
 ; Set variable 'SDEDT' (loop end point) to a user selected date.
 K DIR
 S DIR(0)="DA^"_SDSCBDT_":"_DT_":EX"
 S DIR("A")="Please enter END date: "
 S DIR("B")=$$FMTE^XLFDT($S(SDSCEDT]"":SDSCEDT,1:DT),"1Z")
 S DIR("?")="This END date cannot precede the START date or exceed today's date"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S (SDSCTDT,SDEDT)="" Q
 S:Y>0 SDEDT=Y
 Q
 ;
ELIG ; Compile list of service connected eligibility codes.
 N I,J
 K SDLIST
 ; loop "D" x-ref of ELIGIBILITY CODE (#8) file
 ; Entries 1 and 3 are the service connected entries in this file.
 F I=1,3 S J=0 F  S J=$O(^DIC(8,"D",I,J)) Q:'J  S SDLIST(J)=""
 Q
 ;
COMPILE ; Called by option "SDSC COMPILE"
 ; - Compile ASCD Encounters by Date Range
 ;   (Rated Disabilities/ICDs for Encounters)
 N DIR,X,Y,SDSCBDT,SDSCEDT,ZTIO,ZTDESC,ZTRTN,ZTSAVE
 N SDSCITE,SDSCDAY
 D HOME^%ZIS
 ; Get start and end date for compile.
 S (SDSCBDT,SDSCEDT,SDSCDAY)=""
 S SDSCITE=$P($$SITE^VASITE(),U,1)
 S SDSCDAY=$$GET^XPAR((+SDSCITE)_";DIC(4,","SDSC SITE PARAMETER")
 ; set default start date based on site parameter (30 days max)
 I SDSCDAY="" S SDSCDAY=30
 S SDSCBDT=$$FMADD^XLFDT(DT,-SDSCDAY)
 ;
 D GETDATE1 I SDSCTDT="" G END
 ; Setup list of service connected eligibility codes.
 D ELIG
 ; Ask user if compile should be in background and handle queuing if requested.
 K DIR
 S DIR(0)="YA",DIR("B")="YES"
 S DIR("A")="Do you wish to schedule the compile? "
 S DIR("?")="Enter 'YES' to schedule compile using TaskMan or 'NO' to compile immediately."
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) D EN^DDIOL("<Compile Aborted> ",,"!!?10") G END
 I Y D  G END
 . S ZTIO="NULL",ZTDESC="COMPARE RATED DISABILITY/ICDs PER ENCOUNTER (COMPILE)",ZTRTN="TASK^SDSCOMP",ZTSAVE("*")=""
 . D ^%ZTLOAD
 . I $G(ZTSK)]"" D EN^DDIOL("Extract's TaskMan ID is "_ZTSK,"","!!?10")
 . K ZTSK
 . Q
 D EN^DDIOL("Comparing Rated Disabilities and Diagnosis Code per Encounter ...",,"!!?10")
 ;
TASK ; Start compile (one-time compile - remove from queue when complete)
 D OPT
 I $D(ZTQUEUED) S ZTREQ="@"
 G END
 ;
TASK1 ; Start compile (scheduled compile - don't remove from queue)
 D OPT
 G END
 ;
OPT ; Loop through all outpatient encounters for the specified dates.
 N SDSCTOT,SDSCSVC,SDSCNSC,SDSCBAD,SDSCNCT,SDSCEXS,SDSCNDX,SDSCNBL
 N SDSCMAP1,SDSCMAP2,SDSCINS,SDOEDT,SDOE
 S (SDSCTOT,SDSCSVC,SDSCNSC,SDSCBAD,SDSCNCT,SDSCEXS,SDSCNDX,SDSCNBL,SDSCMAP1,SDSCMAP2,SDSCINS)=0
 S SDOEDT=SDSCTDT F  S SDOEDT=$O(^SCE("B",SDOEDT)) Q:(SDOEDT\1)>SDEDT  Q:SDOEDT=""  D
 . S SDOE=0 F  S SDOE=$O(^SCE("B",SDOEDT,SDOE)) Q:'SDOE  D OPT1
 . Q
 ;
 ;  Check for newly identified insurance
 D EN^SDSCINS(.SDSCINS,.SDSCSVC)
 ;
 ; Send mail message with counts of records
 D MMSG
 ;
 ; Check for encounters in ASCD that were deleted from (#409.68)
 D EN^SDSCPRG
 Q
 ;
OPT1 ; Check the service connected info for one encounter.
 N SDOEDAT,SDEC,SDPAT,SDCLIN,SDCST,SDV0,SDFILEOK,SDPRV,SDOSC
 S SDSCTOT=SDSCTOT+1
 ; If this encounter has already been compiled for review, quit.
 I $D(^SDSC(409.48,SDOE,0)) S SDSCEXS=SDSCEXS+1 Q
 ; Get encounter data.  If no encounter data, quit.
 ;            Replace all ^SCE calls with new variable.
 S SDOEDAT=$$GETOE^SDOE(SDOE)
 I SDOEDAT="" S SDSCBAD=SDSCBAD+1 Q
 ; if child encounter, reduce count and quit
 I $P(SDOEDAT,U,6) S SDSCTOT=SDSCTOT-1 Q
 ; if not Check-out, quit
 I $P(SDOEDAT,U,12)'=2 S SDSCNBL=SDSCNBL+1 Q
 ; Get eligibility.  If no eligibility, quit.
 S SDEC=$P(SDOEDAT,U,13) I SDEC="" S SDSCBAD=SDSCBAD+1 Q
 ; If eligibility is not service connected, quit.
 I '$D(SDLIST(SDEC)) S SDSCNSC=SDSCNSC+1 Q
 ; Get patient. If no patient, quit.
 S SDPAT=$P(SDOEDAT,U,2) I SDPAT="" S SDSCBAD=SDSCBAD+1 Q
 ; Checks for clinic and stop code.
 ; Get clinic. If no clinic, quit.
 S SDCLIN=$P(SDOEDAT,U,4) I SDCLIN="" S SDSCBAD=SDSCBAD+1 Q
 ; Get clinic stop code. If no clinic stop code, quit.
 S SDCST=$P(SDOEDAT,U,3) I SDCST="" S SDSCBAD=SDSCBAD+1 Q
 ; If clinic is non-count, quit.
 I $$NCTCL^SDSCUTL(SDCLIN) S SDSCNCT=SDSCNCT+1 Q
 ; If encounter is non-billable for first and third party, quit.
 I $$NBFP^SDSCUTL(SDOE),$$NBTP^SDSCUTL(SDOE) S SDSCNBL=SDSCNBL+1 Q
 ; Get visit file entry. If no visit, quit.
 S SDV0=$P(SDOEDAT,U,5) I SDV0="" S SDSCBAD=SDSCBAD+1 Q
 S SDOSC=$$GET1^DIQ(9000010,SDV0_",",80001,"I")
 I SDOSC="" S SDSCNBL=SDSCNBL+1 Q
 ; Get and evaluate all ICD9 entries for the specified visit.
 S SDFILEOK=$$SC^SDSCAPI(SDPAT,,SDOE)
 ;no ICDs were found for this encounter SDFILEOK=""
 I SDFILEOK="" S SDSCNDX=SDSCNDX+1 Q
 ;checks if ICD match found
 I +SDFILEOK D
 .I '$P(SDFILEOK,"^",4) S SDSCMAP1=SDSCMAP1+1 Q
 .S SDSCMAP2=SDSCMAP2+1
 I '+SDFILEOK S SDSCNSC=SDSCNSC+1
 ; Get Primary Provider for the specified visit.
 S SDPRV=$$PRIMVPRV^PXUTL1(SDV0) I SDPRV=0 S SDPRV=""
 ; Store the encounter for later use.
 S SDSCSVC=SDSCSVC+1
 I $P(SDFILEOK,U,4) Q:$D(^SDSC(409.48,SDOE,0))  D STORE Q
 I SDOSC'=$P(SDFILEOK,U) D STORE
 Q
 ;
STORE ; Save the information for the found encounter.
 N SDERR,SDIEN,SDSC
 S SDIEN(1)=SDOE
 S SDSC(409.48,"+1,",.01)=SDOE
 S SDSC(409.48,"+1,",.04)=DT
 S SDSC(409.48,"+1,",.07)=SDOEDT
 S SDSC(409.48,"+1,",.08)=SDPRV
 S SDSC(409.48,"+1,",.09)=$P(SDFILEOK,U,3)
 S SDSC(409.48,"+1,",.11)=SDPAT
 S SDSC(409.48,"+1,",.12)=$P(SDOEDAT,U,11)
 S SDSC(409.48,"+1,",.05)="N"
 S SDSC(409.48,"+1,",.13)=SDOSC
 D UPDATE^DIE("","SDSC","SDIEN","SDERR")
 Q
 ;
MMSG ; Send Mail Message
 N SDCNT,SDTEXT,DIFROM,XMY,XMDUZ,XMTEXT,XMSUB,XMZ,XMDUN
 S SDTEXT(1)="Date Range (Compile)   - From: "_$$FMTE^XLFDT(SDSCTDT,1)_" Thru: "_$$FMTE^XLFDT(SDEDT,1)
 S SDTEXT(2)="Date Range (Late Ins.) - "
 I '$D(SDSCBDT),'$D(SDSCEDT) S SDTEXT(2)=SDTEXT(2)_"None"
 E  S SDTEXT(2)=SDTEXT(2)_"From: "_$$FMTE^XLFDT(SDSCBDT,1)_" Thru: "_$$FMTE^XLFDT(SDSCEDT,1)
 S SDTEXT(3)=" "
 S SDTEXT(4)="Number of encounters Service Connected (Compile)   :     "_$J(SDSCSVC-SDSCINS,7)
 S SDTEXT(5)="Number of encounters Service Connected (Late Ins.) :     "_$J(SDSCINS,7)
 S SDTEXT(6)="   (Number SvcConn with a True Map)       : "_$J(SDSCMAP1,7)
 S SDTEXT(6.5)="   (Number SvcConn with a Partial Map)    : "_$J(SDSCMAP2,7)
 S SDTEXT(7)="   (Number SvcConn that don't Map to VBA) : "_$J(SDSCSVC-SDSCMAP1-SDSCMAP2,7)
 S SDTEXT(8)="Number of encounters Not Service Connected         :     "_$J(SDSCNSC,7)
 S SDTEXT(9)="Number of encounters that are Non-billable         :     "_$J(SDSCNBL,7)
 S SDTEXT(10)="Number of encounters with Non-count Clinics        :     "_$J(SDSCNCT,7)
 S SDTEXT(11)="Number of encounters with no diagnoses             :     "_$J(SDSCNDX,7)
 S SDTEXT(12)="Number of encounters with other errors             :     "_$J(SDSCBAD,7)
 S SDTEXT(13)="Number of encounters already evaluated             :     "_$J(SDSCEXS,7)
 S SDTEXT(14)="---------------------------------------------------------------------------"
 S SDTEXT(15)="Total Encounters Checked:                                "_$J(SDSCTOT,7)
 S SDCNT=15
 D AUDIT^SDSCINS(.SDTEXT,.SDCNT)
 I $G(DUZ)="" S XMZ(.5)=""
 S XMZ(DUZ)="",XMDUZ="ASCD Compile",XMY("G.SDSC NIGHTLY TALLY")=""
 S XMTEXT="SDTEXT(",XMSUB="ASCD Compile Numbers"
 D ^XMD
 Q
 ;
END ; Clear all variables before exiting.
 K SDSCTDT,SDEDT,SDOEX,SDRD,SDRDIEN,SDSCBDT,SDSCEDT,SDIEN,SDERR,SDSC
 K SDVBA,SDVBAI,SDLIST,P,L,SDABRT,X,Y,DTOUT,DUOUT
 Q
