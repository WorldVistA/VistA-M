YTXCHGV ;SLC/KCM - Instrument Specification Validation ; 9/15/2015
 ;;5.01;MENTAL HEALTH;**121**;Dec 30, 1994;Build 61
 ;
IDXALL ; Index all tests
 N TEST,CNT,XCHGIDX
 S CNT=1,XCHGIDX=1 ; XCHGIDX is flag to build full index
 D LOG^YTXCHGU("info","Gathering installed instruments")
 L +^XTMP("YTXIDX"):60 E  Q
 K ^XTMP("YTXIDX")
 S ^XTMP("YTXIDX",0)=$$FMADD^XLFDT(DT,1)_U_DT_U_"MH Instrument Combined Index"
 S TEST=0 F  S TEST=$O(^YTT(601.71,TEST)) Q:'TEST  D
 . S CNT=CNT+1
 . W:'(CNT#10) "."
 . D BLDTEST(TEST)
 L -^XTMP("YTXIDX")
 Q
ADDIDX(FILE,IEN,TEST) ; add entry to full index
 N XCHGIDX S XCHGIDX=1
 L +^XTMP("YTXIDX",FILE):DILOCKTM E  Q
 D SETP(FILE,IEN)
 L -^XTMP("YTXIDX",FILE)
 Q
DELIDX(FILE,IEN,TEST) ; remove entry from full index
 L +^XTMP("YTXIDX",FILE):DILOCKTM E  Q
 K ^XTMP("YTXIDX",FILE,IEN,TEST)
 L -^XTMP("YTXIDX",FILE)
 Q
COLLIDE(FILE,IEN) ; return 1 if there is a collision with another instrument
 ; expects TSTIEN to be the IEN of the current instrument
 I '$G(TSTIEN) Q 0  ; no test to compare with
 I $D(^XTMP("YTXIDX","ignore",FILE,IEN)) Q 0  ; ignore collision
 N I,X
 S X=""
 S I=0 F  S I=$O(^XTMP("YTXIDX",FILE,IEN,I)) Q:'I  I I'=TSTIEN D
 . S X=X_$S($L(X):",",1:"")_$P(^YTT(601.71,I,0),U)
 I $L(X) D LOG^YTXCHGU("conflict",FILE_":"_IEN_" used by "_X)
 Q $S($L(X):1,1:0)
 ;
ISONLY(FILE,IEN,TSTIEN) ; return 1 if TEST is only user of FILE:IEN
 N I,CNT
 S CNT=0
 S I=0 F  S I=$O(^XTMP("YTXIDX",FILE,IEN,I)) Q:'I  I I'=TSTIEN S CNT=CNT+1
 Q:'CNT 1
 Q 0
 ;
BLDTEST(TEST,GBLROOT) ; Assemble IEN's used by TEST
 D SETP(601.71,TEST)
 ; MH INSTRUMENT CONTENT loop
 N IC,XC0,IQ,XQ2,ICT,XCT,XCT0
 S IC=0 F  S IC=$O(^YTT(601.76,"AC",TEST,IC)) Q:'IC  D
 . S XC0=$G(^YTT(601.76,IC,0)),IQ=+$P(XC0,U,4)
 . D SETP(601.76,IC)                           ; content entry
 . D SETP(601.72,IQ)                           ; question entry
 . D SETP(601.88,+$P(XC0,U,6))                 ; question display
 . D SETP(601.88,+$P(XC0,U,7))                 ; intro display
 . D SETP(601.88,+$P(XC0,U,8))                 ; choice display
 . S XQ2=$G(^YTT(601.72,IQ,2)),XCT=+$P(XQ2,U,3)
 . D SETP(601.73,+$P(XQ2,U))                   ; intro entry
 . D SETP(601.89,+$O(^YTT(601.89,"B",XCT,0)))  ; choice identifier entry
 . S ICT=0 F  S ICT=$O(^YTT(601.751,"B",XCT,ICT)) Q:'ICT  D
 . . D SETP(601.751,ICT)                       ; choicetype entry
 . . S XCT0=$G(^YTT(601.751,ICT,0))
 . . D SETP(601.75,+$P(XCT0,U,3))              ; choice entry
 ; MH SCALEGROUPS loop
 N IG,XG0,IS,XS0,IK
 S IG=0 F  S IG=$O(^YTT(601.86,"AD",TEST,IG)) Q:'IG  D
 . S XG0=$G(^YTT(601.86,IG,0))
 . D SETP(601.86,IG)                           ; scalegroup entry
 . S IS=0 F  S IS=$O(^YTT(601.87,"AD",IG,IS)) Q:'IS  D
 . . S XS0=$G(^YTT(601.87,IS,0))
 . . D SETP(601.87,IS)                         ; scale entry
 . . S IK=0 F  S IK=$O(^YTT(601.91,"AC",IS,IK)) Q:'IK  D
 . . . D SETP(601.91,IK)                       ; scoring key entry
 ; MH SECTIONS loop
 N I,X0
 S I=0 F  S I=$O(^YTT(601.81,"AC",TEST,I)) Q:'I  D
 . S X0=$G(^YTT(601.81,I,0))
 . D SETP(601.81,I)                            ; section entry
 . D SETP(601.72,+$P(X0,U,3))                  ; question entry
 . D SETP(601.88,+$P(X0,U,6))                  ; section display
 ; MH INSTRUMENTRULES loop
 S I=0 F  S I=$O(^YTT(601.83,"C",TEST,I)) Q:'I  D
 . S X0=$G(^YTT(601.83,I,0))
 . D SETP(601.83,I)                            ; instrumentrule entry
 . D SETP(601.72,+$P(X0,U,3))                  ; question entry
 . D SETP(601.82,+$P(X0,U,4))                  ; rule entry
 ; MH SKIPPED QUESTIONS loop
 S I=0 F  S I=$O(^YTT(601.79,"AC",TEST,I)) Q:'I  D
 . S X0=$G(^YTT(601.79,I,0))
 . D SETP(601.79,I)                            ; skipped question entry
 . D SETP(601.82,+$P(X0,U,3))                  ; rule entry
 . D SETP(601.72,+$P(X0,U,4))                  ; question entry
 Q
