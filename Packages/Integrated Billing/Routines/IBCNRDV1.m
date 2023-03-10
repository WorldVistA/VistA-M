IBCNRDV1 ;AITC/TAZ - INSURANCE INFORMATION EXCHANGE VIA RDV ;11-MAR-2020
 ;;2.0;INTEGRATED BILLING;**664**;21-MAR-94;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine is used to exchange insurance information between
 ; facilities.
 ;
 Q  ;Only called from labels
 ;
EN ; -- main entry point for IBCN RDV SELECTION
 N NUMSEL
 S NUMSEL=0
 D EN^VALM("IBCN RDV SELECTOR")
 Q
 ;
HDR ; -- header code
 N PATNAM,VA
 S PATNAM=$$GET1^DIQ(2,DFN_",",.01)
 D PID^VADPT
 S VALMHDR(1)="Patient Name: "_PATNAM_" "_$E(PATNAM,1)_$G(VA("BID"))_" "_$$FMTE^XLFDT($$GET1^DIQ(2,DFN_",",.03))
 S VALMHDR(2)=NUMSEL_" Polic"_$S(NUMSEL=1:"y",1:"ies")_" selected."
 S VALM("TITLE")="Insurance Import Selection"
 Q
 ;
INIT ; -- init variables and list array
 N DATA,LINE,LINEVAR
 K @VALMAR
 D BLD
 Q
 ;
BLD ;
 ;Source Data from ^TMP($J,"IBCNRDV")
 N IIEN,LINE
 S (IIEN,VALMCNT)=0
 F  S IIEN=$O(^TMP($J,"IBCNRDV",IIEN)) Q:'IIEN  D
 . S VALMCNT=VALMCNT+1
 . S LINE=$$BLDLN(VALMCNT,IIEN)
 . D SET^VALM10(VALMCNT,LINE,LINE)
 . S ^TMP("IBCNRDVIX",$J,VALMCNT)=IIEN
 Q
 ;
BLDLN(ICTR,IIEN,DATA) ;EP
 ; Builds a line to display one insurance company
 ; Input:   ICTR                        - Selection Number
 ;          IIEN                        - IEN of the Policy to be displayed
 ;          ^TMP("IBCNRDVA",$J,IIEN)    - Array of currently selected policies
 ;
 ; Output:  LINE    - Formatted for setting into the list display
 N DATA,LINEVAR
 M DATA=^TMP($J,"IBCNRDV",IIEN)
 S LINEVAR=""
 I $D(^TMP("IBCNRDVA",$J,IIEN)) S ICTR=ICTR_">"
 S LINEVAR=$$SETFLD^VALM1(ICTR,LINEVAR,"CTR")
 S LINEVAR=$$SETFLD^VALM1($G(DATA(20.01)),LINEVAR,"INSCO")
 S LINEVAR=$$SETFLD^VALM1($G(DATA(40.02)),LINEVAR,"GRPNM")
 S LINEVAR=$$SETFLD^VALM1($$GET1^DIQ(4,$G(DATA(.14)),.01),LINEVAR,"SITE")
 Q LINEVAR
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 ;File selected plans
 I $D(IBFASTXT)!'$D(^TMP("IBCNRDVA",$J)) G EXITQ
 N X,Y
 S DIR(0)="YA",DIR("A")="Are you sure you want to file the selected plans? (Y/N): ",DIR("B")="Y"
 D ^DIR K DIR
 I Y D
 . N IBB,IIEN
 . S IIEN=0
 . F  S IIEN=$O(^TMP("IBCNRDVA",$J,IIEN)) Q:'IIEN  D
 .. M IBB=^TMP($J,"IBCNRDV",IIEN)
 .. S IBB=$$ADDSTF^IBCNBES($G(IBB(.03),1),DFN,.IBB)
 . W !!,NUMSEL," entr",$S(NUMSEL=1:"y has",1:"ies have")," been added to the Insurance Buffer File."
 . D WAIT^VALM1
 ;
