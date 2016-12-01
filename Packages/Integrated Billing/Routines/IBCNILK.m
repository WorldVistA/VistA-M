IBCNILK ;ALB/FA - Insurance Company Selection ; 02-OCT-2015
 ;;2.0;INTEGRATED BILLING;**549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ;
EN(WHICH,PIEN,FILTER) ;EP
 ; Main entry point for the Insurance Company Selection template
 ; Input:   WHICH     - 1 - Only Show Active Insurance Companies
 ;                      0 - Only Show Inactive Insurance Companies
 ;                      2 - Show Both Active and Inactive Insurance Companies
 ;          PIEN      - IEN of the Payer to use to filter Insurance Company
 ;                      lookups. Optional, defaults to "".
 ;          FILTER    - A^B^C Where:
 ;                       A - 1 - Search for Insurance Companies that begin with
 ;                               the specified text (case insensitive)
 ;                           2 - Search for Insurance Companies that contain
 ;                               the specified text (case insensitive)
 ;                           3 - Search for Insurance Companies in a specified
 ;                               range (inclusive, case insensitive)
 ;                           4 - Filter by Selected Payer only
 ;                       B - Begin with text if A=1, Contains Text if A=2 or
 ;                            the range start if A=3
 ;                       C - Range End text (only present when A=3)
 ;                      Optional, if not passed, user is prompted for filter
 ;                      selection
 ; Output:  ^TMP("IBCNILKA,$J,IIEN)    - Array of selected insurance companies
 N NUMSEL
 S:'$D(PIEN) PIEN=""
 S:'$D(FILTER) FILTER=$$GETFILT()
 Q:FILTER=""
 S NUMSEL=0
 K ^TMP("IBCNILKA",$J)
 D EN^VALM("IBCN INS CO SELECTOR")
 Q
 ;
NEWSRCH() ; EP
 ; Protocol action to get new filter criteria and redisplay the listman
 ; template body and header
 ; Input:   FILTER      - Current Insurance Company Filter (See EN for details)
 ; Output:  FILTER      - Update Insurance Company Filter (See EN for details)
 N XX
 S VALMBCK="R"
 D FULL^VALM1
 W !!
 S XX=$$GETFILT()
 I XX=-1 D  Q
 . W *7,"Invalid Filter - nothing done"
 . D PAUSE^VALM1
 S FILTER=XX
 K ^TMP("IBCNILK",$J),^TMP("IBCNILKIX",$J)
 D BLD,HDR
 Q
 ;
GETFILT() ; Gets the Insurance company filter
 ; Input:   None
 ; Returns: A^B^C Where:
 ;           A - 1 - Search for Insurance Companies that begin with
 ;                   the specified text (case insensitive)
 ;               2 - Search for Insurance Companies that contain
 ;                   the specified text (case insensitive)
 ;               3 - Search for Insurance Companies in a specified
 ;                   range (inclusive, case insensitive)
 ;           B - Begin with text if A=1, Contains Text if A=2 or
 ;               the range start if A=3
 ;           C - Range End text (only present when A=3)
 ;         -1 if a valid filter was not selected
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILTER,X,XX,Y
 ;
 ; First ask what kind of filter to use
 W !
 S DIR(0)="SA^1:Begins with;2:Contains;3:Range"
 S DIR("A")="     Select 1, 2 or 3: "
 S DIR("A",1)=" 1 - Select Insurance Companies that Begin with: XXX"
 S DIR("A",2)=" 2 - Select Insurance Companies that Contain: XXX"
 S DIR("A",3)=" 3 - Select Insurance Companies in Range: XXX - YYY"
 S DIR("B")=1
 S DIR("?",1)="Select the type of filter to determine what Insurance Companies"
 S DIR("?",2)="will be displayed as follows:"
 S DIR("?",3)="   Begins with - Displays all insurance companies that begin with"
 S DIR("?",4)="                 the specified text (inclusive, case insensitive)"
 S DIR("?",5)="   Contains    - Displays all insurance companies that contain"
 S DIR("?",6)="                 the specified text (inclusive, case insensitive)"
 S DIR("?",7)="   Range       - Displays all insurance companies within the "
 S DIR("?")="                 the specified range (inclusive, case insensitive)"
 S XX="1:Begins with;2:Contains;3:Range"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q -1                 ; No valid search selected
 S FILTER=Y
 ;
 ; Next ask for 'Begin with', 'Contains' or 'Range Start' text
 W !
 K DIR
 S DIR(0)="F^1;30"
 S XX=$S(FILTER=1:"that begin with",FILTER=2:"that contain",1:"Start of Range")
 S DIR("A")="     Select Insurance Companies "_XX
 I FILTER=1 D
 . S DIR("?")="Enter the text the each Insurance Company will begin with"
 I FILTER=2 D
 . S DIR("?")="Enter the text the each Insurance Company will contains"
 I FILTER=3 D
 . S DIR("?")="Enter the starting range text"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) Q -1                 ; No valid search selected
 S $P(FILTER,"^",2)=Y
 Q:$P(FILTER,"^",1)'=3 FILTER
 ;
 ; Finally, ask for 'Range End' text if using a range filter
 W !
 K DIR
 S DIR(0)="F^1;30"
 S DIR("A")="     Select Insurance Companies End of Range"
 S DIR("B")=$P(FILTER,"^",2)
 S DIR("?")="Enter the ending Range text"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q -1                 ; No valid search selected
 S $P(FILTER,"^",3)=Y
 Q FILTER
 ;
