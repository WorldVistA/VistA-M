IBCNSUR4 ;ALB/VD - SELECT MULTIPLE SUBSCRIBERS LOOK-UP UTILITY ; 14-APR-15
 ;;2.0;INTEGRATED BILLING;**549**;14-APR-15;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ;
EN(IBC1,IBP1,IBDD,IBSBID,IBVAL,IBSUBACT,IBEFDT,IBEFDT1,IBEFDT2) ; Entry Point
 ; Look-up Utility to Select Multiple Subscribers
 ;  Input:  IBC1    --  Pointer to the company in file #36
 ;          IBP1    --  Pointer to the plan in file #355.3
 ;          IBDD    --  Deceased Subscribers Indicator (1 - Include
 ;                      Deceased, 0 - Ignore Deceased)
 ;          IBSBID  --  Subscriber ID Filter (1 - Use IBVAL to filter
 ;                      Subscriber IDs, 0 - Ignore Subscriber IDs)
 ;          IBVAL   --  Use the contained value to screen Subscriber IDs.
 ;          IBSUBACT --  Subscriber Filter for Active Indicator (0 - Ignore
 ;                      Active Status, 1 - Filter Active, 2 - Filter Inactive)
 ;                      to be excluded from selection
 ;          IBEFDT  --  Effective Date Filter Indicator (1 - Use Effective
 ;                      Dates as a filter, 0 - Ignore Effective Dates.)
 ;          IBEFDT1 --  Effective Date Filter Start Date.
 ;          IBEFDT2 --  Effective Date Filter End Date.
 ;
 ; Output:  IBCNT  --  Number of Subscriber Policies to Move.
 ;          ^TMP("IBCNSUR4A,$J) - Array of selected Subscribers.
 D EN^VALM("IBCN SUBSCRIBER SELECTOR")
 I +$G(IBFASTXT) S IBQUIT=1
 Q +$G(NUMSEL)_U_+$G(IBSUB)
 ;
HDR(SELECTED) ;EP
 ; Header code for the Subscriber Selection template
 ;  Input:  SELECTED -- 1=Showing header for selected listman
 ;                      0=Is the default or optional value
 ;
 ;          IBC1    --  Pointer to the company in file #36
 ;          IBP1    --  Pointer to the plan in file #355.3
 ;          IBDD    --  Deceased Subscribers Indicator (1 - Include
 ;                      Deceased, 0 - Ignore Deceased)
 ;          IBSBID  --  Subscriber ID Filter (1 - Use IBVAL to filter
 ;                      Subscriber IDs, 0 - Ignore Subscriber IDs)
 ;          IBVAL   --  Use the contained value to screen Subscriber IDs.
 ;          IBSUBACT -- Subscriber Filter for Active Indicator (0 - Ignore
 ;                      Active Status, 1 - Filter Active, 2 - Filter Inactive)
 ;                      to be excluded from selection
 ;          IBACTV  --  List of Active or Inactive policies.
 ;          IBEFDT  --  Effective Date Filter Indicator (1 - Use Effective
 ;                      Dates as a filter, 0 - Ignore Effective Dates.)
 ;          IBEFDT1 --  Effective Date Filter Start Date.
 ;          IBEFDT2 --  Effective Date Filter End Date.
 ;
 ; Output:  VALMHDR --  Header information to display
 N HCTR
 S:$G(IBSORT)="" IBSORT="1^Patient Name"
 S VALMHDR(1)="Subscribers in: "_$$GET1^DIQ(36,+IBC1,.01),$E(VALMHDR(1),50,79)="Grp Name: "_$$GET1^DIQ(355.3,+IBP1,.03)
 S VALMHDR(2)=$E($$GET1^DIQ(36,+IBC1,.111),1,20)_"  "_$E($$GET1^DIQ(36,+IBC1,.114),1,20)   ; Address and City
 S VALMHDR(2)=VALMHDR(2)_", "_$P($G(^DIC(5,+$$GET1^DIQ(36,+IBC1,.115,"I"),0)),U,2)_" "_$E($$GET1^DIQ(36,+IBC1,.116),1,5)  ; ST Zip.
 S $E(VALMHDR(2),53,99)="Grp #: "_$$GET1^DIQ(355.3,+IBP1,.04)
 ;
 S VALMHDR(3)=+$G(NUMSEL)_" Subscriber"_$S(+$G(NUMSEL)=1:"",1:"s")_" selected out of "_+$G(IBSUB),$E(VALMHDR(3),50,99)="Sorted by: "_$P(IBSORT,U,2)
 S HCTR=4
 S VALMHDR(HCTR)="Filters: "_$S(IBDD=1:"Living PATs",1:"All PATs")
 I $L(IBVAL) S VALMHDR(HCTR)=VALMHDR(HCTR)_", SubIDs w/'"_IBVAL_"'"
 I $L(VALMHDR(HCTR))>57 S HCTR=HCTR+1
 I '$D(VALMHDR(HCTR)) S VALMHDR(HCTR)="        "
 S VALMHDR(HCTR)=VALMHDR(HCTR)_$S(IBSUBACT=1:", Active",IBSUBACT=2:", Inactive",IBSUBACT=3:", All",1:$S(+IBSUBACT:"",1:", All"))_" Policies"
 I $L(VALMHDR(HCTR))>46 S HCTR=HCTR+1
 I +IBEFDT D
 . I '$D(VALMHDR(HCTR)) S VALMHDR(HCTR)="        "
 . S VALMHDR(HCTR)=VALMHDR(HCTR)_", Eff "_$$DAT1^IBOUTL(IBEFDT1)_"-"_$$DAT1^IBOUTL(IBEFDT2)
 Q
 ;
INIT ;EP
 ; Initialize variables and list array
 ; Input: None
 ; Output:  ^TMP("IBCNSUR4",$J) - Body lines to display
 K ^TMP("IBCNSUR4",$J),^TMP("IBCNSUR4IX",$J),^TMP("IBCNSUR4A",$J)
 S:$G(IBSORT)="" IBSORT="1^Patient Name"
 D BLD
 Q
 ;
BLD ; Build listman body
 ;  Input:  IBC1    --  Pointer to the company in file #36
 ;          IBP1    --  Pointer to the plan in file #355.3
 ;          IBDD    --  Deceased Subscribers Indicator (1 - Include
 ;                      Deceased, 0 - Ignore Deceased)
 ;          IBSBID  --  Subscriber ID Filter (1 - Use IBVAL to filter
 ;                      Subscriber IDs, 0 - Ignore Subscriber IDs)
 ;          IBVAL   --  Use the contained value to screen Subscriber IDs.
 ;          IBSUBACT -- Subscriber Filter for Active Indicator (0 - Include
 ;                      Both Active & Inactive, 1 - Include Active,
 ;                      2 - Include Inactive) to be included in selection.
 ;          IBACTV  --  List of Active or Inactive policies.
 ;          IBEFDT  --  Effective Date Filter Indicator (1 - Use Effective
 ;                      Dates as a filter, 0 - Ignore Effective Dates.)
 ;          IBEFDT1 --  Effective Date Filter Start Date.
 ;          IBEFDT2 --  Effective Date Filter End Date.
 ; Output:  VALMCNT   - Total number of lines displayed in the body
 ;          ^TMP("IBCNSUR4",$J)   - Body lines to display
 ;          ^TMP("IBCNSUR4IX",$J) - Index of Entry IENs by display line
 ;
 N ACTIVE,CURCNT,DFN,DFNY,OMIT,PATEFF,PATEXP,PATID,PATNAM,PATSID,PATSSN,PATWHO
 N SORTED,SRTKEY1,SRTKEY2,SRTKEY3,SRTREC,Y
 S IBSUB=$$SUBS^IBCNSJ(IBC1,IBP1,0,"^TMP($J,""IBCNSURS"")")
 S (CURCNT,VALMCNT)=0
 I '+IBSUB S ^TMP("IBCNSUR4",$J,1,0)="*  This group plan has no subscribers!" Q
 I IBSUB D
 . S DFN=""
 . F  S DFN=$O(^TMP($J,"IBCNSURS",DFN)) Q:DFN=""  D
 . . S Y=""
 . . F  S Y=$O(^TMP($J,"IBCNSURS",DFN,Y)) Q:Y=""  D
 . . . S OMIT=0,DFNY=DFN_"~"_Y
 . . . D GTSREC(DFNY,.SRTREC)
 . . . S PATSID=$P(SRTREC,U,2),PATEFF=$P(SRTREC,U,3),PATEXP=$P(SRTREC,U,4)
 . . . S ACTIVE=$S('PATEXP:1,DT>+PATEXP:0,1:1)
 . . . I +IBDEAD,+$$GET1^DIQ(2,DFN_",",.351,"I") Q   ; If ignoring deceased and subscriber is deceased exclude.
 . . . I +IBSUBID,$L(IBVALUE),($$UP^XLFSTR(PATSID)'[IBVALUE) Q    ; Sub ID doesn't contain the Sub ID screen exclude.
 . . . I +IBSUBACT D  Q:OMIT      ; Active vs Inactive
 . . . . I IBSUBACT=1,'ACTIVE S OMIT=1 Q  ; Include active Policies.
 . . . . I IBSUBACT=2,+ACTIVE S OMIT=1    ; Include inactive Policies.
 . . . I +IBEFDT D  Q:OMIT        ; Effective Date
 . . . . I PATEFF<IBEFDT1 S OMIT=1 Q    ; Effective date is less than starting date.
 . . . . I PATEFF>IBEFDT2 S OMIT=1      ; Effective date is less than ending date.
 . . . I '$D(IBSORT) S IBSORT=1
 . . . S SRTKEY1=$P(SRTREC,U,IBSORT)
 . . . S SRTKEY2=$P(SRTREC,U,1)   ; PATNAM
 . . . S SRTKEY3=$O(SORTED(SRTKEY1,SRTKEY2,""),-1)+1
 . . . S SORTED(SRTKEY1,SRTKEY2,SRTKEY3)=SRTREC
 . . . ;
 . S SRTKEY1=""
 . F  S SRTKEY1=$O(SORTED(SRTKEY1)) Q:SRTKEY1=""  D
 . . S SRTKEY2=""
 . . F  S SRTKEY2=$O(SORTED(SRTKEY1,SRTKEY2)) Q:SRTKEY2=""  D
 . . . S SRTKEY3=""
 . . . F  S SRTKEY3=$O(SORTED(SRTKEY1,SRTKEY2,SRTKEY3)) Q:SRTKEY3=""  D
 . . . . S SRTREC=SORTED(SRTKEY1,SRTKEY2,SRTKEY3)
 . . . . S DFNY=$P(SRTREC,U,8),DFN=$P(DFNY,"~",1),Y=$P(DFNY,"~",2)
 . . . . S CURCNT=CURCNT+1
 . . . . S LINE=$$BLDLN(CURCNT,DFN,Y,SRTREC)
 . . . . S VALMCNT=VALMCNT+1
 . . . . D SET^VALM10(VALMCNT,LINE,LINE)
 . . . . S ^TMP("IBCNSUR4IX",$J,CURCNT)=DFNY
 I IBSUB S IBSUB=CURCNT
 I VALMCNT=0 D
 . S ^TMP("IBCNSUR4",$J,1,0)="No Subscribers with Selection Criteria were found."
 Q
 ;
GTSREC(DFNY,SRTREC) ; Get the sort record data
 N DFN,PATEFF,PATEXP,PATID,PATNAM,PATSID,PATSSN,PATWHO,Y
 S SRTREC=""
 S DFN=$P(DFNY,"~",1),Y=$P(DFNY,"~",2)
 S PATNAM=$$GET1^DIQ(2,DFN_",",.01),PATNAM=$S($L(PATNAM):PATNAM,1:" ")
 S PATSSN=$E($$GET1^DIQ(2,DFN_",",.09),6,9),PATSSN=$S($L(PATSSN):PATSSN,1:" ")
 S PATSID=$E($$GET1^DIQ(2.312,Y_","_DFN_",",7.02),1,20),PATSID=$S($L(PATSID):PATSID,1:" ")   ;Only use the 1st 20 chars of SUBID.
 S PATEFF=$$GET1^DIQ(2.312,Y_","_DFN_",",8,"I"),PATEFF=$S($L(PATEFF):PATEFF,1:" ")
 S PATEXP=$$GET1^DIQ(2.312,Y_","_DFN_",",3,"I"),PATEXP=$S($L(PATEXP):PATEXP,1:" ")
 S PATWHO=$$GET1^DIQ(2.312,Y_","_DFN_",",6),PATWHO=$S('$L(PATWHO):"UNK",1:$E(PATWHO,1,3))
 S PATID=$$GET1^DIQ(2.312,Y_","_DFN_",",5.01),PATID=$S($L(PATID):PATID,1:" ")
 S SRTREC=PATNAM_U_PATSID_U_PATEFF_U_PATEXP_U_PATWHO_U_PATID_U_PATSSN_U_DFNY
 Q
 ;
BLDLN(ICTR,DFN,Y,SRTREC) ;EP
 ; Also called from BLD^IBCNEILK2
 ; Builds a line to display one Subscriber
 ; Input:   ICTR                          - Selection Number
 ;          DFN                           - DFN of the Subscriber to be displayed
 ;          Y                             - Y of the 2.312 occurrence.
 ;          ^TMP("IBCNSUR4A",$J,DFN,Y)    - Array of currently selected Subscribers
 ; Output:  LINE    - Formatted for setting into the list display
 N LINE,LINEI,XXN
 S:$D(^TMP("IBCNSUR4A",$J,DFN,Y)) ICTR=ICTR_">"         ; Mark as selected
 S LINE=$$SETSTR^VALM1(ICTR,"",1,4)                     ; Selection #
 S LINE=$$SETSTR^VALM1($E($P(SRTREC,U,1),1,15),LINE,6,20)    ; Patient Name
 S LINE=$$SETSTR^VALM1($S($P(SRTREC,U,7)=-9999:" ",1:$P(SRTREC,U,7)),LINE,22,25)            ; SSN
 S LINE=$$SETSTR^VALM1($S($P(SRTREC,U,2)=-9999:" ",1:$E($P(SRTREC,U,2),1,20)),LINE,27,46)   ; Subscriber ID (first 20 chars)
 S LINE=$$SETSTR^VALM1($S($P(SRTREC,U,3)=-9999:" ",1:$$DAT1^IBOUTL($P(SRTREC,U,3))),LINE,48,55)  ; Effective Date
 S LINE=$$SETSTR^VALM1($S($P(SRTREC,U,4)=-9999:" ",1:$$DAT1^IBOUTL($P(SRTREC,U,4))),LINE,57,64)  ; Expiration Date
 S LINE=$$SETSTR^VALM1($P(SRTREC,U,5),LINE,66,68)            ; Whose
 S LINE=$$SETSTR^VALM1($S($P(SRTREC,U,6)=-9999:" ",1:$E($P(SRTREC,U,6),1,30)),LINE,71,100)            ; Patient ID
 Q LINE
 ;
HELP ;EP
 ; Help code
 ; Input: None
 D FULL^VALM1
 S VALMBCK="R"
 W @IOF,"A '>' after the Subscriber Selection number indicates that this Subscriber"
 W !,"has already been selected."
 Q
 ;
EXIT ;EP
 ; Exit code
 ; Input: None
 K IBSORT,^TMP("IBCNSUR4",$J),^TMP("IBCNSUR4IX",$J)
 D CLEAR^VALM1
 Q
 ;
SEL ;EP
 ; Protocol Action to de-select an already selected Subscriber
 ; Input:   NUMSEL                    - Current number of selected Subscribers
 ;          ^TMP("IBCNSUR4",$J)       - Current Array of displayed Subscribers
 ;          ^TMP("IBCNSUR4IX",$J)     - Current Index of displayed Subscribers
 ;          ^TMP("IBCNSUR4A,$J,DFN,Y) - Current Array of selected Subscribers
 ;
 ; Output:  NUMSEL                    - Updated number of selected Subscribers
 ;          ^TMP("IBCNSUR4A,$J,DFN,Y) - Updated Array of selected Subscribers
 ;          Selected Subscriber is removed from the worklist 
 ;          Error message displayed (potentially)
 N DFN,DFNS,DFNY,DIR,DIROUT,DIRUT,DLINE,DTOUT,DUOUT,ERROR,IX,LINE,PROMPT,Y
 S VALMBCK="R",ERROR=0
 ; 
 ; First select the Subscriber(s) to be selected
 S PROMPT="Select Subscriber(s)"
 S DFNS=$$SELSUB(1,PROMPT,.DLINE,1,"IBCNSUR4IX")
 I DFNS="" S VALMBCK="R" Q                 ; None Selected
 F IX=1:1:$L(DFNS,",") D
 . S DFNY=$P(DFNS,",",IX)
 . S DFN=$P(DFNY,"~",1)
 . S Y=$P(DFNY,"~",2)
 . S LINE=$P(DLINE,",",IX)
 . ;
 . ; If currently selected, display an error message
 . I $D(^TMP("IBCNSUR4A",$J,DFN,Y)) D  Q
 . . W !,*7,">>>> # ",LINE," is currently selected."
 . . S ERROR=1
 . D MARK(1,DFNY,LINE,.NUMSEL)              ; Show the selection mark
 D HDR                                      ; Update the header
 D:ERROR PAUSE^VALM1
 Q
 ;
UNSEL(SELECTED) ;EP
 ; Protocol Action to de-select an already selected Subscriber
 ; Input:
 ; Optional, defaults to 0
 ;   NUMSEL                    - Current number of selected Subscribers
 ;   ^TMP("IBCNSUR4",$J)       - Current Array of displayed Subscribers
 ;   ^TMP("IBCNSUR4S",$J)      - Current Array of selected Insurance Companies
 ;   ^TMP("IBCNSUR4IX",$J)     - Current Index of displayed Subscribers
 ;   ^TMP("IBCNSUR4A,$J,DFN,Y) - Current Array of selected Subscribers
 ;
 ; Output:  NUMSEL             - Current number of selected Subscribers
 ;   ^TMP("IBCNSUR4A,$J,DFN,Y) - Updated Array of selected Subscribers
 ;
 ; Selected Subscriber is removed from the worklist 
 ; Error message displayed (potentially)
 N DFN,DFNS,DFNY,DIR,DIROUT,DIRUT,DLINE,DTOUT,DUOUT,ERROR,IX,LINE,MSG,PROMPT,WARRAY,Y
 I '$D(SELECTED) D
 . S SELECTED=0,WARRAY="IBCNSUR4IX"
 E  S WARRAY="IBCNSUR4SIX"
 S VALMBCK="R",ERROR=0
 ;
 ; First select the Subscriber(s) to be de-selected
 S PROMPT="De-Select Subscriber(s)"
 S MSG="Are you sure you want to De-Select "
 S DFNS=$$SELSUB(1,PROMPT,.DLINE,1,WARRAY)
 I DFNS="" S VALMBCK="R" Q                 ; None Selected
 F IX=1:1:$L(DFNS,",") D
 . S DFNY=$P(DFNS,",",IX)
 . S DFN=$P(DFNY,"~",1)
 . S Y=$P(DFNY,"~",2)
 . S LINE=$P(DLINE,",",IX)
 . ;
 . ; If not currently selected, display an error message
 . I '$D(^TMP("IBCNSUR4A",$J,DFN,Y)) D  Q
 . . W !,*7,">>>> # ",LINE," is not currently selected. It cannot be de-selected."
 . . S ERROR=1
 . D MARK(0,DFNY,LINE,.NUMSEL)              ; De-Select the entry
 D HDR                                     ; Update the header
 D:ERROR PAUSE^VALM1
 Q
 ;
MARK(WHICH,DFNY,LINE,NUMSEL)   ; Mark/Remove 'Selection' from a selected
 ; Subscriber line
 ; Input:   WHICH   - 0 - Remove 'Selection' mark
 ;                    1 - Set 'Selection' mark
 ;          DFNY    - DFN and Y of the entry to Mark/Remove 'In-Progress'
 ;          LINE    - Line number being marked/unmarked
 ;          WLIST   - Worklist, the user is selecting from.
 ;          NUMSEL  - Current # of selected Subscriber
 ;          ^TMP("IBCNSUR4A",$J)- Current array of selected Subscriber 
 ; Output:  Subscriber is marked or unmarked as selected
 ;          NUMSEL  - Current # of selected Subscribers
 ;          ^TMP("IBCNSUR4A",$J)- Updated array of selected Subscribers 
 ;
 N TEXT,DFN,Y
 S DFN=$P(DFNY,"~",1)
 S Y=$P(DFNY,"~",2)
 I WHICH D                                  ; Mark as selected
 . S ^TMP("IBCNSUR4A",$J,DFN,Y)=""
 . S TEXT=LINE_">",NUMSEL=NUMSEL+1
 E  D                                       ; Mark as unselected
 . K ^TMP("IBCNSUR4A",$J,DFN,Y)
 . S TEXT=LINE,NUMSEL=NUMSEL-1
 D FLDTEXT^VALM10(LINE,"CTR",TEXT)          ; Update display
 D WRITE^VALM10(LINE)                       ; Redisplay line
 Q
 ;
SHOWSEL ;EP
 ; Protocol action used to display a listman template of the currently
 ; selected Subscribers
 ; Input:   NUMSEL                        - Current number of selected Subscribers
 ;          ^TMP("IBCNSUR4A",$J,DFN,Y)    - Current Array of selected Subscribers
 ; Output:  NUMSEL                        - Updated number of selected Subscribers
 ;          ^TMP("IBCNSUR4A",$J,DFN,Y)    - Updated Array of selected Subscribers
 S VALMBCK="R"
 D EN^VALM("IBCN SUBSCRIBER SELECTED")
 D HDR,BLD
 Q
 ;
SELSUB(FULL,PROMPT,DLINE,MULT,WLIST)    ;EP
 ; Select Subscriber(s) to perform an action upon
 ; Input:   FULL                    - 1 - full screen mode, 0 otherwise
 ;          PROMPT                  - Prompt to be displayed to the user
 ;          MULT                    - 1 to allow multiple entry selection
 ;                                    0 to only allow single entry selection
 ;                                    Optional, defaults to 0
 ;          WLIST                   - Worklist, the user is selecting from
 ;          ^TMP("IBCNSUR4IX",$J)   - Index of displayed lines of the Subscriber
 ;                                    Selector Template. 
 ;                                    Only used when WLIST="IBCNSUR4IX"
 ;          ^TMP("IBCNSUR4SIX",$J)  - Index of displayed lines of the Subscriber
 ;                                    Selected Template
 ;                                    Only used if WLIST is "IBCNSUR4IX"
 ; Output:  DLINE                   - Comma delimited list of Line #(s) of the 
 ;                                    selected Subscriber
 ; Returns: IEN(s) - Comma delimited string or IENS for the selected Subscriber(s)
 ;          Error message and "" DFNS if multi-selection and not allowed
 N DFNY,DFNS,DIR,DIROUT,DIRUT,DTOUT,DUOUT,IX,VALMY,X,Y
 S:'$D(MULT) MULT=0
 S:'$D(WLIST) WLIST="IBCNSUR4"
 D:FULL FULL^VALM1
 S DLINE=$P($P($G(XQORNOD(0)),"^",4),"=",2)     ; User selection with action
 S DLINE=$TR(DLINE,"/\; .",",,,,,")             ; Check for multi-selection
 S DFNS=""
 I 'MULT,DLINE["," D  Q ""                      ; Invalid multi-selection
 . W !,*7,">>>> Only single entry selection is allowed"
 . S DLINE=""
 . K DIR
 . D PAUSE^VALM1
 ;
 ; Let the user enter their selection(s)
 D EN^VALM2($G(XQORNOD(0)),"O")                 ; ListMan generic selector
 I '$D(VALMY) Q ""
 S IX="",DLINE=""
 F  D  Q:IX=""
 . S IX=$O(VALMY(IX))
 . Q:IX=""
 . S DLINE=$S(DLINE="":IX,1:DLINE_","_IX)
 . S DFNY=$G(^TMP(WLIST,$J,IX))
 . S DFNS=$S(DFNS="":DFNY,1:DFNS_","_DFNY)
 Q DFNS
 ;
INIT2 ;EP for Show Selections
 ; Initialize variables and list array
 ; Input: None
 ; Output:  ^TMP("IBCNSUR4",$J) - Body lines to display
 K ^TMP("IBCNSUR4S",$J),^TMP("IBCNSUR4SIX",$J)
 D BLD2
 Q
 ;
BLD2 ; Build listman body for Show Selections
 ; Input:   None
 ; Output:  VALMCNT   - Total number of lines displayed in the body
 ;          ^TMP("IBCNSUR4S",$J)   - Body lines to display
 ;          ^TMP("IBCNSUR4SIX",$J) - Index of Entry DFNs by display line
 N DFN,DFNY,ICTR,LINE,SORTED,SRTKEY1,SRTKEY2,SRTKEY3,Y
 ;
 ; First sort the currently selected Subscribers into name order
 S DFN=""
 F  S DFN=$O(^TMP("IBCNSUR4A",$J,DFN)) Q:DFN=""  D
 . S Y=""
 . F  S Y=$O(^TMP("IBCNSUR4A",$J,DFN,Y)) Q:Y=""  D
 . . S DFNY=DFN_"~"_Y
 . . D GTSREC(DFNY,.SRTREC)
 . . S SRTKEY1=$P(SRTREC,U,IBSORT)
 . . S SRTKEY2=$P(SRTREC,U,1)   ; PATNAM
 . . S SRTKEY3=$O(SORTED(SRTKEY1,SRTKEY2,""),-1)+1
 . . S SORTED(SRTKEY1,SRTKEY2,SRTKEY3)=SRTREC
 ;
 ; Now build the lines to be displayed
 S (ICTR,VALMCNT)=0,SRTKEY1=""
 F  S SRTKEY1=$O(SORTED(SRTKEY1)) Q:SRTKEY1=""  D
 . S SRTKEY2=""
 . F  S SRTKEY2=$O(SORTED(SRTKEY1,SRTKEY2)) Q:SRTKEY2=""  D
 . . S SRTKEY3=""
 . . F  S SRTKEY3=$O(SORTED(SRTKEY1,SRTKEY2,SRTKEY3)) Q:SRTKEY3=""  D
 . . . S SRTREC=SORTED(SRTKEY1,SRTKEY2,SRTKEY3)
 . . . S DFNY=$P(SRTREC,U,8)
 . . . S DFN=$P(DFNY,"~",1),Y=$P(DFNY,"~",2)
 . . . S ICTR=ICTR+1
 . . . S LINE=$$BLDLN(ICTR,DFN,Y,SRTREC)
 . . . S VALMCNT=VALMCNT+1
 . . . D SET^VALM10(VALMCNT,LINE,LINE)
 . . . S ^TMP("IBCNSUR4SIX",$J,ICTR)=DFN_"~"_Y
 ;
 I VALMCNT=0 D
 . S ^TMP("IBCNSUR4",$J,1,0)="No Selected Subscribers were found."
 Q
 ;
EXIT2 ;EP for Show Selections
 ; Exit code
 ; Input: None
 K ^TMP("IBCNSUR4S",$J),^TMP("IBCNSUR4SIX",$J)
 D CLEAR^VALM1
 Q
 ;
SELSORT ;  select the way to sort the list screen
 N DIR,DIRUT,X,Y,DTOUT,DUOUT,DIROUT,ST,STDES
 ;
 D FULL^VALM1 W !
 W !,"Select the item to sort the subscriber records on the subscriber list screen."
 S DIR(0)="SO^1:Patient Name;2:Subscriber ID;3:Effective Date;4:Date Expired;5:Whose;6:Patient ID"
 S DIR("A")="Sort the list by",DIR("B")=$P($G(IBSORT),"^",2)
 D ^DIR K DIR
 I 'Y G SELSORTX
 S IBSORT=Y_"^"_Y(0)
 ;
 ; rebuild and resort the list and update the list header
 D BLD,HDR
 ;
SELSORTX ;
 S VALMBCK="R",VALMBG=1
 Q
 ;
