YTWJSON ;SLC/KCM - Generate JSON Instrument Spec ; 7/20/2018
 ;;5.01;MENTAL HEALTH;**130**;Dec 30, 1994;Build 62
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; %ZOSV                10097
 ; %ZTER                 1621
 ;
GETSPEC(JSON,TEST) ; Get the JSON admin spec for instrument TEST
 I TEST'=+TEST S TEST=$O(^YTT(601.71,"B",TEST,0)) Q:'TEST
 ;
 N $ES,$ET S $ET="D ERRHND^YTWJSON"   ; quit from ERRHND if error
 N TREE,ERR
 D CONTENT(TEST,.TREE)
 D RULES(TEST,.TREE)
 D FMTJSON^YTWJSONO(.TREE,.JSON) ;D ENCODE^VPRJSON("TREE","JSON","ERR")
 Q
ERRHND ; Handle errors & clear stack
 N ERROR S ERROR=$$EC^%ZOSV           ; grab the error code
 I ERROR["ZTER" D UNWIND^%ZTER        ; ignore errors clearing stack
 N $ET S $ET="D ^%ZTER,UNWIND^%ZTER"  ; avoid looping on add'l error
 D ^%ZTER                             ; record failure in error trap
 K JSON                               ; delete the return value
 D UNWIND^%ZTER                       ; clear the call stack
 Q
CONTENT(TEST,TREE) ; build TEST spec as TREE for JSON conversion
 S TREE("name")=$P(^YTT(601.71,TEST,0),U)
 ; TODO: replace Copyright (c) with \u00A9 ??
 S TREE("copyright")=$$HTMLESC^YTWJSONU($G(^YTT(601.71,TEST,7)))
 S TREE("restartDays")=$P($G(^YTT(601.71,TEST,8)),U,7)
 I TREE("restartDays")="" S TREE("restartDays")=2
 ;
 N SECTIONS D SECTIONS(TEST,.SECTIONS)  ; build SECTIONS(questionId)
 N CTNTIDX S CTNTIDX=0                  ; content index - global scope
 N LSTINTRO S LSTINTRO=0                ; last intro used
 ;
 ; loop thru content by sequence, then choices by sequence
 N SEQ,CTNT,X0,X2,QSTN,DISP,RTYP,CTYP
 S SEQ=0 F  S SEQ=$O(^YTT(601.76,"AD",TEST,SEQ)) Q:'SEQ  D
 . S CTNT=0 F  S CTNT=$O(^YTT(601.76,"AD",TEST,SEQ,CTNT)) Q:'CTNT  D
 . . S X0=^YTT(601.76,CTNT,0),QSTN=$P(X0,U,4),DISP=$P(X0,U,8)
 . . S X2=^YTT(601.72,QSTN,2),RTYP=$P(X2,U,2),CTYP=$P(X2,U,3)
 . . ; TEMPORARY for patch 130, if section header and intro text are
 . . ; both there, prepend section header to intro
 . . I $P(X2,U)'=LSTINTRO S LSTINTRO=$P(X2,U) D
 . . . N SECTHDR S SECTHDR=""
 . . . I $D(SECTIONS(QSTN)) S SECTHDR=$P(SECTIONS(QSTN),U,5)
 . . . I $L(SECTHDR) S SECTHDR=SECTHDR_"<br />"
 . . . D ADDINTRO($P(X2,U),$P(X0,U,7),SECTHDR)
 . . E  D
 . . . I $D(SECTIONS(QSTN)) D ADDSECT(SECTIONS(QSTN))
 . . ; code was:
 . . ; I $D(SECTIONS(QSTN)) D ADDSECT(SECTIONS(QSTN))
 . . ; I $P(X2,U)'=LSTINTRO S LSTINTRO=$P(X2,U) D ADDINTRO($P(X2,U),$P(X0,U,7))
 . . D ADDQSTN(QSTN,$P(X0,U,5),$P(X0,U,6))
 . . ;
 . . ; add additional properties based on response type
 . . ; DISP is the MH DISPLAY entry for MHCHOICEDISPLAYID
 . . ; (the entries for question and intro don't appear to do much)
 . . I RTYP=1 D RADIO(QSTN,DISP,CTYP)
 . . I RTYP=2 D SPIN(QSTN,DISP)
 . . I RTYP=3 D TEXT(QSTN,DISP)
 . . I RTYP=4 D DATE(QSTN,DISP)
 . . I RTYP=5 D MEMO(QSTN,DISP)
 . . I RTYP=7 D RANGE(QSTN,DISP,CTYP)
 . . I RTYP=11 D CHECK(QSTN,DISP,CTYP)
 Q
 ;
 ; -- for the control type entry points below --
 ; expects CTNTIDX to be index of current question
 ; QSTN: question id (file 601.72 ien)
 ; CTYP: choice type (file 601.751 ien, multiple)
 ; DISP: choice display id (file 601.88 ien)
 ;
RADIO(QSTN,DISP,CTYP) ; add properties for radio group (1 MCHOICE)
 ; add choices, inline/columns
 S TREE("content",CTNTIDX,"type")="ChoiceQuestion"
 D CHLOOP(CTYP,1) ; 1=MCHOICE -- add choices
 Q:'$G(DISP)  ; no choice level MH DISPAY ENTRY
 N X0 S X0=$G(^YTT(601.88,DISP,0))
 ; for now, make inline if columns > 1
 S TREE("content",CTNTIDX,"inline")=$S($P(X0,U,11)>1:"true",1:"false")
 I $P(X0,U,11) S TREE("content",CTNTIDX,"columns")=$P(X0,U,11)
 ; I $P(X0,U,11)>2 W !,"Test:",TEST,"  Qstn:",QSTN,"  Cols:",$P(X0,U,11)
 Q
SPIN(QSTN,DISP) ; add properties for spin control (2 INTEGER)
 ; add inline, default value, max, min
 S TREE("content",CTNTIDX,"type")="IntegerQuestion"
 D MINMAX(QSTN)
 D MASK(DISP)
 Q
TEXT(QSTN,DISP) ; add properties for edit control (3 STRING)
 ;inline, width, default value (mask), max, min
 S TREE("content",CTNTIDX,"type")="StringQuestion"
 D MINMAX(QSTN)
 D MASK(DISP)
 Q
DATE(QSTN,DISP) ; add properties for date picker  (4 DATE)
 ;add inline, default value
 S TREE("content",CTNTIDX,"type")="DateQuestion"
 D MASK(DISP)
 Q
MEMO(QSTN,DISP) ; add properties for memo control (5 MEMO)
 ; add width, default value
 S TREE("content",CTNTIDX,"type")="MemoQuestion"
 D MASK(DISP)
 Q
RANGE(QSTN,DISP,CTYP) ; add properties for range/slider (7 TRACK BAR)
 ;add min, max, legend (choices), {labels}
 S TREE("content",CTNTIDX,"type")="SliderQuestion"
 D MINMAX(QSTN)
 D CHLOOP(CTYP,7) ; 7=TRACK BAR 
 Q
CHECK(QSTN,DISP,CTYP) ; add properties for check list  (11 CHECKLIST)
 ; add choices, inline/columns
 S TREE("content",CTNTIDX,"type")="CheckQuestion"
 D CHLOOP(CTYP,11) ; 11=CHECKLIST
 N X0 S X0=$G(^YTT(601.88,DISP,0))
 ; for now, make inline if columns > 1
 S TREE("content",CTNTIDX,"inline")=$S($P(X0,U,11)>1:"true",1:"false")
 I $P(X0,U,11) S TREE("content",CTNTIDX,"columns")=$P(X0,U,11)
 Q
 ;
MINMAX(QSTN) ; set max/min properties
 N X2 S X2=$G(^YTT(601.72,QSTN,2))
 I +$P(X2,U,4)=$P(X2,U,4) S TREE("content",CTNTIDX,"min")=+$P(X2,U,4)
 I +$P(X2,U,5)=$P(X2,U,5) S TREE("content",CTNTIDX,"max")=+$P(X2,U,5)
 Q
MASK(DISP) ; set properties from |-delimited MASK field
 Q:'DISP                     ; some instruments have no display pointer
 Q:'$D(^YTT(601.88,DISP,0))  ; some instruments have broken pointers
 N MASK S MASK=$P(^YTT(601.88,DISP,0),U,10)
 I +MASK S TREE("content",CTNTIDX,"controlWidth")=+MASK
 I $L($P(MASK,"|",2)) S TREE("content",CTNTIDX,"default")=$P(MASK,"|",2)
 I $P(MASK,"|",3)="S" S TREE("content",CTNTIDX,"inline")="true"
 Q
CHLOOP(CTYP,CALL) ; loop through choices for a choice type
 ; CTYP: Id for ChoiceTypes (601.751) and ChoiceIdentifier (601.89)
 ; CALL: Code to call for building appropriate type of node
 N CIDF,CSEQ,CHID,CIEN,CIDX
 S CIDX=0,CIDF=$O(^YTT(601.89,"B",CTYP,0)) ; choice identifier ien
 S CSEQ=0 F  S CSEQ=$O(^YTT(601.751,"AC",CTYP,CSEQ)) Q:'CSEQ  D
 . S CHID=0 F  S CHID=$O(^YTT(601.751,"AC",CTYP,CSEQ,CHID)) Q:'CHID  D
 . . ; removed the loop below, since it doesn't seem to buy us anything
 . . ; and it was causing some instruments to have duplicate choices
 . . ; S CIEN=0 F  S CIEN=$O(^YTT(601.751,"AC",CTYP,CSEQ,CHID,CIEN)) Q:'CIEN  D
 . . S CIDX=CIDX+1
 . . I CALL=1 D ADDCH(CIDX,CIDF,CHID) Q   ; radio buttons
 . . I CALL=7 D ADDLGND(CIDX,CHID) Q      ; range control
 . . I CALL=11 D ADDCH(CIDX,CIDF,CHID) Q  ; checklist
 Q
SECTIONS(TEST,SECTIONS) ; build list of sections for TEST
 ; SECTIONS(questionIEN)=ID^TEST^Question^TabName^Header^Format
 N IEN,X0,SCNT
 S SCNT=0
 S IEN=0 F  S IEN=$O(^YTT(601.81,"AC",TEST,IEN)) Q:'IEN  D
 . S X0=^YTT(601.81,IEN,0)
 . S SECTIONS($P(X0,U,3))=X0,SCNT=SCNT+1
 ;I SCNT<2 K SECTIONS    ; only need sections if there are more than one
 Q
ADDSECT(X0) ; add section node
 ; expects TREE, CTNTIDX from CONTENT
 ; X0: ID^TEST^Question^TabName^Header^Format
 S CTNTIDX=CTNTIDX+1
 ; TEMPORARY for 130, treat Section Header as Intro
 I '$L($P(X0,U,5)) QUIT
 S TREE("content",CTNTIDX,"id")="s"_+X0
 S TREE("content",CTNTIDX,"type")="IntroText"
 S TREE("content",CTNTIDX,"text")=$P(X0,U,5)
 ; code was:
 ; S TREE("content",CTNTIDX,"id")="s"_+X0
 ; S TREE("content",CTNTIDX,"type")="Section"
 ; I $L($P(X0,U,4)) S TREE("content",CTNTIDX,"tab")=$P(X0,U,4)
 ; I $L($P(X0,U,5)) S TREE("content",CTNTIDX,"text")=$P(X0,U,5)
 Q
ADDINTRO(IEN,FORMAT,PREPEND) ; add intro node
 ; expects TREE, CTNTIDX from CONTENT
 Q:'IEN
 N TEXT
 S CTNTIDX=CTNTIDX+1
 S TREE("content",CTNTIDX,"id")="i"_+^YTT(601.73,IEN,0)
 S TREE("content",CTNTIDX,"type")="IntroText"
 D BLDTXT^YTWJSONU($NA(^YTT(601.73,IEN,1)),.TEXT)
 S TEXT=PREPEND_TEXT ; TEMPORARY fix of section header
 M TREE("content",CTNTIDX,"text")=TEXT
 Q
ADDQSTN(IEN,DESIG,FORMAT) ; add question node
 N TEXT,X0,X2,ITEXT
 S CTNTIDX=CTNTIDX+1
 S X0=^YTT(601.72,IEN,0),X2=$G(^(2))
 I $L(DESIG),($E(DESIG,$L(DESIG))'=".") S DESIG=DESIG_"."
 S TREE("content",CTNTIDX,"id")="q"_+X0
 D BLDTXT^YTWJSONU($NA(^YTT(601.72,IEN,1)),.TEXT)
 M TREE("content",CTNTIDX,"text")=TEXT
 S TREE("content",CTNTIDX,"text")=DESIG_" "_TREE("content",CTNTIDX,"text")
 S TREE("content",CTNTIDX,"required")=$S($P(X2,U,6)="Y":"true",1:"false")
 I +X2 D
 . D BLDTXT^YTWJSONU($NA(^YTT(601.73,+X2,1)),.ITEXT)
 . M TREE("content",CTNTIDX,"intro")=ITEXT
 ; add HINT? -- not currently used by any of the active instruments
 Q
ADDCH(INDEX,IDENTIEN,CHIEN) ; add choice node
 ; child of current question, use current CTNTIDX
 N IDBASE,NUM,QUICK
 S TREE("content",CTNTIDX,"choices",INDEX,"id")="c"_+^YTT(601.75,CHIEN,0)
 ; default IDBASE to 1 if no file entry for legacy tests
 S IDBASE=$S('IDENTIEN:1,1:$P(^YTT(601.89,IDENTIEN,0),U,2))
 S NUM=$S(IDBASE=0:INDEX-1,IDBASE=1:INDEX,1:"") S:$L(NUM) NUM=NUM_"."
 S TREE("content",CTNTIDX,"choices",INDEX,"text")=NUM_" "_$$HTMLESC^YTWJSONU(^YTT(601.75,CHIEN,1))
 S QUICK=$P(NUM,"."),QUICK=$S(+QUICK=QUICK:+QUICK,1:"") ;S:QUICK QUICK=QUICK+48
 I $L(QUICK) S TREE("content",CTNTIDX,"choices",INDEX,"quickKey")=QUICK
 Q
ADDLGND(INDEX,CHIEN) ; add legend based on choices
 S TREE("content",CTNTIDX,"legend",INDEX)=^YTT(601.75,CHIEN,1)
 Q
RULES(TEST,TREE) ; add RULES for TEST to spec TREE for JSON conversion
 N IRID,RID,RIDX,X,X0,X1,QSTN1,QSTN2
 S RIDX=0
 S QSTN1=0 F  S QSTN1=$O(^YTT(601.83,"AD",TEST,QSTN1)) Q:'QSTN1  D
 . S IRID=0 F  S IRID=$O(^YTT(601.83,"AD",TEST,QSTN1,IRID)) Q:'IRID  D
 . . S RID=$P(^YTT(601.83,IRID,0),U,4),RIDX=RIDX+1
 . . S X0=^YTT(601.82,RID,0),X1=$G(^(1)),X=$P(X0,U,5)
 . . S TREE("rules",RIDX,"question")="q"_QSTN1
 . . S TREE("rules",RIDX,"operator")=$S(X="Does not equal":"NE",X="Equals":"EQ",1:X)
 . . S TREE("rules",RIDX,"value")=$$TRUTHVAL(QSTN1,$P(X0,U,3))
 . . I $L(X1),$P(X0,U,6)="AND" D
 . . . S QSTN2=$P(X0,U,7),X=$P(X1,U,3) Q:'QSTN2
 . . . S TREE("rules",RIDX,"conjunction")="and"
 . . . S TREE("rules",RIDX,"question2")="q"_QSTN2
 . . . S TREE("rules",RIDX,"operator2")=$S(X="Does not equal":"NE",X="Equals":"EQ",1:X)
 . . . S TREE("rules",RIDX,"value2")=$$TRUTHVAL(QSTN2,$P(X1,U,1))
 . . D SETSKIPS(RID,RIDX)
 Q
TRUTHVAL(QSTN,VALUE) ; return the target value for the rule
 ; if MCHOICE, convert from Delphi itemIndex value to choice id
 I $P($G(^YTT(601.72,QSTN,2)),U,2)'=1 Q VALUE  ; not MCHOICE so return value
 N CTYP,CSEQ,CHID,IDX,DONE                     ; otherwise, find choice id
 S CTYP=$P($G(^YTT(601.72,QSTN,2)),U,3),(CSEQ,CHID,DONE,IDX)=0
 F  S CSEQ=$O(^YTT(601.751,"AC",CTYP,CSEQ)) Q:'CSEQ  D  Q:DONE 
 . I IDX=VALUE S CHID=$O(^YTT(601.751,"AC",CTYP,CSEQ,CHID)),DONE=1 Q
 . S IDX=IDX+1
 Q "c"_CHID
 ;
SETSKIPS(RID,RIDX) ; set skipped questions for rule RID at index RIDX
 N SID,QID,SIDX
 S SIDX=0
 S SID=0 F  S SID=$O(^YTT(601.79,"AE",RID,SID)) Q:'SID  D
 . S QID=$P(^YTT(601.79,SID,0),U,4) Q:'QID
 . S SIDX=SIDX+1
 . S TREE("rules",RIDX,"skips",SIDX)="q"_QID
 Q
