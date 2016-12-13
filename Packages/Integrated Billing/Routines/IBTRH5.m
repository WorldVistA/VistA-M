IBTRH5 ;ALB/FA - HCSR Response Worklist ;18-JUL-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ;
EN(IBFILTSR) ;EP
 ; Main entry point for HCSR Response Worklist
 ; Input: IBFILTSR  - Array of filter options from the HCSR Worklist
 ;                    NOTE: Any modifications done to these filters in the 
 ;                          REFRESH menu action are not returned back to
 ;                          HCSR Worklist
 N HCSRSRTR
 D EN^VALM("IBT HCSR RESPONSE WORKLIST")
 Q
 ;
HDR ;EP
 ; Header code for HCSR Response Worklist
 ; Input:   HCSSRTR         - Current sort selection
 ; Output:  VALMHDR         - Header information to display
 ;          VALM("TITLE")   - HCSR Response Worklist Title
 ;          VALMSG          - Initial Error line display
 N SORT
 S:$G(HCSRSRTR)="" HCSRSRTR="1^Oldest Entries First"
 S SORT=$P(HCSRSRTR,"^",2)
 S VALMHDR(1)=$$FILTBY^IBTRH1(.IBFILTSR)
 S VALMHDR(2)="Sorted By:   "_SORT
 S VALM("TITLE")="HCSR Response Worklist"
 S VALMSG="#In-Prog"
 Q
 ;
INIT ;EP
 ; Initialize variables and list array
 ; Input: None
 ; Output:  HCSRSRTR            - Initial worklist sort if not yet defined
 ;          ^TMP("IBTRH5",$J)   - Body lines to display
 K ^TMP("IBTRH5",$J),^TMP($J,"IBTRH5IX")
 S:$G(HCSRSRTR)="" HCSRSRTR="1^Oldest Entries First"
 D BLD
 Q
 ;
BLD ; Build screen array, no variables required for input
 ; Input: HCSRSRTR              - Current select sort type
 ; Output:  ^TMP("IBTRH5",$J)   - Body lines to display
 ;          ^TMP($J,"IBTRH5S")  - Sorted Body lines to display
 ;          ^TMP($J,"IBTRH5IX") - Index of Event IENs by display line
 N DA,ECTR,LINE,S1,S2,S3,XSELCNT,XDA1
 D SORT1   ; Build the sorted list of lines to display
 S (ECTR,VALMCNT)=0,S1=""
 F  S S1=$O(^TMP($J,"IBTRH5S",S1)) Q:S1=""  D
 .S S2="" F  S S2=$O(^TMP($J,"IBTRH5S",S1,S2)) Q:S2=""  D
 .. S S3="" F  S S3=$O(^TMP($J,"IBTRH5S",S1,S2,S3)) Q:S3=""  D
 ... S DA="" F  S DA=$O(^TMP($J,"IBTRH5S",S1,S2,S3,DA)) Q:DA=""  D
 .... S ECTR=ECTR+1
 .... S LINE=^TMP($J,"IBTRH5S",S1,S2,S3,DA)
 .... S LINE=$$BLDLN(ECTR,LINE)
 .... S VALMCNT=VALMCNT+1,XSELCNT=$G(XSELCNT)+1
 .... D SET^VALM10(VALMCNT,LINE,XSELCNT)
 .... S ^TMP($J,"IBTRH5IX",XSELCNT)=DA
 .... S XDA1=$G(^IBT(356.22,DA,103))
 .... I $P(XDA1,"^",3)'="" D
 ..... N XREVDA1
 ..... D GETS^DIQ(356.021,$P(XDA1,"^",3),".01:.02",,"XREVDA1")
 ..... S VALMCNT=VALMCNT+1
 ..... D SET^VALM10(VALMCNT,"      Review Decision: "_XREVDA1(356.021,$P(XDA1,"^",3)_",",".01")_" - "_XREVDA1(356.021,$P(XDA1,"^",3)_",",".02"),XSELCNT)
 I VALMCNT=0 D
 . S ^TMP("IBTRH5",$J,1,0)="There are no events to display."
 Q
 ;
