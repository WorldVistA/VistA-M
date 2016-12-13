IBCNCH3 ;ALB/FA - PATIENT POLICY COMMENT HISTORY ;27-APR-2015
 ;;2.0;INTEGRATED BILLING;**549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Patient Policy Comment - Expand the selected Comment
 ;                     OR
 ; Patient Policy Comment - Display Search Comment Results
 ;
EXPCOM(VMODE) ;EP
 ; Protocol action to expand a selected Patient Policy Comment
 ; After selected a comment to expand the IBCNCH POLICY COMMENT EXPAND
 ; Listman template is shown
 ; Input:   VMODE   - 1 if in view only mode, 0 otherwise
 ;                    Optional, defaults to 0
 ;          DFN     - IEN of the selected Patient
 ;          IBIIEN  - ^DPT(DFN,.312,IBIIEN,0) Where IBIIEN is the
 ;                    multiple IEN of the selected Patient Policy
 ; Output:  All Policy Comment History fields displayed
 N COMNUM
 S:'$D(VMODE) VMODE=0
 S VALMBCK="R"
 S COMNUM=$$SELCOM^IBCNCH(1,"Select Comment to expand","","IBCNCHIX")
 Q:COMNUM=""
 D EN(DFN,IBIIEN,COMNUM,VMODE)
 Q
 ;
SEARCH(DFN,IBIIEN,SRCHTXT,FOUNDTXT) ;EP
 ; Called from SEARCH^IBCNCH2 to display all the comments with the found search
 ; text in expanded mode with the search text highlighted wherever it was found
 ; Input:   DFN     - IEN of the selected Patient
 ;          IBIIEN  - ^DPT(DFN,.312,IBIIEN,0) Where IBIIEN is the
 ;                    multiple IEN of the selected Patient Policy
 ;          SRCHTXT - Text user was searching for
 ;          FOUNDTXT- Array of Patient Policy Comment IENS Where the search
 ;                    text was found
 D EN(DFN,IBIIEN,"","",SRCHTXT,.FOUNDTXT)
 Q
 ;
EN(DFN,IBIIEN,COMIEN,VMODE,SRCHTXT,FOUNDTXT) ; Display the expand Listman template
 ; Input:   DFN     - IEN of the selected Patient
 ;          IBIIEN  - ^DPT(DFN,.312,IBIIEN,0) Where IBIIEN is the multiple IEN
 ;                    of the selected Patient Policy
 ;          COMIEN  - IEN of the selected Patient Policy Comment
 ;                    "" when called to in display search text mode
 ;          VMODE   - 1 if in view only mode, 0 otherwise
 ;                    Optional, defaults to 0
 ;          SRCHTXT - Text user was searching for
 ;                    Optional, only passed when displaying found search text
 ;          FOUNDTXT- Array of Patient Policy Comment IENS Where the search
 ;                    text was found
 ;                    Optional, only passed when displaying found search text
 ; Output:  COMIEN  - COMIEN of comment to display in search mode
 ;                    Only set when in search mode
 S:'$D(FOUNDTXT) FOUNDTXT=0
 K VALMQUIT
 I $G(DFN)="" D  Q
 . W !!,*7,"Patient is not identified."
 . D PAUSE^VALM1
 I IBIIEN=0 D  Q
 . W !!,*7,"Patient Policy is not identified."
 . D PAUSE^VALM1
 ;
 I FOUNDTXT D  Q                                ; Display Search listman
 . S COMIEN=FOUNDTXT(0,1)
 . D EN^VALM("IBCNCH POLICY COMMENT SEARCH")
 ;
 I VMODE D  Q
 . D EN^VALM("IBCNCH POL COMMENT EXPAND VIEW")
 D EN^VALM("IBCNCH POLICY COMMENT EXPAND")
 I $G(IBFASTXT)'=1 D
 . D CLEAN^VALM10,INIT^IBCNCH,HDR^IBCNCH
 . S VALMBCK="R"
 Q
 ;
