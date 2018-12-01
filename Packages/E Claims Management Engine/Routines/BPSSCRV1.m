BPSSCRV1 ;AITC/PD - ECME SCREEN CHANGE VIEW continued;1/17/2018
 ;;1.0;E CLAIMS MGMT ENGINE;**23**;JUN 2004;Build 44
 ;;Per VA Directive 6402, this routine should not be modified.
 ;USER SCREEN continued
 Q
 ;****
 ;
 ; New'ing of BPS* arrays and variables handled in routine BPSSCRCV
 ; 
BPS201(BPARR) ; FIELD 2.01 - Eligibility Type
BPS201A ;
 ;
 S BPS201STR=",V,T,C,A,"
 S DIR(0)="FO^0:7"
 S DIR("A",1)=""
 S DIR("A",2)="     Select one of the following:"
 S DIR("A",3)=""
 S DIR("A",4)="          V         VETERAN"
 S DIR("A",5)="          T         TRICARE"
 S DIR("A",6)="          C         CHAMPVA"
 S DIR("A",7)="          A         ALL"
 S DIR("A",8)=""
 S DIR("A")="Select One or Many Eligibility Types or (A)ll"
 S DIR("B")="V"
 I $G(BPARR(2.01))'="" S DIR("B")=BPARR(2.01)
 S DIR("?",1)="Enter a single response or multiple responses separated by commas."
 S DIR("?",2)=" Example:"
 S DIR("?",3)="  T"
 S DIR("?")="  T,C"
 D ^DIR K DIR
 ;
 I $D(DIRUT) Q 0
 ;
 ; Loop through user input (returned in variable X).
 ; Display warning message if any user input selection is not included
 ; in the string of acceptable codes (BPS201STR) and re-prompt question.
 ; Assign valid selections to BPS201 array. This array will prevent
 ; duplicate entries from being saved to the user's profile.
 ;
 K BPS201
 S X=$TR(X,"vtca","VTCA")
 S X=$TR(X," ","")
 S BPSERR=0
 F BPSX=1:1:$L(X,",") D
 . S BPSSEL=$P(X,",",BPSX)
 . I BPS201STR'[(","_BPSSEL_",") W !," ",BPSSEL," is not a valid entry." S BPSERR=1 Q
 . S BPS201(BPSSEL)=""
 ; 
 I $G(BPSERR)=1 G BPS201A
 ; 
 ; If user included (A)ll as a selection, set profile setting to A.
 ;
 I $D(BPS201("A")) S BPARR(2.01)="A"
 E  D  ; User did not enter "A".
 . ;
 . ; At this point user selections are valid and do not include "A".
 . ; Loop through valid user selections. Set selections into a
 . ; comma delimited string before assigning to BPARR array.
 . ;
 . S BPSSEL=""
 . W !,?2,"Selected:"
 . F  S BPSSEL=$O(BPS201(BPSSEL)) Q:BPSSEL=""  D
 . . S BPS201=$G(BPS201)_BPSSEL_","
 . . I BPSSEL="C" W !,?10,"CHAMPVA"
 . . I BPSSEL="T" W !,?10,"TRICARE"
 . . I BPSSEL="V" W !,?10,"VETERAN"
 . S BPS201=$E(BPS201,1,($L(BPS201)-1))
 . S BPARR(2.01)=BPS201
 ;
 Q 1
 ;
 ; ^^^^^^^^^^ End of BPS201 Logic ^^^^^^^^^^
 ;
 ; ********** Start of BPS101 / BPS116 Logic **********
 ;
 ; User input will be temporarily stored in BPS116AR for display to user 
 ; of selected USERS while in CV Action.
 ; 
 ; If U is selected, at least one USER must be selected. If not, selection 
 ; will default to (A)ll and the current question will be re-prompted.
 ; 
 ; Upon completion of USERs entry, values will be placed into a string 
 ; delimited by semicolons. e.g. BPARR(1.16)=";12345;56789;"
 ; 
 ; BPS116AR = array containing USER information
 ; BPS116AR(BPS116)=""    BPS116 = IEN from New Person File #200
 ; BPS116AR("B",BPS116NM) BPS116NM = User Name - Index used to display 
 ; selected USERs in alphabetical order while in CV Action.
 ;
