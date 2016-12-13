IBCNCH2 ;ALB/FA - PATIENT POLICY COMMENT HISTORY ;27-APR-2015
 ;;2.0;INTEGRATED BILLING;**549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Patient Policy Comments - 1. Build main insurance comment display
 ;                           2. Search Comments for a specified String
 ;
BLD(DFN,IBIIEN) ;EP
 ; Build the listman template body of the main Insurance Comment display
 ; Input:   DFN                     - IEN of the patient
 ;          IBIIEN                  - ^DPT(DFN,.312,IBIIEN,0) Where IBIIEN is the
 ;                                    multiple IEN of the selected patient policy
 ;          ^TMP($J,"IBCNCHIX",CNT) - See GETCOMS
 N CNT,LINE,LN,XX
 D GETCOMS(DFN,IBIIEN)
 S VALMCNT=0,LINE="",CNT=""
 ;
 F  D  Q:CNT=""
 . S CNT=$O(^TMP($J,"IBCNCHIX",CNT))
 . Q:CNT=""
 . I CNT'=1 D
 . . S VALMCNT=VALMCNT+1
 . . D SET^VALM10(VALMCNT,"",VALMCNT)
 . ;
 . S VALMCNT=VALMCNT+1
 . D BLDONEC(.VALMCNT,CNT)
 ;
 I VALMCNT=0  D
 . S VALMCNT=1,XX="   *** No comments to display ***"
 . D SET^VALM10(VALMCNT,XX,VALMCNT)
 Q
 ;
BLDONEC(VALMCNT,COMCNT) ; (Re)Build one comment into the listman display
 ; Called from BLD and after adding or editing a comment
 ; Input:   VALMCNT                     - Current Line of the display being
 ;                                       (re)built
 ;          COMCNT                      - Comment Number
 ;          ^TMP($J,"IBCNCHIX",COMCNT)  - See GETONEC for details
 ; Output:  VALMCNT                     - Updated Line of the display being
 ;                                       (re)built
 N DATALN,LINE
 S LINE=$$SETL("",COMCNT,"",1,4)                ; Comment #
 S DATALN=^TMP($J,"IBCNCHIX",COMCNT)
 S XX=$P(DATALN,"^",1)                          ; Dt Entered
 S LINE=$$SETL(LINE,XX,"",6,15)
 D SET^VALM10(VALMCNT,LINE,VALMCNT)
 S XX=$P(DATALN,"^",2)                          ; Entered By
 S LINE=$$SETL(LINE,XX,"",18,37)
 D SET^VALM10(VALMCNT,LINE,VALMCNT)
 S XX=$P(DATALN,"^",4)                          ; Method
 S LINE=$$SETL(LINE,XX,"",44,52)
 D SET^VALM10(VALMCNT,LINE,VALMCNT)
 S XX=$P(DATALN,"^",3)                          ; Person Contacted
 S LINE=$$SETL(LINE,XX,"",55,80)
 D SET^VALM10(VALMCNT,LINE,VALMCNT)
 S VALMCNT=VALMCNT+1
 S XX=$E($P(DATALN,"^",8),1,132)                ; Start of Comment
 S LINE=$$SETL("",XX,"",6,80)
 D SET^VALM10(VALMCNT,LINE,VALMCNT)
 Q
 ;
GETCOMS(DFN,IBIIEN) ; Retrieves the policy comments for the selected
 ; patient and policy in most recent date order
 ; Input:   DFN                     - IEN of the patient
 ;          IBIIEN                  - ^DPT(DFN,.312,IBIIEN,0) Where IBIIEN is the
 ;                                    multiple IEN of the selected patient policy
 ; Output:  ^TMP($J,"IBCNCHIX",CNT) - A1^A2^A3^A4^A5^A6^A7^A8^A9^A10
 ;                                    See GETONEC for detailed explanation
 N CNT,COMDT,COMIEN
 S CNT=0,COMDT=""
 F  D  Q:COMDT=""
 . S COMDT=$O(^DPT(DFN,.312,IBIIEN,13,"B",COMDT),-1)
 . Q:COMDT=""
 . S COMIEN=""
 . F  D  Q:COMIEN=""
 . . S COMIEN=$O(^DPT(DFN,.312,IBIIEN,13,"B",COMDT,COMIEN),-1)
 . . Q:COMIEN=""
 . . S CNT=CNT+1
 . . D GETONEC(DFN,IBIIEN,COMIEN,CNT)           ; Get One Comment
 Q
 ;
