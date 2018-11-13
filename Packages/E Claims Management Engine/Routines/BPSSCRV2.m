BPSSCRV2 ;AITC/PD - ECME SCREEN CHANGE VIEW continued;1/17/2018
 ;;1.0;E CLAIMS MGMT ENGINE;**23**;JUN 2004;Build 44
 ;;Per VA Directive 6402, this routine should not be modified.
 ;USER SCREEN continued
 Q
 ;****
 ;
 ; New'ing of BPS* arrays and variables handled in routine BPSSCRCV
 ;
BPS106(BPARR) ; FIELD 1.06 - Rejects / Payables / Unstranded / All
BPS106A ;
 ; 
 S BPS106STR=",R,P,U,A,"
 S DIR(0)="FO^0:7"
 S DIR("A",1)=""
 S DIR("A",2)="     Select one of the following:"
 S DIR("A",3)=""
 S DIR("A",4)="          R         REJECTS"
 S DIR("A",5)="          P         PAYABLES"
 S DIR("A",6)="          U         UNSTRANDED"
 S DIR("A",7)="          A         ALL"
 S DIR("A",8)=""
 S DIR("A")="Display (R)ejects or (P)ayables or (U)nstranded or (A)ll"
 S DIR("B")="A"
 I $G(BPARR(1.06))'="" S DIR("B")=BPARR(1.06)
 S DIR("?",1)="Enter a single response or multiple responses separated by commas."
 S DIR("?",2)=" Example:"
 S DIR("?",3)="  P"
 S DIR("?")="  P,R"
 D ^DIR K DIR
 ;
 I $D(DIRUT) Q 0
 ;
 ; Loop through user input (returned in variable X).
 ; Display warning message if any user input selection is not included
 ; in the string of acceptable codes (BPS106STR) and re-prompt question.
 ; Assign valid selections to BPS106 array. This array will prevent
 ; duplicate entries from being saved to the user's profile.
 ;
 K BPS106
 S BPSERR=0
 S X=$TR(X,"rpua","RPUA")
 S X=$TR(X," ","")
 F BPSX=1:1:$L(X,",") D
 . S BPSSEL=$P(X,",",BPSX)
 . I BPS106STR'[(","_BPSSEL_",") W !," ",BPSSEL," is not a valid entry." S BPSERR=1 Q
 . S BPS106(BPSSEL)=""
 ;
 I $G(BPSERR)=1 G BPS106A
 ;
 ; If user included (A)ll as a selection, set profile setting to A.
 ;
 I $D(BPS106("A")) S BPARR(1.06)="A"
 E  D  ; User did not enter "A"
 . ; 
 . ; At this point user selections are valid and do not include "A".
 . ; Loop through valid user selections. Set selections into a
 . ; comma delimited string before assigning to BPARR array.
 . ; 
 . S BPSSEL=""
 . W !,?2,"Selected:"
 . F  S BPSSEL=$O(BPS106(BPSSEL)) Q:BPSSEL=""  D
 . . S BPS106=$G(BPS106)_BPSSEL_","
 . . I BPSSEL="P" W !,?10,"PAYABLES"
 . . I BPSSEL="U" W !,?10,"UNSTRANDED"
 . . I BPSSEL="R" W !,?10,"REJECTS"
 . S BPS106=$E(BPS106,1,($L(BPS106)-1))
 . S BPARR(1.06)=BPS106
 ;
 Q 1
 ;
 ; ^^^^^^^^^^ End of BPS106 Logic ^^^^^^^^^^
 ;
 ; ********** Start of BPS108 Logic **********
 ;
 ; BPS108STR = string of valid codes
 ; 
 ; Upon completion of prompt, values will be placed into a string delimited
 ; by commas. e.g. C,M
 ; 
 ; If user includes (A)ll as a code, only A will be stored in BPARR
 ; array. e.g. Entry of C,M,A will save as BPARR(1.08)="A"
 ; 
 ; User input values are temporary stored in array BPS108 to eliminate duplicate 
 ; entries. e.g. Entry of C,M,C will save as BPARR(1.08)="C,M"
 ;   
