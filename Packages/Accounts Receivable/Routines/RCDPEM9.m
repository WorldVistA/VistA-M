RCDPEM9 ;OIFO-BAYPINES/PJH - PAYER SELECTION ;10/18/11 6:17pm
 ;;4.5;Accounts Receivable;**276,284,318,326**;Mar 20, 1995;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; PRCA*4.5*318 - Added parameters MIXED and BLANKLN
 ; PRCA*4.5*326 - Extensive rewrite to include selection/sort by payer TIN in the Auto Post Report
GETPAY(FILE,MIXED,BLANKLN,NMORTIN,SHOWTIN) ; Let user select payer for filter
 ; Input:   FILE    - File to retrieve Payers from either #344.4 OR ##344.31
 ;          MIXED   - 1 to display prompts in mixed case
 ;                    Optional, defaults to 0
 ;          BLANKLN - 0 skip initial blank line
 ;                    Optional, defaults to 1
 ;          NMORTIN - 1 to look-up Payer by Payer Name, 2 to look-up by TIN
 ;                    0 or undefined - pre-326 behavior, look-up by payer name and don't include TIN in output array.
 ;                    Optional, defaults to 0
 ;          SHOWTIN - 1 to append the Payer Name or Payer TIN when displaying payers
 ;                    Optional, defaults to 0
 ; Output:  ^TMP("RCSELPAY",$J) - Array of selected Payers
 ; Returns: A1^A2^A3 Where:
 ;           A1 - -1 - None selected
 ;                 1 - Range of payers
 ;                 2 - All payers selected
 ;                 3 - Specific payers
 ;           A2 - From Range (When a from/thru range is selected by user)
 ;           A3 - Thru Range (When a from/thru range is selected by user)
 N CNT,DIR,DIROUT,DIRUT,DTOUT,DUOUT,I,IEN,INDX
 N RCANS,RCANS2,RCINC,RCINSF,RCINST,RCPAY,RNG1,RNG2,RTNFLG,TIN,X,XX,Y
 S:'$D(MIXED) MIXED=0   ; PRCA*4.5*318 - Added logic for MIXED and BLANKLN
 S:'$D(BLANKLN) BLANKLN=1
 S:'$D(NMORTIN) NMORTIN=0
 S:'$D(SHOWTIN) SHOWTIN=0
 ;
 S RTNFLG=0,INDX=1,RNG1="",RNG2=""
 K ^TMP("RCSELPAY",$J)                      ; Clear list of selected Payers
 ;
 ; Select option required (All, Selected or Range)
 I NMORTIN=2 D
 . S DIR(0)="SA^A:ALL;S:SPECIFIC"
 . S:MIXED DIR("A")="Run Report for (A)LL or (S)PECIFIC Insurance Companies?: "
 . S:'MIXED DIR("A")="RUN REPORT FOR (A)LL OR (S)PECIFIC INSURANCE COMPANIES?: "
 E  D
 . S DIR(0)="SA^A:ALL;S:SPECIFIC;R:RANGE"
 . S:MIXED DIR("A")="Run Report for (A)LL, (S)PECIFIC, or (R)ANGE of Insurance Companies?: "
 . S:'MIXED DIR("A")="RUN REPORT FOR (A)LL, (S)PECIFIC, OR (R)ANGE OF INSURANCE COMPANIES?: "
 . S DIR("?",2)="Enter 'RANGE' to select an Insurance Company range."
 S DIR("B")="ALL"
 S DIR("?",1)="Enter 'ALL' to select all Insurance Companies."
 S DIR("?")="Enter 'SPECIFIC' to select specific Insurance Companies."
 W:BLANKLN !         ; PRCA*4.5*318 - Added condition for BLANKLN
 D ^DIR K DIR
 ;
 ; Abort on ^ exit or timeout
 I $D(DTOUT)!$D(DUOUT) S RTNFLG=-1 Q RTNFLG
 ;
 ; ALL payers 
 ; Switch to use new Payer Name/Payer TIN index
 I Y="A" D
 . S CNT=0,RCPAY="",RTNFLG=2
 . F  S RCPAY=$O(^RCY(FILE,"C",RCPAY)) Q:RCPAY=""  D
 . . S CNT=CNT+1,IEN=$O(^RCY(FILE,"C",RCPAY,""))
 . . S TIN=$$GET1^DIQ(FILE,IEN,.03,"E")
 . . S XX=$S(NMORTIN=2:TIN_"/"_RCPAY,NMORTIN=1:RCPAY_"/"_TIN,1:RCPAY)
 . . S ^TMP("RCSELPAY",$J,CNT)=XX
 ;
 ; Selected Payers
 I Y="S" D
 . D GLIST(FILE,NMORTIN),GETPAYS(CNT,MIXED,NMORTIN)  ; PRCA*4.5*318 - Added parameter MIXED
 ;
 ; Range of Payers
 I Y="R" D
 . D GLIST(FILE,NMORTIN),GETPAYR(MIXED,BLANKLN)  ; PRCA*4.5*318 - Added parameters MIXED and BLANKLN
 ;
 K:RTNFLG'=2 ^TMP("RCPAYER",$J)             ; Clear list of all payers
 K:RTNFLG=-1 ^TMP("RCSELPAY",$J)            ; Aborting, clear any selected payers
 ;
 ; PRCA*4.5*284 - Update return value to include from/thru range. See above for documentation
 Q RTNFLG_"^"_RNG1_"^"_RNG2                 ; Return value
 ;