BLDLN(ECTR,LINED) ; Builds a line to display on List screen for one event
 ; Input:   ECTR    - Event counter
 ;          LINED   - A1^A2^...A9 Where:
 ;                      A1  - Patient Name
 ;                      A2  - Patient Status ('I' or 'O')
 ;                      A3  - External Appt or Admission date
 ;                      A4  - Clinic or Ward name
 ;                      A5  - COB ('P', 'S' or 'T')
 ;                      A6  - Insurance Company Name
 ;                      A7  - Certification Action Code
 ; Output:  LINE    - Formatted for setting into the list display
 N LINE
 S LINE=$$SETSTR^VALM1(ECTR,"",1,4)                 ; Event #
 S LINE=$$SETSTR^VALM1($P(LINED,"^",1),LINE,6,23)   ; Patient Name
 S LINE=$$SETSTR^VALM1($P(LINED,"^",2),LINE,30,1)   ; Patient Status
 S LINE=$$SETSTR^VALM1($P(LINED,"^",3),LINE,32,8)   ; Appt/Adm Date
 S LINE=$$SETSTR^VALM1($P(LINED,"^",4),LINE,41,10)  ; Clinic or Ward
 S LINE=$$SETSTR^VALM1($P(LINED,"^",5),LINE,52,1)   ; COB
 S LINE=$$SETSTR^VALM1($P(LINED,"^",6),LINE,55,14)  ; Insurance Name
 S LINE=$$SETSTR^VALM1($P(LINED,"^",7),LINE,70,5)   ; Certification Action Code
 Q LINE
 ;
HELP ;EP
 ; Display HCSR Response worklist Help
 ; Input: None
 D FULL^VALM1
 S VALMBCK="R"
 W @IOF,"Flags displayed on screen for S (Patient Status):"
 W !,"  O - Outpatient"
 W !,"  I - Inpatient"
 W !!,"Flags displayed on screen for COB:"
 W !,"  P - Primary Insurance"
 W !,"  S - Secondary Insurance"
 W !,"  T - Tertiary"
 W !!,"Flags displayed for Cert Type (Certification Action):"
 W !,"  A1 - Certified in Total"
 W !,"  A2 - Certified in Partial"
 W !,"  A3 - Not Certified"
 W !,"  A6 - Modified "
 W !,"  C  - Cancelled"
 W !,"  CT - Contact Payer"
 W !,"  NA - No Action Required"
 W !,"  51 - Complete"
 W !,"  71 - Term Expired"
 W !,"The following Status indicator may appear to the left of the patient name:"
 W !,"  #  - 278 has been not been initiated, entry is in-progress"
 D PAUSE^VALM1
 Q
 ;
DEL ;EP
 ; Protocol Action to select an entry to be manually removed from the
 ; Response Worklist
 ; Input:   ^TMP("IBTRH5",$J)   - Current Array of displayed entries
 ;          ^TMP($J,"IBTRH5IX") - Current Index of displayed entries
 ; Output:  Selected Entry is removed from the worklist 
 ;          Error messages display (potentially)
 ;          ^TMP("IBTRH5",$J)   - Updated Array of displayed entries
 ;          ^TMP($J,"IBTRH5IX") - Updated Index of displayed entries
 N DIR,DIROUT,DIRUT,DLINE,DTOUT,DUOUT,EIEN,EIENS,ERROR,IEN,IX,LINE,MSG
 N PROMPT,SDATA,DELRCODE,XCOM,COM,DIWETXT
 S VALMBCK="R",ERROR=0
 S VALMSG="#In-Prog"
 ; First select the entry(s) to be removed from the worklist
 S PROMPT="Select the worklist entry(s) to be deleted"
 S MSG="Are you sure you want to delete "
 ; Select the entry to be deleted
 S EIENS=$$SELEVENT^IBTRH1(1,PROMPT,.DLINE,1,"IBTRH5IX")
 I EIENS="" S VALMBCK="R" Q
 ;; 1/19/16 comment out delete reason code entry
 ;; enter a delete reason code