BPS108(BPARR) ; FIELD 1.08 - CMOP / Mail / Window / All
BPS108A ;
 ; 
 S BPS108STR=",C,M,W,A,"
 S DIR(0)="FO^0:7"
 S DIR("A",1)=""
 S DIR("A",2)="     Select one of the following:"
 S DIR("A",3)=""
 S DIR("A",4)="          C         CMOP"
 S DIR("A",5)="          M         MAIL"
 S DIR("A",6)="          W         WINDOW"
 S DIR("A",7)="          A         ALL"
 S DIR("A",8)=""
 S DIR("A")="Display (C)MOP or (M)ail or (W)indow or (A)ll"
 S DIR("B")="A" S:$G(BPARR(1.08))'="" DIR("B")=BPARR(1.08)
 S DIR("?",1)="Enter a single response or multiple responses separated by commas."
 S DIR("?",2)=" Example:"
 S DIR("?",3)="  C"
 S DIR("?")="  C,M"
 D ^DIR K DIR
 ;
 I $D(DIRUT) Q 0
 ;
 ; Loop through user input (returned in variable X).
 ; Display warning message if any user input selection is not included
 ; in the string of acceptable codes (BPS108STR) and re-prompt question.
 ; Assign valid selections to BPS108 array. This array will prevent
 ; duplicate entries from being saved to the user's profile.
 ;
 K BPS108
 S BPSERR=""
 S X=$TR(X,"cmwa","CMWA")
 S X=$TR(X," ","")
 F BPSX=1:1:$L(X,",") D
 . S BPSSEL=$P(X,",",BPSX)
 . I BPS108STR'[(","_BPSSEL_",") W !," ",BPSSEL," is not a valid entry." S BPSERR=1 Q
 . S BPS108(BPSSEL)=""
 ;
 I $G(BPSERR)=1 G BPS108A
 ;
 ; If user included (A)ll as a seleection, set profile setting to A.
 ;
 I $D(BPS108("A")) S BPARR(1.08)="A"
 E  D  ; User did not enter "A".
 . ;
 . ; At this point user selections are valid and do not include "A".
 . ; Loop through valid user selections. Set selections into a
 . ; comma delimited string before assigning to BPARR array.
 . ;
 . S BPSSEL=""
 . W !,?2,"Selected:"
 . F  S BPSSEL=$O(BPS108(BPSSEL)) Q:BPSSEL=""  D
 . . S BPS108=$G(BPS108)_BPSSEL_","
 . . I BPSSEL="C" W !,?10,"CMOP"
 . . I BPSSEL="M" W !,?10,"MAIL"
 . . I BPSSEL="W" W !,?10,"WINDOW"
 . S BPS108=$E(BPS108,1,($L(BPS108)-1))
 . S BPARR(1.08)=BPS108
 ;
 Q 1
 ;
 ; ^^^^^^^^^^ End of BPS108 Logic ^^^^^^^^^^
 ;
 ; ********** Start of BPS109 Logic **********
 ;
 ; BPS109STR = string of valid codes
 ;
 ; Upon completion of prompt, values will be placed into a string delimited
 ; by commas. e.g. P,R
 ;
 ; If user includes (A)ll as a code, only A will be stored in BPARR
 ; array. e.g. Entry of R,P,A will save as BPARR(1.09)="A"'
 ;
 ; User input values are temporary stored in array BPS106 to eliminate duplicate 
 ; entries. e.g. Entry of R,P,R will save as BPARR(1.09)="P,R"
 ;  
