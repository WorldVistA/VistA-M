IBTREC ;BAH/MBS - Claims Tracking Comment Editor ; Nov 04, 2024@13:01
 ;;2.0;INTEGRATED BILLING;**796,828**;21-MAR-94;Build 3
 ;Per VA Directive 6402, this routine should not be modified.
 ;ICR -# 1350 $$GET1^DIQ(356,CTIEN_",",.18)
 ;ICR -# 2053 - FILE^DIE
 ;ICR -# 2053 - UPDATE^DIE
 ;ICR -#10103 - $$FMTE^XLFDT
 ;ICR -#10116 - VALM1
 ;ICR -#10117 - VALM10
 ;ICR -#10061 - PID^VADPT
 ;ICR -#10102 DISP^XQORM1
 Q
EN(CTIEN,DFN) ; -- main entry point for IBT CLAIMS TRACKING CMT EDITOR
 ;K VALMQUIT
 N DIR,X,Y,IBROTH,IBRGENS,IBOKAY,IBREENT,IBRNB,IBFASTXT   ;ADD NEWING TO IBFASTXT IB*2.0*828
 S (IBROTH,IBRGENS,IBOKAY,IBREENT,IBUP)=0
 I +$G(CTIEN)'>0 D  Q
 . W !!,*7,"Claims Tracking record is not identified."
 . D PAUSE^VALM1
 I +$G(DFN)'>0 D
 . S DFN=$P($G(^IBT(356,CTIEN,0)),U,2)
 S IBRNB=$$GET1^DIQ(356,CTIEN_",",.19,"I")
 I $O(^IBE(356.8,"B","GLOBAL SURGERY",0))=+$G(IBRNB) D  Q:+$G(IBUP)
 . N IBX,IENS,IBFDA,%DT,X,Y
 . S IBRGENS=1
 . W !!," For the RNB of GLOBAL SURGERY, enter the related Surgery Date"
 . ;S %DT("A")=" Enter Surgery Date: ",%DT="AEX" D ^%DT S IBX=+Y,IBUP=$S(Y="^":1,1:0)
 . S DIR(0)="DAO^::EX",DIR("A")=" Enter Surgery Date: "
 . S DIR("?")="A 2-digit year means no more than 20 years in the future, or 80 years in the past."
 . S DIR("?",1)="Examples of Valid Dates:"
 . S DIR("?",2)="   JAN 20 1957 or 20 JAN 57 or 1/20/57 or 012057  (omitting punctuation)"
 . S DIR("?",3)="   T   (for TODAY),  T+1 (for TOMORROW),  T+2,  T+7, etc."
 . S DIR("?",4)="   T-1 (for YESTERDAY),  T-3W (for 3 WEEKS AGO), etc."
 . S DIR("?",5)="If the year is omitted, the computer uses CURRENT YEAR."
 . D ^DIR
 . S IBX=+Y,IBUP=+$G(DUOUT) Q:IBUP
 . Q:IBX'?7N
 . S IBX="Global Surgery: "_$$FMTE^XLFDT(IBX,2),IBX=$E(IBX,1,80)
 . S IENS="+1,"_CTIEN_","
 . S IBFDA(356.04,IENS,.01)=DT ; Date is today
 . S IBFDA(356.04,IENS,.02)=DUZ ; User is current user
 . S IBFDA(356.04,IENS,1)=IBX ; Comment is Comment
 . D UPDATE^DIE(,"IBFDA")
 I $O(^IBE(356.8,"B","OTHER",0))=+$G(IBRNB) D
 . S IBROTH=1
 . W !,"The RNB of OTHER requires a Comment of at least 15 characters"
 F  D  Q:IBOKAY!IBUP
 . S IBOKAY=1
 . I 'IBREENT S DIR(0)="Y",DIR("A")=" ADDITIONALA COMMENTS: ",DIR("B")="Y" D ^DIR
 . I $D(DUOUT) S IBUP=1 Q
 . I Y!(IBREENT) S IBREENT=1,IBFASTXT=0 D EN^VALM("IBT CLAIMS TRACKING CMT EDITOR")
 . L -^IBT(356,+CTIEN)
 . I IBROTH D
 . . S (I,IBOKAY)=0 F  S I=$O(^IBT(356,CTIEN,4,I)) Q:'+I  D  Q:IBOKAY
 . . . I $L($P($G(^IBT(356,CTIEN,4,I,1)),U))>14 S IBOKAY=1
 . . I 'IBOKAY D
 . . . W !,"The RNB of OTHER requires a Comment of at least 15 characters.",!,"No comment currently satisfies this requirement."
 . . . I IBREENT K DIR D PAUSE^VALM1
 W:IBREENT !!!
 Q
 ;