BPS101(BPARR) ; Fields 1.01 and 1.16 - User(s)
BPS101A ;
 ;
 N BPSI
 ;
 S BPINP=$$EDITFLD^BPSSCRCV(1.01,+BPDUZ7,"S^U:USER;A:ALL","Display One or Many ECME (U)sers or (A)LL","ALL",.BPARR)
 I BPINP=-1 Q 0
 ;
 S BPSERR=0
 ;
 ; If user selection is U, assign existing entry(s) into BPS116AR array.
 ;
 I $P(BPINP,U,2)="U" D
 . S BPS116=$G(BPARR(1.16))
 . I BPS116'="" D
 . . S BPSCNT=$L(BPS116,";")
 . . I BPSCNT=1 D
 . . . S BPS116NM=$$GET1^DIQ(200,BPS116,.01)
 . . . I $G(BPS116NM)'="" S BPS116AR(BPS116)="",BPS116AR("B",BPS116NM)=""
 . . I +BPSCNT>2 D
 . . . F BPSI=2:1:BPSCNT-1 D
 . . . . S BPS116X=$P(BPS116,";",BPSI),BPS116NM=$$GET1^DIQ(200,BPS116X,.01)
 . . . . I $G(BPS116NM)'="" S BPS116AR(BPS116X)="",BPS116AR("B",BPS116NM)=""
 . ;
 . ; Display existing entry(s) to user.
 . ;
 . I $D(BPS116AR) D
 . . W !,?2,"Selected:"
 . . S BPS116NM="" F  S BPS116NM=$O(BPS116AR("B",BPS116NM)) Q:BPS116NM=""  W !,?10,BPS116NM
 . ;
 . W !!,"Enter a user to select."
 . W !,"Once all users are selected, hit enter without making a selection.",!
 . ;
 . S BPS116="" F  D  Q:BPS116=-1
 . . S DIR0="P^VA(200,"
 . . S PRMTMSG="Select User"
 . . S DFLTVAL=""
 . . S BPS116=$$PROMPT^BPSSCRCV(DIR0,PRMTMSG,DFLTVAL)
 . . ;
 . . ; Exit 'Select User' loop if user entered nil.
 . . ; 
 . . I BPS116=-1 Q
 . . ; 
 . . S BPS116NM=$$GET1^DIQ(200,BPS116,.01)
 . . ;
 . . ; If entry exists in BPS116AR array, prompt user to delete from list.
 . . ; 
 . . I $D(BPS116AR(BPS116)) D
 . . . S DIR(0)="S^Y:YES;N:NO"
 . . . S DIR("A")="Delete "_BPS116NM_" from your list?"
 . . . S DIR("B")="NO"
 . . . D ^DIR
 . . . I Y="Y" K BPS116AR(BPS116),BPS116AR("B",BPS116NM)
 . . . ; 
 . . E  D
 . . . ; 
 . . . ; Set new entry into BPS116AR array.
 . . . ;
 . . . I $G(BPS116NM)'="" S BPS116AR(BPS116)="",BPS116AR("B",BPS116NM)=""
 . . ;
 . . ; Display existing entry(s) to user. 
 . . ;
 . . I $D(BPS116AR) D
 . . . W !,?2,"Selected:"
 . . . S BPS116NM="" F  S BPS116NM=$O(BPS116AR("B",BPS116NM)) Q:BPS116NM=""  W !,?10,BPS116NM
 . ;
 . ; If user selected (U)ser but has not selected any users,
 . ; set profile setting to ALL and set BPSERR flag to re-prompt question.
 .; 
 . I '$D(BPS116AR) S BPARR(1.01)="A",BPARR(1.16)="" S BPSERR=1 Q
 . ;
 . ; Loop through selected users, setting selected users into 
 . ; BPARR array - delimited by semi-colon.
 . ; 
 . S BPARR(1.16)=";"
 . S BPS116=0 F  S BPS116=$O(BPS116AR(BPS116)) Q:+BPS116=0  S BPARR(1.16)=BPARR(1.16)_BPS116_";"
 E  D  ; User selected ALL
 . S BPARR(1.01)="A"
 . S BPARR(1.16)=""
 ;
 ; If BPSERR flag is 1, re-prompt question.
 ; 
 I $G(BPSERR)=1 G BPS101A
 ;
 Q 1
 ;
 ; ^^^^^^^^^^ End of BPS101 / BPS116 Logic ^^^^^^^^^^
 ;
 ; ********** Start of BPS102 / BPS117 Logic **********
 ;
 ; User input will be temporarily stored in BPS117AR for display to user 
 ; of selected PATIENTS while in CV Action.
 ; 
 ; If P is selected, at least one PATIENT must be selected. If not, selection 
 ; will default to (A)ll and the current question will be re-prompted.
 ; 
 ; Upon completion of PATIENTs entry, values will be placed into a string 
 ; delimited by semicolons. e.g. BPARR(1.17)=";12345;56789;"
 ; 
 ; BPS117AR = array containing PATIENT information
 ; BPS117AR(BPS117)=""    BPS117 = IEN from Patient File ^DPT
 ; BPS117AR("B",BPS117M) BPS117NM = Patient Name - Index used to display 
 ; selected PATIENTs in alphabetical order while in CV Action. 
 ;
