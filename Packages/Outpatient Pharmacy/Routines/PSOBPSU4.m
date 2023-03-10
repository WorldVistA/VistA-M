PSOBPSU4 ;AITC/MRD - BPS (ECME) Utilities 4 ;10/29/2020
 ;;7.0;OUTPATIENT PHARMACY;**561,648**;DEC 1997;Build 15
 ;
BYPASSACT(PSORX) ; 'BY' hidden action, Bypass 3/4 Day Supply.
 ;
 ; The 'BY' hidden action allows the user to set a flag, BYPASS
 ; 3/4 DAY SUPPLY LOGIC, which, when set, causes the 3/4 day
 ; supply checks to be bypassed during CMOP processing.  If the
 ; flag is already set when the user performs the 'BY' action,
 ; the flag is reset to 'NO'.
 ;
 N DIR,PSOCOMMENT,PSOFILL,PSOFLAG,PSOREASON,Y
 ;
 D FULL^VALM1
 S VALMBCK="R"
 ;
 ; Determine current fill.
 ;
 S PSOFILL=$O(^PSRX(PSORX,1,"A"),-1)
 I PSOFILL="" S PSOFILL=0
 ;
 ; If the Rx/Fill is not e-billable, then display a message and
 ; Quit out.
 ;
 I '$$EBILLABLE^PSOSULB2(PSORX,PSOFILL) D  Q
 . W !!,*7,"***This option only applies to ePharmacy billable prescriptions***",!
 . S DIR(0)="E",DIR("A")="Press Return to Continue"
 . D ^DIR
 . Q
 ;
 ; Determine how the flag is currently set.
 ;
 S PSOFLAG=$$FLAG(PSORX,PSOFILL)
 ;
 ; Display message.
 ;
 I PSOFLAG="YES" D
 . W !!,"Currently, Bypass 3/4 Day Supply is set to YES."
 . W !!,"If you continue, Bypass 3/4 Day Supply will be set to NO and the 3/4"
 . W !,"Days Supply logic will apply when the RX is sent to CMOP.",!
 . Q
 E  D
 . W !!,"Currently, Bypass 3/4 Day Supply is set to NO."
 . W !!,"If you continue, Bypass 3/4 Day Supply will be set to YES and the 3/4"
 . W !,"Days Supply logic will be bypassed when the RX is sent to CMOP.",!
 . Q
 ;
 S DIR(0)="Y",DIR("A")="Continue",DIR("B")="YES"
 D ^DIR
 ;
 I Y'=1 Q
 ;
 ; Set or reset the bypass flag for this Rx/fill.
 ;
 S PSOFLAG=$S(PSOFLAG="YES":"NO",1:"YES")
 D SETFLAG(PSORX,PSOFILL,PSOFLAG)
 ;
 ; Add a comment to Activity Log.  Make the reason S(uspense) if the Rx
 ; is on the suspense queue; otherwise, make the reason E(dit).
 ;
 S PSOCOMMENT="Bypass 3/4 Day Supply set to "_PSOFLAG
 I $P($$SUSPFILL(PSORX),"^",1)="" S PSOREASON="E"
 E  S PSOREASON="S"
 D RXACT^PSOBPSU2(PSORX,PSOFILL,PSOCOMMENT,PSOREASON,DUZ)
 ;
 Q
 ;
FLAG(PSORX,PSOFILL) ; Determine how the bypass flag is currently set.
 ;
 ; This function will return the external value (YES or NO) of the
 ; Bypass 3/4 Day Supply flag for the given Rx and Fill.
 ;
 I PSOFILL=0 Q $$GET1^DIQ(52,PSORX,94,"E")
 E  Q $$GET1^DIQ(52.1,PSOFILL_","_PSORX,98,"E")
 ;