HDR(SELECTED) ;EP
 ; Header code for the Insurance Company Selection template
 ; Input:   SELECTED        - 1 - Showing header for selected listman
 ;                                Optional, defaults to 0
 ;          NUMSEL          - Current # of Insurance Companies Selected
 ;          FILTER          - Current Insurance Company Filter (See EN for details)
 ;          WHICH           - Active/Inactive/Both filter option
 ; Output:  VALMHDR         - Header information to display
 N PNM,XX
 S:'$D(SELECTED) SELECTED=0
 I 'SELECTED D
 . I $P(FILTER,"^",1)=4 S VALMHDR(1)="" Q
 . I $P(FILTER,"^",1)=1 D  Q
 . . S VALMHDR(1)="Insurance Companies that begin with: "_$P(FILTER,"^",2)
 . I $P(FILTER,"^",1)=2 D  Q
 . . S VALMHDR(1)="Insurance Companies that contain: "_$P(FILTER,"^",2)
 . S XX=$P(FILTER,"^",2)_" - "_$P(FILTER,"^",3)
 . S VALMHDR(1)="Insurance Companies in range: "_XX
 S XX=$S(WHICH=1:"Active ",WHICH=0:"Inactive ",1:"All ")
 S XX="Showing "_XX_"Insurance Companies"
 ;
 ; Add Payer filter, if present
 I PIEN'="" D
 . S PNM=$E($$GET1^DIQ(365.12,PIEN_",",.01),1,30)
 . S PNM="Payer: "_PNM
 . S XX=$$SETSTR^VALM1(PNM,XX,40,40)        ; Payer Name
 S VALMHDR(2)=XX
 S VALMHDR(3)=NUMSEL_" Insurance Companies selected"
 Q
 ;
INIT ;EP
 ; Initialize variables and list array
 ; Input: None
 ; Output:  ^TMP("IBCNILK",$J) - Body lines to display
 K ^TMP("IBCNILK",$J),^TMP("IBCNILKIX",$J),^TMP("IBCNILKA",$J)
 D BLD
 Q
 ;