HDR ; -- header code
 D PID^VADPT N IBXR
 ;S VALMHDR(1)="Claims Tracking Entries for: "_$E($P($G(^DPT(DFN,0)),"^"),1,20)_" "_$E($G(^(0)),1)_VA("BID")
 S XX=$E($P(^DPT(DFN,0),"^",1),1,20)_"  "_$P($$PT^IBEFUNC(DFN),"^",2)
 S ZZ=$$GET1^DIQ(2,DFN_",",.03),XX=XX_"  "_ZZ
 S VALMHDR(1)="RNB Comment History for: "_XX
 S VALMHDR(2)="For "_$$GET1^DIQ(356,CTIEN_",",.18)_" on: "_$$GET1^DIQ(356,CTIEN_",",.06)
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP($J,"IBTREC"),^TMP($J,"IBTRECEX")
 D BLD
 Q
 ;
BLD ; -- Build list of comments
 N CNT,LINE,LN,XX
 D GETCMTS(CTIEN)
 S VALMCNT=0,LINE="",CNT=""
 ;
 S CNT=0 F  S CNT=$O(^TMP($J,"IBTRECEX",CNT)) Q:'+CNT  D
 . I CNT'=1 D  ; Set an empty  line between records
 . . S VALMCNT=VALMCNT+1
 . . D SET^VALM10(VALMCNT,"",VALMCNT)
 . ;
 . S VALMCNT=VALMCNT+1
 . D BLDONEC(.VALMCNT,CNT)
 ;
 I VALMCNT=0  D
 . S VALMCNT=1,XX="   *** No comments to display ***"
 . D SET^VALM10(VALMCNT,XX,VALMCNT)
 I $G(IBROTH) S VALMSG="RNB of OTHER requires Comment of at least 15 chars"
 Q
 ;