BPS109(BPARR) ; FIELD 1.09 - Realtime / Backbills / Pro Option / Resubmission / All
BPS109A ;
 ;
 S BPS109STR=",R,B,P,S,A,"
 S DIR(0)="FO^0:7"
 S DIR("A",1)=""
 S DIR("A",2)="     Select one of the following:"
 S DIR("A",3)=""
 S DIR("A",4)="          R         REALTIME"
 S DIR("A",5)="          B         BACKBILLS"
 S DIR("A",6)="          P         PRO OPTION"
 S DIR("A",7)="          S         RESUBMISSION"
 S DIR("A",8)="          A         ALL"
 S DIR("A",9)=""
 S DIR("A")="Display (R)ealTime, (B)ackbills, (P)RO Option, Re(S)ubmission or (A)ll"
 S DIR("B")="A"
 I $G(BPARR(1.09))'="" S DIR("B")=BPARR(1.09)
 S DIR("?",1)="Enter a single response or multiple responses separated by commas."
 S DIR("?",2)=" Example:"
 S DIR("?",3)="  B"
 S DIR("?")="  B,P"
 D ^DIR K DIR
 ;
 I $D(DIRUT) Q 0
 ;
 ; Loop through user input (returned in variable X).
 ; Display warning message if any user input selection is not included
 ; in the string of acceptable codes (BPS109STR) and re-prompt question.
 ; Assign valid selections to BPS109 array. This array will prevent
 ; duplicate entries from being saved to the user's profile.
 ;
 K BPS109
 S X=$TR(X,"rbpsa","RBPSA")
 S X=$TR(X," ","")
 S BPSERR=""
 F BPSX=1:1:$L(X,",") D
 . S BPSSEL=$P(X,",",BPSX)
 . I BPS109STR'[(","_BPSSEL_",") W !," ",BPSSEL," is not a valid entry." S BPSERR=1 Q
 . S BPS109(BPSSEL)=""
 ;
 I $G(BPSERR)=1 G BPS109A
 ;
 ; If user included (A)ll as a selection, set profile setting to A.
 ;
 I $D(BPS109("A")) S BPARR(1.09)="A"
 E  D  ; User did not enter "A".
 . ;
 . ; At this point user selections are valid and do not include "A".
 . ; Loop through valid user selections. Set selections into a
 . ; comma delimited string before assigning to BPARR array.
 . ;
 . S BPSSEL=""
 . W !,?2,"Selected:"
 . F  S BPSSEL=$O(BPS109(BPSSEL)) Q:BPSSEL=""  D
 . . S BPS109=$G(BPS109)_BPSSEL_","
 . . I BPSSEL="B" W !,?10,"BACKBILLS"
 . . I BPSSEL="P" W !,?10,"PRO OPTION"
 . . I BPSSEL="R" W !,?10,"REALTIME"
 . . I BPSSEL="S" W !,?10,"RESUBMISSION"
 . S BPS109=$E(BPS109,1,($L(BPS109)-1))
 . S BPARR(1.09)=BPS109
 ;
 Q 1
 ;
 ; ^^^^^^^^^^ End of BPS109 Logic ^^^^^^^^^^
 ;
 ; ********** Start of BPS110 / BPS115 Logic **********
 ;
 ; User input will be temporarily stored in BPS115AR for display to user 
 ; of selected REJECT CODES while in CV Action.
 ; 
 ; If R is selected, at least one REJECT CODE must be selected. If not, selection 
 ; will default to (A)ll and the current question will be re-prompted.
 ; 
 ; Upon completion of REJECT CODEs entry, values will be placed into a string 
 ; delimited by semicolons. e.g. BPARR(1.15)=";50;60;"
 ; 
 ; BPS115AR = array containing REJECT CODE information
 ; BPS115AR(BPS115)=BPS115NM    BPS115 = IEN from File #9002313.93
 ;                              BPS115NM = Reject Code Explanation 
 ; 
