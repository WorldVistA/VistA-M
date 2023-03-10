IBCNSU21 ;ALB/TAZ - INSURANCE PLAN SELECTOR UTILITY ; 13-OCT-2021
 ;;2.0;INTEGRATED BILLING;**702**;21-MAR-94;Build 53
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
LKP(IBCNS,IBIND,IBACT,IBIGN,IBFIL) ; Select Utility for Insurance Company Plans
 ;
 ;Input:   
 ; IBCNS   - IEN of the Insurance Company (file 36)
 ; IBIND   - Include Individual Plans?  (1 - Yes | 0 - No)
 ; IBACT   - Optional, defaults to 0
 ;           0 - Only allow inactive plans
 ;           1 - Only allow active plans
 ;           2 - Allow both inactive and active plans to be chosen
 ; IBIGN   - 0 - search Group Name
 ;           1 - search Group Number
 ;           2 - search Both Group Name and Group Number
 ; IBFIL  A^B^C
 ;           A - 1 - Search for Group(s) that Begin with specified text (case insensitive)
 ;               2 - Search for Group(s) that Contain the specified text (case insensitive)
 ;               3 - Search for Group(s) in a specified Range (inclusive, case insensitive)
 ;           B - Begin with text if A=1, Contains Text if A=2 or Range start if A=3
 ;           C - Range End text (only present when A=3)
 ;Output:  
 ; ^TMP($J,"IBSEL",PIEN) - Array of selected plan iens (where PIEN
 ;                     is the plan IEN) is returned if multiple plans may
 ;                     be selected.
 ;
 Q:'$G(IBCNS)                               ; No Insurance Company
 N IBMULT,IDX,NUMSEL,SELECTED,VALMBG,VALMCNT,VALMY,VALMHDR
 F IDX="IBCNSU21","IBCNSU21A","IBCNSU21IX" K ^TMP(IDX,$J)
 S IBIND=+$G(IBIND)
 S IBACT=+$G(IBACT)
 S IBFIL=$G(IBFIL)
 S IBMULT=1,NUMSEL=0
 D EN^VALM("IBCNS PLAN SELECTOR")
 Q
 ;
INIT ; Build the list of plans.
 N IBP,X
 S VALMCNT=0,VALMBG=1
 S IBP=0
 F  S IBP=$O(^IBA(355.3,"B",+IBCNS,IBP)) Q:'IBP  D
 . N PLANDATA,PLANOK
 . D GETS^DIQ(355.3,+IBP_",",".11;2.01;2.02","EI","PLANDATA")
 . I '$$PLANOK(.PLANDATA,IBACT,IBIGN,IBFIL) Q  ;Check plans based on selection criteria.
 . S VALMCNT=VALMCNT+1
 . S X=$$BLDLN(VALMCNT,IBP)
 . ;
 . S ^TMP("IBCNSU21",$J,VALMCNT,0)=X
 . S ^TMP("IBCNSU21",$J,"IDX",VALMCNT,VALMCNT)=IBP
 . ;
 . S ^TMP("IBCNSU21IX",$J,VALMCNT)=IBP
 ;
 I '$D(^TMP("IBCNSU21",$J)) D
 . S VALMCNT=2,^TMP("IBCNSU21",$J,1,0)=" "
 . S ^TMP("IBCNSU21",$J,2,0)="   No plans were identified for this company."
 S SELECTED=0
 Q
 ;