BLD ; Build listman body
 ; Input:   FILTER    - Current Insurance Company Filter (See EN for details)
 ;          WHICH     - 1 - Only Show Active Insurance Companies
 ;                      0 - Only Show Inactive Insurance Companies
 ;                      2 - Show Both Active and Inactive Insurance Companies
 ; Output:  VALMCNT   - Total number of lines displayed in the body
 ;          ^TMP("IBCNILK",$J)   - Body lines to display
 ;          ^TMP("IBCNILKIX",$J) - Index of Entry IENs by display line
 N FTEXT1,FTEXT2,FTYPE,ICTR,IIEN,INACT,INM,INMU,LINE,PLEN,SKIP,START,STOP,XX
 S FTYPE=$P(FILTER,"^",1)
 S FTEXT1=$P(FILTER,"^",2),FTEXT1=$$UP^XLFSTR(FTEXT1)
 S FTEXT2=$P(FILTER,"^",3),FTEXT2=$$UP^XLFSTR(FTEXT2)
 S:FTYPE=4 FTEXT1="A"
 S:FTYPE=1 PLEN=$L(FTEXT1)
 S:FTYPE=3 PLEN=$L(FTEXT2)
 S (ICTR,STOP,VALMCNT)=0,INM=""
 S:FTYPE'=2 INM=$O(^DIC(36,"B",FTEXT1),-1)
 F  D  Q:(INM="")!STOP
 . S INM=$O(^DIC(36,"B",INM))
 . Q:INM=""
 . S INMU=$$UP^XLFSTR(INM)
 . I FTYPE=1,$E(INMU,1,PLEN)'=FTEXT1 S STOP=1 Q
 . I FTYPE=2,INMU'[FTEXT1 Q
 . I FTYPE=3 D  Q:STOP
 . . S START=$E(FTEXT1,1,$L(FTEXT1))
 . . S XX=$E(INMU,1,$L(FTEXT1))
 . . Q:XX=START
 . . Q:$E(INMU,1,PLEN)']FTEXT2
 . . S STOP=1
 . S IIEN=""
 . F  D  Q:IIEN=""
 . . S IIEN=$O(^DIC(36,"B",INM,IIEN))
 . . Q:IIEN=""
 . . Q:'$D(^DIC(36,IIEN))                   ; Corrupt data index, skip
 . . S SKIP=0
 . . I PIEN'="" D  Q:SKIP                   ; Wrong payer
 . . . S XX=$$GET1^DIQ(36,IIEN_",",3.1,"I")
 . . . S:XX'=PIEN SKIP=1
 . . S INACT=+$$GET1^DIQ(36,IIEN_",",.05,"I")
 . . I WHICH=1,INACT=1 Q                    ; Not Active
 . . I WHICH=0,INACT=0 Q                    ; Not Inactive
 . . S ICTR=ICTR+1
 . . S LINE=$$BLDLN(ICTR,IIEN)
 . . S VALMCNT=VALMCNT+1
 . . D SET^VALM10(VALMCNT,LINE,LINE)
 . . S ^TMP("IBCNILKIX",$J,ICTR)=IIEN
 ;
 I VALMCNT=0 D
 . S ^TMP("IBCNILK",$J,1,0)="No Insurance Companies matching filter criteria were found."
 Q
 ;
BLDLN(ICTR,IIEN) ;EP
 ; Builds a line to display one insurance company
 ; Input:   ICTR                        - Selection Number
 ;          IIEN                        - IEN of the insurance company to be
 ;                                        displayed
 ;          ^TMP("IBCNILKA",$J,IIEN)   - Array of currently selected
 ;                                        Insurance Companies
 ; Output:  LINE    - Formatted for setting into the list display
 N LINE,LINEI,XX
 S:$D(^TMP("IBCNILKA",$J,IIEN)) ICTR=ICTR_">"       ; Mark as selected
 S LINE=$$SETSTR^VALM1(ICTR,"",1,4)                 ; Selection #
 S XX=$$GET1^DIQ(36,IIEN_",",.01)
 S LINE=$$SETSTR^VALM1(XX,LINE,7,30)                ; Ins Co Name
 S XX=+$$GET1^DIQ(36,IIEN_",",.05,"I")
 S XX=$S(XX:"I",1:"A")
 S LINE=$$SETSTR^VALM1(XX,LINE,41,1)                ; Active/Inactive
 S XX=$$GET1^DIQ(36,IIEN_",",.111)
 S LINE=$$SETSTR^VALM1(XX,LINE,46,35)               ; Street Address
 S XX=$$GET1^DIQ(36,IIEN_",",.114)
 S LINE=$$SETSTR^VALM1(XX,LINE,84,25)               ; City
 S XX=$$GET1^DIQ(36,IIEN_",",.115,"I")
 S XX=$$GET1^DIQ(5,XX_",",1)
 S LINE=$$SETSTR^VALM1(XX,LINE,111,2)               ; State
 S XX=$$GET1^DIQ(36,IIEN_",",.116)
 S LINE=$$SETSTR^VALM1(XX,LINE,116,20)              ; Zip Code
 Q LINE
 ;
HELP ;EP
 ; Help code
 ; Input: None
 D FULL^VALM1
 S VALMBCK="R"
 W @IOF,"A '>' after the Insurance Company Selection number indicates that this Insurance"
 W !,"Company has already been selected."
 Q
 ;
EXIT ;EP
 ; Exit code
 ; Input: None
 K ^TMP("IBCNILK",$J),^TMP("IBCNILKIX",$J)
 D CLEAR^VALM1
 Q
 ;