GLIST(FILE,NMORTIN) ; Build list for this file
 ; Input:   FILE    - File to retrieve Payers from either #344.4 OR ##344.31
 ;          NMORTIN - 2 - lookup by TIN, 1 - lookup by Payer Name, 0 - pre 326 behavior
 ; Output:  ^TMP("RCPAYER",$J,A1)=A2 Where:
 ;                    A1 - Counter
 ;                    A2 - Payer Name/TIN if NMORTIN=1, TIN/Payer Name if NMORTIN=2, else Payer Name 
 ;          ^TMP("RCPAYER",$J,"B",B1,B2)=B3 Where:
 ;                    B1 - Payer TIN if NMORTIN=2, else Payer Name
 ;                    B2 - Counter
 ;                    B3 - Payer Name if NMORTIN=0 or 1, else Payer TIN
 N IEN,PAYNAM,TIN
 K ^TMP("RCPAYER",$J)                       ; Clear workfile
 I NMORTIN=2 D  Q                           ; Build list of Payers by TIN
 . S CNT=0,TIN=""
 . F  S TIN=$O(^RCY(FILE,"ATP",TIN)) Q:TIN=""  D
 . . S PAYNAM=""
 . . F  S PAYNAM=$O(^RCY(FILE,"ATP",TIN,PAYNAM)) Q:PAYNAM=""  D
 . . . S CNT=CNT+1
 . . . S ^TMP("RCPAYER",$J,CNT)=TIN_"/"_PAYNAM
 . . . S ^TMP("RCPAYER",$J,"B",TIN,CNT)=PAYNAM
 ;
 S CNT=0,PAYNAM=""
 F  S PAYNAM=$O(^RCY(FILE,"APT",PAYNAM)) Q:PAYNAM=""  D
 . S TIN=""
 . F  S TIN=$O(^RCY(FILE,"APT",PAYNAM,TIN)) Q:TIN=""  D
 . . S CNT=CNT+1
 . . S ^TMP("RCPAYER",$J,CNT)=$S(NMORTIN=1:PAYNAM_"/"_TIN,1:PAYNAM)
 . . S ^TMP("RCPAYER",$J,"B",PAYNAM,CNT)=TIN
 Q
 ;
 ; PRCA*4.5*318 - Added parameter & logic for MIXED
GETPAYS(CNT,MIXED,NMORTIN) ; Select Specific payer for filter
 ; Input:   CNT     - Number of Payers
 ;          MIXED   - 1 to display prompts in mixed case
 ;                    Optional, defaults to 0
 ;          NMORTIN - 2 to lookup by TIN, 1 to lookup by Payer, 0 - Pre 326 behavior
 ;                    Optional, defaults to 0
 ; Output: RTNFLG -1 - No Payer selected
 ;                 3 - At least one Payer selected
 S:'$D(MIXED) MIXED=0
 S:'$D(NMORTIN) NMORTIN=0
 K ^TMP("RCDPEM9",$J)
 F  Q:RTNFLG'=0  D
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 . S DIR("A")="SELECT INSURANCE COMPANY"
 . S:MIXED DIR("A")="Select Insurance Company "_$S(NMORTIN=2:"TIN",1:"NAME")   ; PRCA*4.5*318
 . S DIR(0)="FO^1:30"
 . S DIR("?")="ENTER THE "_$S(NMORTIN=2:"TIN",1:"NAME")_" OF THE PAYER OR '??' TO LIST PAYERS"
 . ; PRCA*4.5*318 - Added MIXED
 . S:MIXED DIR("?")="Enter the "_$S(NMORTIN=2:"TIN",1:"name")_" of the payer or '??' to list payers"
 . S DIR("??")="^D LIST^RCDPEM9(CNT)"
 . D ^DIR K DIR
 . ;
 . ; User pressed ENTER
 . I Y="",'$D(DTOUT) S RTNFLG=$S($D(^TMP("RCSELPAY",$J)):3,1:-1) Q
 . ;
 . ; First check for exits
 . I $D(DUOUT)!$D(DTOUT)!$D(DIRUT)!$D(DIROUT) S RTNFLG=-1 Q
 . S (RCANS,RCANS2)="",RCANS=Y
 . I NMORTIN=2 D  Q                               ; TIN lookup
 . . I '$D(^TMP("RCPAYER",$J,"B",RCANS)) D  Q
 . . . W "  ??"
 . . I $D(^TMP("RCDPEM9",$J,RCANS)) D  Q
 . . . W:'MIXED "  ?? PAYER ALREADY SELECTED"
 . . . W:MIXED "  ?? Payer already selected"
 . . D SELTIN(RCANS,.INDX)
 . ;
 . ; Check for Partial Match on user input
 . I '(RCANS?.N) D   Q:'$G(RCANS2)
 . . S RCANS2=$O(^TMP("RCPAYER",$J,"B",RCANS,RCANS2))
 . . D:'RCANS2 PART(NMORTIN,RCANS,.INDX)
 . S:$G(RCANS2) RCANS=RCANS2
 . I RCANS="" W "  ??" Q
 . I RCANS?.N,((+RCANS<1)!(+RCANS>CNT)) W "  ??" Q
 . I RCANS'?.N W "  ??" Q
 . I $D(^TMP("RCDPEM9",$J,RCANS)) D  Q
 . . W:'MIXED "  ?? PAYER ALREADY SELECTED"
 . . W:MIXED "  ?? Payer already selected"
 . S ^TMP("RCDPEM9",$J,RCANS)=""
 . W "  ",^TMP("RCPAYER",$J,RCANS)
 . S ^TMP("RCSELPAY",$J,INDX)=$G(^TMP("RCPAYER",$J,RCANS))
 . S INDX=INDX+1
 K ^TMP("RCDPEM9",$J)
 Q
 ;
