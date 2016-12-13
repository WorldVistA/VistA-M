IBTRH1 ;ALB/FA - HCSR Worklist ;01-JUL-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ;
EN ;EP
 ; Main entry point for HCSR Worklist
 ; Input: None
 N HCSRSORT,IBFILTS
 Q:'$$FILTERS^IBTRH1A(.IBFILTS)  ; Returns an array of filter settings
 D SORT(1) ; Sort the entries
 D EN^VALM("IBT HCSR WORKLIST")
 Q
 ;
HDR ;EP
 ; Header code for HCSR Worklist
 ; Input:   HCSRSORT        - Current sort selection
 ;          IBFILTS()       - Array of filter criteria
 ; Output:  VALMHDR         - Header information to display
 ;          VALM("TITLE")   - HCSR Worklist Title
 ;          VALMSG          - Initial Error line display
 N XX
 S:$G(HCSRSORT)="" HCSRSORT="1^Oldest Entries First"
 S VALMHDR(1)=$$FILTBY(.IBFILTS)
 S VALMHDR(2)="Sorted By:   "_$P(HCSRSORT,"^",2)
 S VALM("TITLE")="HCSR Worklist"
 D VALMSGH    ; Set flag legend
 Q
 ;
VALMSGH(INP) ;EP
 ; Sets the legend into variable VALMSG
 ; Input:   INP     - 1 - Only display #In-Prog, 0 - Display all
 ;                    Optional, defaults to 0
 ; Output:  VALMSG is set
 S:'$D(INP) INP=0
 I INP  S VALMSG="#In-Prog" Q
 S VALMSG="?Await #In-Prog -RespErr !Unable +Pend *NextRev"
 Q
 ;