D1 ;;
 ;;S DIC(0)="AEQM",DIC="^IBT(356.023,"
 ;;S DIC("A")="Select a Delete Reason Code: "
 ;;D ^DIC
 ;;I Y<0 Q:X="^"  W !,*7,">>>> A Delete Reason Code must be selected, or '^' to exit." G D1
 ;;S DELRCODE=$P(Y,"^")
 ;; 1/19/16 commented out code above to enter delete reason code
 ;
 Q:'$$ASKSURE^IBTRH1(DLINE,MSG)                 ; Final warning
 F IX=1:1:$L(EIENS,",") D
 . S EIEN=$P(EIENS,",",IX)
 . S LINE=$P(DLINE,",",IX)
 . ; Next update the status to be manually removed
 . I '$$LOCKEV^IBTRH1(EIEN) D  Q
 . . W !,*7,">>>> Someone else is editing entry ",LINE,". Try again later."
 . . S ERROR=1
 . K SDATA
 . S IEN=EIEN_","
 . S SDATA(356.22,IEN,.22)=1             ; Set Response manual remove flag
 . S SDATA(356.22,IEN,.23)=$$NOW^XLFDT() ; Set Manually Removed Date/Time
 . S SDATA(356.22,IEN,.24)=DUZ           ; Set Manually Removed By User
 . ;;S SDATA(356.22,IEN,.25)=DELRCODE      ; Set Delete Reason code pointer
 . I $P(^IBT(356.22,EIEN,0),"^",11)="" S SDATA(356.22,IEN,.11)=DUZ  ; 517-T14: if REQUESTED BY is blank, set it to user deleting
 . D FILE^DIE("","SDATA")
 . D UNLOCKEV^IBTRH1(EIEN)
 K DIR
 Q
 ;
EXIT ;EP
 ; Exit the HCSR Response worklist
 ; Input: None
 K ^TMP("IBTRH5",$J),^TMP($J,"IBTRH5IX"),^TMP($J,"IBTRH5S")
 K HCSRSRTR
 D CLEAR^VALM1
 Q
 ;
SORT(NOIOF) ;EP
 ; Listman Protocol Action to sort the worklist
 ; Input:   NOIOF       - 1 to not write @IOF, 0 otherwise
 ;                        Optional, defaults to 0
 ;          HCSRSRTR    - Current sort selection
 ; Output:  HCSRSRTR    - New sort selection
 N CTR,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,XX,Y
 S:'$D(NOIOF) NOIOF=0
 D FULL^VALM1
 S CTR=1
 W:'NOIOF @IOF
 W !,"Select the item to sort the records on the HCSR Response Worklist screen."
 S XX="SO^"_CTR_":Oldest Entries First",CTR=CTR+1
 S XX=XX_";"_CTR_":Newest Entries First",CTR=CTR+1
 S:+IBFILTSR(0)=2 XX=XX_";"_CTR_":Outpatient Appointments First",CTR=CTR+1
 S:+IBFILTSR(0)=2 XX=XX_";"_CTR_":Inpatient Admissions First",CTR=CTR+1
 S XX=XX_";"_CTR_":Insurance Company Name",CTR=CTR+1
 S XX=XX_";"_CTR_":Certification Type"
 S DIR(0)=XX
 S DIR("A")="Sort the list by",DIR("B")=$P($G(HCSRSRTR),"^",2)
 D ^DIR K DIR
 I 'Y S VALMBCK="R" Q                           ; User quit or timed out
 S HCSRSRTR=Y_"^"_Y(0)                          ; Sort selection
 ; Rebuild and resort the list and update the list header
 D INIT,HDR
 S VALMBCK="R",VALMBG=1
 Q
 ;
