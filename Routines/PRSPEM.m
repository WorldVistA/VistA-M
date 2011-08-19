PRSPEM ;WOIFO/MGD - PTP ENTER MEMORANDUM ;06/01/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;The following routine will allow HR to enter a Part Time Physician's
 ;Memorandum of Service Level Expectations.  Memorandums will cover 364
 ;days (26 full Pay Periods) and the Agreed Hours must be equally
 ;divisible by 26.
 ;
 Q
MAIN ; Main Driver
 N DFN,STDAT,ENDAT,AHRS,ICOM,ESOK
 ; Prompt for Part Time Physician
 D PTP
 I PRSIEN'>0 D KILL Q
 ; Display Header info to validate the correct employee was chosen
 D HDR
 ; Prompt and validate Start Date. Calculate and display End Date
 S QUIT=0
 F  D  Q:QUIT!('OVERLAP)
 . S OVERLAP=0
 . D START
 . Q:QUIT
 . D END
 I QUIT D KILL Q
 ;
 ; Prompt and validate Agreed Hours
 D AHRS
 I Y'>0 D KILL Q
 ; Prompt for Initial Comments
 D ICOM
 I Y="^" D KILL Q
 ; Prompt for E-Sig and save if confirmed
 D ESIG
 Q
 ;
PTP ; Prompt for Part Time Physician
 N SSN
 W !
 S DIC="^PRSPC(",DIC(0)="AEMQZ",DIC("A")="Select EMPLOYEE: "
 D ^DIC K DIC
 S PRSIEN=+Y
 Q:PRSIEN<1
 ;
 ; determine associated NEW PERSON entry
 S SSN=$$GET1^DIQ(450,PRSIEN_",",8,"I")
 S IEN200=$S(SSN="":"",1:$O(^VA(200,"SSN",SSN,0)))
 I 'IEN200 D
 . W $C(7),!!,"Can't find an entry in the NEW PERSON file for this employee."
 . W !,"They must be added as a user before the memorandum is created."
 . S PRSIEN=-1
 Q
 ;
HDR ; Display PTP info
 S SCRTTL="Enter PT Physician Memoranda"
 D HDR^PRSPUT1(PRSIEN,SCRTTL)
 W !
 Q
 ;
START ; Prompt for Start Date
 ; This subroutine prompts for the date then goes through several
 ; checks if any check fails we give an explanation message and
 ; reprompt for the date.  If no checks fail we set valid to
 ; quit.  The user must ^ or timeout to quit.
 ;
 N VALID S VALID=0
 F  D  Q:QUIT!(VALID)
 . N Y,DIR,DIRUT S DIR(0)="458.7,1A0",DIR("A")="Start Date: " D ^DIR
 .; Validate that the Start Date is the first day of a Pay Period.
 . I $D(DIRUT) S QUIT=1 Q
 . S D1=+Y
 . D PP^PRSAPPU
 . I DAY'=1 D  Q
 . . D SILMO^PRSLIB01(D1)
 . . W !,"You entered ",$$EXTERNAL^DILFD(458.7,1,,D1)
 . . W !!,"The Start Date must be the first day of a Pay Period."
 . . W !,"Please re-enter.",!
 . S STDAT=D1
 .; Check to see if this employee's timecard for this PP is
 .; in a status other than Timekeeper
 . S PPI=$P($G(^PRST(458,"AD",D1)),U)
 . I (D1<DT),($G(PPI)'>0) D  Q
 . .  W !!,?3,"There is no pay period on file for that past date."
 .;
 .; for all past dates the employee must have a timecard in a
 .; a status of 'T"
 .;
 . I (D1<DT),($P($G(^PRST(458,PPI,"E",PRSIEN,0)),U,2)'="T") D  Q
 ..  W !!,?3,"To enter memos for past dates, the employee must have a"
 ..  W !,?3,"timecard in Timekeeper status."
 .;
 .; for future dates when there is a timecard we must also be in
 .; timekeeper status
 .; 
 . I (D1'<DT),($G(PPI)>0),$D(^PRST(458,PPI,"E",PRSIEN,0)),($P($G(^PRST(458,PPI,"E",PRSIEN,0)),U,2)'="T") D  Q
 . . W !!,?3,"This employee's timecard has a status other than "
 . . W !,?3,"Timekeeper.  It will have to be returned to the Timekeeper "
 . . W !,?3,"before a memo covering this pay period can be entered."
 .;
 .; If we make it through all the checks set valid and QUIT only gets
 .; set when we abort or timeout
 . S VALID=1
 Q
 ;
END ; Calculate and display End Date
 N X1,X2,X,Y
 S X1=D1,X2=363
 D C^%DTC
 S ENDDAT=X,Y=X
 D DD^%DT
 W !,"  End Date: ",Y
 K D1
 ; Verify that there are no other Memorandums covering this same time
 S IEN=""
 F  S IEN=$O(^PRST(458.7,"B",PRSIEN,IEN)) Q:IEN=""  D  Q:QUIT
 . S DATA=$G(^PRST(458.7,IEN,0))
 . Q:DATA=""
 . S START=$P(DATA,U,2),END=$P(DATA,U,3),STATUS=$P(DATA,U,6)
 . S TDAT=$P($G(^PRST(458.7,IEN,4)),U,1) ; Termination Date
 . S END=$S(TDAT:TDAT,1:END)
 . I STDAT'>START,ENDDAT'<START D OVRLAP
 . I STDAT'>END,ENDDAT'<END D OVRLAP
 ; If all checks have passed, calculate the PPs covered by the Memo
 I $G(PPE)?2N1"-"2N D CALPP
 Q
 ;
OVRLAP ; Display warning when dates cover an existing memo
 ;
 S Y=START ;       START DATE
 D DD^%DT
 S START=Y
 S Y=END ;       END DATE
 D DD^%DT
 S END=Y
 W !!,"These dates overlap the following memorandum:"
 W !,"Start Date: ",START," - "
 W $S(TDAT:"Termination Date: ",1:"End Date: "),END
 S OVERLAP=1
 Q
 ;
AHRS ; Display list of Agreed Hours
 W !!,"Agreed Hours must be equally divisible by 26 Pay Periods."
 W !!,"1/8 = 260, 1/4 = 520, 3/8 = 780, 1/2 = 1040, 5/8 = 1300, "
 W "3/4 = 1560, 7/8 = 1820",!
 S DIR(0)="NO",DIR("A")="Agreed Hours"
 D ^DIR
 ; Verify that Agreed Hours is divisible by 26.
 I Y#26 G AHRS
 S AHRS=Y
 Q
 ;
ICOM ; Prompt for Initial Comments
 W !
 S DIR(0)="FO^1:240^^O",DIR("A")="Initial Comments" D ^DIR
 S ICOM=Y
 Q
 ;
ESIG ; Prompt for Electronic Signature and store fields in #458.7
 ;
 N ESOK,HOL
 K PRSFDA,IEN4587
 D ^PRSAES
 I ESOK D
 . ; Create entry in #458.7
 . S PRSFDA(458.7,"+1,",.01)=PRSIEN ;   EMPLOYEE
 . D UPDATE^DIE("","PRSFDA","IEN4587"),MSG^DIALOG()
 . S IEN4587=IEN4587(1)_","
 . S PRSFDA(458.7,IEN4587,1)=STDAT ;  START DATE
 . S PRSFDA(458.7,IEN4587,2)=ENDDAT ; END DATE
 . S PRSFDA(458.7,IEN4587,3)=AHRS ;   AGREED HOURS
 . S PRSFDA(458.7,IEN4587,4)=ICOM ;   INITIAL COMMENTS
 . ;
 . ; Check to see if 1st pay period covered by memo is opened
 . ; 1 = NOT STARTED  2 = ACTIVE
 . S PRSFDA(458.7,IEN4587,5)=$S($D(^PRST(458,"AD",STDAT)):2,1:1)
 . S PRSFDA(458.7,IEN4587,6)=DUZ  ;   ENTERED BY
 . D NOW^%DTC
 . S PRSFDA(458.7,IEN4587,7)=% ;      DATE/TIME ENTERED
 . D FILE^DIE("","PRSFDA",),MSG^DIALOG()  ; Set fields into 0 node
 . ;
 . ; Initialize the PPs within the Memo (#458.701 multiple)
 . F I=1:1:26 D
 . . S PRSFDA(458.701,"+"_I_","_IEN4587,.01)=$P(PPESTR,U,I)
 . D UPDATE^DIE("","PRSFDA"),MSG^DIALOG()
 . ;
 . ; Allocate the security key to the PTP if they don't already hold it
 . I '$D(^XUSEC("PRSP EMP",IEN200)) D
 . . N KEYIEN
 . . S KEYIEN=$$FIND1^DIC(19.1,,"X","PRSP EMP")
 . . I 'KEYIEN D  Q
 . . . W !!,"PRSP EMP key was not found in the 19.1 file."
 . . S PRSFDA(200.051,"?+1,"_IEN200_",",.01)=KEYIEN
 . . S PRSIENS(1)=KEYIEN
 . . D UPDATE^DIE("","PRSFDA","PRSIENS"),MSG^DIALOG()
 ;
 ; Check to see if PPs covered by the memo are already opened
 Q:'$$MIEN^PRSPUT1(PRSIEN,STDAT)
 S PPI=+$G(^PRST(458,"AD",STDAT))
 Q:'PPI
 ; Loop thru pay periods in file 458
 S PPI=PPI-.001 ; init PPI so loop will include 1st PP covered by memo
 F  S PPI=$O(^PRST(458,PPI)) Q:'PPI  D
 . N PRSD
 . ; Quit if the employee doesn't have a timecard for this PP yet.
 . ; When the Timekeeper creates the timecard it will update the ESR as
 . ; needed
 . Q:'$D(^PRST(458,PPI,"E",PRSIEN,0))
 . ; Quit if timecard does not have status = Timekeeper
 . Q:$P($G(^PRST(458,PPI,"E",PRSIEN,0)),U,2)'="T"
 . ;
 . ; clear any Timecard exceptions, remarks, and posting status
 . F PRSD=1:1:14 K ^PRST(458,PPI,"E",PRSIEN,"D",PRSD,2),^(3),^(10)
 . ; Call to initialize ESR
 . D ^PRSAPPH ; Set up HOL and PDT
 . D ESRUPDT^PRSPUT3(PPI,PRSIEN)
 . ; Call to Autopost PT Phy Leave
 . D PLPP^PRSPLVA(PRSIEN,PPI)
 . ; Call to Autopost PT Phy Extended Absence
 . D PEAPP^PRSPEAA(PRSIEN,PPI)
 ;
 Q
 ;
CALPP ; Calculate the PPs covered by the memorandum
 S PPESTR=""
 S (STDATX,D1)=STDAT
 D PP^PRSAPPU
 S PPESTR=PPESTR_PPE_U
 F I=1:1:25 D
 . S X1=STDATX,X2=14
 . D C^%DTC
 . S (D1,STDATX)=X
 . D PP^PRSAPPU
 . S PPESTR=PPESTR_PPE_$S(I=25:"",1:"^")
 Q
 ;
KILL ; Clean up variables
 ;
 K AHRS,DATA,DAY,DIR,END,ENDDAT,I,ICOM,IEN,IEN200,IEN4587,OVERLAP
 K PPE,PPI,PPESTR,PRSFDA,PRSIEN,PRSIENS,QUIT,SCRTTL,START,STATUS
 K STDAT,STDATX,TDAT,X,Y,%,%DT
 Q