FILTBY(IBFILTS) ;EP
 ; Creates the 'Filtered By' line of the worklist header
 ; Input:   IBFILT  - Array of current filter settings
 ; Returns: Filtered By line
 N XX
 I $P(IBFILTS(0),"^",2)=0 S XX="CPAC, "
 I $P(IBFILTS(0),"^",2)=1 S XX="CHAMPVA/TRICARE, "
 I $P(IBFILTS(0),"^",2)=2 S XX="Both CPAC and CHAMPVA/TRICARE, "
 S XX=XX_$S($G(IBFILTS(3))'="":"Sel Div, ",1:"All Div, ")
 I $P(IBFILTS(0),"^",1)=0 D
 . S XX=XX_$S($G(IBFILTS(1))'="":"Sel Outpt",1:"All Outpt")
 I $P(IBFILTS(0),"^",1)=1 D
 . S XX=XX_$S($G(IBFILTS(2))'="":"Sel Inpt",1:"All Inpt")
 I $P(IBFILTS(0),"^",1)=2 D
 . S XX=XX_$S($G(IBFILTS(1))'="":"Sel Outpt, ",1:"All Outpt, ")
 . S XX=XX_$S($G(IBFILTS(2))'="":"Sel Inpt",1:"All Inpt")
 Q "Filtered By: "_XX
 ;
INIT ;EP
 ; Initialize variables and list array
 ; Input: None
 ; Output:  HCSRSORT            - Initial worklist sort if not yet defined
 ;          IBFILTS()           - Array of filter criteria
 ;          ^TMP("IBTRH1",$J)   - Body lines to display
 K ^TMP("IBTRH1",$J),^TMP($J,"IBTRH1IX")
 S:$G(HCSRSORT)="" HCSRSORT="1^Oldest Entries First"
 D BLD
 Q
 ;
BLD ; Build screen array, no variables required for input
 ; Input:   HCSRSORT            - Current select sort type
 ;          IBFILTS()           - Array of filter criteria
 ; Output:  ^TMP("IBTRH1",$J)   - Body lines to display
 ;          ^TMP($J,"IBTRH1S")  - Sorted Body lines to display
 ;          ^TMP($J,"IBTRH1IX") - Index of Entry IENs by display line
 N DA,ECTR,LINE,S1,S2,S3,XSELCNT,XDA1,XRESP,XREJDA,XREJDA1
 ; Build the sorted list of lines to display
 D SORT1^IBTRH1A
 S (ECTR,VALMCNT)=0,S1=""
 F  S S1=$O(^TMP($J,"IBTRH1S",S1)) Q:S1=""  D
 .S S2="" F  S S2=$O(^TMP($J,"IBTRH1S",S1,S2)) Q:S2=""  D
 ..S S3="" F  S S3=$O(^TMP($J,"IBTRH1S",S1,S2,S3)) Q:S3=""  D
 ...S DA="" F  S DA=$O(^TMP($J,"IBTRH1S",S1,S2,S3,DA)) Q:DA=""  D
 ....S ECTR=ECTR+1
 ....S LINE=^TMP($J,"IBTRH1S",S1,S2,S3,DA)
 ....S LINE=$$BLDLN(ECTR,LINE)
 ....S VALMCNT=VALMCNT+1,XSELCNT=$G(XSELCNT)+1
 ....D SET^VALM10(VALMCNT,LINE,XSELCNT),BLD1
 ....S ^TMP($J,"IBTRH1IX",XSELCNT)=DA
 ....S XRESP=$P(^IBT(356.22,DA,0),U,14)
 ....I XRESP'="" S XDA1=$G(^IBT(356.22,XRESP,103))
 ....I $P($G(XDA1),U,3)'="" D
 .....N XREVDA1
 .....D GETS^DIQ(356.021,$P(XDA1,U,3),".01:.02",,"XREVDA1")
 .....S VALMCNT=VALMCNT+1
 .....D SET^VALM10(VALMCNT,"       Review Decision: "_XREVDA1(356.021,$P(XDA1,U,3)_",",".01")_" - "_XREVDA1(356.021,$P(XDA1,U,3)_",",".02"),XSELCNT)
 .....D BLD1
 ....I XRESP'="" S XDA1=0 F  S XDA1=$O(^IBT(356.22,XRESP,101,XDA1)) Q:'XDA1  D
 .....S XREJDA=+$P($G(^IBT(356.22,XRESP,101,XDA1,0)),U,4) I 'XREJDA Q
 .....D GETS^DIQ(365.017,XREJDA,".01:.02",,"XREJDA1")
 .....S VALMCNT=VALMCNT+1
 .....D SET^VALM10(VALMCNT,"       Rejection: "_XREJDA1(365.017,XREJDA_",",".01")_" - "_XREJDA1(365.017,XREJDA_",",".02"),XSELCNT)
 .....D BLD1
 .....S XDA1=""
 .....Q
 ....Q
 ...Q
 ..Q
 .Q
 I VALMCNT=0 D
 .S ^TMP("IBTRH1",$J,1,0)="There are no entries to display."
 Q
 ;
BLD1 ;
 S ^TMP("IBTRH1",$J,"IDXX",XSELCNT,VALMCNT)=""
 Q
 ;
BLDLN(ECTR,LINED) ; Builds a line to display on List screen for one entry
 ; Input:   ECTR    - Entry counter
 ;          LINED   - A1^A2^...A9 Where:
 ;                      A1  - Patient Name
 ;                      A2  - Patient Status ('I' or 'O')
 ;                      A3  - External Appt or Admission date
 ;                      A4  - Clinic or Ward name
 ;                      A5  - COB ('P' or 'S')
 ;                      A6  - Insurance Company Name
 ;                      A7  - Utilization Review required
 ;                      A8  - Pre-Certification required
 ;                      A9  - Service Connection flags
 ; Output:  LINE    - Formatted for setting into the list display
 N LINE,LINEI
 S LINE=$$SETSTR^VALM1(ECTR,"",1,4)               ; Entry #
 S LINE=$$SETSTR^VALM1($P(LINED,"^",1),LINE,6,23) ; Patient Name
 S LINE=$$SETSTR^VALM1($P(LINED,"^",2),LINE,30,1) ; Patient Status
 S LINE=$$SETSTR^VALM1($P(LINED,"^",3),LINE,32,8) ; Appt/Adm Date
 S LINE=$$SETSTR^VALM1($P(LINED,"^",4),LINE,41,10)  ; Clinic or Ward
 S LINE=$$SETSTR^VALM1($P(LINED,"^",5),LINE,52,1) ; COB
 S LINE=$$SETSTR^VALM1($P(LINED,"^",6),LINE,55,14)  ; Insurance Name
 S LINE=$$SETSTR^VALM1($P(LINED,"^",7),LINE,70,1) ; UR required
 S LINE=$$SETSTR^VALM1($P(LINED,"^",8),LINE,72,1) ; Pre-Cert Required
 S LINE=$$SETSTR^VALM1($P(LINED,"^",9),LINE,74,5) ; Service Connections
 Q LINE
 ;
HELP ;EP
 ; Help code
 ; Input: None
 D FULL^VALM1
 S VALMBCK="R"
 W @IOF,"Flags displayed on screen for SC Reas (Service Connected Reason):"
 W !,"  A - Agent Orange"
 W !,"  I - Ionizing Radiation"
 W !,"  S - Southwest Asia"
 W !,"  N - Nose/Throat Radium"
 W !,"  C - Combat Veteran"
 W !,"  M - Military Sexual Trauma (MST)"
 W !,"  L - Camp Lejeune"
 W !,"Flags displayed on screen for U (UR Required) or P (Pre-certification Required):"
 W !,"  Y - Yes,  N - No"
 W !,"Flags displayed on screen for S (Patient Status):"
 W !,"  O - Outpatient, I - Inpatient"
 W !,"The following Status indicators may appear to the left of the patient name:"
 W !,"  #       - 278 has been not been initiated, entry is in-progress"
 W !,"  ?       - 278 has been sent and waiting for response"
 W !,"  +       - 278 is pending"
 W !,"  *       - Flagged for Next Review"
 W !,"  !       - Unable to send 278"
 W !,"  <Blank> - Entry added through scheduled task"
 W !,"  -       - 278 has been sent and negative response received "
 W !,"            (error AAA condition  in AAA segment(s))"
 S VALMSG="?Await #In-Prog -RespErr !Unable +Pend *NextRev"
 Q
 ;
EXIT ;EP
 ; Exit code
 ; Input: None
 K ^TMP("IBTRH1",$J),^TMP($J,"IBTRH1IX"),^TMP($J,"IBTRH1S")
 K HCSRSORT
 D CLEAR^VALM1
 Q
 ;
SORT(FIRST) ;EP
 ; Listman Protocol Action to sort the worklist
 ; Input:   FIRST    - 1 - Called for the first time before the Worklist is displayed
 ;                     2 - Called from Refresh action (REFRESH^IBTRH1A)
 ;                     0 - Called as an action from within the Worklist, Optional, defaults to 0
 ;          HCSRSORT - Current sort selection (null if FIRST=1)
 ;          IBFILTS()- Array of filter criteria
 ; Output:  HCSRSORT - New sort selection and list is sorted
 N CTR,DIR,DIROUT,DIRUT,DTOUT,DUOUT,ST,STDES,X,XX,Y
 D VALMSGH  ; Set flag legend
 S CTR=1
 S:'$D(FIRST) FIRST=0
 S:FIRST=1 HCSRSORT="1^Oldest Entries First"
 I 'FIRST!(FIRST=2) D
 . D:'FIRST FULL^VALM1
 . W:'FIRST @IOF
 . W !,"Select the item to sort the records on the HCSR Worklist screen."
 S XX="SO^"_CTR_":Oldest Entries First",CTR=CTR+1
 S XX=XX_";"_CTR_":Newest Entries First",CTR=CTR+1
 S:+IBFILTS(0)=2 XX=XX_";"_CTR_":Outpatient Appointments First",CTR=CTR+1
 S:+IBFILTS(0)=2 XX=XX_";"_CTR_":Inpatient Admissions First",CTR=CTR+1
 S XX=XX_";"_CTR_":Insurance Company Name"
 S DIR(0)=XX
 S DIR("A")="Sort the list by",DIR("B")=$P($G(HCSRSORT),"^",2)
 D ^DIR K DIR
 I 'Y S VALMBCK="R" Q  ; User quit or timed out
 S XX=$S(+IBFILTS(0)=2:Y,Y<3:Y,1:5)
 S HCSRSORT=XX_"^"_Y(0) ; Sort selection
 Q:FIRST
 ; Rebuild and resort the list and update the list header
 D INIT,HDR
 S VALMBCK="R",VALMBG=1
 Q
 ;
DEL ;EP
 ; Protocol Action to select an entry to be manually removed from the worklist
 ; Input:   ^TMP("IBTRH1",$J)   - Current Array of displayed entries
 ;          ^TMP($J,"IBTRHIX")  - Current Index of displayed entries
 ; Output:  Selected Entry is removed from the worklist 
 ;          Error messages display (potentially)
 ;          ^TMP("IBTRH1",$J)   - Updated Array of displayed entries
 ;          ^TMP($J,"IBTRHIX")  - Updated Index of displayed entries
 N DIR,DIROUT,DIRUT,DLINE,DTOUT,DUOUT,EIEN,EIENS,ERROR,IEN,IX,LINE,MSG
 N PROMPT,SDATA,DELRCODE,XCOM,COM,DIWETXT
 D VALMSGH  ; Set flag legend
 S VALMBCK="R",ERROR=0
 ; First select the entry(s) to be removed from the worklist
 S PROMPT="Select the worklist entry(s) to be deleted"
 S MSG="Are you sure you want to delete "
 S EIENS=$$SELEVENT(1,PROMPT,.DLINE,1)   ; Select the entry to be deleted
 I EIENS="" S VALMBCK="R" Q
D1 ;
 S DIC(0)="AEQM",DIC="^IBT(356.023,"
 S DIC("A")="Select a Delete Reason Code: "
 D ^DIC
 I Y<0 Q:X="^"  W !,*7,">>>> A Delete Reason Code must be selected, or '^' to exit." G D1
 S DELRCODE=$P(Y,"^")
 Q:'$$ASKSURE(DLINE,MSG)    ; Final warning
 F IX=1:1:$L(EIENS,",") D  Q:$G(ERROR)
 . S EIEN=$P(EIENS,",",IX)
 . S LINE=$P(DLINE,",",IX)
 . ; Don't allow deletion of entries with a pending response (status '02')
 . I +$P(^IBT(356.22,EIEN,0),"^",8)=2 D  Q
 .. W !,*7,">>>> Entry ",LINE," has been sent and is awaiting a response. It cannot be deleted."
 .. N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 .. S DIR(0)="EA"
 .. S DIR("A",1)=" "
 .. S DIR("A")="Press RETURN to continue " D ^DIR
 .. S ERROR=1
 .. Q
 . ; Next update the status to be manually removed
 . I '$$LOCKEV(EIEN) D  Q
 .. W !,*7,">>>> Someone else is editing entry ",LINE,". Try again later."
 .. S ERROR=1
 . K SDATA
 . S IEN=EIEN_","
 . S SDATA(356.22,IEN,.08)="06"  ; Set Status manual remove flag
 . S SDATA(356.22,IEN,.23)=$$NOW^XLFDT() ; Set Manually Removed Date/Time
 . S SDATA(356.22,IEN,.24)=DUZ   ; Set Manually Removed By User
 . S SDATA(356.22,IEN,.25)=DELRCODE  ; Set Delete Reason code pointer
 . I $P(^IBT(356.22,EIEN,0),"^",11)="" S SDATA(356.22,IEN,.11)=DUZ  ; 517-T14: if REQUESTED BY is blank, set it to user deleting
 . D FILE^DIE("","SDATA")
 . D UNLOCKEV(EIEN)
 I $G(ERROR) Q
 K DIR
 Q
 ;
ASKSURE(DLINE,MSG,ENTIRE)   ;EP
 ; Make sure the user wants to proceed with the selected action
 ; Input:   DLINE   - Comma delimited list of valid selected lines
 ;          MSG     - Message to be displayed to the user
 ;          ENTIRE  - 1 - MSG is the entire prompt do not append
 ;                    0 - MSG is not the entire prompt append
 ;                    Optional, defaults to 0
 ; Returns: 1 - Proceed with action, 0 otherwise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,XX,Y
 S:'$D(ENTIRE) ENTIRE=0
 S XX=$S(DLINE[",":"entries ",1:"entry ")
 S DIR(0)="YO",DIR("B")="N"
 S:'ENTIRE MSG=MSG_XX_DLINE
 S DIR("A")=MSG
 D ^DIR K DIR
 Q:'Y 0
 Q 1
 ;
PRMARK(WHICH,EIENIN,WLIST)   ;EP
 ; Listman Protocol Action to Mark/Remove 'In-Progress' from a selected entry
 ; Called from HSCR Worklist and HSCR Response Worklist
 ; Input:   WHICH   - 0 - Remove 'In-Progress' mark
 ;                    1 - Set 'In-Progress' mark
 ;          EIENIN  - IEN of the entry to Mark/Remove 'In-Progress'
 ;                    Only passed when called from Mark/Remove protocol actions
 ;                    from the Expand Entry Worklist.
 ;                    Optional, defaults to "-1"
 ;          WLIST   - Worklist, the user is selecting from. Set to 'IBTRH5IX'
 ;                    when called from the response worklist.
 ;                    Optional, defaults to 'IBTRH1IX' 
 ;          ^TMP($J,"IBTRH1IX") - Index of displayed lines of the HCSR Worklist
 ;                                Only used if WLIST is not 'IBTRH5IX"
 ;          ^TMP($J,"IBTRH5IX") - Index of displayed lines of the HCSR Response
 ;                                Worklist. Only used if WLIST is 'IBTRH5IX"
 ;          ^TMP("IBTRH1",$J)   - Current Array of displayed entries
 ;          ^TMP($J,"IBTRHIX")  - Current Index of displayed lines
 ; Output:  Selected Entry is marked in progress or remove marked in progress 
 ;          or VALMSG is displayed with an error message
 ;          ^TMP("IBTRH1",$J)   - Updated Array of displayed entries
 ;          ^TMP($J,"IBTRHIX")  - Updated Index of displayed lines
 ;      
 N CSTAT,DIR,DIROUT,DIRUT,DLINE,DTOUT,DUOUT,EIEN,EIENS,ERROR,EVENT,FIELD,FLG
 N IX,LINE,PROMPT,REST,STATUS,STATUSDT,STATUSU,XX
 S:$G(EIENIN)="" EIENIN=-1
 S:'$D(WLIST) WLIST="IBTRH1IX"
 S XX=$S(WLIST="IBTRH5IX":1,1:0)
 D VALMSGH(XX) ; Set flag legend
 S EIENS=$S(EIENIN'=-1:EIENIN,1:"")
 S VALMBCK="R"
 S ERROR=0
 I WHICH=0 S REST=" remove 'In-Progress' mark",STATUS="0",STATUSDT="@",STATUSU="@"
 E  S REST="Set 'In-Progress' mark",STATUS="01",STATUSDT=DT,STATUSU=DUZ
 I WLIST="IBTRH5IX",STATUS="01" S STATUS=1
 ; First select the entry to be removed from the worklist
 S PROMPT="Select the entry(s) to "_REST
 S:EIENS="" EIENS=$$SELEVENT(1,PROMPT,.DLINE,1,WLIST)  ; Select the entry(s) to update
 I EIENS="" S VALMBCK="R" Q
 F IX=1:1:$L(EIENS,",") D
 . S EIEN=$P(EIENS,",",IX)
 . S LINE=$S(EIENIN'=-1:"",1:$P(DLINE,",",IX))
 . ; Get the current status of the entry
 . S:WLIST="IBTRH5IX" CSTAT=+$$GET1^DIQ(356.22,EIEN_",",.21,"I")
 . S:WLIST'="IBTRH5IX" CSTAT=+$$GET1^DIQ(356.22,EIEN_",",.08,"I")
 . ; Make sure the entry can be changed to in-progress, quit otherwise
 . I (CSTAT'=0),(CSTAT'=1) D  Q                 ; Invalid to be changed
 .. W !,*7,">>>> Entry ",LINE," - Invalid Status, action not performed"
 .. S ERROR=1
 . ; Next update the status to be manually updated
 . I '$$LOCKEV(EIEN) D  Q
 .. W !,*7,">>>> Some else is editing the entry ",LINE,". Try again later."
 .. S ERROR=1
 . S XX=$S(WLIST="IBTRH5IX":1,1:0)
 . D PRMARK1(EIEN,STATUS,STATUSU,STATUSDT,XX)
 . D UNLOCKEV(EIEN)
 . Q:EIENIN'=-1
 . ; Finally, update the line and redisplay it
 . S EVENT=^IBT(356.22,EIEN,0)
 . I WLIST="IBTRH1IX" D
 .. S FLG=$S($P(EVENT,"^",8)="01":"#",1:" ")
 .. S LINE=$O(^TMP("IBTRH1",$J,"IDXX",LINE,0))
 .. S FIELD=FLG_$E($G(^TMP("IBTRH1",$J,LINE,0)),7,23)
 . I WLIST="IBTRH5IX" D
 .. S FLG=$S($P(EVENT,"^",21)=1:"#",1:" ")
 .. S FIELD=FLG_$E($G(^TMP("IBTRH5",$J,LINE,0)),7,23)
 . D FLDTEXT^VALM10(LINE,"PAT NAME",FIELD)      ; Update flag display
 . D WRITE^VALM10(LINE)                         ; Redisplay line
 K DIR
 Q:EIENIN'=-1
 D:ERROR PAUSE^VALM1
 Q
 ;
PRMARK1(IEN,STATUS,USER,TSTAMP,RESP) ; Change 'In-Progress' status of a given entry
 ; Input:   IEN     - IEN of file 356.22 entry to use
 ;          STATUS  - New status to set: '01' - Set 'In-Progress', 
 ;                                       '0'  - Remove 'In-Progress'
 ;          USER    - File 200 ien of a user changing the status, defaults
 ;                    to DUZ
 ;          TSTAMP  - Timestamp of the status change, defaults to current
 ;                    date/time
 ;          RESP    - 1 - Setting field .21 instead of field .08
 ;                    Optional, defaults to 0
 N IENS,SDATA
 Q:'+$G(IEN)                           ; Invalid ien
 S:'$D(RESP) RESP=0
 I 'RESP,"^01^0^"'[(U_$G(STATUS)_U) Q  ; Invalid status for Main Worklist
 I RESP,"^1^0^"'[(U_$G(STATUS)_U) Q  ; Invalid status for Response Worklist
 S:$G(USER)="" USER=DUZ
 S:$G(TSTAMP)="" TSTAMP=$$NOW^XLFDT()
 S IENS=+IEN_","
 S:'RESP SDATA(356.22,IENS,.08)=STATUS ; Update status
 S:RESP SDATA(356.22,IENS,.21)=STATUS  ; Update Response Status
 S SDATA(356.22,IENS,.09)=USER ; Update status entered by
 S SDATA(356.22,IENS,.1)=TSTAMP  ; Update status entered date
 D FILE^DIE("","SDATA")
 Q
 ;
SELEVENT(FULL,PROMPT,DLINE,MULT,WLIST)    ;EP
 ; Select Entry(s) to perform an action upon
 ; Input:   FULL                - 1 - full screen mode, 0 otherwise
 ;          PROMPT              - Prompt to be displayed to the user
 ;          MULT                - 1 to allow multiple entry selection
 ;                                0 to only allow single entry selection
 ;                                Optional, defaults to 0
 ;          WLIST               - Worklist, the user is selecting from
 ;                                Set to 'IBTRH5IX' when called from the
 ;                                response worklist.
 ;                                Optional, defaults to 'IBTRH1IX' 
 ;          ^TMP($J,"IBTRH1IX") - Index of displayed lines of the HCSR Worklist
 ;                                Only used if WLIST is not 'IBTRH5IX"
 ;          ^TMP($J,"IBTRH5IX") - Index of displayed lines of the HCSR Response
 ;                                Worklist. Only used if WLIST is 'IBTRH5IX"
 ; Output:  DLINE               - Comma delimited list of Line #(s) of the 
 ;                                selected entries
 ; Returns: EIN(s) - Comma delimited string or IENS for the selected entry(s)
 ;          Error message and "" IENS if multi-selection and not allowed
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,EIEN,EIENS,IX,VALMY,X,Y
 S:'$D(MULT) MULT=0
 S:'$D(WLIST) WLIST="IBTRH1IX"
 D:FULL FULL^VALM1
 S DLINE=$P($P($G(XQORNOD(0)),"^",4),"=",2) ; User selection with action
 S DLINE=$TR(DLINE,"/\; .",",,,,,") ; Check for multi-selection
 S EIENS=""
 I 'MULT,DLINE["," D  Q ""   ; Invalid multi-selection
 . W !,*7,">>>> Only single entry selection is allowed"
 . S DLINE=""
 . K DIR
 . D PAUSE^VALM1
 ; Check the user enter their selection(s)
 D EN^VALM2($G(XQORNOD(0)),"O") ; ListMan generic selector
 I '$D(VALMY) Q ""
 S IX="",DLINE=""
 F  D  Q:IX=""
 . S IX=$O(VALMY(IX))
 . Q:IX=""
 . S DLINE=$S(DLINE="":IX,1:DLINE_","_IX)
 . S EIEN=$G(^TMP($J,WLIST,IX))
 . S EIENS=$S(EIENS="":EIEN,1:EIENS_","_EIEN)
 Q EIENS
 ;
ADDCMT  ;EP
 ; Listman Protocol Action to add a comment to a selected entry
 ; Input:   ^TMP("IBTRH1",$J)   - Current Array of displayed entries
 ;          ^TMP($J,"IBTRHIX")  - Current Index of displayed lines
 ; Output:  Comment is added (Potentially) to the selected entry
 N DLINE,IBTRIEN,PROMPT
 S VALMBCK="R"
 D VALMSGH ; Set flag legend
 ; First select the entry to add a comment to
 S PROMPT="Select the entry to add a comment to"
 S IBTRIEN=$$SELEVENT(1,PROMPT,.DLINE) ; Select the entry to add comment to
 I IBTRIEN="" S VALMBCK="R" Q
 D ADDCMT^IBTRH2(1)
 Q
 ;
LOCKEV(IEN) ;EP
 ; Locks the specified entry for editing
 ; Input:   IEN     - IEN of the entry to locked
 ; Output:  Entry is locked (potentially)
 ; Returns: 1       - Entry was locked
 ;          0       - Entry couldn't be locked
 L +^IBT(356.22,IEN):1
 Q:$T 1
 Q 0
 ;
UNLOCKEV(IEN)   ;EP
 ; Unlocks the specified entry
 ; Input:   IEN     - IEN of the entry to be unlocked
 ; Output:  Entry is unlocked
 L -^IBT(356.22,IEN)
 Q
 ;
COMMENT(COM)    ; Enter the comment
 ; Input:   None
 ; Output:  COM   - Array of Comment text to be entered
 ; Returns: 1     - 1 - Text entered, 0 otherwise
 N DIC,DWPK
 K ^TMP($J,"COMMENT")
 S DWPK=1,DIC="^TMP($J,""COMMENT"","
 D EN^DIWE
 Q:'$D(^TMP($J,"COMMENT")) 0
 M COM=^TMP($J,"COMMENT")
 K ^TMP($J,"COMMENT")
 Q 1
