IBTRH1A ;ALB/FA - HCSR Worklist ;12-AUG-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ;
 ; Contains Entry points and functions used in filtering/displaying the 
 ; HCSR Worklist
 ;
 ; --------------------------   Entry Points   --------------------------------
 ;    FILTERS   - Used to set filtering criteria for what entries should be
 ;                displayed in the worklist
 ;    PATLOC    - Formats the Clinic or Ward name for display on the HCSR 
 ;                Worklist and the HCSR Response Worklist
 ;    PNAME     - Formats the patient name for display on the HCSR Worklist
 ;                and the HCSR Response Worklist
 ;    REFRESH   - Protocol action that allows the user to check for recent
 ;                appointments and admissions, re-select filter options and
 ;                redisplays the HCSR Worklist
 ;    SORT1     - Used to sort the entries in the worklist per user selected
 ;                option
 ;-----------------------------------------------------------------------------
 ;
REFRESH ;EP
 ; Protocol action to search for new appointments/admission, reset filter
 ; and redisplay the HCSR Worklist
 ; Input:   HCSSORT             - Current sort selection
 ; Output:  IBFILTS()           - Array of filter criteria
 ;          ^TMP("IBTRH1",$J)   - Body lines to display
 ;          ^TMP($J,"IBTRH1S")  - Sorted Body lines to display
 ;          ^TMP($J,"IBTRH1IX") - Index of Event IENs by display line
 ;
 ; First check to see if we can create more event entries
 ;;D EN^IBTRHDE(1)   ;JWS 3/21/16 - remove this.  don't want to create more entries this way
 D VALMSGH^IBTRH1                               ; Set flag legend
 D FULL^VALM1
 S VALMBCK="R"
 Q:'$$FILTERS(.IBFILTS)                         ; Reset Filter criteria
 D CLEAN^VALM10
 S VALMBG=1
 D SORT^IBTRH1(2)                               ; Sort the entries
 D INIT^IBTRH1                                  ; Rebuild the worklist
 D HDR^IBTRH1                                   ; Redisplay the header
 Q
 ;