BPS110(BPARR) ; Fields 1.10 and 1.15 - Reject Code(s)
BPS110A ;
 ;
 N BPSI
 ;
 S BPINP=$$EDITFLD^BPSSCRCV(1.1,+BPDUZ7,"S^R:REJECT CODE;A:ALL","Display Specific (R)eject Code or (A)LL","ALL",.BPARR)
 I BPINP=-1 Q 0
 ;
 S BPSERR=0
 ; 
 ; If user selection is R, assign existing entry(s) into BPS115AR array.
 ;
 I $P(BPINP,U,2)="R" D
 . S BPS115=$G(BPARR(1.15))
 . I BPS115'="" D
 . . S BPSCNT=$L(BPS115,";")
 . . I BPSCNT=1 D
 . . . S BPS115CD=$$GET1^DIQ(9002313.93,BPS115,.01)
 . . . S BPS115NM=$$GET1^DIQ(9002313.93,BPS115,.02)
 . . . S BPS115AR(BPS115)=BPS115CD_"^"_BPS115NM
 . . I +BPSCNT>2 D
 . . . F BPSI=2:1:BPSCNT-1 D
 . . . . S BPS115X=$P(BPS115,";",BPSI)
 . . . . S BPS115CD=$$GET1^DIQ(9002313.93,BPS115X,.01)
 . . . . S BPS115NM=$$GET1^DIQ(9002313.93,BPS115X,.02)
 . . . . S BPS115AR(BPS115X)=BPS115CD_"^"_BPS115NM
 . ;
 . ; Display existing entry(s) to user.
 . ; 
 . I $D(BPS115AR) D
 . . W !,?2,"Selected:"
 . . S BPS115="" F  S BPS115=$O(BPS115AR(BPS115)) Q:BPS115=""  D
 . . . W !,?10,$P(BPS115AR(BPS115),"^")
 . . . W ?20,$P(BPS115AR(BPS115),"^",2)
 . ;
 . S BPS115="" F  D  Q:BPS115=-1
 . . S DIR0="P^BPSF(9002313.93,"
 . . S PRMTMSG="Select Reject Code"
 . . S DFLTVAL=""
 . . S BPS115=$$PROMPT^BPSSCRCV(DIR0,PRMTMSG,DFLTVAL)
 . . ; 
 . . ; Exit 'Select Reject Code' loop if user entered nil.
 . . ; 
 . . I BPS115=-1 Q
 . . ;
 . . S BPS115CD=$$GET1^DIQ(9002313.93,BPS115,.01)
 . . S BPS115NM=$$GET1^DIQ(9002313.93,BPS115,.02)
 . . 
 . . ;
 . . ; If entry exists in BPS115AR array, prompt user to delete from list.
 . . ; 
 . . I $D(BPS115AR(BPS115)) D
 . . . S DIR(0)="S^Y:YES;N:NO"
 . . . S DIR("A")="Delete "_$P(BPS115AR(BPS115),"^")_" from your list?"
 . . . S DIR("B")="NO"
 . . . D ^DIR
 . . . I Y="Y" K BPS115AR(BPS115)
 . . . ; 
 . . E  D
 . . . ; 
 . . . ; Set new entry intp BPS115AR array.
 . . . ; 
 . . . S BPS115AR(BPS115)=BPS115CD_"^"_BPS115NM
 . . ;
 . . ; Display existing entry(s) to user.
 . . ; 
 . . I $D(BPS115AR) D
 . . . W !,?2,"Selected:"
 . . . S BPS115="" F  S BPS115=$O(BPS115AR(BPS115)) Q:BPS115=""  D
 . . . . W !,?10,$P(BPS115AR(BPS115),"^")
 . . . . W ?20,$P(BPS115AR(BPS115),"^",2)
 . ;
 . ; If user selected (R)eject but has not selected any Reject Codes,
 . ; set profile setting to ALL and set BPSERR flag to re-prompt question.
 . ;
 . I '$D(BPS115AR) S BPARR(1.1)="A",BPARR(1.15)="" S BPSERR=1 Q
 . ;
 . ; Loop through selected reject codes, setting selected reject codes into
 . ; BPARR array - delimited by semi-colon. 
 . ; 
 . S BPARR(1.15)=";"
 . S BPS115=0 F  S BPS115=$O(BPS115AR(BPS115)) Q:+BPS115=0  S BPARR(1.15)=BPARR(1.15)_BPS115_";"
 E  D  ; User selected ALL
 . S BPARR(1.1)="A"
 . S BPARR(1.15)=""
 ; 
 ; If BPSERR flag is 1, re-prompt question.
 ; 
 I $G(BPSERR)=1 G BPS110A
 ;
 Q 1
 ;
 ; ^^^^^^^^^^ End of BPS110 / BPS115 Logic ^^^^^^^^^^
 ;
 Q
