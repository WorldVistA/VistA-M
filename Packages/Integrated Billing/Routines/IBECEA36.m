IBECEA36 ;ALB/CPM - Cancel/Edit/Add... Urgent Care Add Utilities ; 23-APR-93
 ;;2.0;INTEGRATED BILLING;**646,663,671,677,689,696,716**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to FILE #27.11 in ICR #5158
 ; Reference to FILE #2 in ICR #7182
 ;
PRTUCVST(DFN,IBDT,IBDUPFLG) ; Print the UC visits for a calendar year
 ;
 N IBCT,IBDATA,IBFRCT,IBI,IBLDT,IBDCT
 K ^TMP($J,"IBUCVST")  ;clear previous lookup if any
 S IBCT=$$GETVST(DFN,IBDT)
 S IBFRCT=$P(IBCT,U,2),IBDCT=$P(IBCT,U,3),IBCT=$P(IBCT,U)
 W !!,"This patient has had ",IBDCT," Urgent Care "_$S(IBCT=1:"visit",1:"visits")," this calendar year:",!
 ;
 ;Display the visits...
 I IBCT>0 D
 .  W !,"Date of Visit",?16,"Station",?37,"Status",?48,"Bill No.",?61,"Reason"
 .  W !,"-------------",?16,"-------",?37,"------",?48,"--------",?61,"------"
 .  S IBLDT=0
 .  F  S IBLDT=$O(^TMP($J,"IBUCVST",IBLDT)) Q:'IBLDT  D
 .  .  I IBLDT=IBDT S IBDUPFLG=1
 .  .  S IBI=0
 .  .  F  S IBI=$O(^TMP($J,"IBUCVST",IBLDT,IBI)) Q:'IBI  D
 .  .  .  S IBDATA=^TMP($J,"IBUCVST",IBLDT,IBI)
 .  .  .  Q:IBDATA=""
 .  .  .  W !,$P(IBDATA,U),?16,$P(IBDATA,U,2),?37,$P(IBDATA,U,3)
 .  .  .  I $P(IBDATA,U,4)'="" W ?48,$P(IBDATA,U,4)
 .  .  .  I $P(IBDATA,U,5)'=""  W ?61,$E($P(IBDATA,U,5),1,19)
 W !
 K ^TMP($J,"IBUCVST")  ;clear lookup to clean up
 Q IBCT_U_IBFRCT
 ;