FILTERS(FILTERS)    ;EP
 ; Sets an array of filters to determine which entries in HCSR Transmission
 ; file should be displayed to the user
 ; Input:   None
 ; Output:  FILTERS(0)  - A1^A2 Where:
 ;                          A1 - 0 - 'Output' entries only
 ;                               1 - 'Input' entries only
 ;                               2 - Both Output and Input entries
 ;                          A2 - O - CPAC entries only
 ;                               1 - Champva/Tricare entries only
 ;                               2 - Both CPAC and Champva/Tricare entries
 ;                          A3 - 0 - No Division filter
 ;                               1 - Selected Division filter
 ;          FILTERS(1)  - '^' delimited list of included Clinic IENs
 ;                        Null if all clinics are included
 ;                        Only set if FILTERS(0)= 0 OR 2
 ;          FILTERS(2)  - '^' delimited list of included WARD IENs
 ;                        Null if all wards are included
 ;                        Only set if FILTERS(0)= 1 OR 2
 ;          FILTERS(3)  - '^' delimited list of included Division IENs
 ;                        Null if all Divisions are included
 ; Returns: 0 if the user entered '^' or timed out, 1 otherwise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,XX,Y
 K FILTERS
 ;
 ; ChampVA/Tricare filter
 S DIR(0)="S",DIR("A")="Show CHAMPVA/TRICARE entries, CPAC entries or Both",DIR("B")="B"
 S DIR("?",1)="Enter 'T' to only view entries created for CHAMPVA/TRICARE"
 S DIR("?",2)="Enter 'C' to only view entries created for CPAC"
 S DIR("?")="Enter 'B' to view entries both CHAMPVA/TRICARE and CPAC entries"
 S $P(DIR(0),"^",2)="T:CHAMPVA/TRICARE;C:CPAC;B:Both"
 W !! D ^DIR K DIR
 I $G(DIRUT) Q 0
 ;
 ; Inpatient/Outpatient filter
 S X=$$UP^XLFSTR(X)
 S $P(FILTERS(0),"^",2)=$S(X="C":0,X="T":1,1:2)
 S DIR(0)="S",DIR("A")="Show Inpatient entries, Outpatient entries or Both",DIR("B")="B"
 S DIR("?",1)="Enter 'I' to only view entries created for inpatients"
 S DIR("?",2)="Enter 'O' to only view entries created for outpatients"
 S DIR("?")="Enter 'B' to view entries both inpatient and outpatient entries"
 S $P(DIR(0),"^",2)="O:Outpatient;I:Inpatient;B:Both"
 W ! D ^DIR K DIR
 I $G(DIRUT) Q 0
 S X=$$UP^XLFSTR(X)
 S $P(FILTERS(0),"^",1)=$S(X="O":0,X="I":1,1:2)
 ;
 ; Division filter
 S X=$$UP^XLFSTR(X)
 S $P(FILTERS(0),"^",3)=$S(X="A":0,1:1)
 S DIR(0)="S",DIR("A")="Select(A)ll or (S)elected Divisions",DIR("B")="All"
 S DIR("?",1)="Enter 'A' to not filter by division."
 S DIR("?")="Enter 'S' to view entries for selected division(s)."
 S $P(DIR(0),"^",2)="A:All;S:Selected"
 W ! D ^DIR K DIR
 I $G(DIRUT) Q 0
 S X=$$UP^XLFSTR(X)
 S $P(FILTERS(0),"^",3)=$S(Y="A":0,1:1)
 ;
 ; Set Division inclusion filter
 I $P(FILTERS(0),"^",3)=1 D ASKDIV(.FILTERS)
 ;
 ; Set Ward inclusion filter
 I $P(FILTERS(0),"^",1)>0 D ASKWORC(0,.FILTERS)
 ;
 ; Set Clinic inclusion filter
 I ($P(FILTERS(0),"^",1)=0)!($P(FILTERS(0),"^",1)=2) D ASKWORC(1,.FILTERS)
 ;
 ; If any Division, Clinic or Ward inclusion filters were set, display the final results
 I ($G(FILTERS(1))'="")!($G(FILTERS(2))'="")!($G(FILTERS(3))'="") D
 . D SHOWFILT^IBTRH1B(.FILTERS)
 Q 1
 ;
ASKDIV(FILTERS)   ; Sets a list of Division to be displayed in the HSCR Worklist
 ; Input:   FILTERS - Current Array of filter settings
 ; Output:  FILTERS - Updated Array of filter settings
 N DIC,DIR,DIRUT,DIVS,DUOUT,FIRST,IBIENS,IBIENS2,IEN,N,X,XX,Y
 S DIC=40.8,DIC(0)="AE",FIRST=1
 F  D  Q:+IEN<1
 . D ONEDIV(.DIC,.IEN,.FIRST)                   ; One Division prompt
 . Q:+IEN<1
 . S IBIENS($P(IEN,"^",2))=$P(IEN,"^",1)
 . S IBIENS2($P(IEN,"^",1))=$P(IEN,"^",2)
 I '$D(IBIENS) S $P(FILTERS(0),"^",3)=0 Q
 ;
 ; Set the filter node responses in alphabetical order
 S XX=""
 F  D  Q:XX=""
 . S XX=$O(IBIENS(XX))
 . Q:XX=""
 . S N=IBIENS(XX)
 . S FILTERS(3)=$S($G(FILTERS(3))'="":FILTERS(3)_"^"_N,1:N)
 Q
 ;
ONEDIV(DIC,IEN,FIRST)  ; Prompts the user for a division
 ; Input:   DIC     - Variable/Array of settings needed for ^DIC call
 ;          FIRST   - Set to 1 initially and then 0 for subsequent calls
 ; Output:  FIRST   - Set to 0
 ;          IEN     - IEN of the selected Division
 ;                    null of no selection was made
 S DIC("A")=$S(FIRST:"Select a Division: ",1:"Select Another Division: ")
 D ^DIC
 S FIRST=0,IEN=Y
 Q
 ;
ASKWORC(WHICH,FILTERS)   ; Sets a list of wards or clinics to be displayed in
 ; the HCSR Worklist
 ; Input:   WHICH   - 0 Ward selection, 1 - Clinic Selection
 ;          FILTERS - Current Array of filter settings
 ; Output:  FILTERS - Updated Array of filter settings
 N CLINS,DIC,DIR,DIRUT,DIVS,DUOUT,FIRST,IBIENS,IBIENS2,IEN,N,NM,NODE,WARDS,X,XX,Y
 S DIC=$S(WHICH=0:42,1:44),DIC(0)="AE",FIRST=1
 S NODE=$S(WHICH=0:2,1:1)
 F N=1:1:$L($G(FILTERS(3)),"^") D 
 . S XX=$P($G(FILTERS(3)),"^",N)
 . Q:XX=""
 . S DIVS(XX)=""
 ;
 I WHICH=0 D
 . S N=0,NM="Ward"
 . F  D  Q:+N=0
 . . S N=$O(^IBE(350.9,1,64,N))
 . . Q:+N=0
 . . S IEN=$P(^IBE(350.9,1,64,N,0),"^",1)
 . . S WARDS(IEN)=""
 . I $D(WARDS)!$D(FILTERS(3)) D
 . . S DIC("S")="I $$WCFILT^IBTRH1A(1,Y,.DIVS,"""",.WARDS)"
 I WHICH=1 D
 . S N=0,NM="Clinic"
 . F  D  Q:+N=0
 . . S N=$O(^IBE(350.9,1,63,N))
 . . Q:+N=0
 . . S IEN=$P(^IBE(350.9,1,63,N,0),"^",1)
 . . S CLINS(IEN)=""
 . I $D(CLINS)!$D(FILTERS(3)) D
 . . S DIC("S")="I $$WCFILT^IBTRH1A(0,Y,.DIVS,.CLINS,"""")"
 F  D  Q:+IEN<1
 . D ONEWORC(.DIC,NM,.IEN,.FIRST)               ; One Clinic or Ward prompt
 . Q:+IEN<1
 . S IBIENS($P(IEN,"^",2))=$P(IEN,"^",1)
 . S IBIENS2($P(IEN,"^",1))=$P(IEN,"^",2)
 I '$D(IBIENS) S FILTERS(NODE)="" Q
 ;
 ; Set the filter node responses in alphabetical order
 S XX=""
 F  D  Q:XX=""
 . S XX=$O(IBIENS(XX))
 . Q:XX=""
 . S N=IBIENS(XX)
 . S FILTERS(NODE)=$S($G(FILTERS(NODE))'="":FILTERS(NODE)_"^"_N,1:N)
 Q
 ;
ONEWORC(DIC,WHICH,IEN,FIRST)  ; Prompts the user for a clinic or ward
 ; Input:   DIC     - Variable/Array of settings needed for ^DIC call
 ;          WHICH   - 'Ward' or 'Clinic'
 ;          FIRST   - Set to 1 initially and then 0 for subsequent calls
 ; Output:  FIRST   - Set to 0
 ;          IEN     - IEN of the selected Ward or clinic Entry
 ;                    null of no selection was made
 S DIC("A")=$S(FIRST:"Select "_WHICH_": ",1:"Select Another "_WHICH_": ")
 D ^DIC
 S FIRST=0,IEN=Y
 Q
 ;
WCFILT(WHICH,IEN,DIVS,CLINS,WARDS)   ; Used as a dictionary screen when doing
 ; Clinic or Ward inclusion filter lookups.
 ; Input:   WHICH   - 0 - Clinic Lookup
 ;                    1 - Ward lookup
 ;          IEN     - IEN of the Clinic or Ward being looked up
 ;          DIVS    - Array of Included Divisions (if any)
 ;          CLINS   - Array of Site Parameter included Clinics (if any)
 ;          WARDS   - Array of Site Parameter included Wards (if any) 
 ; Returns: 1 - Clinic or Ward is valid, 0 otherwise
 N IDIVS,RETURN,SDIV
 S IDIVS=$S($O(DIVS(""))'="":1,1:0)
 S RETURN=1
 ;
 ; Clinic filter check
 I WHICH=0 D  Q RETURN
 . I $D(CLINS),'$D(CLINS(IEN)) S RETURN=0 Q     ; Not on Site param inc list
 . ;
 . ; If we have included divisions make sure clinic is for the division
 . I IDIVS D  Q
 . . S SDIV=$$GET1^DIQ(44,IEN_",",3.5,"I")      ; Division of the Clinic
 . . Q:SDIV=""
 . . S:'$D(DIVS(SDIV)) RETURN=0                 ; Division not in list
 ;
 ; Ward filter check
 I $D(WARDS),'$D(WARDS(IEN)) Q 0                ; On Site param exclusion list
 ;
 ; If we have included divisions make sure ward is for the division
 I IDIVS D
 . S SDIV=$$GET1^DIQ(42,IEN_",",.015,"I")       ; Division of the Ward
 . Q:SDIV=""
 . S:'$D(DIVS(SDIV)) RETURN=0                   ; Division not in list
 Q RETURN
 ;
SORT1    ;EP
 ; Builds the sorted list of HCSR entries to be displayed on the HCSR Worklist
 ; Input:   HCSRSORT            - Current sort selection
 ;          IBFILTS()           - Array of filter settings. See FILTERS for a
 ;                                detailed explanation of the FILTERS array
 ; Output:  ^TMP("IBTRH1S",$J)  - Sorted Event Entries to display 
 ; 
 N DFN,CSTAT,ECTR,EIEN,EVDT,EVENT
 K ^TMP($J,"IBTRH1S")
 S ECTR=0
 ;
 ; Loop through all the statuses that are shown on the worklist
 F CSTAT=0,1,2,3,4,7,8 D
 . S EVDT=""
 . F  D  Q:EVDT=""
 . . S EVDT=$O(^IBT(356.22,"AD",CSTAT,EVDT))
 . . Q:EVDT=""
 . . S EIEN=""
 . . F  D  Q:EIEN=""
 . . . S EIEN=$O(^IBT(356.22,"AD",CSTAT,EVDT,EIEN))
 . . . Q:EIEN=""
 . . . S EVENT=$G(^IBT(356.22,EIEN,0))
 . . . Q:$P(EVENT,"^",13)'=""                   ; Response entry - skip
 . . . Q:$$SKIP(EVENT)                          ; Entry is filtered out
 . . . S ECTR=ECTR+1
 . . . I '$D(ZTQUEUED),'(ECTR#15) W "."
 . . . D ONEEVENT(CSTAT,EIEN,EVENT)             ; Add one event to sort array
 Q
 ;
SKIP(EVENT) ; Checks to see if the specified event entry should display on the
 ; list
 ; Input:   EVENT       - Event Entry being checked
 ;          IBFILTS()   - Array of filter settings. See FILTERS for a
 ;                        detailed explanation of the FILTERS array
 ; Returns: 1 - Don't display the entry on the list, 0 - Display entry on list
 N DELAY,IEN,IORO,SKIP,TRICARE,NOW,XX,YY,ZZ
 I $P(EVENT,"^",19)=1 Q 1                       ; Skip if a 215 was triggered
 S IORO=$P(EVENT,"^",4)                         ; 'I' Inpatient, 'O' Outpatient
 S NOW=$$DT^XLFDT()                             ; Today's Internal Fileman date
 S DELAY=0
 S:+$P(EVENT,"^",8)=8 DELAY=$P(EVENT,"^",17)    ; Delay Date (if any)
 I IORO="I",$P(IBFILTS(0),"^",1)=0 Q 1          ; Only show outpatients, skip
 I IORO="O",$P(IBFILTS(0),"^",1)=1 Q 1          ; Only show inpatients, skip
 S TRICARE=$$TRICARE(EVENT)                     ; Is event for Tricare?
 I $P(IBFILTS(0),"^",2)=0,TRICARE Q 1           ; Only show CPAC, Skip
 I $P(IBFILTS(0),"^",2)=1,'TRICARE Q 1          ; Only show Champ/Tricare, Skip
 S SKIP=0
 ;
 ; Check Division filter
 I $D(IBFILTS(3)) D  Q:SKIP 1
 . S XX="^"_IBFILTS(3)_"^",Y=1
 . S IEN=$P(EVENT,"^",5)                        ; Ward IEN
 . S:IEN="" IEN=$P(EVENT,"^",6),Y=0             ; Clinic IEN
 . I Y S ZZ=$$GET1^DIQ(42,IEN_",",.015,"I")
 . E  S ZZ=$$GET1^DIQ(44,IEN_",",3.5,"I")
 . S ZZ="^"_ZZ_"^"
 . I XX'[ZZ S SKIP=1                            ; Wrong division
 ;
 ; Check Inpatient entry
 I IORO="I" D  Q:SKIP 1
 . Q:$G(IBFILTS(2))=""                          ; No Ward filters display
 . S IEN=$P(EVENT,"^",5)                        ; Ward IEN
 . S XX="^"_IBFILTS(2)_"^"
 . Q:XX[("^"_IEN_"^")                           ; On inclusion list display
 . S SKIP=1                                     ; Not on inclusion list skip
 ;
 ; Check Outpatient entry
 I IORO="O" D  Q:SKIP 1
 . Q:$G(IBFILTS(1))=""                          ; No Clinic filters display
 . S IEN=$P(EVENT,"^",6)                        ; Clinic IEN
 . S XX="^"_IBFILTS(1)_"^"
 . Q:XX[("^"_IEN_"^")                           ; On inclusion list display
 . S SKIP=1
 ;
 ; Skip entries that haven't reached their delay date yet
 I DELAY D  Q:SKIP 1
 . I DELAY'="D" D  Q
 . . S:DELAY>NOW SKIP=1                         ; Delay date not met, skip
 . S:'$$DISCH(EVENT) SKIP=1                     ; Not Discharge yet, skip
 Q 0                                            ; Display this entry
 ;
TRICARE(EVENT)  ;EP
 ; Checks to see if the entry is for a ChampVA/Tricare insurance
 ; Input:   EVENT   - Node 0 of the Event Entry being checked
 ; Returns: 1 if the entry is for ChampVA/Tricare Insurance, 0 otherwise
 N COVTYPE,DFN,IENS,IIEN,IMIEN,INSNAME,GRPLAN,GRPLANTP
 S DFN=$P(EVENT,U,2)                                    ; Patient IEN
 S IMIEN=$P(EVENT,U,3),IENS=IMIEN_","_DFN_","           ; Insurance Multiple IEN
 S IIEN=$$GET1^DIQ(2.312,IENS,.01,"I")                  ; Insurance Company IEN
 S GRPLAN=$$GET1^DIQ(2.312,IENS,.18,"I")   ;GROUP PLAN 355.3 PTR
 S GRPLANTP=$$GET1^DIQ(355.3,GRPLAN_",",.09)
 S COVTYPE=$$UP^XLFSTR($$GET1^DIQ(36,IIEN_",",.13,"E")) ; Type of Coverage (36/.13)
 S INSNAME=$$UP^XLFSTR($$GET1^DIQ(36,IIEN_",",.01))     ; Insurance Company Name
 S TRICARE=0
 S:(COVTYPE["TRICARE")!(COVTYPE["CHAMPVA")!(INSNAME["TRICARE")!(INSNAME["CHAMPVA")!(GRPLANTP["CHAMPVA")!(GRPLANTP["TRICARE") TRICARE=1
 Q TRICARE
 ;
DISCH(EVENT) ; Checks to see if the admission of the entry has been discharged
 ; Input:   EVENT   - Node 0 of the Event Entry being checked
 ; Returns: 1 if the admission has been discharged, 0 otherwise
 N ADATE,DA,DFN,DT,FOUND,IADATE,REC
 S DFN=$P(EVENT,"^",2)                          ; DFN of the patient
 S ADATE=$P(EVENT,"^",7)                        ; Internal Admit date
 I ADATE["-" Q 0                                ; Admission is already discharged
 S IADATE=9999999.9999999-ADATE
 S DA=$O(^DGPM("ATID1",DFN,IADATE,""))          ; DBIA419
 Q:DA="" -1                                     ; No Patient Movement admission record
 I $$GET1^DIQ(405,DA_",",.17,"I")'="" Q 1       ; Patient has been discharged
 Q 0                                            ; Admission is still active
 ;
ONEEVENT(CSTAT,EIEN,EVENT)  ; Adds one event to the sorted list
 ; Input:   HCSRSORT            - Current sort selection
 ;          CSTAT               - Status of the event to be added
 ;          EIEN                - Internal IEN of the event being added
 ;          EVENT               - ^IBT(356.22,EIEN,0)
 ; Output:  ^TMP("IBTRH1S",$J)  - Sorted Event entries to display 
 N ADATE,DFN,ESTATUS,HS1,HS2,HS3,ICOB,IENS,IGROUP,IIEN,IMIEN,INAME,ISTATUS
 N LINE,PCREQ,PNAME,RFLG,URREQ,XX
 S (INAME,LINE,PCREQ,URREQ)=""
 ;
 ; Symbol to display in front of the patient name (if any)
 S RFLG=$S(CSTAT=1:"#",CSTAT=2:"?",CSTAT=3:"!",CSTAT=4:"-",CSTAT=7:"+",CSTAT=8:"*",1:" ")
 S DFN=$P(EVENT,"^",2),PNAME=""                 ; Patient IEN
 S ESTATUS=$P(EVENT,"^",4)                      ; Patient Status 'I' or 'O'
 S $P(LINE,"^",2)=ESTATUS
 S ADATE=$P($P(EVENT,"^",7),"-",1)              ; Internal Appt/Adm Date/Tm
 S $P(LINE,"^",3)=$$FMTE^XLFDT(ADATE,"2DZ")
 S ISTATUS=1
 I ESTATUS="O",+HCSRSORT=3 S ISTATUS=0          ; Appointment sort
 I ESTATUS="I",+HCSRSORT=4 S ISTATUS=0          ; Admissions sort
 S $P(LINE,"^",1)=$$PNAME(DFN,RFLG,.PNAME)      ; Set 'PAT NAME' column
 S $P(LINE,"^",4)=$$PATLOC(EVENT)               ; Ward or Clinic
 S IMIEN=$P(EVENT,"^",3),IENS=IMIEN_","_DFN_"," ; Insurance Multiple IEN
 S IIEN=$$GET1^DIQ(2.312,IENS,.01,"I")          ; Insurance Company IEN
 S IGROUP=$$GET1^DIQ(2.312,IENS,.18,"I")        ; Insurance Group IEN
 S:+IIEN INAME=$$GET1^DIQ(36,IIEN_",",.01)      ; Insurance Company Name
 S:INAME="" INAME="**DELETED**"
 S ICOB=$$GET1^DIQ(2.312,IENS,.2,"I")           ; Level of COB External Display
 S:ICOB="" ICOB=1
 S $P(LINE,"^",5)=$S(ICOB=1:"P",ICOB=2:"S",1:"T") ; Level of COB External Display
 S $P(LINE,"^",6)=$E(INAME,1,14)
 ;
 I +HCSRSORT=1 S HS1=ADATE,HS2=PNAME,HS3=ICOB       ; Oldest event first
 I +HCSRSORT=2 S HS1=ADATE*-1,HS2=PNAME,HS3=ICOB    ; Newest event first
 I +HCSRSORT=3 S HS1=ISTATUS,HS2=PNAME,HS3=ICOB     ; Appointments first
 I +HCSRSORT=4 S HS1=ISTATUS,HS2=PNAME,HS3=ICOB     ; Admissions sort
 I +HCSRSORT=5 D                                    ; Insurance name sort
 . S HS1=$$UP^XLFSTR(INAME),HS2=PNAME,HS3=ICOB
 S XX=$P($G(^IBA(355.3,+IGROUP,0)),"^",6)       ; Pre-Certification Req
 S PCREQ=$S(XX=1:"Y",XX=0:"N",1:"")
 S XX=$P($G(^IBA(355.3,+IGROUP,0)),"^",5)       ; Utilization Review Req 
 S URREQ=$S(XX=1:"Y",XX=0:"N",1:"")
 S $P(LINE,"^",7)=URREQ
 S $P(LINE,"^",8)=PCREQ
 S $P(LINE,"^",9)=$$GETSCR(DFN)                 ; Service Connected Reasons
 S ^TMP($J,"IBTRH1S",HS1,HS2,HS3,EIEN)=LINE
 Q
 ;
PNAME(DFN,RFLG,PNAME) ;EP
 ; Format the patient name column for display in the worklist
 ; Input:   DFN     - Internal IEN of the patient
 ;          RFLG    - Symbol to display in front of the name (if any)
 ; Output:  PNAME   - $P(^DPT(DFN,0),"^",1)
 ; Returns: Formatted patient name
 N PNM,SSN4
 Q:+DFN=0 ""
 S PNAME=$$GET1^DIQ(2,DFN_",",.01)              ; Patient Name
 S PNM=RFLG_PNAME,PNM=$E(PNM,1,18)
 S:$L(PNM)<18 PNM=PNM_$J("",18-$L(PNM))
 S SSN4=$E($$GET1^DIQ(2,DFN_",",.09),6,9)       ; Last 4 of SSN
 Q PNM_" "_SSN4
 ;
PATLOC(EVENT) ;EP
 ; Returns the Clinic or Ward associated with the event
 ; Input:   EVENT   - ^IBT(356.22,EIEN,0)
 ; Returns: Formatted Clinic or location name
 N ELOC
 S ELOC=$P(EVENT,"^",5)
 I ELOC'="" D                                   ; Ward Name 
 . S ELOC=$$GET1^DIQ(42,ELOC_",",.01)
 E  D                                           ; Clinic Name
 . S ELOC=$P(EVENT,"^",6)
 . S:ELOC'="" ELOC=$$GET1^DIQ(44,ELOC_",",.01)
 Q $E(ELOC,1,10)
 ;
GETSCR(DFN) ; Retrieves all of the services connected reasons to be displayed
 ; Input:   DFN     - Internal IEN of the patient of the event
 ; Returns: SCR     - String of Service Connected reasons to be displayed
 N DGNTARR,SCR,VAERR,VASV,XX
 S SCR=""
 ; DBIA #10061
 D SVC^VADPT I 'VAERR D
 .I VASV(2) S SCR="A"       ; Agent Orange Exposure
 .I VASV(3) S SCR=SCR_"I"   ; Ionizing Radiation
 .I VASV(1) S SCR=SCR_"S"   ; Southwest Asia
 .I VASV(5) S SCR=SCR_"C"   ; Combat Veteran
 .I $G(VASV(15)) S SCR=SCR_"L"  ; Camp Lejeune
 .Q
 S XX=$$GETCUR^DGNTAPI(DFN,"DGNTARR") ; Nose/Throat Radium, DBIA3457
 S XX=$S(XX>0:DGNTARR("INTRP"),1:"")
 I +XX S SCR=SCR_"N"
 S XX=$P($$GETSTAT^DGMSTAPI(DFN),"^",2) ; Military Sexual Trauma, DBIA2716
 I XX="Y" S SCR=SCR_"M"
 Q SCR