SETFLAG(PSORX,PSOFILL,PSOFLAG) ; Set the bypass flag to the value passed.
 ;
 N PSOX
 ;
 I PSOFILL=0 D
 . S PSOX(52,PSORX_",",94)=PSOFLAG
 . D FILE^DIE("E","PSOX","")
 . Q
 E  D
 . S PSOX(52.1,PSOFILL_","_PSORX_",",98)=PSOFLAG
 . D FILE^DIE("E","PSOX","")
 . Q
 ;
 Q
 ;
BYPASSOPT ; Entry point for menu option Bypass 3/4 Day Supply.
 ;
 ; The menu option Bypass 3/4 Day Supply allows the user to select one
 ; or more prescription for which the Bypass 3/4 Day Supply flag will
 ; be set.  It will also reset the Suspense Date to be today.
 ;
 N DEAD,DIC,DIR,INDT,PSOARRAY,PSOCOMMENT,PSOFILL,PSOPROMPT
 N PSORX,PSORXIEN,PSOSUSPFILL,PSOSUSPIEN,PSOX,SFN,X,Y
 ;
 W !!,"Select one or more prescriptions currently on the CMOP suspense"
 W !,"queue.  For each prescription entered, the 3/4 days Supply logic"
 W !,"will be bypassed when the CMOP process runs.  This will apply only"
 W !,"to the current fill on each ePharmacy billable prescription"
 W !,"selected.",!
 ;
 S PSOPROMPT="Select PRESCRIPTION RX #: "
 ;
B1 ;
 ;
 K DIC
 ;
 S DIC=52
 S DIC(0)="AEMQ"
 S DIC("A")=PSOPROMPT
 S DIC("T")=""
 ;
 D ^DIC
 ;
 ; If the user just hit <enter>, skip down to B2.
 ;
 I X="" G B2
 I Y=-1 G BQ
 ;
 S PSORXIEN=+Y
 S PSORX=$P(Y,"^",2)
 S PSOPROMPT="Another one: "
 ;
 ; Verify that the selected Rx is currently on the CMOP
 ; suspense queue.
 ;
 S PSOSUSPFILL=$$SUSPFILL(PSORXIEN)
 I $P(PSOSUSPFILL,"^",1)="" D  G B1
 . W !,*7,?8,"RX is not on CMOP suspense queue"
 . Q
 ;
 ; If the Rx/Fill is not e-billable, then display a message and
 ; Go back to the prompt (B1).
 ;
 I '$$EBILLABLE^PSOSULB2(PSORXIEN,$P(PSOSUSPFILL,"^",1)) D  G B1
 . W !,*7,?8,"RX is not ePharmacy billable"
 . Q
 ;
 ; If the user enters an Rx already on the list, conditionally
 ; remove it.
 ;
 I $D(PSOARRAY(PSORXIEN)) D  G B1
 . S DIR(0)="Y"
 . S DIR("A")="Remove RX "_PSORX_" from your list"
 . S DIR("B")="YES"
 . D ^DIR
 . I Y=1 K PSOARRAY(PSORXIEN)
 . Q
 ;
 ; Add the select Rx to the list.
 ;
 S PSOARRAY(PSORXIEN)=PSOSUSPFILL
 ;
 G B1
 ;