SELTIN(TIN,INDX) ; Show all the payers with the selected TIN and ask the user
 ; if they want to select the TIN
 ; Input:   TIN                     - User Selected TIN
 ;          INDX                    - Current # of selected Payers
 ;          ^TMP("RCPAYER",$J,"B")  - Array of TINs on file
 ;          ^TMP("RCSELPAY",$J,A1)= A2/A3  Current Selected Payers Where:
 ;                            A1 - Counter
 ;                            A2 - Selected TIN
 ;                            A3 - Selected PAYER
 ; Output:  INDX                    - Updated # of selected Payers                     
 ;          ^TMP("RCSELPAY",$J,A1)= A2/A3  Updated Selected Payers Where:
 ;                            A1 - Counter
 ;                            A2 - Selected TIN
 ;                            A3 - Selected PAYER
 N CTR,DIR,DIROUT,DIRUT,DTOUT,DUOUT,SELPAY,X,Y
 W !,"The following Payers with TIN ",TIN," have ERAs on file"
 D PART(2,TIN,INDX,.SELPAY)
 S DIR(0)="Y"
 S DIR("A")="Select this TIN"
 S DIR("B")="YES"
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT)
 Q:Y=0
 M ^TMP("RCSELPAY",$J)=SELPAY("RCSELPAY")
 S INDX=$O(SELPAY("RCSELPAY",""),-1)+1
 Q
 ;
LIST(CNT) ; Display all the Payers
 ; Prompt users for stations to be used for filtering
 ; Input:   CNT - Total # of Payers in tmp file
 ;          ^TMP("RCPAYER",$J,A1)=A2 Where:
 ;                    A1 - Counter
 ;                    A2 - Payer Name/TIN if NMORTIN=1, TIN/Payer Name if NMORTIN=2, else Payer Name
 N I
 F I=1:1:CNT D
 . W !,I,".",?5,$G(^TMP("RCPAYER",$J,I))
 Q
 ;