SORT1    ; Builds the sorted list of HCSR Responses to be displayed
 ; Input:   HCSRSRTR            - Current sort selection
 ; Output:  ^TMP("IBTRH5S",$J)  - Sorted Event entries to display 
 ; 
 N CSTAT,DISPDT,ECTR,EIEN,EVDT,EVENT,XX
 K ^TMP($J,"IBTRH5S")
 S XX=$P(^IBE(350.9,1,62),"^",12)*-1   ; # of days to display
 S CSTAT=5                             ; Event status for responses
 S DISPDT=$$FMADD^XLFDT(DT,XX)
 S EVDT=DISPDT,ECTR=0
 F  D  Q:EVDT=""
 . S EVDT=$O(^IBT(356.22,"AD",CSTAT,EVDT))
 . Q:EVDT=""
 . S EIEN=""
 . F  D  Q:EIEN=""
 .. S EIEN=$O(^IBT(356.22,"AD",CSTAT,EVDT,EIEN))
 .. Q:EIEN=""
 .. S EVENT=$G(^IBT(356.22,EIEN,0))
 .. Q:$P(EVENT,"^",13)=""        ; Not a Response entry - skip
 .. Q:$P(EVENT,"^",22)=1         ; Manually Removed - skip
 .. Q:$$SKIP(EIEN,EVENT)         ; Entry is filtered out
 .. S ECTR=ECTR+1
 .. I '$D(ZTQUEUED),'(ECTR#15) W "."
 .. D ONEEVENT(CSTAT,EIEN,EVENT) ; Add one event to sort array
 Q
 ;
SKIP(EIEN,EVENT) ; Checks to see if the specified event entry should display on
 ; the list
 ; Input:   EIEN        - IEN of the Event entry
 ;          EVENT       - Node0 of the Event Entry being checked
 ;          IBFILTSR()  - Array of filter settings. See FILTERS for a
 ;                        detailed explanation of the FILTERS array
 ; Returns: 1 - Don't display the entry on the list, 0 - Display entry on list
 N IEN,IORO,SKIP,TRICARE,NOW,XX,ZZ
 S IORO=$P(EVENT,"^",4)                         ; 'I' Inpatient, 'O' Outpatient
 S NOW=$$DT^XLFDT()                             ; Today's Internal Fileman date
 I IORO="I",$P(IBFILTSR(0),"^",1)=0 Q 1         ; Only show outpatients, skip
 I IORO="O",$P(IBFILTSR(0),"^",1)=1 Q 1         ; Only show inpatients, skip
 S TRICARE=$$TRICARE^IBTRH1A(EVENT)             ; Is event for Tricare?
 I $P(IBFILTSR(0),"^",2)=0,TRICARE Q 1          ; Only show CPAC, Skip
 I $P(IBFILTSR(0),"^",2)=1,'TRICARE Q 1         ; Only show Champ/Tricare, Skip
 S SKIP=0
 ; Check Division filter
 I $D(IBFILTSR(3)) D  Q:SKIP 1
 . S XX="^"_IBFILTSR(3)_"^",Y=1
 . S IEN=$P(EVENT,"^",5)                        ; Ward IEN
 . S:IEN="" IEN=$P(EVENT,"^",6),Y=0             ; Clinic IEN
 . I Y S ZZ=$$GET1^DIQ(42,IEN_",",.015,"I")
 . E  S ZZ=$$GET1^DIQ(44,IEN_",",3.5,"I")
 . S ZZ="^"_ZZ_"^"
 . I XX'[ZZ S SKIP=1                            ; Wrong division
 ; Check Inpatient entry
 I IORO="I" D  Q:SKIP 1
 . Q:$G(IBFILTSR(2))=""                         ; No Ward filters display
 . S IEN=$P(EVENT,"^",5)                        ; Ward IEN
 . S XX="^"_IBFILTSR(2)_"^"
 . Q:XX[("^"_IEN_"^")                           ; On inclusion list display
 . S SKIP=1                                     ; Not on inclusion list skip
 ; Check Outpatient entry
 I IORO="O" D  Q:SKIP 1
 . Q:$G(IBFILTSR(1))=""                         ; No Clinic filters display
 . S IEN=$P(EVENT,"^",6)                        ; Clinic IEN
 . S XX="^"_IBFILTSR(1)_"^"
 . Q:XX[("^"_IEN_"^")                           ; On inclusion list display
 . S SKIP=1
 Q 0                                            ; Display this entry
 ;
ONEEVENT(CSTAT,EIEN,EVENT)  ; Adds one event to the sorted list
 ; Input:   HCSRSORT            - Current sort selection
 ;          CSTAT               - Status of the event to be added
 ;          EIEN                - Internal IEN of the event being added
 ;          EVENT               - ^IBT(356.22,EIEN,0)
 ; Output:  ^TMP("IBTRH5S",$J)  - Sorted Event entries to display 
 N ADATE,CERTCDE,DFN,ESTATUS,HS1,HS2,HS3,ICOB,IENS,IGROUP,IIEN,INAME,ISTATUS
 N LINE,PNAME,RFLG,IMIEN
 S (INAME,LINE)=""
 ; Symbol to display in front of the patient name (if any)
 S RFLG=$S($$GET1^DIQ(356.22,EIEN_",",.21,"I")=1:"#",1:" ")
 S DFN=$P(EVENT,"^",2),PNAME=""                 ; Patient IEN
 S ESTATUS=$P(EVENT,"^",4)                      ; Patient Status
 S $P(LINE,"^",2)=ESTATUS
 S ADATE=$P(EVENT,"^",7)                        ; Internal Appt/Adm Date/Tm
 S $P(LINE,"^",3)=$$FMTE^XLFDT(ADATE,"2DZ")
 S ISTATUS=1
 I ESTATUS="O",+HCSRSRTR=3 S ISTATUS=0           ; Appointment sort
 I ESTATUS="I",+HCSRSRTR=4 S ISTATUS=0           ; Admissions sort
 S $P(LINE,"^",1)=$$PNAME^IBTRH1A(DFN,RFLG,.PNAME) ; Set 'PAT NAME' column
 S $P(LINE,"^",4)=$$PATLOC^IBTRH1A(EVENT)        ; Ward or Clinic
 S IMIEN=$P(EVENT,"^",3),IENS=IMIEN_","_DFN_"," ; Insurance Multiple IEN
 S IIEN=$$GET1^DIQ(2.312,IENS,.01,"I")          ; Insurance Company IEN
 S IGROUP=$$GET1^DIQ(2.312,IENS,.18,"I")        ; Insurance Group IEN
 S:+IIEN INAME=$$GET1^DIQ(36,IIEN_",",.01)      ; Insurance Company Name
 S:INAME="" INAME="**DELETED**"
 S ICOB=$$GET1^DIQ(2.312,IENS,.2,"I")           ; Level of COB External Display
 S:ICOB="" ICOB=1
 S $P(LINE,"^",5)=$S(ICOB=1:"P",ICOB=2:"S",1:"T") ; Level of COB External Display
 S CERTCDE=$$GET1^DIQ(356.22,EIEN_",",103.01)
 S $P(LINE,"^",6)=$E(INAME,1,14)
 I +HCSRSRTR=1 S HS1=ADATE,HS2=PNAME,HS3=ICOB    ; Oldest event first
 I +HCSRSRTR=2 S HS1=ADATE*-1,HS2=PNAME,HS3=ICOB ; Newest event first
 I +HCSRSRTR=3 S HS1=ISTATUS,HS2=PNAME,HS3=ICOB  ; Appointments first
 I +HCSRSRTR=4 S HS1=ISTATUS,HS2=PNAME,HS3=ICOB  ; Admissions sort
 I +HCSRSRTR=5 D                                 ; Insurance name sort
 . S HS1=$$UP^XLFSTR(INAME),HS2=PNAME,HS3=ICOB
 I +HCSRSRTR=6 S HS1=CERTCDE,HS2=PNAME,HS3=ADATE ; Certification Action sort
 S $P(LINE,"^",7)=CERTCDE
 S ^TMP($J,"IBTRH5S",HS1,HS2,HS3,EIEN)=LINE
 Q
 ;
SELEVENT(FULL,PROMPT,DLINE)    ;EP
 ; Select an Event to perform an action upon
 ; upon
 ; Input:   FULL                - 1 - full screen mode, 0 otherwise
 ;          PROMPT              - Prompt to be displayed to the user
 ;          ^TMP("IBTRH5",$J)   - Array of displayed events
 ;          ^TMP($J,"IBTRH5IX") - Index of displayed lines
 ; Output:  DLINE               - Line # of the selected event
 ; Returns: EIN                 - IEN of the selected event or 
 ;                                0 if none selected
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,EIEN,X,Y
 D:FULL FULL^VALM1
 S DLINE=$P($P($G(XQORNOD(0)),"^",4),"=",2)     ; User selection with action
 I $D(^TMP($J,"IBTRH5IX",+DLINE)) D  Q EIEN
 . S EIEN=^TMP($J,"IBTRH5IX",DLINE)
 S DIR(0)="NO^"_VALMBG_":"_VALMLST_":0"         ; Select an event from screen
 S DIR("A")=PROMPT
 D ^DIR K DIR
 Q:'Y 0
 S DLINE=Y,EIEN=^TMP($J,"IBTRH5IX",DLINE)
 Q EIEN
 ;
REFRESH ;EP
 ; Protocol action to search for new Responses, reset filter
 ; and redisplay the HCSR Response Worklist
 ; Input:   HCSSORTR            - Current sort selection
 ; Output:  IBFILTSR()          - Array of filter criteria
 ;                                NOTE: Any modifications done to these filters
 ;                                      are not returned back to HCSR Worklist.
 ;          ^TMP("IBTRH5",$J)   - Body lines to display
 ;          ^TMP($J,"IBTRH5S")  - Sorted Body lines to display
 ;          ^TMP($J,"IBTRH5IX") - Index of Event IENs by display line
 ;
 ; First check to see if we can create more event entries
 D FULL^VALM1
 S VALMBCK="R"
 Q:'$$FILTERS^IBTRH1A(.IBFILTSR)                ; Reset Filter criteria
 D SORT(1)
 ;;3/21/16 JWS don't need to D HDR,INIT - already done in SORT(1) above
 ;D HDR                                          ; Redisplay the header
 ;D INIT                                         ; Rebuild the worklist
 Q
 ;
SEND278(EIEN) ;EP
 ; Protocol action to create a new 278 request from a response. Copies the
 ; Request data from the response's original request and then allows the
 ; user to edit it before sending the request
 ; Input:   EIEN    - IEN of the Response Entry to create a new worklist
 ;                    entry from. Optional, only set when called from
 ;                    Protocol IBT HCSR RESPONSE EE SEND278 - SR from
 ;                    the EE action off of the Response Worklist.
 N DLINE,IBTRENT,IBTRIEN,PROMPT,REIEN,SEIEN,IBRESP
 S SEIEN=$S($D(EIEN):EIEN,1:"")
 ; 
 ; First select the entry to create a request for from the worklist
 S PROMPT="Select the worklist entry"
 S:SEIEN="" SEIEN=$$SELEVENT^IBTRH1(1,PROMPT,.DLINE,0,"IBTRH5IX")
 I SEIEN="" S VALMBCK="R" Q
 ; do not allow multiple 278s to be created from the same response
 I $P(^IBT(356.22,SEIEN,0),"^",27) D  Q
 . W !,*7,">>>> A 278 request has already been created from this response message."
 . D PAUSE^VALM1
 ;
 ; Next Lock the response entry 
 I '$$LOCKEV^IBTRH1(SEIEN) D  Q
 . W !,*7,">>>> Someone else is editing this entry. Try again later."
 . D PAUSE^VALM1
 ; Copy the request
 S REIEN=$P(^IBT(356.22,SEIEN,0),"^",13)            ; Original Request entry
 S IBTRIEN=$$CRTENTRY^IBTRH5C(REIEN,SEIEN,"","",1)  ; Copy the original request
 D UNLOCKEV^IBTRH1(SEIEN)                           ; Unlock the response entry
 Q:IBTRIEN=0                                        ; Copy was unsuccessful
 ; Next Lock the new request entry 
 I '$$LOCKEV^IBTRH1(IBTRIEN) D  Q
 . W !,*7,">>>> Someone else is editing entry. Try again later."
 . D PAUSE^VALM1
 S IBTRENT=2                                    ; Flag to indicate origin from here
 D SEND278^IBTRH2                               ; Create and Send the request
 D UNLOCKEV^IBTRH1(IBTRIEN)                     ; Unlock the request entry
 W !,"A new HCSR Worklist entry has been created for Response."
 D PAUSE^VALM1
 Q
 ;
DELAY ;EP
 ; Protocol action to create a new request from the response but delay its
 ; viewing on the HCSR Worklist until admission of the entry has been 
 ; discharged.
 ; Input:   ^TMP("IBTRH5",$J)   - Current Array of displayed entries
 ;          ^TMP($J,"IBTRH5IX") - Current Index of displayed entries
 ; Output:  A new Request is created from the Selected Entry (potentially)
 N DDATE,DIR,DIROUT,DIRUT,DLINE,DTOUT,DUOUT,EIEN,EIENS,FIELD,GOOD
 N IX,LINE,MSG,PROMPT,REIEN,SDATA
 S VALMBCK="R",GOOD=0
 S MSG="Are you sure you want to delay "
 S PROMPT="Select the worklist entry(s) to be delayed"
 ; First select the entry(s) to be delay review from the worklist
 S EIENS=$$SELEVENT^IBTRH1(1,PROMPT,.DLINE,1,"IBTRH5IX")
 I EIENS="" S VALMBCK="R" Q
 S DDATE=$$GETDDATE^IBTRH1B(DLINE)              ; Get delay date
 Q:DDATE=""
 S MSG=MSG_$S(DLINE[",":"Entries ",1:"Entry ")_DLINE_" until "
 S MSG=MSG_$S(DDATE="D":"Discharge",1:$$FMTE^XLFDT(DDATE,"2Z"))
 Q:'$$ASKSURE^IBTRH1(DLINE,MSG,1)               ; Final warning
 F IX=1:1:$L(EIENS,",") D
 . S EIEN=$P(EIENS,",",IX)
 . S LINE=$P(DLINE,",",IX)
 . ; do not allow multiple 278s to be created from the same response
 . I $P(^IBT(356.22,EIEN,0),"^",27) D  Q
 .. W !,*7,">>>> A 278 request has already been created from this response message."
 . ; Only allow delay of events for Inpatients
 . I $P(^IBT(356.22,EIEN,0),"^",4)="O" D  Q
 .. W !,*7,">>>> Entry ",LINE," is for an Outpatient and cannot be delayed"
 . ; Next set the delay date of the entry
 . I '$$LOCKEV^IBTRH1(EIEN) D  Q
 .. W !,*7,">>>> Someone else is editing entry ",LINE,". Try again later."
 . ; Copy the request
 . S GOOD=1
 . S REIEN=$P(^IBT(356.22,EIEN,0),"^",13)                 ; Original Request entry
 . S IBTRIEN=$$CRTENTRY^IBTRH5C(EIEN,REIEN,"","",1,DDATE) ; Copy original request
 . D UNLOCKEV^IBTRH1(EIEN)
 K DIR
 I GOOD D
 . W !!,$S(DLINE[",":"Entries ",1:"Entry ")_DLINE
 . W $S(DLINE[",":" have_",1:" has ")_"been delayed"
 D PAUSE^VALM1
 Q
 ;