B2 ;
 ;
 I '$D(PSOARRAY) G BQ
 ;
 ; Present to the user the list of all prescriptions selected,
 ; displaying the Rx#, drug, patient name, and patient ID.
 ;
 W !!,"Prescriptions Selected:"
 ;
 S PSORXIEN=0
 F  S PSORXIEN=$O(PSOARRAY(PSORXIEN)) Q:'PSORXIEN  D
 . W !?2,$$GET1^DIQ(52,PSORXIEN,.01,"E")
 . W ?13,$E($$GET1^DIQ(52,PSORXIEN,6,"E"),1,30)
 . W ?45,$E($$GET1^DIQ(52,PSORXIEN,2,"E"),1,30)
 . Q
 ;
 W !!,"When the CMOP suspense queue is run, the 3/4 Days Supply logic"
 W !,"will be bypassed for the current fill for each ePharmacy billable"
 W !,"prescription selected.",!
 ;
 S DIR(0)="Y",DIR("A")="Continue",DIR("B")="YES"
 D ^DIR
 I Y'=1 G BQ
 ;
 W !!,?5,"Rx",?16,"Drug",?48,"Patient",?63,"New Suspense Date"
 ;
 ; For each Rx selected by the user, set the bypass flag to YES, add a
 ; comment to the activity log, reset the suspense date to be today,
 ; and call CHANGE^PSOSUCH1 to update two dates in file 52.
 ;
 S PSORXIEN=0
 F  S PSORXIEN=$O(PSOARRAY(PSORXIEN)) Q:'PSORXIEN  D
 . ;
 . S PSOFILL=$P(PSOARRAY(PSORXIEN),"^",1)
 . S PSOSUSPIEN=$P(PSOARRAY(PSORXIEN),"^",2)
 . ;
 . ; Set the bypass flag for this Rx/fill.
 . ;
 . D SETFLAG(PSORXIEN,PSOFILL,"YES")
 . ;
 . ; Add comment to Activity Log.
 . ;
 . S PSOCOMMENT="Bypass 3/4 Day Supply set to YES"
 . D RXACT^PSOBPSU2(PSORXIEN,PSOFILL,PSOCOMMENT,"S",DUZ)
 . ;
 . ; Reset the suspense date to be today (DT).
 . ;
 . S PSOX(52.5,PSOSUSPIEN_",",.02)=DT
 . D FILE^DIE("E","PSOX","")
 . ;
 . ; The call to CHANGE^PSOSUCH1, further down, updates either the Fill
 . ; Date or Refill Date field in file 52.  The input transform for
 . ; those fields causes the date to be echoed to the screen.  To
 . ; make the display of this date less confusing, we will redisplay
 . ; each Rx on a line, with the date appearing on the end.
 . ;
 . W !?2,$$GET1^DIQ(52,PSORXIEN,.01,"E")
 . W ?13,$E($$GET1^DIQ(52,PSORXIEN,6,"E"),1,30)
 . W ?45,$E($$GET1^DIQ(52,PSORXIEN,2,"E"),1,18)
 . W ?63
 . ;
 . ; CHANGE^PSOSUCH1 updates the Fill (or Refill) Date and the
 . ; Last Dispensed Date in file 52, Prescription.
 . ;
 . S SFN=PSOSUSPIEN
 . S DEAD=0
 . S INDT=DT
 . D CHANGE^PSOSUCH1(PSORXIEN,PSOFILL)
 . ;
 . Q
 ;
BQ ;
 ;
 S VALMBCK="R"
 ;
 Q
 ;
SUSPFILL(PSORX) ; Determine the fill# currently on the suspense queue.
 ;
 ; This function will determine whether a given Rx is on the suspense
 ; queue.  If it is not, or it has already been printed, or it is
 ; on the queue to be filled locally, this function returns "".
 ; Otherwise, it returns the fill# (which may be 0/zero).
 ; It also returns the IEN for the entry in file# 52.5, RX SUSPENSE.
 ;
 N PSOFILL,PSOSUSPIEN
 ;
 ; Quit with "" if this Rx is not on the suspense queue.
 ;
 S PSOSUSPIEN=$O(^PS(52.5,"B",PSORX,""))
 I PSOSUSPIEN="" Q ""
 ;
 ; Quit with "" if this Rx has already been printed.
 ;
 I $$GET1^DIQ(52.5,PSOSUSPIEN,2,"E")="YES" Q ""
 ;
 ; Quit with "" if this is a window (local) fill.
 ;
 I $$GET1^DIQ(52.5,PSOSUSPIEN,.04,"E")="WINDOW" Q ""
 ;
 ; Return the fill# and the IEN to file# 52.5, RX SUSPENSE
 ;
 Q $$GET1^DIQ(52.5,PSOSUSPIEN,9)_"^"_PSOSUSPIEN
 ;
