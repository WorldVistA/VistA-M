PSODIR4 ;EPIP/RTW - Outpatient Site High Cost Related Calls ; 3/30/18 11:30am
 ;;7.0;OUTPATIENT PHARMACY;**452**;Dec 1997;Build 56
 ;------------------------------------------------------------------
 ; ICR#     TYPE    DESCRIPTION
 ;-----  ---------  --------------------------------------------
 ; 2056  Supported  $$GET1^DIQ
 ;10026  Supported  ^DIR
 ;------------------------------------------------------------------
OPTSITE(PSOTRGET,PSORTN,PSOSCREN) ; Prompt for Outpatient Site when the host site
 ; has multiple OUTPATIENT SITE file (#59) entries.
 ;
 ; Input:
 ;   PSOTRGET ; Required ; Name of output variable/array, passed by
 ;                       reference.
 ;   PSORTN    ; Required ; Name of calling routine, usually $T(+0)
 ;   PSOSCREN ; Optional ;
 ;            0 ; By default, no screening of entries will take place
 ;            1 ; Optionally, only active OUTPATIENT SITE entries
 ; Output:  ;
 ;   The passed name of the PSOTRGET will be used in all output as
 ;   follows:
 ;     PSOTRGET=User's response from FM DIR API prompt
 ;     PSOTRGET(PSOIEN59)=NAME (of OUTPATIENT SITE file (#59) entry)
 ;     PSOTRGET("PSOSCNT")=Number of selected OUTPATIENT SITE entries
 ;                   - or -
 ;     PSOTRGET="^" ; If an error occurs, user times out or enters '^'
 ;
 ; Intended usage:
 ;   List the host computer's OUTPATIENT SITE entries allowing
 ;   the user to select any combination of those entries, for example
 ;   if there are 5 active OUTPATIENT SITEs, the user can select one
 ;   of the following: 1  1-3  1,2,5
 ;
 ; Example calls:
 ;   1. Allow both active and/or inactive entries to be selected:
 ;      D OPTSITE^PSODIR4(.PSOTRGET,$T(+0)) G:PSOTRGET="^" EXIT
 ;   2. Allow only active OUTPATIENT SITE entries to be selected:
 ;      D OPTSITE^PSODIR4(.PSOTRGET,$T(+0),1) G:PSOTRGET="^" EXIT
 ;
 KILL PSOTRGET ; Start with fresh output
 S PSOSCREN=$G(PSOSCREN,0) ; Set optional screen to zero (avoid screening)
 ;
 ; Place selectable  OUTPATIENT SITE entries in array:
 ;   PSOINPUT(Sequential#)=PSOIEN59_"^"_PSOSITNM
 ; 
 N PSOSCNT,PSODTINAC,PSOIEN59,PSOINPUT,PSOEXIT,PSOSITNM
 S (PSOSCNT,PSOIEN59)=0 ; PSOSCNT=Count the number of selectable OUTPATIENT SITEs
 F  S PSOIEN59=$O(^PS(59,PSOIEN59)) Q:'PSOIEN59  D  ;
 . S PSOSITNM=$$GET1^DIQ(59,PSOIEN59,.01) ; OUTPATIENT SITE NAME (#.01)
 . I PSOSCREN=1 D  Q:PSOEXIT="^"  ; Keep only active sites
 . . S PSOEXIT=0
 . . S PSODTINAC=$$GET1^DIQ(59,PSOIEN59,2004,"I") ; INACTIVE DATE (#2004)
 . . I PSODTINAC,PSODTINAC'>DT S PSOEXIT="^" Q  ;. Bypass inactive site
 . S PSOSCNT=PSOSCNT+1
 . S PSOINPUT(PSOSCNT)=PSOIEN59_"^"_PSOSITNM
 ;
 I PSOSCNT=1 D  Q  ; When PSOSCNT of entries = 1, no need to prompt user
 . S PSOIEN59=$P(PSOINPUT(PSOSCNT),U,1),PSOSITNM=$P(PSOINPUT(PSOSCNT),U,2)
 . S PSOTRGET(PSOIEN59)=PSOSITNM ; PSOTRGET is the single Outpatient Site
 . S PSOTRGET("PSOSCNT")=1,PSOTRGET=""
 I PSOSCNT=0 S PSOTRGET="^" Q  ; No active OUTPATIENT SITE entries found
 ;
 ; Display the selectable  OUTPATIENT SITE entries from the INPUT 
 ; array previously created above.
 ;
 W !
 W !,"For RXs written at OUTPATIENT SITE(s):  (Example 1,3 or 1-5)"
 ;
 N PSOSCNT,PSOIEN59,PSOMAX
 S (PSOSCNT,PSOMAX)=0 ; MAX=Count the number of selectable OUTPATIENT SITEs
 F  S PSOSCNT=$O(PSOINPUT(PSOSCNT)) Q:'PSOSCNT  D  ;
 . S PSOIEN59=$P(PSOINPUT(PSOSCNT),U),PSOSITNM=$P(PSOINPUT(PSOSCNT),U,2)
 . W !?3,$J(PSOSCNT,2),")  ",PSOSITNM
 . S PSOMAX=PSOMAX+1
 ;
 ; Prepare for DIR (list or range) API to prompt for selected sites
 ;
 N %,DA,DIR,DIRUT,DTOUT,DUOUT,I,X,Y ; DIR API variables
 N PSODEF
 ;
 S DIR("A")="Select NUMBER(s): " ;DIR prompt text
 S PSODEF=$G(^DISV(DUZ,PSORTN,"PSOSITE"),"1-"_PSOMAX) S:PSODEF]"" DIR("B")=PSODEF
 ; Note: Previously defaulted site might be inactivated, making the
 ;       previous default range too large
 I $P(DIR("B"),"-",2)>PSOMAX S DIR("B")="1-"_PSOMAX
 ;
 ; DIR(0) notes
 ;  L=List or range format  A=Nothing can be appended to DIC("A")
 ;                          O=User response is prompt is optional
 ;  Select from 1 to MAXimum selectable range
 S DIR(0)="LAO^1:"_PSOMAX ; User may select list or range from 1 to PSOMAX
 ;
 D ^DIR
 ;
 I $G(DTOUT) S PSOTRGET="^" Q  ; User time out at DIR prompt
 S PSOTRGET=X I PSOTRGET["^" S PSOTRGET="^" Q  ;User up-arrow out at DIR prompt
 ;
 ; Build output PSOTRGET(PSOIEN59)=PSOSITNM from the comma delimited
 ; output varible Y of the FM DIR API.  Example DIR output: Y="1,3,5,"
 ;
 N PSOIEN59,PCE,SUB
 F PCE=1:1 S SUB=$P(Y,",",PCE) Q:'SUB  D  ;
 . S PSOIEN59=$P(PSOINPUT(SUB),U,1),PSOSITNM=$P(PSOINPUT(SUB),U,2)
 . S PSOTRGET(PSOIEN59)=PSOSITNM
 S PSOTRGET("PSOSCNT")=$L(Y,",")-1 ; Number of selected PSOTRGET entries
 ;
 S:PSOTRGET'["^" ^DISV(DUZ,PSORTN,"PSOSITE")=PSOTRGET ; Next default
 ;
 Q
DIVOK(INARRAY,XREF,RX0,RX1) ; Return: 1 if the division of the RX is OK
 ; 0 if the division does not match a specified input selection
 ;
 ; Assumptions:
 ;   This call was designed to work with an Original RX, a Refilled
 ;   RX, or a Partial RX.
 ; Cross References potentially utilized by calling routines
 ;   Original RX: ^PSRX("AL",Released_Dt,RX0,0)=""
 ;   Refilled RX: ^PSRX("AL",Released_Dt,RX0,RX1)=""
 ;   Partial  RX: ^PSRX("AM",Released_Dt,RX0,RX1)=""
 ; Input:
 ;   INARRAY ; Required ; Usually as the result from a previous
 ;             execution of the above companion call OPTSITE^PSOZDIR4
 ;     INARRAY(PSOIEN)=VALUE ; Example: INARRAY(1)="JOHN COCHRAN VAMC"
 ;     INARRAY("B",VALUE,PSOIEN)="" ; INARRAY("B","JOHN COCHRAN VAMC",1)=""
 ;   XREF ; Required ; Type of x-ref, where
 ;              'AL' ; Indicates a either an original RX when RX1=0
 ;                     Indicates a refilled (multiple) RX when RX1>0
 ;              'AM' ; Indicates a partial  (multiple) RX
 ;          Note: See routine PSOSCT10 as an example, used by the
 ;                option High Cost Rx Report [PSO HI COST].
 ;   RX0  ; Required ; IEN of PRESCRIPTION file #52 entry
 ;   RX1  ; Required ; IEN1 of Refill or a Partial RX multiple entry.
 ; Output:
 ;   This extrinsic functions returns 1 (true) or 0 (false)
 ; Intended usage:
 ;   This purpose of this API is to screen a particular RX for report
 ;   inclusion or exclusion, that is, if the RX was dispensed at a
 ;   previously selected Outpatient Site it should be included. In
 ;   this, the extrinsic function will return a one (1).  If the RX
 ;   was not dispensed at a selected Outpatient Site, it should be
 ;   excluded and the extrinsic function will return a zero (0).
 ;   Althought this API can be used independently, this entry point
 ;   was written as a companion call to be utilized after calling the
 ;   OPTSITE^PSOZDIR4 API.
 ; Example call:
 ;   ; Prompt for which Outptient Site(s) to include
 ;   D OPTSITE^PSOZDIR4(.PSOSITE,$T(+0)) G:PSOSITE="^" EXIT
 ;   ; When looping thru entries in file (#52), screen
 ;   ; the RX to only include a selected Outpatient Site.
 ;   Q:'$$DIVOK^PSOZDIR4(.PSOSITE,TY,PSRXN,PSFILL)
 ;
 N DIRUT,PSOIENS,PSOSITEI,PSOVAL,IENS
 ;
 S PSOVAL=0 ; Default return value to false (failed screen by division)
 ;
 I XREF="AL" D  ; An original or a refill, depending upon value RX1
 . ;
 . I RX1=0 D  ; Original RX based upon an 'AL' type of XREF
 . . ;
 . . ; DIVISION (#20) [RP59'] of PRESCRIPTION file (#52)
 . . S IENS=RX0_","
 . . S PSOSITEI=$$GET1^DIQ(52,IENS,20,"I") Q:$G(DIERR)
 . ;
 . I RX1>0 D  ; Refilled RX based upon an 'AL' type of XREF
 . . ;
 . . ; DIVISION (#8) [RP59'] of REFILL multiple (#52.1)
 . . S IENS=RX1_","_RX0_","
 . . S PSOSITEI=$$GET1^DIQ(52.1,IENS,8,"I") Q:$G(DIERR)
 . ;
 . I $D(INARRAY(PSOSITEI)) S PSOVAL=1 ; Selected DIVISION found
 ;
 I XREF="AM" D  ; Partial RX based upon 'AM' type of XREF
 . ;
 . ; DIVISION (#.09) [RP59'] of PARTIAL DATA multiple (#52.2)
 . S IENS=RX1_","_RX0_","
 . S PSOSITEI=$$GET1^DIQ(52.2,IENS,.09,"I") Q:$G(DIERR)
 . ;
 . I $D(INARRAY(PSOSITEI)) S PSOVAL=1 ; Selected DIVISION found
 ;
 Q PSOVAL
DIR() Q "%,DIR,DIRUT,DTOUT,DUOUT,I,X,Y" ;............... ^DIR
 Q
 ;
GETSITE(PSORTN) ; Prompt for Outpatient Site (or Division)
 ;
 ; Output:
 ;     PSOSSITE(IENof59)=NAME (of OUTPATIENT SITE file #59)
 ;     PSOFLGQ = 1 if user enters '^' or no active Outpatient Site found
 ;
 N PSODEF,PSODTINAC,PSOIEN59,PSOIENS,PSOFLGQ,PSOMAX,PROMPT,PSOSITNM,PSOSCNT
 ;
 ; Set default to user's previous response; or '1-2'
 ; if no previous response
 ;
 S PSODEF=$G(^DISV(DUZ,PSORTN,"PSOSITE"),"1-2")
 ;
 ; Loop through OUTPATIENT SITE file (#59) entries
 ; and bypass any inactive entries.  Build a prompt array to be used
 ; as input to the FM DIR API call and display prompt text and any
 ; active OUTPATIENT SITE entries for user selection.
 ;
 S (PSOSCNT,PSOIEN59)=0
 F  S PSOIEN59=$O(^PS(59,PSOIEN59)) Q:'PSOIEN59  D  ;
 . S PSOIENS=PSOIEN59_"," ; IEN String for FM Database Server calls
 . S PSODTINAC=$$GET1^DIQ(59,PSOIENS,2004,"I") Q:$G(DIERR)  ; INACTIVE DATE
 . I PSODTINAC,PSODTINAC'>DT Q  ; Quit if currently inactive
 . S PSOSITNM=$$GET1^DIQ(59,PSOIENS,.01) Q:$G(DIERR)  ; NAME of SITE
 . Q:PSOSITNM=""  ; Quit it NAME of OUTPATIENT SITE is null
 . S PSOSCNT=PSOSCNT+1 ; Increment count of active Outpatient Sites
 . I PSOSCNT=1 D  ;. Display prompt text before 1st active Outpatient Site
 . . W !
 . . W !,"For RXs written at OUTPATIENT SITEs:  (Example 1,3 or 1-5)"
 . S PROMPT(PSOSCNT)=PSOIEN59_"^"_PSOSITNM ; Input array to FM DIR API
 . W !?3,$J(PSOSCNT,2),")  ",PSOSITNM ;.. Display choice number & site
 ;
 I 'PSOSCNT S PSOFLGQ=1 Q  ; If no active sites, return PSOFLGQ = 1
 ;
 ; Refresh output array, prompt user using FM DIR List or Range API
 ; and save user's choice in ^DISV global for future default
 ;
 KILL PSOSSITE ; Refresh output array
 W ! D REFSITE(.PROMPT,.PSOSSITE,PSOSCNT,$G(DEF),1)
 S:PSOMAX'["^" ^DISV(DUZ,PSORTN,"PSOSSITE")=PSOMAX
 ;
 Q
REFSITE(PSOINPUT,PSOOUTPT,PSOMAX,PSODEF,PSORETRN) ; Prompt for range or list of displayed items
 ; PSOINPUT  - Array of displayed menu items in the format:
 ; PSOINPUT(PSONUM)=PSOIEN_"^"_PSOVALU
 ; PSOOUTPT - Array of user selected items in the format:
 ;    PSOOUTPT(PSOIEN)=PSOVALU
 ; PSOMAX ; User's response
 ; PSOMAX    - Maximum number of items displayed
 ; PSODEF    - Default answer (optional)
 ; PSORETRN - If 1 the users response will be returned in var. PSOMAX
 ; (optional)
 ;
 N @($$DIR^PSODIR4())
 N PSOI,PSOIEN,PSONUM,PSOVALU
 S DIR(0)="LAO^1:"_PSOMAX ;...User may select list or range
 S DIR("A")="Select NUMBER(s): " ;...Prompt text
 I PSODEF]"" S DIR("B")=PSODEF
 D ^DIR ;...Prompt user IA #10026
 S PSOOUTPT=X
 I $G(PSORETRN)=1 S PSOMAX=X
 I "^"[X S PSOFLGQ=1 Q
 ;-> Process user's list of choices.  Example Y="1,3,5,6,"
 S PSONUM=""
 F PSOI=1:1 S PSONUM=$P(Y,",",PSOI) Q:'PSONUM  D  ;
 . S PSOIEN=$P(PSOINPUT(PSONUM),U,1),PSOVALU=$P(PSOINPUT(PSONUM),U,2)
 . S PSOOUTPT(PSOIEN)=PSOVALU
 ;
 Q