BPS102(BPARR) ; Fields 1.02 and 1.17 - Patient(s)
BPS102A ;
 ;
 N BPSI
 ;
 S BPINP=$$EDITFLD^BPSSCRCV(1.02,+BPDUZ7,"S^P:PATIENT;A:ALL","Display One or Many (P)atients or (A)LL","ALL",.BPARR)
 I BPINP=-1 Q 0
 ;
 S BPSERR=0
 ;
 ; If user selection is P, assign existing entry(s) into BPS117AR array.
 ;
 I $P(BPINP,U,2)="P" D
 . S BPS117=$G(BPARR(1.17))
 . I BPS117'="" D
 . . S BPSCNT=$L(BPS117,";")
 . . I BPSCNT=1 D
 . . . S BPS117NM=$$GET1^DIQ(2,BPS117,.01)
 . . . I $G(BPS117NM)'="" S BPS117AR(BPS117)="",BPS117AR("B",BPS117NM)=""
 . . I +BPSCNT>2 D
 . . . F BPSI=2:1:BPSCNT-1 D
 . . . . S BPS117X=$P(BPS117,";",BPSI),BPS117NM=$$GET1^DIQ(2,BPS117X,.01)
 . . . . I $G(BPS117NM)'="" S BPS117AR(BPS117X)="",BPS117AR("B",BPS117NM)=""
 . ;
 . ; Display existing entry(s) to user.
 . ; 
 . I $D(BPS117AR) D
 . . W !,?2,"Selected:"
 . . S BPS117NM="" F  S BPS117NM=$O(BPS117AR("B",BPS117NM)) Q:BPS117NM=""  W !,?10,BPS117NM
 . ;
 . W !!,"Enter a patient to select."
 . W !,"Once all patients are selected, hit enter without making a selection.",!
 . ;
 . S BPS117="" F  D  Q:BPS117=-1
 . . S DIR0="P^DPT("
 . . S PRMTMSG="Select Patient"
 . . S DFLTVAL=""
 . . S BPS117=$$PROMPT^BPSSCRCV(DIR0,PRMTMSG,DFLTVAL)
 . . ;
 . . ; Exit 'Select Patient' loop if user entered nil.
 . . ; 
 . . I BPS117=-1 Q
 . . ; 
 . . S BPS117NM=$$GET1^DIQ(2,BPS117,.01)
 . . ;
 . . ; If entry exists in BPS117AR array, prompt user to delete from list.
 . . ; 
 . . I $D(BPS117AR(BPS117)) D
 . . . S DIR(0)="S^Y:YES;N:NO"
 . . . S DIR("A")="Delete "_BPS117NM_" from your list?"
 . . . S DIR("B")="NO"
 . . . D ^DIR
 . . . I Y="Y" K BPS117AR(BPS117),BPS117AR("B",BPS117NM)
 . . . ; 
 . . E  D
 . . . ; 
 . . . ; Set new entry into BPS117AR array.
 . . . ; 
 . . . I $G(BPS117NM)'="" S BPS117AR(BPS117)="",BPS117AR("B",BPS117NM)=""
 . . ;
 . . ; Display existing entry(s) to user.
 . . ; 
 . . I $D(BPS117AR) D
 . . . W !,?2,"Selected:"
 . . . S BPS117NM="" F  S BPS117NM=$O(BPS117AR("B",BPS117NM)) Q:BPS117NM=""  W !,?10,BPS117NM
 . ;
 . ; If user selected (P)atient but has not selected any patients,
 . ; set profile setting to ALL and re-prompt question.
 . ; 
 . I '$D(BPS117AR) S BPARR(1.02)="A",BPARR(1.17)="" S BPSERR=1 Q
 . ;
 . ; Loop through selected patients, setting selected patients into
 . ; BPARR array - delimited by semi-colon.
 . ;
 . S BPARR(1.17)=";"
 . S BPS117=0 F  S BPS117=$O(BPS117AR(BPS117)) Q:+BPS117=0  S BPARR(1.17)=BPARR(1.17)_BPS117_";"
 E  D  ; User selected ALL
 . S BPARR(1.02)="A"
 . S BPARR(1.17)=""
 ;
 ; If BPSERR flag is 1, re-prompt question.
 ; 
 I $G(BPSERR)=1 G BPS102A
 ;
 Q 1
 ;
 ; ^^^^^^^^^^ End of BPS102 / BPS117 Logic ^^^^^^^^^^
 ;
 ; ********** Start of BPS103 / BPS118 Logic **********
 ;
 ; User input will be temporarily stored in BPS118AR for display to user 
 ; of selected RXs while in CV Action.
 ; 
 ; If R is selected, at least one RX must be selected. If not, selection 
 ; will default to (A)ll and the current question will be re-prompted.
 ; 
 ; Upon completion of RXs entry, values will be placed into a string 
 ; delimited by semicolons. e.g. BPARR(1.18)=";12345;56789;"
 ; 
 ; BPS118AR = array containing RX information
 ; BPS118AR(BPS118)=""  BPS118 = IEN from Prescription File #52
 ; BPS118AR("B",BPSRXN) BPSRXN = RX Number - Index used to display 
 ; selected RXs in numerical order while in CV Action.
 ;   