SEL ;EP
 ; Protocol Action to de-select an already selected insurance company
 ; Input:   NUMSEL                  - Current number of selected insurance
 ;                                    companies
 ;          ^TMP("IBCNILK",$J)     - Current Array of displayed Ins Cos
 ;          ^TMP("IBCNILKIX",$J)   - Current Index of displayed Ins Cos
 ;          ^TMP("IBCNILKA,$J,IIEN)- Current Array of selected Ins Cos
 ; Output:  NUMSEL                  - Updated number of selected insurance
 ;                                    companies
 ;          ^TMP("IBCNILKA,$J,IIEN)- Updated Array of selected Ins Cos
 ;          Selected Insurance Company is removed from the worklist 
 ;          Error message displayed (potentially)
 N DIR,DIROUT,DIRUT,DLINE,DTOUT,DUOUT,ERROR,IEN,IIENS,IX,LINE,PROMPT
 S VALMBCK="R",ERROR=0
 ; 
 ; First select the Insurance Company(s) to be selected
 S PROMPT="Select Insurance Company(s)"
 S IIENS=$$SELINS(1,PROMPT,.DLINE,1,"IBCNILKIX")
 I IIENS="" S VALMBCK="R" Q                 ; None Selected
 F IX=1:1:$L(IIENS,",") D
 . S IIEN=$P(IIENS,",",IX)
 . S LINE=$P(DLINE,",",IX)
 . ;
 . ; If currently selected, display an error message
 . I $D(^TMP("IBCNILKA",$J,IIEN)) D  Q
 . . W !,*7,">>>> # ",LINE," is currently selected."
 . . S ERROR=1
 . D MARK(1,IIEN,LINE,.NUMSEL)              ; Show the selection mark
 D HDR                                      ; Update the header
 D:ERROR PAUSE^VALM1
 Q
 ;
UNSEL(SELECTED) ;EP
 ; Protocol Action to deselect an already selected insurance company
 ; Input:   SELECTED                - 1 - Called from IBCN INS CO ACTIVE UNSELECT
 ;                                    0 - Called from IBCN INS CO UNSELECT
 ;                                    Optional, defaults to 0
 ;          NUMSEL                  - Current number of selected insurance
 ;                                    companies
 ;          ^TMP("IBCNILK",$J)     - Current Array of displayed Ins Cos
 ;          ^TMP("IBCNILKS",$J)    - Current Array of selecte Ins Cos
 ;          ^TMP("IBCNILKIX",$J)   - Current Index of displayed Ins Cos
 ;          ^TMP("IBCNILKA,$J,IIEN)- Current Array of selected Ins Cos
 ; Output:  NUMSEL                  - Current number of selected insurance
 ;                                    companies
 ;          ^TMP("IBCNILKA,$J,IIEN)- Updated Array of selected Ins Cos
 ;          Selected Insurance Company is removed from the worklist 
 ;          Error message displayed (potentially)
 N DIR,DIROUT,DIRUT,DLINE,DTOUT,DUOUT,ERROR,IEN,IIENS,IX,LINE,PROMPT,WARRAY
 I '$D(SELECTED) D
 . S SELECTED=0,WARRAY="IBCNILKIX"
 E  S WARRAY="IBCNILKSIX"
 S VALMBCK="R",ERROR=0
 ; 
 ; First select the Insurance Company(s) to be deselected
 S PROMPT="Deselect Insurance Company(s)"
 S IIENS=$$SELINS(1,PROMPT,.DLINE,1,WARRAY)
 I IIENS="" S VALMBCK="R" Q                 ; None Selected
 F IX=1:1:$L(IIENS,",") D
 . S IIEN=$P(IIENS,",",IX)
 . S LINE=$P(DLINE,",",IX)
 . ;
 . ; If not currently selected, display an error message
 . I '$D(^TMP("IBCNILKA",$J,IIEN)) D  Q
 . . W !,*7,">>>> # ",LINE," is not currently selected. It cannot be deselected."
 . . S ERROR=1
 . D MARK(0,IIEN,LINE,.NUMSEL)              ; Deselect the entry
 D HDR(SELECTED)                            ; Update the header
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
 ;          NUMSEL  - Current # of selected Insurance Companies
 ;          ^TMP("IBCNILKA",$J)- Current array of selected Insurance Companies 
 ; Output:  Insurance  Company is marked or unmarked as selected
 ;          NUMSEL  - Current # of selected Insurance Companies
 ;          ^TMP("IBCNILKA",$J)- Updated array of selected Insurance Companies 
 ;      
 N TEXT
 I WHICH D                                  ; Mark as selected
 . S ^TMP("IBCNILKA",$J,IIEN)=""
 . S TEXT=LINE_">",NUMSEL=NUMSEL+1
 E  D                                       ; Mark as selected
 . K ^TMP("IBCNILKA",$J,IIEN)
 . S TEXT=LINE,NUMSEL=NUMSEL-1
 D FLDTEXT^VALM10(LINE,"CTR",TEXT)          ; Update display
 D WRITE^VALM10(LINE)                       ; Redisplay line
 Q
 ;
SHOWSEL ;EP
 ; Protocol action used to display a listman template of the currently
 ; selected Insurance companies
 ; Input:   NUMSEL                      - Current number of selected insurance
 ;                                        companies
 ;          ^TMP("IBCNILKA",$J,IEN)    - Current Array of selected insurance
 ;                                        companies
 ; Output:  NUMSEL                      - Updated number of selected insurance companies
 ;          ^TMP("IBCNILKA",$J,IEN)    - Updated Array of selected insurance
 ;                                        companies
 S VALMBCK="R"
 D EN^VALM("IBCN INS CO SELECTED")
 D HDR,BLD
 Q
 ;
SELINS(FULL,PROMPT,DLINE,MULT,WLIST)    ;EP
 ; Select Insurance Company(s) to perform an action upon
 ; Also called from IBCNILK@UNSEL
 ; Input:   FULL                    - 1 - full screen mode, 0 otherwise
 ;          PROMPT                  - Prompt to be displayed to the user
 ;          MULT                    - 1 to allow multiple entry selection
 ;                                    0 to only allow single entry selection
 ;                                    Optional, defaults to 0
 ;          WLIST                   - Worklist, the user is selecting from
 ;          ^TMP("IBCNILKIX",$J)   - Index of displayed lines of the Ins Co
 ;                                    Selector Template. 
 ;                                    Only used when WLIST="IBCNILKIX"
 ;          ^TMP("IBCNILKSIX",$J)  - Index of displayed lines of the Ins Cos
 ;                                    Selected Template
 ;                                    Only used if WLIST is "IBCNILKSIX"
 ; Output:  DLINE                   - Comma delimited list of Line #(s) of the 
 ;                                    selected Ins Cos
 ; Returns: IIEN(s) - Comma delimited string or IENS for the selected Ins Co(s)
 ;          Error message and "" IENS if multi-selection and not allowed
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IIEN,IIENS,IX,VALMY,X,Y
 S:'$D(MULT) MULT=0
 S:'$D(WLIST) WLIST="IBCNILK"
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
INIT2 ;EP for Show Selections
 ; Initialize variables and list array
 ; Input: None
 ; Output:  ^TMP("IBCNILK",$J) - Body lines to display
 K ^TMP("IBCNILKS",$J),^TMP("IBCNILKSIX",$J)
 D BLD2
 Q
 ;
BLD2 ; Build listman body for Show Selections
 ; Input:   None
 ; Output:  VALMCNT   - Total number of lines displayed in the body
 ;          ^TMP("IBCNILKS",$J)   - Body lines to display
 ;          ^TMP("IBCNILKSIX",$J) - Index of Entry IENs by display line
 N IIEN,LINE,NM,SORTED
 ;
 ; First sort the currently selected insurance companies into name order
 S IIEN=""
 F  D  Q:IIEN=""
 . S IIEN=$O(^TMP("IBCNILKA",$J,IIEN))
 . Q:IIEN=""
 . S NM=$$GET1^DIQ(36,IIEN_",",.01)
 . S SORTED(NM,IIEN)=""
 ;
 ; Now build the lines to be displayed
 S (ICTR,VALMCNT)=0,NM=""
 F  D  Q:NM=""
 . S NM=$O(SORTED(NM))
 . Q:NM=""
 . S IIEN=""
 . F  D  Q:IIEN=""
 . . S IIEN=$O(SORTED(NM,IIEN))
 . . Q:IIEN=""
 . . S ICTR=ICTR+1
 . . S LINE=$$BLDLN(ICTR,IIEN)
 . . S VALMCNT=VALMCNT+1
 . . D SET^VALM10(VALMCNT,LINE,LINE)
 . . S ^TMP("IBCNILKSIX",$J,ICTR)=IIEN
 ;
 I VALMCNT=0 D
 . S ^TMP("IBCNILK",$J,1,0)="No Selected Insurance Companies were found."
 Q
 ;
EXIT2 ;EP for Show Selections
 ; Exit code
 ; Input: None
 K ^TMP("IBCNILKS",$J),^TMP("IBCNILKSIX",$J)
 D CLEAR^VALM1
 Q
 ;