HDR ; Build the list header.
 N IBCNS0,IBCNS11,IBCNS13,IBLEAD,X,XX,X1,X2
 S IBCNS0=$G(^DIC(36,+IBCNS,0)),IBCNS11=$G(^(.11)),IBCNS13=$G(^(.13))
 ;
 S X2=$S('IBACT:"Inactive ",IBACT=2:"",1:"Active ")
 S IBLEAD=$S(IBIND:"All "_X2,1:X2_"Group ")_"Plans for: "
 S X2=$$GET1^DIQ(36,+IBCNS_",",.131) I X2']"" S X2="<not filed>"
 S X="Phone: "_X2
 S X2=$$GET1^DIQ(36,+IBCNS_",",.01)
 S VALMHDR(1)=$$SETSTR^VALM1(X,IBLEAD_X2,81-$L(X),40)
 ;
 S X2=$$GET1^DIQ(36,+IBCNS_",",.133) I X2']"" S X2="<not filed>"
 S X1="Precerts: "_X2
 S X2=$$GET1^DIQ(36,+IBCNS_",",.111) I X2']"" S X2="<no street address>"
 S X=$TR($J("",$L(IBLEAD)),""," ")_X2
 S VALMHDR(2)=$$SETSTR^VALM1(X1,X,81-$L(X1),40)
 ;
 S X=$$GET1^DIQ(36,+IBCNS_",",.114) I X']"" S X="<no city>"_", "
 S X1=$$GET1^DIQ(5,$$GET1^DIQ(36,+IBCNS_",",.115,"I")_",",1) I X1']"" S X1="<no state>"
 S X2=$$GET1^DIQ(36,+IBCNS_",",.116) I $L(X2)=9 S X2=$E(X2,1,5)_"-"_$E(X2,6,9)
 S X=X_", "_X1_"  "_X2
 S VALMHDR(3)=$$SETSTR^VALM1(X,"",$L(IBLEAD)+1,80)
 ;
 S X="#" I $G(IBIND) S X="#  + => Indiv. Plan"
 I $G(IBACT) S X=$E(X_$J("",23),1,23)_"* => Inactive Plan"
 S VALMHDR(4)=$$SETSTR^VALM1("Pre-  Pre-  Ben",X,64,17)
 Q
 ;
EXIT ; Exit action.
 N IDX
 K VALMBCK
 M ^TMP($J,"IBSEL")=^TMP("IBCNSU21A",$J) S ^TMP($J,"IBSEL",0)=NUMSEL
 F IDX="IBCNSU21","IBCNSU21A","IBCNSU21IX" K ^TMP(IDX,$J)
 D CLEAN^VALM10,CLEAR^VALM1
 Q
 ;
BLD ;
 ;Source Data from ^TMP($J,"IBCNSU21")
 N IIEN,LINE
 S (IIEN,VALMCNT)=0
 F  S IIEN=$O(^TMP($J,"IBCNSU21",IIEN)) Q:'IIEN  D
 . S VALMCNT=VALMCNT+1
 . S LINE=$$BLDLN(VALMCNT,IIEN)
 . D SET^VALM10(VALMCNT,LINE,LINE)
 . S ^TMP("IBCNSU21IX",$J,VALMCNT)=IIEN
 Q
 ;
BLDLN(ICTR,IIEN,DATA) ;EP
 ; Builds a line to display one insurance company
 ; Input:   ICTR                        - Selection Number
 ;          IIEN                        - IEN of the Policy to be displayed
 ;          ^TMP("IBCNSU21A",$J,IIEN)    - Array of currently selected policies
 ;
 ; Output:  LINE    - Formatted for setting into the list display
 N DATA,LINEVAR
 D GETS^DIQ(355.3,+IIEN_",",".02;.05;.06;.07;.08;.09;.11;2.01;2.02","EI","DATA")
 S LINEVAR=""
 I $D(^TMP("IBCNSU21A",$J,IIEN)) S ICTR=ICTR_">"
 S LINEVAR=$$SETFLD^VALM1(ICTR,"","CTR")
 I '$G(DATA(355.3,IIEN_",",.02,"I")) S $E(LINEVAR,4)="+"
 S LINEVAR=$$SETFLD^VALM1($G(DATA(355.3,IIEN_",",2.01,"E")),LINEVAR,"GNAME")
 I $G(DATA(355.3,IIEN_",",.11,"I")) S $E(LINEVAR,24)="*"
 S LINEVAR=$$SETFLD^VALM1($G(DATA(355.3,IIEN_",",2.02,"E")),LINEVAR,"GNUM")
 S LINEVAR=$$SETFLD^VALM1($G(DATA(355.3,IIEN_",",.09,"E")),LINEVAR,"TYPE")
 S LINEVAR=$$SETFLD^VALM1($$YN^IBCNSM($G(DATA(355.3,IIEN_",",.05,"I"))),LINEVAR,"UR")
 S LINEVAR=$$SETFLD^VALM1($$YN^IBCNSM($G(DATA(355.3,IIEN_",",.06,"I"))),LINEVAR,"PREC")
 S LINEVAR=$$SETFLD^VALM1($$YN^IBCNSM($G(DATA(355.3,IIEN_",",.07,"I"))),LINEVAR,"PREEX")
 S LINEVAR=$$SETFLD^VALM1($$YN^IBCNSM($G(DATA(355.3,IIEN_",",.08,"I"))),LINEVAR,"BENAS")
 Q LINEVAR
 ;
SEL ;EP
 ; Protocol Action to select an unselected policy
 ; Input:   NUMSEL                  - Current number of selected policies
 ;          ^TMP("IBCNSU21",$J)     - Current Array of displayed policies
 ;          ^TMP("IBCNSU21IX",$J)    - Current Index of displayed policies
 ;          ^TMP("IBCNSU21A,$J,IIEN) - Current Array of selected policies
 ; Output:  NUMSEL                  - Updated number of selected policies
 ;          ^TMP("IBCNSU21A,$J,IIEN)- Updated Array of selected policies
 ;          Selected Insurance Company is added to the worklist 
 ;          Error message displayed (potentially)
 N DIR,DIROUT,DIRUT,DLINE,DTOUT,DUOUT,ERROR,IEN,IIENS,IX,LINE
 S VALMBCK="R",ERROR=0
 ; 
 ; First select the Policy(s) to be selected
 S IIENS=$$SELPOL(1,.DLINE,1,"IBCNSU21IX")
 I IIENS="" S VALMBCK="R" Q                 ; None Selected
 F IX=1:1:$L(IIENS,",") D
 . S IIEN=$P(IIENS,",",IX)
 . S LINE=$P(DLINE,",",IX)
 . ;
 . ; If currently selected, display an error message
 . I $D(^TMP("IBCNSU21A",$J,IIEN)) D  Q
 . . W !,*7,">>>> # ",LINE," is currently selected."
 . . S ERROR=1
 . D MARK(1,IIEN,LINE,.NUMSEL)              ; Show the selection mark
 D HDR                                      ; Update the header
 D:ERROR PAUSE^VALM1
 Q
 ;
UNSEL(SELECTED) ;EP
 ; Protocol Action to deselect an already selected policy
 ; Input:   SELECTED                - 1 - Called from IBCN POL DESELECT
 ;                                    0 - Called from IBCN DESELECT
 ;                                    Optional, defaults to 0
 ;          NUMSEL                  - Current number of selected policies
 ;          ^TMP("IBCNSU21",$J)     - Current Array of displayed policies
 ;          ^TMP("IBCNSU21S",$J)    - Current Array of selected policies
 ;          ^TMP("IBCNSU21IX",$J)   - Current Index of displayed policies
 ;          ^TMP("IBCNSU21A,$J,IIEN)- Current Array of selected policies
 ; Output:  NUMSEL                  - Current number of selected policies
 ;          ^TMP("IBCNSU21A,$J,IIEN)- Updated Array of selected policies
 ;          Selected policy is removed from the worklist 
 ;          Error message displayed (potentially)
 N DIR,DIROUT,DIRUT,DLINE,DTOUT,DUOUT,ERROR,IEN,IIENS,IX,LINE,WARRAY
 I '$D(SELECTED) D
 . S SELECTED=0,WARRAY="IBCNSU21IX"
 E  S WARRAY="IBCNSU21SIX"
 S VALMBCK="R",ERROR=0
 ; 
 ; First select the Policy(s) to be deselected
 S IIENS=$$SELPOL(1,.DLINE,1,WARRAY)
 I IIENS="" S VALMBCK="R" Q                 ; None Selected
 F IX=1:1:$L(IIENS,",") D
 . S IIEN=$P(IIENS,",",IX)
 . S LINE=$P(DLINE,",",IX)
 . ;
 . ; If not currently selected, display an error message
 . I '$D(^TMP("IBCNSU21A",$J,IIEN)) D  Q
 . . W !,*7,">>>> # ",LINE," is not currently selected. It cannot be deselected."
 . . S ERROR=1
 . D MARK(0,IIEN,LINE,.NUMSEL)              ; Deselect the entry
 D HDR                                      ; Update the header
 D:ERROR PAUSE^VALM1
 Q
 ;
MARK(WHICH,IIEN,LINE,NUMSEL)   ;EP
 ; Mark/Remove 'Selection' from a selected
 ; Insurance Company line
 ; Input:   WHICH   - 0 - Remove 'Selection' mark
 ;                    1 - Set 'Selection' mark
 ;          IENIN   - IEN of the entry to Mark/Remove 'In-Progress'
 ;          LINE    - Line number being marked/unmarked
 ;          WLIST   - Worklist, the user is selecting from.
 ;          NUMSEL  - Current # of selected policies
 ;          ^TMP("IBCNSU21A",$J)- Current array of selected policies 
 ; Output:  Policy is marked or unmarked as selected
 ;          NUMSEL  - Current # of selected policies
 ;          ^TMP("IBCNSU21A",$J)- Updated array of selected policies 
 ;      
 N TEXT
 I WHICH D                                  ; Mark as selected
 . S ^TMP("IBCNSU21A",$J,IIEN)=""
 . S TEXT=LINE_">",NUMSEL=NUMSEL+1
 E  D                                       ; Mark as unselected
 . K ^TMP("IBCNSU21A",$J,IIEN)
 . S TEXT=LINE,NUMSEL=NUMSEL-1
 D FLDTEXT^VALM10(LINE,"CTR",TEXT)          ; Update display
 D WRITE^VALM10(LINE)                       ; Redisplay line
 Q
 ;
SELPOL(FULL,DLINE,MULT,WLIST)    ;EP
 ; Select Insurance Company(s) to on report
 ; Also called from IBCNRDV1@UNSEL
 ; Input:   FULL                    - 1 - full screen mode, 0 otherwise
 ;          MULT                    - 1 to allow multiple entry selection
 ;                                    0 to only allow single entry selection
 ;                                    Optional, defaults to 0
 ;          WLIST                   - Worklist, the user is selecting from
 ;          ^TMP("IBCNSU21IX",$J)   - Index of displayed lines of the policy
 ;                                    Selector Template. 
 ;                                    Only used when WLIST="IBCNSU21IX"
 ;          ^TMP("IBCNSU21SIX",$J)  - Index of displayed lines of the policy
 ;                                    Selected Template
 ;                                    Only used if WLIST is "IBCNSU21SIX"
 ; Output:  DLINE                   - Comma delimited list of Line #(s) of the 
 ;                                    selected Ins Cos
 ; Returns: IIEN(s) - Comma delimited string or IENS for the selected policy(s)
 ;          Error message and "" IENS if multi-selection and not allowed
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IIEN,IIENS,IX,VALMY,X,Y
 S:'$D(MULT) MULT=0
 S:'$D(WLIST) WLIST="IBCNSU21"
 D:FULL FULL^VALM1
 S DLINE=$P($P($G(XQORNOD(0)),"^",4),"=",2)     ; User selection with action
 S DLINE=$TR(DLINE,"/\; .",",,,,,")             ; Check for multi-selection
 S IIENS=""
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
 . S IIEN=$G(^TMP(WLIST,$J,IX))
 . S IIENS=$S(IIENS="":IIEN,1:IIENS_","_IIEN)
 Q IIENS
 ;
SHOWSEL ;EP
 ; Protocol action used to display a listman template of the currently
 ; selected policies
 ; Input:   NUMSEL                      - Current number of selected policies
 ;          ^TMP("IBCNSU21A",$J,IEN)    - Current Array of selected policies
 ; Output:  NUMSEL                      - Updated number of selected policies
 ;          ^TMP("IBCNSU21A",$J,IEN)    - Updated Array of selected policies
 S VALMBCK="R",SELECTED=1
 D EN^VALM("IBCNS POLICIES SELECTED")
 I '$D(IBFASTXT) D HDR,INIT
 Q
 ;
INIT2 ;EP for Show Selections
 ; Initialize variables and list array
 ; Input: None
 ; Output:  ^TMP("IBCNSU21S",$J) - Body lines to display
 S VALMBCK="R"
 K ^TMP("IBCNSU21S",$J),^TMP("IBCNSU21SIX",$J)
 D BLD2
 Q
 ;
BLD2 ; Build listman body for Show Selections
 ; Input:   None
 ; Output:  VALMCNT   - Total number of lines displayed in the body
 ;          ^TMP("IBCNSU21S",$J)   - Body lines to display
 ;          ^TMP("IBCNSU21SIX",$J) - Index of Entry IENs by display line
 N IIEN,LINE
 ;
 ; Build the lines to be displayed
 S (IIEN,VALMCNT)=0
 F  S IIEN=$O(^TMP("IBCNSU21A",$J,IIEN)) Q:'IIEN  D
 . S VALMCNT=VALMCNT+1
 . S LINE=$$BLDLN(VALMCNT,IIEN)
 . D SET^VALM10(VALMCNT,LINE,LINE)
 . S ^TMP("IBCNSU21SIX",$J,VALMCNT)=IIEN
 ;
 I VALMCNT=0 D
 . S ^TMP("IBCNSU21S",$J,1,0)="No Selected Policies were found."
 Q
 ;
EXIT2 ;EP for Show Selections
 ; Exit code
 ; Input: None
 K ^TMP("IBCNSU21S",$J),^TMP("IBCNSU21SIX",$J)
 D CLEAR^VALM1
 Q
 ;
HELP  ;
 Q
 ;
PLANOK(DATA,IBACT,IBNANU,IBFLT) ;Check to see if plan qualifies
 ;Input:
 ;DATA   - This array is passed by reference.  It is constructed by the SETS^DIQ call:
 ;           D GETS^DIQ(355.3,+IBP_",",".02;.05;.06;.07;.08;.09;.11;2.01;2.02","EI","PLANDATA")
 ;         It must contain the following fields:
 ;         .11 - INACTIVE
 ;         2.01 - GROUP NAME
 ;         2.02 - GROUP NUMBER
 ;
 ;IBACT  - 0 - INACTIVE Group Plans Only
 ;         1 - ACTIVE Group Plans Only
 ;         2 - Both ACTIVE and INACTIVE Group Plans
 ;
 ;IBNANU - 1 - Check GROUP NAME only
 ;         2 - Check GROUP NUMBER only
 ;         3 - Check BOTH
 ;
 N IBP,INACTIVE,OK
 S OK=0
 S IBP=$O(DATA(355.3,""))
 S INACTIVE=$G(DATA(355.3,IBP,.11,"I"))  ;1=Inactive, 0=Active
 I 'INACTIVE,'IBACT G PLANOKX   ; Plan is Active and looking for Inactive only
 I INACTIVE,(IBACT=1) G PLANOKX   ; Plan is Inactive and looking for Active only
 ;
 I 'IBFLT G PLANOKX  ;Exit if no filter defined.
 ;
 I IBNANU=1!(IBNANU=3) D  I OK G PLANOKX  ;GROUP NAME only or Both
 . S OK=$$FILTER($G(DATA(355.3,IBP,2.01,"E")),IBFLT)
 I IBNANU=2!(IBNANU=3) D  ;GROUP NUMNBER only or Both
 . S OK=$$FILTER($G(DATA(355.3,IBP,2.02,"E")),IBFLT)
PLANOKX ;Exit
 Q OK
 ;
FILTER(STR,FLT) ; Filter Group Name or Number
 ;IBFLT A^B^C
 ;         A - 1 - Search for Group(s) that begin with
 ;                 the specified text (case insensitive)
 ;             2 - Search for Group(s) that contain
 ;                 the specified text (case insensitive)
 ;             3 - Search for Group(s) in a specified
 ;                 range (inclusive, case insensitive)
 ;             4 - Search for Group(s) that are blank (null)
 ;         B - Begin with text if A=1, Contains Text if A=2 or
 ;             the range start if A=3
 ;         C - Range End text (only present when A=3)
 ;
 N BEG,CHR,END,OK,TYPE
 S STR=$$UP^XLFSTR(STR)
 S TYPE=$P(FLT,U,1)
 S BEG=$$UP^XLFSTR($P(FLT,U,2))
 S END=$$UP^XLFSTR($P(FLT,U,3))
 S OK=0
 ;Blank
 I TYPE=4 D  G FILTERX
 . I STR="" S OK=1
 ;Test begins with
 I TYPE=1 D  G FILTERX
 . I ($E(STR,1,$L(BEG))=BEG) S OK=1
 ;Test contains
 I TYPE=2 D  G FILTERX
 . I (STR[BEG) S OK=1
 ;Test range
 I TYPE=3 D  G FILTERX
 . N XX
 . S XX=$E(STR,1,$L(BEG))
 . I XX=BEG S OK=1 Q   ;Matches begining characters of BEG - include
 . I XX']BEG Q         ;Preceeds Beg search
 . S XX=$E(STR,1,$L(END))
 . I XX=END S OK=1 Q   ;Matches beginning characters of END - include
 . I XX]END Q          ;Follows End search
 . S OK=1
FILTERX ; Exit
 Q OK
 ;