HDR ;EP
 ; Build the listman template header information
 ; Input:   DFN     - IEN of the select Patient
 ;          IBPPOL  - ^DPT(DFN,.312,PIEN,0) Where PIEN is the IEN of the
 ;                    selected Patient Policy
 ;          COMIEN  - IEN of the selected Patient Policy Comment
 ;                    "" when called to in display search text mode
 ;          SRCHTXT - Text user was searching for
 ;                    Optional, only passed when displaying found search text
 ;          FOUNDTXT- Array of Patient Policy Comments Where the search
 ;                    text was found
 ;                    Optional, only passed when displaying found search text
 N WW,XX,YY,ZZ
 S XX=$E($P(^DPT(DFN,0),"^",1),1,20)_"  "_$P($$PT^IBEFUNC(DFN),"^",2)
 S ZZ=$$GET1^DIQ(2,DFN_",",.03),XX=XX_"  "_ZZ
 S VALMHDR(1)="Policy Comment History for: "_XX
 S ZZ=$G(^DPT(DFN,.312,+$P(IBPPOL,"^",4),0))
 S WW=$P($G(^IBA(355.3,+$P(ZZ,"^",18),0)),"^",11)
 S YY=$E($P($G(^DIC(36,+ZZ,0)),"^",1),1,20)_" Insurance Company"
 S XX="** Plan Currently "_$S(WW:"Ina",1:"A")_"ctive **"
 S VALMHDR(2)=$$SETSTR^VALM1(XX,YY,48,29)
 I FOUNDTXT D
 . S YY=FOUNDTXT(1,COMIEN)
 . S XX=$S(YY=1:"1st",YY=2:"2nd",YY=3:"3rd",1:YY_"th")
 . S ZZ="Displaying "_XX_" of "_FOUNDTXT_" Pt Policy Comments where '"
 . S ZZ=ZZ_SRCHTXT_"' was found."
 . S VALMHDR(3)=ZZ
 Q
 ;
INIT ;EP
 ; Initialize the listman template
 ; Input:   DFN                 - IEN of the selected Patient
 ;          IBIIEN              - ^DPT(DFN,.312,IBIIEN,0) Where IBIIEN is the
 ;                                multiple IEN of the selected Patient Policy
 ;          COMIEN              - IEN of the selected Patient Policy Comment
 ;          SRCHTXT             - Text user was searching for
 ;                                Optional, only passed when displaying found
 ;                                          search text
 ;          FOUNDTXT            - Array of Patient Policy Comment IENS Where 
 ;                                the search text was found
 ;                                Optional, only passed when displaying found
 ;                                search text
 ; Output:  ^TMP("IBCNCH3",$J)  - Body lines to display for specified template
 K ^TMP("IBCNCH3",$J)
 S:'$D(SRCHTXT) SRCHTXT=""
 D BLD(DFN,IBIIEN,COMIEN,SRCHTXT)
 Q
 ;