EXITQ ;
 K @VALMAR,^TMP("IBCNRDVIX",$J),^TMP("IBCNRDVA",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
SEL ;EP
 ; Protocol Action to select an unselected policy
 ; Input:   NUMSEL                  - Current number of selected policies
 ;          ^TMP("IBCNRDV1",$J)     - Current Array of displayed policies
 ;          ^TMP("IBCNRDVIX",$J)    - Current Index of displayed policies
 ;          ^TMP("IBCNRDVA,$J,IIEN) - Current Array of selected policies
 ; Output:  NUMSEL                  - Updated number of selected policies
 ;          ^TMP("IBCNRDVA,$J,IIEN)- Updated Array of selected policies
 ;          Selected Insurance Company is added to the worklist 
 ;          Error message displayed (potentially)
 N DIR,DIROUT,DIRUT,DLINE,DTOUT,DUOUT,ERROR,IEN,IIENS,IX,LINE,PROMPT
 S VALMBCK="R",ERROR=0
 ; 
 ; First select the Policy(s) to be selected
 S PROMPT="Select Policy(s)"
 S IIENS=$$SELINS(1,PROMPT,.DLINE,1,"IBCNRDVIX")
 I IIENS="" S VALMBCK="R" Q                 ; None Selected
 F IX=1:1:$L(IIENS,",") D
 . S IIEN=$P(IIENS,",",IX)
 . S LINE=$P(DLINE,",",IX)
 . ;
 . ; If currently selected, display an error message
 . I $D(^TMP("IBCNRDVA",$J,IIEN)) D  Q
 . . W !,*7,">>>> # ",LINE," is currently selected."
 . . S ERROR=1
 . D MARK(1,IIEN,LINE,.NUMSEL)              ; Show the selection mark
 D HDR                                      ; Update the header
 D:ERROR PAUSE^VALM1
 Q
 ;
UNSEL(SELECTED) ;EP
 ; Protocol Action to deselect an already selected policy
 ; Input:   SELECTED                - 1 - Called from IBCN RDV POL DESELECT
 ;                                    0 - Called from IBCN RDV DESELECT
 ;                                    Optional, defaults to 0
 ;          NUMSEL                  - Current number of selected policies
 ;          ^TMP("IBCNRDV",$J)     - Current Array of displayed policies
 ;          ^TMP("IBCNRDVS",$J)    - Current Array of selected policies
 ;          ^TMP("IBCNRDVIX",$J)   - Current Index of displayed policies
 ;          ^TMP("IBCNRDVA,$J,IIEN)- Current Array of selected policies
 ; Output:  NUMSEL                  - Current number of selected policies
 ;          ^TMP("IBCNRDVA,$J,IIEN)- Updated Array of selected policies
 ;          Selected policy is removed from the worklist 
 ;          Error message displayed (potentially)
 N DIR,DIROUT,DIRUT,DLINE,DTOUT,DUOUT,ERROR,IEN,IIENS,IX,LINE,PROMPT,WARRAY
 I '$D(SELECTED) D
 . S SELECTED=0,WARRAY="IBCNRDVIX"
 E  S WARRAY="IBCNRDVSIX"
 S VALMBCK="R",ERROR=0
 ; 
 ; First select the Policy(s) to be deselected
 S PROMPT="Deselect Policy(s)"
 S IIENS=$$SELINS(1,PROMPT,.DLINE,1,WARRAY)
 I IIENS="" S VALMBCK="R" Q                 ; None Selected
 F IX=1:1:$L(IIENS,",") D
 . S IIEN=$P(IIENS,",",IX)
 . S LINE=$P(DLINE,",",IX)
 . ;
 . ; If not currently selected, display an error message
 . I '$D(^TMP("IBCNRDVA",$J,IIEN)) D  Q
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
 ;          ^TMP("IBCNRDVA",$J)- Current array of selected policies 
 ; Output:  Policy is marked or unmarked as selected
 ;          NUMSEL  - Current # of selected policies
 ;          ^TMP("IBCNRDVA",$J)- Updated array of selected policies 
 ;      
 N TEXT
 I WHICH D                                  ; Mark as selected
 . S ^TMP("IBCNRDVA",$J,IIEN)=""
 . S TEXT=LINE_">",NUMSEL=NUMSEL+1
 E  D                                       ; Mark as selected
 . K ^TMP("IBCNRDVA",$J,IIEN)
 . S TEXT=LINE,NUMSEL=NUMSEL-1
 D FLDTEXT^VALM10(LINE,"CTR",TEXT)          ; Update display
 D WRITE^VALM10(LINE)                       ; Redisplay line
 Q
 ;
SHOWSEL ;EP
 ; Protocol action used to display a listman template of the currently
 ; selected policies
 ; Input:   NUMSEL                      - Current number of selected policies
 ;          ^TMP("IBCNRDVA",$J,IEN)    - Current Array of selected policies
 ; Output:  NUMSEL                      - Updated number of selected policies
 ;          ^TMP("IBCNRDVA",$J,IEN)    - Updated Array of selected policies
 S VALMBCK="R"
 D EN^VALM("IBCN RDV POL SELECTED")
 I '$D(IBFASTXT) D HDR,BLD
 Q
 ;
SELINS(FULL,PROMPT,DLINE,MULT,WLIST)    ;EP
 ; Select Insurance Company(s) to perform an action upon
 ; Also called from IBCNRDV1@UNSEL
 ; Input:   FULL                    - 1 - full screen mode, 0 otherwise
 ;          PROMPT                  - Prompt to be displayed to the user
 ;          MULT                    - 1 to allow multiple entry selection
 ;                                    0 to only allow single entry selection
 ;                                    Optional, defaults to 0
 ;          WLIST                   - Worklist, the user is selecting from
 ;          ^TMP("IBCNRDVIX",$J)   - Index of displayed lines of the policy
 ;                                    Selector Template. 
 ;                                    Only used when WLIST="IBCNRDVIX"
 ;          ^TMP("IBCNRDVSIX",$J)  - Index of displayed lines of the policy
 ;                                    Selected Template
 ;                                    Only used if WLIST is "IBCNRDVSIX"
 ; Output:  DLINE                   - Comma delimited list of Line #(s) of the 
 ;                                    selected Ins Cos
 ; Returns: IIEN(s) - Comma delimited string or IENS for the selected policy(s)
 ;          Error message and "" IENS if multi-selection and not allowed
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IIEN,IIENS,IX,VALMY,X,Y
 S:'$D(MULT) MULT=0
 S:'$D(WLIST) WLIST="IBCNRDV1"
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
 ; Output:  ^TMP("IBCNRDV",$J) - Body lines to display
 S VALMBCK="R"
 K ^TMP("IBCNRDVS",$J),^TMP("IBCNRDVSIX",$J)
 D BLD2
 Q
 ;
BLD2 ; Build listman body for Show Selections
 ; Input:   None
 ; Output:  VALMCNT   - Total number of lines displayed in the body
 ;          ^TMP("IBCNRDVS",$J)   - Body lines to display
 ;          ^TMP("IBCNRDVSIX",$J) - Index of Entry IENs by display line
 N IIEN,LINE
 ;
 ; Build the lines to be displayed
 S (IIEN,VALMCNT)=0
 F  S IIEN=$O(^TMP("IBCNRDVA",$J,IIEN)) Q:'IIEN  D
 . S VALMCNT=VALMCNT+1
 . S LINE=$$BLDLN(VALMCNT,IIEN)
 . D SET^VALM10(VALMCNT,LINE,LINE)
 . S ^TMP("IBCNRDVSIX",$J,VALMCNT)=IIEN
 ;
 I VALMCNT=0 D
 . S ^TMP("IBCNRDVS",$J,1,0)="No Selected Policies were found."
 Q
 ;
EXIT2 ;EP for Show Selections
 ; Exit code
 ; Input: None
 K ^TMP("IBCNRDVS",$J),^TMP("IBCNRDVSIX",$J)
 D CLEAR^VALM1
 Q