GETVST(DFN,IBDT) ;Retrieve the UC visits as recorded in VistA during the calendar year being
 ; being billed
 ;
 ; Returns:
 ;          Total Count of visits ^ Total Free Count of Visits ^ Total Display Count (no REMOVED) visits
 ;
 N IBCAL,IBCT,IBI,IBSITE,IBSTAT,IBCMT,IBBILL,IBBLCMT,IBSITECD,IBSITENM,IBVDT,IBDCT
 ;
 S (IBDCT,IBCT,IBFRCT,IBI)=0,(IBBILL,IBCMT)=""
 ;determine calendar year(ADD 1700 to first three digits in the FileMan date
 S IBCAL=+$E(IBDT,1,3)
 ;Loop through the tracking DB to find all of the visits for that calendar year.
 F  S IBI=$O(^IBUC(351.82,"B",DFN,IBI)) Q:'IBI  D
 .  S IBDATA=$G(^IBUC(351.82,IBI,0))
 .  S IBVDT=$P(IBDATA,U,3)
 .  ; Only retrieve the visits from the calendar year being billed
 .  Q:$E(IBVDT,1,3)'=IBCAL
 .  I $P(IBDATA,U,2)'="" D
 .  .  S IBSITE=$$GET1^DIQ(351.82,IBI_",",.02,"I")
 .  .  S IBSITECD=$$GET1^DIQ(4,IBSITE_",",99,"I")
 .  .  S IBSITENM=$$GET1^DIQ(4,IBSITE_",",.01,"E")
 .  .  S IBSITE=$E(IBSITECD_"-"_IBSITENM,1,20)
 .  S IBSTAT=$$GET1^DIQ(351.82,IBI_",",.04)
 .  S:IBSTAT'="REMOVED" IBDCT=IBDCT+1   ; Moved from above and prevented REMOVED visits from counting
 .  S IBCT=IBCT+1   ; Moved from above and prevented REMOVED visits from counting
 .  S:IBSTAT="FREE" IBFRCT=IBFRCT+1
 .  S IBBILL=$P(IBDATA,U,5)
 .  S IBBLCMT=""
 .  S:IBBILL'?1N.N IBBLCMT=IBBILL     ;If the bill number has text, then it is a bill from an external site.
 .  S IBCMT=$$GET1^DIQ(351.82,IBI_",",.06)
 .  ; Still need to add comments, convert date to external, and convert site to display
 .  S ^TMP($J,"IBUCVST",IBVDT,IBCT)=$$FMTE^XLFDT(IBVDT)_U_$G(IBSITE)_U_IBSTAT_U_IBBLCMT_U_IBCMT
 Q IBCT_U_IBFRCT_U_IBDCT
 ;
PRTMSSN ; Print the Mission Act Exemption Message (May get moved to IB ERROR File to use IB ERROR functionality)
 ;
 W !,"Per the MISSION Act of 2018, this patient is allowed 3 free visits per",!,"calendar year",!
 Q
 ;
PRTUCUPD ; Print the UC Visit Tracking DB has been updated.
 ;
 W !,"The patient's Urgent Care visit tracking has been updated.",!
 Q
 ;
PRTSARUR() ; Print the UC SA message for PG 6 vets.
 N DIR,DIRUT,DUOUT,X,Y,IBY
 S IBY=-1   ; Default exit value
 W !
 S DIR(0)="YA",DIR("A",1)="This patient may be covered by a Special Authority.  Has this visit been",DIR("A")="reviewed by RUR? : "
 D ^DIR
 Q:$D(DIRUT) IBY
 Q:$D(DUOUT) IBY
 Q:'Y IBY     ; user selected No
 Q 1          ;Otherwise, the answer was yes
 ;
PRTNORUR ; Print the info message if no RUR completed PG 6 vet copays.
 W !!,"Please send this for review by RUR before entering this copay.",!
 W !,"This charge was not processed.  The patient's Urgent Care visit tracking was not",!,"updated.",!
 Q
 ;
UCCHRG2(DFN,IBDT) ; Process Urgent Care Copay Charge
 ; set the initial charge to $30
 ; Undeclared parameters
 ;   IBFEE - Flag for Community Care Copays
 ;   IBUNIT - (Default 1) # units for the charge
 ;   IBCHG - Default Copay to charge
 ;   DFN   - Patient IEN
 ;
 N IBIND,IBTYPE,IBPRI,IBUCVT,IBCT,IBFRCT,IBRESP,IBOK,IBDUPFLG    ; Patient Enrollment Group/UC Visit Tracking storage flag
 S IBCHG=30,IBUNIT=1  ;initial copay amount
 S (IBDT,IBTO)=IBFR,IBX="O",(IBTYPE,IBUNIT)=1,IBEVDA="*",IBDUPFLG=0
 ;
 ; Ask for other UC copays for the year that are not at this site (future development)
 ;
 ; Retrieve Priority Group
 S IBPRI=$$GETELGP(DFN,IBDT)  ;dbia 5158
 S IBIND=$$INDCHK^IBINUT1(IBDT,DFN)  ; IB*2.0*716
 ;
 ; Process Enrollment Priority Groups 7 and 8
 I 'IBIND,IBPRI>6 D  Q  ; IB*2.0*716
 . S IBCT=+$$PRTUCVST(DFN,IBDT,.IBDUPFLG)
 . ; Call CTBB^IBECEAU3 to confirm or substitute amount of Copay
 . D CTBB^IBECEAU3
 . ;Set UC Visit Tracking flag to Billed
 . S IBUCVT=1
 ;
 ; Process Enrollment Priority Groups 1 to 5
 I IBIND!(IBPRI<6) D  Q  ; IB*2.0*716
 . S IBCT=$$PRTUCVST(DFN,IBDT,.IBDUPFLG) ;Retrieve the number of visits and display them
 . S IBFRCT=$P(IBCT,U,2),IBCT=$P(IBCT,U)
 . I IBFRCT<3 D  Q               ; SC vet has < 3 Free UC visits print statements and quit
 . . D PRTMSSN                   ; display the mission act statement
 . . S IBOK=$$GETOK(IBDUPFLG)              ; Confirm with the user that it is ok to proceed.
 . . I IBOK D
 . . . D ADDVST(DFN,IBDT,"",1,2)
 . . . D PRTUCUPD                ; display the Patient Tracker statement.
 . . S IBY=-1                    ; Set the quit flag, but don't provide an error message.
 . ;
 . ; Call CTBB^IBECEAU3 to confirm or substitute amount of Copay
 . D CTBB^IBECEAU3
 ;
 ;PG 6 processing
 ;
 ;Ask user if RUR was completedIf there were Fewer than 3 visits
 S IBCT=$$GETVST(DFN,IBDT) ;Retrieve the number of visits
 S IBFRCT=$P(IBCT,U,2),IBCT=$P(IBCT,U)
 S IBRESP=""                 ; Initialize IBRESP
 I IBFRCT<3 D  Q:IBRESP<0    ; SC vet has < 3 Free UC visits print statements and quit
 . S IBRESP=$$PRTSARUR
 . I IBRESP<0 D PRTNORUR S IBY=-1
 ;
 ; Display the visits
 S IBCT=$$PRTUCVST(DFN,IBDT,.IBDUPFLG) ;Retrieve the number of visits and display them
 S IBFRCT=$P(IBCT,U,2),IBCT=$P(IBCT,U)
 ;
 S IBRESP=1    ;Reset the temporary response flag variable.  Assume patient will be charged.
 I IBFRCT<3 D  Q:$G(IBY)=-1        ; SC vet has < 3 Free UC visits print statements and quit
 . S IBRESP=$$PRTVSTSA
 . I IBRESP=-1 S IBY=-1 Q
 . I +$G(IBRESP)=1 D
 . . D PRTMSSN                     ; display the mission act statement
 . . S IBOK=$$GETOK(IBDUPFLG)      ; Confirm with the user that it is ok to proceed.
 . . I IBOK D
 . . . D ADDVST(DFN,IBDT,"",1,1)   ;
 . . . D PRTUCUPD                  ; display the Patient Tracker statement.
 . . S IBY=-1                      ; Set the quit flag, but don't provide an error message.
 ;
 ; Call CTBB^IBECEAU3 to confirm or substitute amount of Copay, then update the UC Visit Database
 D CTBB^IBECEAU3
 Q
 ;
ADDVST(DFN,IBDT,IBN,IBSTATUS,IBREAS,IBSITE) ; Update the Visit Tracking DB
 ;
 ;Input:
 ;   DFN      - (Required) Patient IEN (from file #2)
 ;   IBDT     - (Required) Date of Visit
 ;   IBN      - (Required) Copay IEN (from file #350)
 ;   IBSTATUS - (Required) Urgent Care Visit Billing Status
 ;              1 - FREE
 ;              2 - BILLED (i.e. copay was created)
 ;              3 - Not Counted (i.e. UC visit was cancelled at the site)
 ;              4 - Visit Only (Visit counted, but no bill produced)
 ;   IBREAS   - Code # for the comment
 ;   IBCMT    - Add SC/SA/SV (1) comment if adding a visit for a PG6.
 ;   IBSITE   - (Optional) Site where the copay was charged.  Defaults to IBFAC if not passed in.
 ;
 N FDA,FDAIEN,IBSITE,IBBILL,IBERROR,IBBLSTAT
 ;
 ;check for a defined site in the copay file
 ;WCJ;IB696
 ;S:$G(IBSITE)="" IBSITE=$$GET1^DIQ(350,$G(IBN)_",",.13,"I")
 I $G(IBSITE)="" S IBSITE=$$STA^XUAF4($$GET1^DIQ(350,$G(IBN)_",",.13,"I")) S:IBSITE]"" IBSITE=+IBSITE
 ;
 ;Otherwise, default to IBFAC
 ;WCJ;IB696;IBFAC can be an IEN for a child and not the actual facility so it may not be the IEN for the actual site. Pretty sure IBSITE will already be defined
 ;but if we need to use IBFAC, let's turn it into a site number
 ;S:$G(IBSITE)="" IBSITE=IBFAC
 S:$G(IBSITE)="" IBSITE=$$STA^XUAF4(IBFAC)
 ;
 S IBBILL=$$GET1^DIQ(350,$G(IBN)_",",.11,"E")
 S IBREAS=$G(IBREAS)
 ;
 ;If no Bill Number, check to see if on hold.  If so, store ON HOLD
 I IBBILL="" D
 . S IBBLSTAT=$$GET1^DIQ(350,$G(IBN)_",",.05,"I")
 . ; If bill status is 8 (On Hold) then store On Hold as the Bill Number
 . I IBBLSTAT=8 s IBBILL="ON HOLD"
 ;
 ;Call utility to add to DB
 D ADD^IBECEA38(DFN,IBSITE,IBDT,IBSTATUS,IBBILL,IBREAS,1,"",.IBERROR)
 ;
 Q
 ;
PRTVSTSA() ; Print the UC SA message for PG 6 vets.
 N DIR,DIRUT,DUOUT,X,Y,IBY
 S IBY=-1   ; Default exit value
 S DIR(0)="YA",DIR("A")="Is this visit related to the patient's Special Authority?  : "
 D ^DIR
 W !     ;force a line feed between the messages
 Q:$D(DIRUT) IBY
 Q:$D(DUOUT) IBY
 Q:'Y Y       ; user selected No
 Q 1          ;Otherwise, the answer was yes
 ;
GETOK(IBDUPFLG) ; Ask the user if it is OK to proceed.
 N DIR,DIRUT,DUOUT,X,Y,IBY
 S IBDUPFLG=$G(IBDUPFLG)
 I IBDUPFLG D
 . S DIR(0)="YA",DIR("A")="Duplicate visit detected.  Is the date of service correct? :"
 . D ^DIR
 . W !           ;force a line feed between the messages
 ;
 ; If the user enters No
 I IBDUPFLG,(+$G(Y)'=1) D  Q +$G(Y)
 . W !!,"Visit Date not confirmed - Visit Tracking Database not updated."
 ;
 S DIR(0)="YA",DIR("A")="Is the above information correct?  : "
 D ^DIR
 W !           ;force a line feed between the messages
 Q +Y          ;Otherwise, the answer was yes
 ;
GETELIG(IBDFN,IBOUT) ; This function returns all of the Enrollment Priority Group Entries for the specified patient
 ;
 ;INPUT  - IBDFN - Patient IEN to look up
 ;OUTPUT - IBOUT - (Optional) Output Array containing entries in the Patient Enrollment file (#27.11) for the patient.
 ;         Function call:
 ;                         -1^<Error Message> - Error occured
 ;                          total of entries found
 ;
 Q:$G(IBDFN)="" "-1^Patient not defined for Enrollment Lookup"
 S:$G(IBOUT)="" IBOUT=0  ;
 ;
 N IBERR
 ;
 S IBERR=""  ;Initialize Error Array
 ;
 ;FIND^DIC structure
 ;D FIND^DIC(file[,iens][,fields][,flags],[.]value[,number][,[.]indexes][,[.]screen][,identifier][,target_root][,msg_root])  ; this line is just for reference
 ;
 ; get all enrollment groups for the specified patient.
 ; screen output to only get entries with "verified" enrollment status (field 27.11/.04)  IB*2.0*689
 D FIND^DIC(27.11,"","@;.07I;.08I","QEP",IBDFN,"","C","I $P(^DGEN(27.11,Y,0),U,4)=2","","IBOUT","IBERR")
 Q +IBOUT("DILIST",0)
 ;
GETELGP(IBDFN,IBDOS) ; Function to return a patient's Enrollment Priority Group For a specified Date of Service
 ;
 ;INPUT:  IBDFN - ibPatient IEN (File #2)
 ;        IBDOS - Date of Service
 ;OUTPUT: GETELGP - Patient's Enrollment Group on the specified DAte of service.
 ;                            or
 ;                   -1^<error message> if Error occurred during Enrollment Lookup
 ;
 N IBOUT,IBCHK,I,IBDATA,IBELIG,IBEFDT,IBELKUP,IBOLD,IBSCEFDT,IBLKDT
 ;
 S IBOUT=""  ;initialize the Enrollment groupt array
 S IBCHK=$$GETELIG(IBDFN,.IBOUT)
 ;
 I +IBCHK=-1 Q IBCHK   ; Error occurred.  Quit and pass error message to calling function
 I +IBCHK=0 Q 8   ;no entries in the Patient Enrollment File, assume PG 8 and quit
 ;
 ; Add sorted by effective Date node.  If multiple on the same day, store the lowest non NULL entry (NULL is assumed to PG 8)
 S I=0
 F  S I=$O(IBOUT("DILIST",I)) Q:'I  D
 .  S IBDATA=$G(IBOUT("DILIST",I,0))
 .  S IBELIG=$P(IBDATA,U,2),IBEFDT=$P(IBDATA,U,3)
 .  S:IBELIG="" IBELIG=8
 .  S IBOLD=$G(IBOUT("SDATE",IBEFDT))
 .  ; If multiple entries with the same effective date, don't update if new eligibility is not less than the currently sorted eligibilty
 .  I IBOLD'="",(IBELIG'<IBOLD) Q
 .  S IBOUT("SDATE",IBEFDT)=IBELIG
 ;
 ;Lookup up the Enrollment Group, 
 ; first for an exact effective date match, 
 S IBELKUP=$G(IBOUT("SDATE",IBDOS))
 I IBELKUP'="" Q +IBELKUP
 ; else look for the effective date.
 S IBLKDT=$O(IBOUT("SDATE",IBDOS),-1)
 I IBLKDT="" Q 8            ; No Enrollment for that date found, assume PG 8
 S IBELKUP=$G(IBOUT("SDATE",IBLKDT))
 ;
 Q:IBELKUP<7 IBELKUP    ; If Priority Group is <7, then don't perform a retro lookup and quit
 ;
 ; Retro award lookup for PG 7's and 8's 
 S IBSCEFDT=$$GET1^DIQ(2,IBDFN_",",.3014,"I")  ; effective SC % date  DBIA 7182
 ;
 ; If no SC % Effective Date, then quit with previously found PG.
 Q:$G(IBSCEFDT)="" IBELKUP
 ;
 ;Check to see of there is a Retro award. Effective SC % date < EG Effective Date
 I IBSCEFDT'<IBLKDT Q IBELKUP
 ;
 ;perform a new lookup using the SC % Effective Date
 I IBSCEFDT'="",$D(IBOUT("SDATE",IBSCEFDT)) S IBELKUP=IBOUT("SDATE",IBSCEFDT)  ; IB*2.0*689
 ;
 Q +IBELKUP
 ;
IBEDIT()  ;Check to see if the user has the IB EDIT Key to allow the user to add a copay
 ;
 I '$D(^XUSEC("IB EDIT",DUZ)) D  Q 0
 . W !!,"IB EDIT Key Required to Add a Charge"  ; Write the message
 . R !!,?10,"Press any key to continue.    ",IBX:DTIME
 ;
 Q 1