GETONEC(DFN,IBIIEN,COMIEN,CNT,CLEN,FULL,NOSET)  ;EP
 ; Get the Data for a specified Policy Comment
 ; Input:   DFN                     - IEN of the patient
 ;          IBIIEN                  - ^DPT(DFN,.312,IBIIEN,0) Where IBIIEN is the
 ;                                    multiple IEN of the selected patient policy
 ;          COMIEN                  - ^DPT(DFN,.312,IBIIEN,13,COMIEN,0) Where 
 ;                                    COMIEN is the multiple IEN of the selected
 ;                                    Patient Policy Comment
 ;          CNT                     - Current Comment Selection Number
 ;          CLEN                    - Length of Partial Comment to be displayed
 ;                                    Optional, defaults to 74
 ;          FULL                    - 1 to return the full comment text,
 ;                                    otherwise
 ;                                    Optional - defaults to 0
 ;          NOSET                   - 1 to not set into ^TMP, 0 otherwise
 ;                                    Optional, defaults to 0
 ; Output:  NOTE: ^TMP($J,"IBCNCHIX",CNT) only set if NOSET=0
 ;          ^TMP($J,"IBCNCHIX",CNT) - A1^A2^A3^A4^A5^A6^A7^A8^A9^A10
 ;                  Where:
 ;                          CNT - Comment selection # (comments ordered by
 ;                               (date entered)
 ;                          A1  - External date/time the comment was entered
 ;                                NOTE: has a leading '+' when A8 > CLEN
 ;                          A2  - External User Name of the user who entered
 ;                                the comment 
 ;                          A3  - Person Contacted
 ;                          A4  - Method of Contact
 ;                          A5  - Contact Phone #
 ;                          A6  - Call Reference #
 ;                          A7  - Authorization #
 ;                          A8  - Comment
 ;                          A9  - Patient Policy Comment IEN
 ;                          A10 - Comment Selection Number
 N COMMENT,DATAOUT,IENS,XX,ZZ
 S:'$D(FULL) FULL=0
 S:'$D(NOSET) NOSET=0
 S:'$D(CLEN) CLEN=74
 S IENS=COMIEN_","_IBIIEN_","_DFN_","
 S COMMENT=$$GET1^DIQ(2.342,IENS,.03)           ; Comment Text
 S XX=$$GET1^DIQ(2.342,IENS,.01,"I")            ; Internal Date/Time entered
 S ZZ=$S($L(COMMENT)>CLEN:"+",1:" ")            ; Truncated Comment Indicator
 S DATAOUT=ZZ_$$FMTE^XLFDT($P(XX,"^",1),"2DZ")
 S XX=$$GET1^DIQ(2.342,IENS,.02,"I")            ; IEN of Last Edited By User
 S ZZ=$$GET1^DIQ(200,XX,.01)                    ; Entered by user
 S $P(DATAOUT,"^",2)=$E(ZZ,1,24)
 S $P(DATAOUT,"^",3)=$$GET1^DIQ(2.342,IENS,.04) ; Person Contacted
 S ZZ=$$GET1^DIQ(2.342,IENS,.07)
 S $P(DATAOUT,"^",4)=$E(ZZ,1,10)                ; Method of Contact
 S $P(DATAOUT,"^",5)=$$GET1^DIQ(2.342,IENS,.05) ; Contact Phone #
 S $P(DATAOUT,"^",6)=$$GET1^DIQ(2.342,IENS,.06) ; Call Reference #
 S $P(DATAOUT,"^",7)=$$GET1^DIQ(2.342,IENS,.08) ; Authorization #
 S ZZ=$S('FULL:$E(COMMENT,1,CLEN),1:COMMENT)
 S $P(DATAOUT,"^",8)=ZZ                         ; Comment
 S $P(DATAOUT,"^",9)=COMIEN                     ; IEN of the Comment
 S $P(DATAOUT,"^",10)=CNT                       ; Comment Number
 S:'NOSET ^TMP($J,"IBCNCHIX",CNT)=DATAOUT
 Q DATAOUT
 ;
SETL(LINE,DATA,LABEL,COL,LNG) ; Creates a line of data to be set into the body
 ; of the worklist
 ; Input:   LINE    - Current line being created
 ;          DATA    - Information to be added to the end of the current line
 ;          LABEL   - Label to describe the information being added
 ;          COL     - Column position in line to add information add
 ;          LNG     - Maximum length of data information to include on the line
 ; Returns: Line updated with added information
 S LINE=LINE_$J("",(COL-$L(LABEL)-$L(LINE)))_LABEL_$E(DATA,1,LNG)
 Q LINE
 ;
SEARCH(COMIN)  ;EP
 ; Protocol action to Search Patient Policy Comments for selected text
 ; Input:   COMIN   - IEN of the selected Patient Policy Comment
 ;                    Optional - Only sent when called from the expanded
 ;                               comment listman template.
 ;          DFN     - IEN of the selected Patient
 ;          IBIIEN  - ^DPT(DFN,.312,IBIIEN,0) Where IBIIEN is the
 ;                    multiple IEN of the selected Patient Policy
 N FOUND,STEXT
 S VALMBCK="R"
 D FULL^VALM1
 S STEXT=$$GETSTXT()                            ; Get the text to search for
 I STEXT="" D  Q
 . W !!,*7,"No search text selected."
 . D PAUSE^VALM1
 ;
 ; Search all of the Patient Policy Comments for the specified search text
 D SEARCHC(DFN,IBIIEN,STEXT,.FOUND)
 I 'FOUND D  Q
 . W !!,*7,STEXT," not found in any Patient Policy Comments."
 . D PAUSE^VALM1
 ;
 ; Display all the Patient Policy Comments where the text was found
 W !!,STEXT," was found in ",FOUND," Patient Policy Comment(s)."
 W !,"The found text will be highlighted within each comment in the Expanded Entry"
 W !,"display.",!!
 Q:'$$ASKYN^IBCNCH("View the results now",1)
 D SEARCH^IBCNCH3(DFN,IBIIEN,STEXT,.FOUND)
 Q
 ;
GETSTXT() ; Get the text to search for
 ; Input:   None
 ; Returns: text to search for or "" if not entered
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="F",DIR("A")="Enter the text to search for"
 D ^DIR
 Q Y
 ;
SEARCHC(DFN,IBIIEN,STEXT,FOUND) ; Search all the Patient Policy Comments
 ; Input:   DFN         - IEN of the Patient
 ;          IBIIEN      - ^DPT(DFN,.312,IBIIEN,0) Where IBIIEN is the multiple
 ;                        IEN of the selected Patient Policy
 ;          STEXT       - Text to search for
 ; Output:  FOUND       - Array of Patient Policy Comments 
 ;                        FOUND        - A1
 ;                        FOUND(0,CTR) - A2                  
 ;                        FOUND(1,A2)  - CTR
 ;                          Where: A1 - Number of comments where text was found
 ;                                 A2 - IEN of the comment where text was found
 ;                                 CTR- Counter to put sort comments by date
 N CNT,COMDT,COMIEN
 S (CNT,FOUND)=0,COMDT=""
 F  D  Q:COMDT=""
 . S COMDT=$O(^DPT(DFN,.312,IBIIEN,13,"B",COMDT),-1)
 . Q:COMDT=""
 . S COMIEN=""
 . F  D  Q:COMIEN=""
 . . S COMIEN=$O(^DPT(DFN,.312,IBIIEN,13,"B",COMDT,COMIEN),-1)
 . . Q:COMIEN=""
 . . Q:'$$FOUNDT(DFN,IBIIEN,COMIEN,STEXT)
 . . S CNT=CNT+1,FOUND=FOUND+1
 . . S FOUND(0,CNT)=COMIEN,FOUND(1,COMIEN)=CNT
 Q
 ;
FOUNDT(DFN,IBIIEN,COMIEN,STEXT) ; Search the specified comment for the
 ; specified text
 ; Input:   DFN         - IEN of the Patient
 ;          IBIIEN      - ^DPT(DFN,.312,IBIIEN,0) Where IBIIEN is the multiple
 ;                        IEN of the selected Patient Policy
 ;          COMIEN      - IEN of the selected Patient Policy Comment
 ;          STEXT       - Text to search for
 ; Returns: 1 if the STEXT was found, 0 otherwise
 N IENS,XX
 S IENS=COMIEN_","_IBIIEN_","_DFN_","
 S STEXT=$$UP^XLFSTR(STEXT)
 S XX=$$UP^XLFSTR($$GET1^DIQ(2.342,IENS,.04))
 I XX[STEXT Q 1                                 ; Search Contact Person
 S XX=$$UP^XLFSTR($$GET1^DIQ(2.342,IENS,.05))
 I XX[STEXT Q 1                                 ; Search Contact Phone
 S XX=$$UP^XLFSTR($$GET1^DIQ(2.342,IENS,.07))
 I XX[STEXT Q 1                                 ; Search Method
 S XX=$$UP^XLFSTR($$GET1^DIQ(2.342,IENS,.06))
 I XX[STEXT Q 1                                 ; Search Call Reference #
 S XX=$$UP^XLFSTR($$GET1^DIQ(2.342,IENS,.08))
 I XX[STEXT Q 1                                 ; Search Authorization #
 S XX=$$UP^XLFSTR($$GET1^DIQ(2.342,IENS,.03))
 I XX[STEXT Q 1                                 ; Search Comment Text
 Q 0
 ; 