BLD(DFN,IBIIEN,COMIEN,SRCHTXT,SMODE) ; Build the listman template body
 ; Input:   DFN         - IEN of the select Patient
 ;          IBIIEN      - ^DPT(DFN,.312,IBIIEN,0) Where IBIIEN is the
 ;                        multiple IEN of the selected Patient Policy
 ;          COMIEN      - IEN of the selected Patient Policy Comment
 ;          SRCHTXT     - Text user was searching for or null if not in search
 ;                        mode
 N ELINEL,ELINER,IENS,SLINE,STARTR
 S VALMCNT=0,SLINE=1
 S IENS=COMIEN_","_IBIIEN_","_DFN_","
 D BLDCOML(IENS,SLINE,.STARTR,.ELINEL,SRCHTXT)  ; Build Left Column
 ;
 ; The next two lines are in place in case a build right column is ever added.
 ; If one is added, we would need to determine which side has more lines but
 ; since none is currently present, temporarily setting ELINER=ELINEL.
 S ELINER=ELINEL
 S SLINE=$S(ELINEL'>ELINER:ELINER,1:ELINEL)
 D BLDCOMT(IENS,SLINE,.ELINEL,SRCHTXT)          ; Build Comment Text
 S VALMCNT=$O(^TMP("IBCNCH3",$J,""),-1)
 Q
 ;
BLDCOML(IENS,SLINE,STARTR,ELINE,SRCHTXT) ; Build the non-comment section
 ; of the Expanded Comment Display
 ; NOTE:    Code is set-up to allow a section display to the right of
 ;          this section but none exists at present
 ; Input:   IENS    - String of IENS needed to access comment fields
 ;          SLINE   - Starting Line Number
 ;          ELINE   - Current Ending Line Number
 ;          SRCHTXT - Text user was searching for
 ;                    Optional, only passed when displaying found search text
 ; Output:  STARTR  - Line to start displaying Right Column
 ;          ELINE   - Updated Ending Line
 ;
 N XX
 S STARTR=SLINE                                 ; Start of Right Section
 S XX=$$GET1^DIQ(2.342,IENS,.01,"I")
 S XX=$$FMTE^XLFDT(XX,"2SZ")
 S ELINE=$$SET("Last Edited Date: ",XX,SLINE,1)
 S ELINE=$$SET("  Last Edited By: ",$$GET1^DIQ(2.342,IENS,.02),ELINE,1)
 S ELINE=$$SET("  Contact Person: ",$$GET1^DIQ(2.342,IENS,.04),ELINE,1,SRCHTXT)
 S ELINE=$$SET(" Contact Phone #: ",$$GET1^DIQ(2.342,IENS,.05),ELINE,1,SRCHTXT)
 S ELINE=$$SET("          Method: ",$$GET1^DIQ(2.342,IENS,.07),ELINE,1,SRCHTXT)
 S ELINE=$$SET("Call Reference #: ",$$GET1^DIQ(2.342,IENS,.06),ELINE,1,SRCHTXT)
 S ELINE=$$SET(" Authorization #: ",$$GET1^DIQ(2.342,IENS,.08),ELINE,1,SRCHTXT)
 Q
 ;
BLDCOMT(IENS,SLINE,ELINE,SRCHTXT) ; Build the Comment Text Section
 ; Input:   IENS    - String of IENS needed to access comment fields
 ;          SLINE   - Starting Line Number
 ;          ELINE   - Current Ending Line Number
 ;          SRCHTXT - Text user was searching for
 ;                    Optional, only passed when displaying found search text
 ; Output:  ELINE   - Updated Ending Line Number
 ;
 N COMTEXT,CPOS,REM,XX
 S COMTEXT=$$GET1^DIQ(2.342,IENS,.03)
 S ELINE=$$SET("","",SLINE,1)                   ; Spacing Blank Line
 S ELINE=$$SET("Comment","",ELINE,1)
 S ELINE=$$SETC(COMTEXT,ELINE,SRCHTXT)          ; Display comment line(s)
 Q
 ;
SETC(DATA,LINE,SRCHTXT) ; Sets comment text into the body of the worklist
 ; Input:   DATA    - Comment Text to set into line(s)
 ;          LINE    - Current Line text is being set into
 ;          SRCHTXT - Text user was searching for
 ;                    Optional, only passed when displaying found search text
 ; Returns: LINE    - Updated Line text is being set into
 ;
 N CLNEND,CPOS,CWLPOS,CWPOS,CWEPOS,DATAU,SPOS,STLEN,STXTU,XX
 S:'$D(SRCHTXT) SRCHTXT=""
 S STLEN=$L(SRCHTXT)
 S DATAU=$$UP^XLFSTR(DATA)
 S STXTU=$$UP^XLFSTR(SRCHTXT)
 ;
 ; Display the comment text 1 line at a time and if in search mode displaying
 ; any instances of found search text in reverse video
 S (CPOS,SPOS)=0,CLNEND=80
 S (CWLPOS,CWPOS)=1,CWEPOS=$L(DATA)
 F  D  Q:(CWPOS>CWEPOS)
 . I SRCHTXT'="" D
 . . S CPOS=$F(DATAU,STXTU,CWPOS),SPOS=0
 . . Q:'CPOS
 . . S SPOS=CPOS-STLEN                      ; Starting position of found text
 . ;
 . ; Not in search mode OR search text not found in characters CWPOS-CLNEND
 . ; of the comment. Display the text from position CWPOS-CLNEND
 . I 'SPOS!(SPOS>CLNEND) D  Q
 . . S XX=$E(DATA,CWPOS,CLNEND)
 . . D SET1(XX,LINE,CWLPOS,$L(XX))
 . . S LINE=LINE+1,CWLPOS=1
 . . S CWPOS=CLNEND+1,CLNEND=CLNEND+80
 . ;
 . ; Search text found starting somewhere in current comment line.  First
 . ; display any text in front of the found search text
 . I SPOS>1 D
 . . S XX=$E(DATA,CWPOS,SPOS-1),CWPOS=SPOS
 . . D SET1(XX,LINE,CWLPOS,$L(XX))
 . . S CWLPOS=CWLPOS+$L(XX)
 . ;
 . ; If entire search text found in characters CWPOS-CLNEND. Display search
 . ; text in reverse video
 . I (CPOS-1)'>CLNEND D  Q
 . . S XX=$E(DATA,CWPOS,(CPOS-1)),CWPOS=CPOS
 . . D SET1(XX,LINE,CWLPOS,$L(XX),0,1)
 . . S CWLPOS=CWLPOS+STLEN
 . ;
 . ; Search text is straddling comment text lines. First display the start of
 . ; the search text on the current line in reverse video
 . S XX=$E(DATA,SPOS,CLNEND),CWPOS=CLNEND+1
 . D SET1(XX,LINE,CWLPOS,$L(XX),0,1)
 . S LINE=LINE+1,CLNEND=CLNEND+80,CWLPOS=1
 . ;
 . ; Next display remaining search text in reverse video
 . S XX=$E(DATA,CWPOS,(CPOS-1)),CWPOS=CPOS
 . D SET1(XX,LINE,CWLPOS,$L(XX),0,1)
 . S CWLPOS=CWLPOS+$L(XX)
 Q LINE
 ;
SET(LABEL,DATA,LINE,COL,SRCHTXT) ; Sets text into the body of the worklist
 ; Input:   LABEL   - Label text to set into the line
 ;          DATA    - Field Data to set into the line
 ;          LINE    - Line to set LABEL and DATA into
 ;          COL     - Starting column position in LINE to insert
 ;                    LABEL_DATA text
 ;          SRCHTXT - Text user was searching for
 ;                    Optional, only passed when displaying found search text
 ; Returns: LINE    - Updated Line by 1
 ;
 N COL,DATAU,FPOS,START,STXTU,WHICH,XX
 S:'$D(SRCHTXT) SRCHTXT=""
 S DATAU=$$UP^XLFSTR(DATA)
 S STXTU=$$UP^XLFSTR(SRCHTXT)
 S WHICH=$S(SRCHTXT="":0,DATAU[STXTU:1,1:0)
 D SET1(LABEL,LINE,1,$L(LABEL),1)               ; First display the label
 ;
 ; Not in search mode OR search text not found
 I 'WHICH D  Q LINE
 . D SET1(DATA,LINE,$L(LABEL)+1,$L(DATA))
 . S LINE=LINE+1
 ;
 ; Display text with all occurrences of the search text in reverse video
 S COL=$L(LABEL)+1
 F  D  Q:(DATA="")!'FPOS
 . S FPOS=$F(DATAU,STXTU)                       ; Find the search text
 . Q:'FPOS                                      ; No more occurrences found
 . S XX=FPOS-$L(SRCHTXT)-1
 . S START=$S(XX:$E(DATA,1,XX),1:"")
 . I START'="" D
 . . D SET1(START,LINE,COL,$L(START))
 . . S COL=COL+$L(START)
 . S XX=$E(DATA,XX+1,FPOS-1)
 . D SET1(XX,LINE,COL,$L(XX),0,1)
 . S COL=COL+$L(SRCHTXT)
 . S DATA=$E(DATA,FPOS,$L(DATA))
 . S DATAU=$E(DATAU,FPOS,$L(DATAU))
 D:DATA'="" SET1(DATA,LINE,COL,$L(DATA))        ; Display any remaining text
 S LINE=LINE+1
 Q LINE
 ;
SET1(TEXT,LINE,COL,WIDTH,BOLD,RV) ; Sets the TMP array with body data
 ; Input:   TEXT                - Text to be set into the specified line
 ;          LINE                - Line to set TEXT into
 ;          COL                 - Column of LINE to set TEXT into
 ;          WIDTH               - Width of the TEXT being set into line
 ;          BOLD                - 1 - Set bold on, 0 otherwise
 ;                                Optional, defaults to ""
 ;          RV                  - 1 - Set Reverse Video on, 0 otherwise
 ;                                Optional, defaults to ""
 ;          ^TMP("IBCNCH3",$J)  - Current ^TMP array
 ; Output:  ^TMP("IBCNCH3",$J)  - Updated ^TMP array
 ;
 N IBX
 S:'$D(BOLD) BOLD=0
 S:'$D(RV) RV=0
 S IBX=$G(^TMP("IBCNCH3",$J,LINE,0))
 S IBX=$$SETSTR^VALM1(TEXT,IBX,COL,WIDTH)
 D SET^VALM10(LINE,IBX)
 D:BOLD CNTRL^VALM10(LINE,COL,WIDTH,IOINHI,IOINORM)
 D:RV CNTRL^VALM10(LINE,COL,WIDTH,IORVON,IORVOFF)
 Q
 ;
HELP ;EP
 ; Display the listman template help
 N X
 S X="?"
 D DISP^XQORM1
 W !!
 Q
 ;
EXIT ;EP
 ; Exit the listman template
 K ^TMP("IBCNCH3",$J)
 D CLEAR^VALM1
 Q
 ;
NEXTCOM ;EP
 ; Protocol action to show the next comment with the found Search text
 ; Input:   DFN     - IEN of the selected Patient
 ;          IBIIEN  - ^DPT(DFN,.312,IBIIEN,0) Where IBIIEN is the
 ;                    multiple IEN of the selected Patient Policy
 ;          COMIEN  - IEN of the currently displayed Patient Policy Comment
 ;          FOUNDTXT- Array of Patient Policy Comment IENS Where the search
 ;                    text was found
 ; Output:  Next Patient Policy Comment is displayed
 ;          COMIEN  - IEN of the next Patient Policy Comment to display
 N XX
 S VALMBCK="R"
 S XX=FOUNDTXT(1,COMIEN),XX=$O(FOUNDTXT(0,XX))
 I XX="" D  Q
 . W !!,*7,"No more comments with the search text were found."
 . D PAUSE^VALM1
 S COMIEN=FOUNDTXT(0,XX)
 D CLEAN^VALM10
 D HDR,INIT
 Q
 ;
PREVCOM ;EP
 ; Protocol action to show the previous comment with the found Search text
 ; Input:   DFN     - IEN of the selected Patient
 ;          IBIIEN  - ^DPT(DFN,.312,IBIIEN,0) Where IBIIEN is the
 ;                    multiple IEN of the selected Patient Policy
 ;          FOUNDTXT- Array of Patient Policy Comment IENS Where the search
 ;                    text was found
 ; Output:  Next Patient Policy Comment is displayed
 ;          COMIENS - Updated Index into the FOUNDTXT array of the Patient
 ;                    Policy Comment currently being shown
 N XX
 S VALMBCK="R"
 S XX=FOUNDTXT(1,COMIEN),XX=$O(FOUNDTXT(0,XX),-1)
 I XX="" D  Q
 . W !!,*7,"First comment with the search text is already being displayed."
 . D PAUSE^VALM1
 S COMIEN=FOUNDTXT(0,XX)
 D CLEAN^VALM10
 D HDR,INIT
 Q