SETP(FILE,IEN) ; Set file,ien pair in global
 ; expects XCHGIDX (for cross-file index) or GBLROOT
 Q:'IEN
 Q:'$D(^YTT(FILE,IEN,0))
 I $G(XCHGIDX) S ^XTMP("YTXIDX",FILE,IEN,TEST)="" QUIT
 S @GBLROOT@(FILE,IEN)=""
 Q
 ;
 ;
VERIFY(TREE,YTXERRS,YTXDELS) ; Verify no conflicts, find records to remove
 ;    TREE: global reference for instruments being installed
 ;     SEQ: identifies which instrument
 ;  ERRORS: contains up to 6 instances of record conflicts
 ; DELETES: lists entries that may be deleted
 ;
 N TEST,ENTRY,FILE,IEN,X
 S TEST=@TREE@("info","name")
 S TEST=$O(^YTT(601.71,"B",TEST,0))
 Q:'TEST
 K ^TMP($J,"local")
 D BLDTEST(TEST)
 ;
 ; look for entries that locally might belong to another instrument
 S ENTRY=0,YTXERRS=0
 F  S ENTRY=$O(@TREE@("verify",ENTRY)) Q:'ENTRY  D  Q:YTXERRS>5
 . S X=@TREE@("verify",ENTRY),FILE=$P(X,":"),IEN=$P(X,":",2)
 . I '$$CHKNODE(FILE,IEN) D
 . . S YTXERRS=YTXERRS+1
 . . S YTXERRS(YTXERRS)="Entry "_FILE_":"_IEN_" belongs to another test"
 ;
 ; look for local entries that should be deleted
 S ENTRY=0,YTXDELS=0
 F  S ENTRY=$O(@TREE@("verify",ENTRY)) Q:'ENTRY  D
 . S X=@TREE@("verify",ENTRY),FILE=$P(X,":"),IEN=$P(X,":",2)
 . K ^TMP($J,"local",FILE,IEN)
 S FILE=0 F  S FILE=$O(^TMP($J,"local",FILE)) Q:'FILE  D
 . S IEN=0 F  S IEN=$O(^TMP($J,"local",FILE,IEN)) Q:'IEN  D
 . . S YTXDELS=YTXDELS+1
 . . S YTXDELS(FILE,IEN)=""
 ;
 K ^TMP($J,"local")
 Q
CHKNODE(FILE,IEN) ; Check to see if node belongs to same test
 I '$D(^YTT(FILE,IEN,0)) Q -1         ; not found, node will be added
 I $D(^TMP($J,"local",FILE,IEN)) Q 1  ; same test, node may be updated
 Q 0                                  ; node present, different test
 ;
BELONG(FILE,IEN) ; Return line of instruments this entry belongs to
 N TEST,X
 S X=""
 S TEST=0 F  S TEST=$O(^XTMP("YTXIDX",FILE,IEN,TEST)) Q:'TEST  D
 . S X=X_$S($L(X):",",1:"")_$P(^YTT(601.71,TEST,0),U)
 Q X
 ;