BPS103(BPARR) ; Fields 1.03 and 1.18 - Rx(s)
BPS103A ;
 ;
 N BPSI
 ;
 S BPINP=$$EDITFLD^BPSSCRCV(1.03,+BPDUZ7,"S^R:RX;A:ALL","Display One or Many (R)x or (A)LL","ALL",.BPARR)
 I BPINP=-1 Q 0
 ;
 S BPSERR=0
 ; 
 ; If user selection is R, assign existing entry(s) into BPS118AR array.
 ;
 I $P(BPINP,U,2)="R" D
 . S BPS118=$G(BPARR(1.18))
 . I BPS118'="" D
 . . S BPSCNT=$L(BPS118,";")
 . . I BPSCNT=1 D
 . . . S DIC=52
 . . . S DR=".01;6"
 . . . S DA=BPS118
 . . . S DIQ="BPSRXD"
 . . . S DIQ(0)="E"
 . . . D DIQ^PSODI(52,DIC,DR,DA,.DIQ)   ; ICR 4858
 . . . ; 
 . . . S BPSRXN=$G(BPSRXD(52,DA,.01,"E"))
 . . . S BPSDRUG=$G(BPSRXD(52,DA,6,"E"))
 . . . ; 
 . . . S BPS118AR(BPS118)="",BPS118AR("B",BPSRXN)=BPSDRUG
 . . . ; 
 . . I +BPSCNT>2 D
 . . . F BPSI=2:1:BPSCNT-1 D
 . . . . S BPS118X=$P(BPS118,";",BPSI)
 . . . . S DIC=52
 . . . . S DR=".01;6"
 . . . . S DA=BPS118X
 . . . . S DIQ="BPSRXD"
 . . . . S DIQ(0)="E"
 . . . . D DIQ^PSODI(52,DIC,DR,DA,.DIQ)   ; ICR 4858
 . . . . ;
 . . . . S BPSRXN=$G(BPSRXD(52,DA,.01,"E"))
 . . . . S BPSDRUG=$G(BPSRXD(52,DA,6,"E"))
 . . . . ; 
 . . . . S BPS118AR(BPS118X)="",BPS118AR("B",BPSRXN)=BPSDRUG
 . ;
 . ; Display existing entry(s) to user.
 . ; 
 . I $D(BPS118AR) D
 . . W !,?2,"Selected:"
 . . S BPSRXN="" F  S BPSRXN=$O(BPS118AR("B",BPSRXN)) Q:BPSRXN=""  W !,?10,BPSRXN,?30,BPS118AR("B",BPSRXN)
 . ;
 . W !!,"Enter a prescription to select."
 . W !,"Once all prescriptions are selected, hit enter without making a selection.",!
 . ;
 . S BPS118="" F  D  Q:BPS118=-1
 . . S PRMTMSG="Select RX"
 . . S DFLTVAL=""
 . . S BPS118=$$PROMPTRX^BPSUTIL1(PRMTMSG,DFLTVAL)
 . . ; 
 . . ; Exit 'Select RX' loop if user entered nil.
 . . ;
 . . I BPS118=-1 Q
 . . ;
 . . S DIC=52
 . . S DR=".01;6"
 . . S DA=BPS118
 . . S DIQ="BPSRXD"
 . . S DIQ(0)="E"
 . . D DIQ^PSODI(52,DIC,DR,DA,.DIQ)   ; ICR 4858
 . . ; 
 . . S BPSRXN=$G(BPSRXD(52,DA,.01,"E"))
 . . S BPSDRUG=$G(BPSRXD(52,DA,6,"E"))
 . .
 . . ; 
 . . ; If entry exists in BPS118AR array, prompt user to delete from list.
 . . ; 
 . . I $D(BPS118AR(BPS118)) D
 . . . S DIR(0)="S^Y:YES;N:NO"
 . . . S DIR("A")="Delete "_BPSRXN_" from your list?"
 . . . S DIR("B")="NO"
 . . . D ^DIR
 . . . I Y="Y" K BPS118AR(BPS118),BPS118AR("B",BPSRXN)
 . . . ; 
 . . E  D
 . . . ; Set new entry into BPS118AR array.
 . . . ; 
 . . . S BPS118AR(BPS118)="",BPS118AR("B",BPSRXN)=BPSDRUG
 . . ;
 . . ; Display existing entry(s) to user.
 . . ;
 . . I $D(BPS118AR) D
 . . . W !,?2,"Selected:"
 . . . S BPSRXN="" F  S BPSRXN=$O(BPS118AR("B",BPSRXN)) Q:BPSRXN=""  W !,?10,BPSRXN,?30,BPS118AR("B",BPSRXN)
 . ;
 . ; If user selected (R)x but has not selected any RXs,
 . ; set profile setting to ALL and set BPSERR flag to re-prompt question.
 . ; 
 . I '$D(BPS118AR) S BPARR(1.03)="A",BPARR(1.18)="" S BPSERR=1 Q
 . ;
 . ; Loop through selected RXs, setting selected RXs into
 . ; BPARR array - delimited by semi-colon.
 . ; 
 . S BPARR(1.18)=";"
 . S BPS118=0 F  S BPS118=$O(BPS118AR(BPS118)) Q:+BPS118=0  S BPARR(1.18)=BPARR(1.18)_BPS118_";"
 E  D  ; User selected ALL
 . S BPARR(1.03)="A"
 . S BPARR(1.18)=""
 ;
 ; If BPSERR flag is 1, re-prompt question.
 ;
 I $G(BPSERR)=1 G BPS103A
 ;
 Q 1
 ;
 ; ^^^^^^^^^^ End of BPS103 / BPS118 Logic ^^^^^^^^^^
 ;
 Q
