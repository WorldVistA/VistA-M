IBTRH1B ;ALB/FA - HCSR Worklist ;11-SEP-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ;
 ; Contains Entry points and functions used in filtering/displaying the 
 ; HCSR Worklist
 ;
 ; --------------------------   Entry Points   --------------------------------
 ;    DELAY     - Protocol Action that allows the user to select multiple
 ;                entries and remove them until a future date or until time
 ;                of discharge.
 ;    GETDDATE  - Returns the delay date for an entry being delayed
 ;    RESPWR    - Protocol Action that allows the user to view the Response
 ;                Worklist.
 ;    SHOWFILT  - Displays the currently selected filter selections for the
 ;                HCSR Worklist
 ;-----------------------------------------------------------------------------
 ;
DELAY ;EP
 ; Protocol action to remove selected HCSR Worklist entry(s) until a
 ; selected date or until time of discharge
 ; Input:   ^TMP("IBTRH1",$J)   - Current Array of displayed entries
 ;          ^TMP($J,"IBTRHIX")  - Current Index of displayed entries
 ; Output:  Selected Entry is removed from the worklist 
 ;          Error messages display (potentially)
 ;          ^TMP("IBTRH1",$J)   - Updated Array of displayed entries
 ;          ^TMP($J,"IBTRHIX")  - Updated Index of displayed entries
 N DDATE,DIR,DIROUT,DIRUT,DLINE,DTOUT,DUOUT,EIEN,EIENS,ERROR,FIELD,IEN,IX,LINE,MSG
 N PROMPT,SDATA
 D VALMSGH^IBTRH1                               ; Set flag legend
 S VALMBCK="R",ERROR=0
 S MSG="Are you sure you want to delay "
 S PROMPT="Select the worklist entry(s) to be delayed"
 ; 
 ; First select the entry(s) to be delay review from the worklist
 S EIENS=$$SELEVENT^IBTRH1(1,PROMPT,.DLINE,1)   ; Select the entry to be delayed
 I EIENS="" S VALMBCK="R" Q
 S DDATE=$$GETDDATE(DLINE)                      ; Get the selected delay date
 Q:DDATE=""
 S MSG=MSG_$S(DLINE[",":"Entries ",1:"Entry ")_DLINE_" until "
 S MSG=MSG_$S(DDATE="D":"Discharge",1:$$FMTE^XLFDT(DDATE,"2Z"))
 Q:'$$ASKSURE^IBTRH1(DLINE,MSG,1)               ; Final warning
 F IX=1:1:$L(EIENS,",") D
 . S EIEN=$P(EIENS,",",IX)
 . S LINE=$P(DLINE,",",IX)
 . ;
 . ; Only allow delay of events for Inpatients
 . I $P(^IBT(356.22,EIEN,0),"^",4)="O" D  Q
 . . W !,*7,">>>> Entry ",LINE," is for an Outpatient and cannot be delayed"
 . . S ERROR=1
 . ;
 . ; Only allow delay of events with no current status
 . I +$P(^IBT(356.22,EIEN,0),"^",8)'=0 D  Q
 . . W !,*7,">>>> Entry ",LINE," is being worked and cannot be delayed"
 . . S ERROR=1
 . ;
 . ; Next set the delay date of the entry
 . I '$$LOCKEV^IBTRH1(EIEN) D  Q
 . . W !,*7,">>>> Someone else is editing entry ",LINE,". Try again later."
 . . S ERROR=1
 . ;
 . K SDATA
 . S IEN=EIEN_","
 . S SDATA(356.22,IEN,.08)="08"                 ; Change Status
 . S SDATA(356.22,IEN,.17)=DDATE                ; Set Status manual remove flag
 . D FILE^DIE("","SDATA")
 . D UNLOCKEV^IBTRH1(EIEN)
 . ;
 . ; Finally, flag the entry for next review
 . S FIELD="*"_$E($G(^TMP("IBTRH1",$J,LINE,0)),7,23)
 . D FLDTEXT^VALM10(LINE,"PAT NAME",FIELD)      ; Update flag display
 . D WRITE^VALM10(LINE)                         ; Redisplay line
 K DIR
 D:ERROR PAUSE^VALM1
 Q
 ;
GETDDATE(DLINE) ;EP
 ; Allows the user to select a delay date which is used to remove
 ; entries from the HCSR Worklist until the delay date has been met
 ; Input:   DLINE   - Comma delimited list of entries to be delayed
 ; Returns: DDATE   - 'D' to delay until admission has been discharged
 ;                    Fileman internal date of when the entry will re-appear
 ;                    null, if nothing selected
 N CODE,DIR,DIROUT,DIRUT,DTOUT,DUOUT,NOW,PROMPT,X,XX,Y
 S PROMPT="Enter 'D' or Future Date for "
 S XX=$S(DLINE[",":"Entries ",1:"Entry ")
 S NOW=$$DT^XLFDT()
 S CODE="I ((X'=""D"")&(X'=""d"")),X'="""" S XX=X,NOW=$$DT^XLFDT,X=XX D ^%DT K:Y'>NOW X"
 S DIR(0)="FO^^"_CODE
 S DIR("A")=PROMPT_XX_DLINE
 S DIR("?",1)="Entry a future date or 'D' to delay until discharge.  A 'D' will remove the"
 S DIR("?",2)="selected entries from the worklist until the patients have been discharged."
 S DIR("?",3)="Entering a Date will remove the selected entries from the worklist until the"
 S DIR("?")="selected date."
 D ^DIR K DIR
 Q:$G(DIRUT) ""
 Q $$UP^XLFSTR(Y)
 ;
RESPWR ;EP
 ; Protocol action to display the Response Worklist to show all Entries with
 ; completed responses.
 ; Input:   IBFILTS - Array of filter options currently set on the
 ;                    HCSR Worklist
 ; Output:  Response Worklist is shown with the current filter settings
 N IBFILTSR
 M IBFILTSR=IBFILTS
 D EN^IBTRH5(.IBFILTSR)
 Q
 ;
SHOWFILT(FILTERS)   ;EP
 ; Displays the currently selected filter selections for the
 ; HCSR Worklist
 ; Input:   FILTERS()   - Array of filter settings. See FILTERS for a detailed
 ;                        explanation of the FILTERS array
 ; Output:  Current Filter settings are displayed
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IEN,IX,LEN,XX
 W !!,"Show ChampVA/Tricare entries, CPAC entries or Both: "
 W $S($P(FILTERS(0),"^",2)=0:"C",FILTERS(0)=1:"T",1:"B")
 W !,"Show Inpatient entries, Outpatient entries or Both: "
 W $S($P(FILTERS(0),"^",1)=0:"O",$P(FILTERS(0),"^",1)=1:"I",1:"B")
 W !,"Show All Divisions or Selected Divisions: "
 W $S($P(FILTERS(0),"^",3)=0:"All",1:"Selected")
 ;
 ; Division list (if any)
 I ($P(FILTERS(0),"^",3)=1) D
 . W !,"Divisions to Display: "
 . S LEN=20
 . F IX=1:1:$L(FILTERS(3),"^") D
 . . S IEN=$P(FILTERS(3),"^",IX),XX=$$GET1^DIQ(40.8,IEN_",",.01)
 . . S LEN=LEN+$L(XX)
 . . I LEN+2<80 D  Q
 . . . W XX
 . . . I $P(FILTERS(3),"^",IX+1)'="" D
 . . . . S LEN=LEN+2
 . . . . W ", "
 . . S LEN=20
 . . W !,"                    ",XX
 ;
 ; Clinic Inclusion list (if any)
 I ($P(FILTERS(0),"^",1)=0)!($P(FILTERS(0),"^",1)=2) D
 . W !,"Clinics to Display: "
 . I $G(FILTERS(1))="" W "ALL" Q
 . S LEN=20
 . F IX=1:1:$L(FILTERS(1),"^") D
 . . S IEN=$P(FILTERS(1),"^",IX),XX=$$GET1^DIQ(44,IEN_",",.01)
 . . S LEN=LEN+$L(XX)
 . . I LEN+2<80 D  Q
 . . . W XX
 . . . I $P(FILTERS(1),"^",IX+1)'="" D
 . . . . S LEN=LEN+2
 . . . . W ", "
 . . S LEN=20
 . . W !,"                    ",XX
 ;
 ; Ward Inclusion list (if any)
 I $P(FILTERS(0),"^",1)>0 D
 . W !,"Wards to Display:   "
 . I $G(FILTERS(2))="" W "ALL" Q
 . S LEN=20
 . F IX=1:1:$L(FILTERS(2),"^") D
 . . S IEN=$P(FILTERS(2),"^",IX),XX=$$GET1^DIQ(42,IEN_",",.01)
 . . S LEN=LEN+$L(XX)
 . . I LEN+2<80 D  Q
 . . . W XX
 . . . W:$P(FILTERS(2),"^",IX+1)'="" ", "
 . . W !,"                    ",XX
 K DIR
 D PAUSE^VALM1
 Q
 ;