BLDONEC(VALMCNT,COMCNT) ; -- Build one item
 N DATALN,I,IBTMP,LINE
 S LINE=$$SETL("",COMCNT,"",1,4)                ; Comment #
 S DATALN=^TMP($J,"IBTRECEX",COMCNT)
 S XX=$P(DATALN,"^",1)                          ; Dt Entered
 S LINE=$$SETL(LINE,XX,"",6,12)
 D SET^VALM10(VALMCNT,LINE,VALMCNT)
 S XX=$P(DATALN,"^",2)                          ; Entered By
 S LINE=$$SETL(LINE,XX,"",19,40)
 D SET^VALM10(VALMCNT,LINE,VALMCNT)
 S XX=$P(DATALN,"^",3)                          ; Department
 S LINE=$$SETL(LINE,XX,"",62,17)
 D SET^VALM10(VALMCNT,LINE,VALMCNT)
 ;S XX=$E($P(DATALN,"^",5),1,80)                ; Start of Comment
 S XX=$P(DATALN,"^",5)
 D WRAP(XX,80)
 S I=0 F  S I=$O(IBTMP(I)) Q:'+I  D
 . S VALMCNT=VALMCNT+1
 . D SET^VALM10(VALMCNT,IBTMP(I),VALMCNT)
 ;F I=1:80:$L(XX) D
 ;S I=1 F  D  Q:I'<$L(XX)
 ;. N X,LEN
 ;. S LEN=79
 ;. F  S X=$E(XX,I+LEN) Q:X=" "!(LEN'>0)  S LEN=LEN-1
 ;. S LINE=$$SETL("",$E(XX,I,I+LEN),"",0,80)
 ;. S VALMCNT=VALMCNT+1
 ;. D SET^VALM10(VALMCNT,LINE,VALMCNT)
 ;. S I=I+LEN
 Q
 ;
WRAP(TEXT,LENGTH) ;
 ;Break TEXT into substrings of length LENGTH
 ;Set each substring into array IBTMP with subscripts 1, 2, 3, etc.
 ;Adapted by Eric Dickerson and Nick Ward from Joel Russell's WRAP^GMTSORC and WRAP^TIUFLD
 N IBI,IBY,IBFT1,IBFT2,LINENO
 I $G(TEXT)']"" Q
 S LINENO=1
 F IBI=1:1 D  Q:IBI=$L(TEXT," ")
 . S IBTMP=$P(TEXT," ",IBI)
 . I $L(IBTMP)>LENGTH D
 . . S IBFT1=$E(IBTMP,1,LENGTH)
 . . S IBFT2=$E(IBTMP,LENGTH+1,$L(IBTMP))
 . . S $P(TEXT," ",IBI)=IBFT1_" "_IBFT2
 S IBTMP(LINENO)=$P(TEXT," ")
 F IBI=2:1 D  Q:IBI'<$L(TEXT," ")
 . S:$L($G(IBTMP(LINENO))_" "_$P(TEXT," ",IBI))>LENGTH LINENO=LINENO+1,IBY=1
 . S IBTMP(LINENO)=$G(IBTMP(LINENO))_$S(+$G(IBY):"",1:" ")_$P(TEXT," ",IBI),IBY=0
 Q
 ;
GETCMTS(CTIEN) ; -- Get Comment details
 N CMTIEN,CNT
 S CNT=0,CMTIEN="A"
 F  S CMTIEN=$O(^IBT(356,CTIEN,4,CMTIEN),-1) Q:'+CMTIEN  D
 . S CNT=CNT+1
 . D GETONE(CTIEN,CMTIEN,CNT)
 Q
 ;
GETONE(CTIEN,CMTIEN,CNT) ; -- Get one comment details
 N COMMENT,DPT,DTENT,IENS,USR
 Q:'$D(^IBT(356,CTIEN,4,CMTIEN))
 S IENS=CMTIEN_","_CTIEN_","
 S COMMENT=$$GET1^DIQ(356.04,IENS,1)            ; Comment Text
 S DTENT=$$GET1^DIQ(356.04,IENS,.01,"I")        ; Internal Date/Time entered
 S DTENT=$$FMTE^XLFDT(DTENT,"2DZ")
 S USR=$$GET1^DIQ(356.04,IENS,.02)              ; Entered by user
 S DPT=$$GET1^DIQ(356.04,IENS,.03)              ; Department of user who entered comment
 S ^TMP($J,"IBTRECEX",CNT)=DTENT_U_USR_U_DPT_U_CMTIEN_U_COMMENT
 Q
 ;
SETL(LINE,DATA,LABEL,COL,LNG) ; Creates a line of data to be set into the body
 ; of the worklist - copied from IBCNCH2
 ; Input:   LINE    - Current line being created
 ;          DATA    - Information to be added to the end of the current line
 ;          LABEL   - Label to describe the information being added
 ;          COL     - Column position in line to add information add
 ;          LNG     - Maximum length of data information to include on the line
 ; Returns: Line updated with added information
 S LINE=LINE_$J("",(COL-$L(LABEL)-$L(LINE)))_LABEL_$E(DATA,1,LNG)
 Q LINE
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP($J,"IBTRECEX"),^TMP($J,"IBTREC")
 D FULL^VALM1,CLEAN^VALM10
 Q
 ;
EXPND ; -- expand code
 Q
 ;
ADDCOM ; Add Comment Logic
 N DIR,DA,IBFDA,IENS,X,Y
 D FULL^VALM1
 S VALMBCK="R"
 S IENS="+1,"_CTIEN_","
 S IBFDA(356.04,IENS,.01)=DT ; Date is today
 S IBFDA(356.04,IENS,.02)=DUZ ; User is current user
 ;Get Department
 S DIR(0)="356.04,.03" D ^DIR
 Q:+$G(DIRUT)  ; Quit if user escaped
 S IBFDA(356.04,IENS,.03)=Y ; Department is Department
 ;Get Comment
 S DIR(0)="356.04,1" D ^DIR
 Q:+$G(DIRUT)!(Y']"")  ; Quit if user escaped or comment is empty
 S IBFDA(356.04,IENS,1)=Y ; Comment is Comment
 D UPDATE^DIE(,"IBFDA")
 ;Now rebuild the list!
 D INIT
 Q
EDCOM ; Edit Comment Logic
 N COMIEN,COMCNT,DIR,IBFDA
 S VALMBCK="R"
 D FULL^VALM1
 S COMIEN=$$SELCOM(0,"Select a comment to edit",.COMCNT,"IBTRECEX")
 Q:'COMIEN
 S IENS=COMIEN_","_CTIEN_","
 S IBFDA(356.04,IENS,.02)=DUZ ; User is current user
 ;Get Department
 S DIR(0)="356.04,.03",DIR("B")=$$GET1^DIQ(356.04,IENS,.03) D ^DIR
 Q:+$G(DIRUT)  ; Quit if user escaped
 S IBFDA(356.04,IENS,.03)=Y ; Department is Department
 ;Get Comment
 S DIR(0)="356.04,1",DIR("B")=$$GET1^DIQ(356.04,IENS,1) D ^DIR
 Q:+$G(DIRUT)  ; Quit if user escaped or comment is empty
 S IBFDA(356.04,IENS,1)=Y ; Comment is Comment
 D FILE^DIE(,"IBFDA")
 D INIT
 Q
DELCOM ; Delete Comment Logic
 N COMIEN,COMCNT,DIR,I,IBERR,IBFDA,IBTMP,X,Y,IBOKAY
 S VALMBCK="R"
 D FULL^VALM1
 S COMIEN=$$SELCOM(0,"Select a comment to delete",.COMCNT,"IBTRECEX")
 Q:'COMIEN
 S IENS=COMIEN_","_CTIEN_","
 W !!,*7,"You have selected this comment:",!
 D WRAP($$GET1^DIQ(356.04,IENS,1),80)
 S I=0 F  S I=$O(IBTMP(I)) Q:'+I  W !,IBTMP(I)
 S DIR(0)="Y",DIR("A")="Are you sure you want to delete this comment",DIR("B")="NO" D ^DIR
 K DIR
 Q:Y'=1  ; Anything other than yes means no
 I $G(IBROTH) S IBOKAY=0 D  Q:'IBOKAY
 . S I=0 F  S I=$O(^IBT(356,CTIEN,4,I)) Q:'+I  D  Q:IBOKAY
 . . I I'=COMIEN,$L($P($G(^IBT(356,CTIEN,4,I,1)),U))>14 S IBOKAY=1
 . I 'IBOKAY D
 . . W !,"The RNB of OTHER requires a Comment of at least 15 characters.",!,"No comment currently satisfies this requirement."
 . . K DIR D PAUSE^VALM1
 S IBFDA(356.04,IENS,.01)="@" D FILE^DIE(,"IBFDA","IBERR")
 W !,"Comment has been deleted."
 D PAUSE^VALM1
 D INIT
 Q
 ;
EXSCN ; Exit Screen
 S VALMBCK="R"
 W !!,*7,"I'm sorry, Dave, I'm afaid I cannot let you do that."
 D PAUSE^VALM1
 Q
 ;
SELCOM(FULL,PROMPT,COMCNT,WLIST)    ; copied from IBCNCH
 ; Select Entry(s) to perform an action upon
 ; Input:   FULL                - 1 - full screen mode, 0 otherwise
 ;          PROMPT              - Prompt to be displayed to the user
 ;          WLIST               - Worklist, the user is selecting from
 ;          ^TMP($J,"IBCNCHIX") - Index of displayed lines of the Comment 
 ;                                History Worklist
 ; Output:  COMCNT              - Comment Number of the selected Comment
 ; Returns: Select Comment IEN
 ;          Error message if invalid selection
 N COMIEN,DIROUT,DIRUT,DLINE,DTOUT,DUOUT,END,START,X,Y
 S:'$D(WLIST) WLIST="IBTRECEX"
 S START=1,END=$O(^TMP($J,WLIST,""),-1)+0
 D:FULL FULL^VALM1
 S COMCNT=$P($P($G(XQORNOD(0)),"^",4),"=",2)    ; User selection with action
 S COMCNT=$TR(COMCNT,"/\; .",",,,,,")           ; Check for multi-selection
 ;
 I COMCNT["," D  Q ""                           ; Invalid multi-selection
 . W !,*7,">>>> Only single entry selection is allowed"
 . K DIR
 . D PAUSE^VALM1
 ;
 I $O(^TMP($J,WLIST,""))="" D  Q ""
 . S X=$P(PROMPT," ",$L(PROMPT," "))
 . W !,*7,">>>> No comments to "_X
 . K DIR
 . D PAUSE^VALM1
 ;
 S:COMCNT="" COMCNT=$$SELENTRY(PROMPT,START,END)
 Q:COMCNT="" ""
 S COMIEN=$P($G(^TMP($J,WLIST,COMCNT)),"^",4)
 I COMIEN="" D  Q ""
 . W !,*7,">>>> Invalid selection number"
 . K DIR
 . D PAUSE^VALM1
 Q COMIEN
 ;
SELENTRY(PROMPT,START,END)    ; select a comment
 ; copied fromm IBCNCH
 ; Input:   PROMPT  - Prompt to be displayed to the user
 ;          START   - Start comment # that can be selected
 ;          END     - Ending comment # that can be selected
 ; Returns: Selected Comment # or "" if not selected
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="NO^"_START_":"_END_":0"
 S DIR("A")=PROMPT
 D ^DIR K DIR
 Q X
 ;
TRIGGER ; Trigger to create new comment when old Additional Comment field was edited
 N IBFDA
 S IENS="+1,"_DA_","
 S IBFDA(356.04,IENS,.01)=DT ; Date is today
 S IBFDA(356.04,IENS,.02)=DUZ ; User is current user
 S IBFDA(356.04,IENS,1)=X ; Comment is Comment
 D UPDATE^DIE(,"IBFDA")
 Q