PART(NMORTIN,RCANS,INDX,SELPAY) ; Give the user a list of partial matches
 ; Input:   NMORTIN - 2 - Lookup by Payer TIN, 0 or 1 - Lookup by Payer Name
 ;          RCANS   - User Payer or TIN selection
 ;          INDX    - Current # of selected Payers (only passed if NMORTIN=2)
 ; Output:  SELPAY()- Array of selected Payers (only returned if NMORTIN=2)
 ;          ^TMP("RCPAYER",$J,A1)=A2 Where:
 ;                    A1 - Counter
 ;                    A2 - Payer Name/TIN if NMORTIN=1, TIN/Payer Name if NMORTIN=2, else Payer Name
 ;          ^TMP("RCPAYER",$J,"B",B1,B2)=B3 Where:
 ;                    B1 - Payer TIN if NMORTIN=0, else Payer Name
 ;                    B2 - Counter
 ;                    B3 - Payer Name if NMORTIN=0 or 1, else Payer TIN
 ; Output:  List of Payers that meet the partial match
 N RCPAR,CNT,CTR,RCSAVE
 S CNT=0,RCPAR=RCANS,RCPAR=$O(^TMP("RCPAYER",$J,"B",RCPAR),-1)
 F  D  Q:RCPAR=""
 . S RCPAR=$O(^TMP("RCPAYER",$J,"B",RCPAR))
 . Q:RCPAR=""
 . I $E(RCPAR,1,$L(RCANS))'[RCANS S RCPAR="" Q
 . S CTR=0
 . F  D  Q:CTR=""
 . . S CTR=$O(^TMP("RCPAYER",$J,"B",RCPAR,CTR))
 . . Q:CTR=""
 . . W !,?5
 . . W:NMORTIN'=2 CTR,"."
 . . W ^TMP("RCPAYER",$J,CTR)
 . . I NMORTIN=2 D
 . . . S SELPAY("RCSELPAY",INDX)=^TMP("RCPAYER",$J,CTR),INDX=INDX+1
 . . S CNT=CNT+1
 . . I CNT=1 S RCSAVE=^TMP("RCPAYER",$J,CTR)
 W:'CNT "  ??"
 I NMORTIN'=2,CNT=1 D  ; one match by name, select it automatically
 . S ^TMP("RCSELPAY",$J,INDX)=RCSAVE,INDX=INDX+1
 . W " - SELECTED"
 Q
 ;
 ; PRCA*4.5*318 - Added parameters & logic for MIXED & BLANKLN
GETPAYR(MIXED,BLANKLN) ;select payer for filter, range
 ; called from ^RCDPEAR1
 ; Input: MIXED   - 1 to display prompts in mixed case
 ;                  Optional, defaults to 0
 ;        BLANKLN - 0 skip initial blank line
 ;                  Optional, defaults to 1 
 ;
 S:'$D(MIXED) MIXED=0           ; PRCA*4.5*318
 S:'$D(BLANKLN) BLANKLN=1
 ;
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,INDX,X,Y,RCINSF,RCINST,NUM
 S DIR("?")="ENTER THE NAME OF THE PAYER OR '??' TO LIST PAYERS"
 S DIR("??")="^D LIST^RCDPEM9(CNT)"
 S DIR(0)="FA^1:30^K:X'?1.U.E X"
 S DIR("A")="START WITH INSURANCE COMPANY NAME: "
 S DIR("B")=$E($O(^TMP("RCPAYER",$J,"B","")),1,30)
 I MIXED D         ;PRCA*4.5*318
 . S DIR("?")="Enter the name of the payer or '??' to list payers"
 . S DIR("A")="Start with Insurance Company name: "
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)!(Y="") S RTNFLG=-1 Q
 S RCINSF=Y
 S DIR("?")="ENTER THE NAME OF THE PAYER OR '??' TO LIST PAYERS"
 S DIR("??")="^D LIST^RCDPEM9(CNT)"
 S DIR(0)="FA^1:30^K:X'?1.U.E X"
 S DIR("A")="GO TO INSURANCE COMPANY NAME: "
 I MIXED D         ;PRCA*4.5*318
 . S DIR("?")="Enter the name of the payer or '??' to list payers"
 . S DIR("A")="Go to Insurance Company name: "
 S DIR("B")=$E($O(^TMP("RCPAYER",$J,"B",""),-1),1,30)
 ; PRCA*4.5*318 - added conditional for MIXED & BLANKLN
 F  W:BLANKLN ! D ^DIR Q:$S($D(DTOUT)!$D(DUOUT):1,1:RCINSF']Y)  D
 . W:'MIXED !,"'GO TO' NAME MUST COME AFTER 'START WITH' NAME"
 . W:MIXED !,"'GO TO' name must come after 'START WITH' name"
 K DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)!(Y="") S RTNFLG=-1 Q
 S RCINST=Y_"Z"  ;entry of "ABC" will pick up "ABC INSURANCE" if "Z" is appended
 ;If the first name is an exact match, back up to the previous entry
 I $D(^TMP("RCPAYER",$J,"B",RCINSF)) S RCINSF=$O(^TMP("RCPAYER",$J,"B",RCINSF),-1)
 ; PRCA*4.5*284 - Save from/thru user responses in RNG1 & RNG2 to rebuild after report is queued. Will be returned to the calling program.
 S RNG1=RCINSF,RNG2=RCINST
 S INDX=1 F  S RCINSF=$O(^TMP("RCPAYER",$J,"B",RCINSF)) Q:RCINSF=""  Q:RCINSF]RCINST  D
 . S NUM=$O(^TMP("RCPAYER",$J,"B",RCINSF,""))
 . S ^TMP("RCSELPAY",$J,INDX)=$G(^TMP("RCPAYER",$J,NUM))
 . S INDX=INDX+1
 ;Set return value
 I INDX=1 S RTNFLG=-1 Q  ; no entries in selected range
 S RTNFLG=1
 Q
