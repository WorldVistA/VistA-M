YTXCHGE ;SLC/KCM - Instrument Specification Export ; 9/15/2015
 ;;5.01;MENTAL HEALTH;**121**;Dec 30, 1994;Build 61
 ;
EXPORT(TEST,DEST) ; extract test entries into DEST array
 ; TEST -- name or IEN of mental health instrument
 ; DEST -- closed array reference for destination JSON
 ;         caller must make sure DEST is empty
 I 'TEST S TEST=$O(^YTT(601.71,"B",TEST,0)) Q:'TEST
 ;
 N MAP,JSONERR,DISPLAY,YTXCHGDT
 S $E(DEST,$L(DEST))=","        ; use open array ref
 D BLDMAP^YTXCHGM(.MAP)         ; build file:field to JSON name map
 D LDINFO(TEST)                 ; load the instrument information
 D LDCTNT(TEST)                 ; load the instrument content
 D LDSCLS(TEST)                 ; load the instrument scales
 D LDRULE(TEST)                 ; load the instrument rules
 D LDREPT(TEST)                 ; load the instrument report
 D LDDISP                       ; load the display formatting entries
 D LDVER(TEST)                  ; load the verify entries
 Q
LDINFO(TEST) ; load general information for instrument
 ; use entry from MH TESTS AND SURVEYS file (601.71)
 D REC2JSON(601.71,TEST_",")
 N SECIEN,NUMS
 S SECIEN=0 F  S SECIEN=$O(^YTT(601.81,"AC",TEST,SECIEN)) Q:'SECIEN  D
 . S NUMS(1)=$G(NUMS(1))+1
 . D REC2JSON(601.81,SECIEN_",",.NUMS)
 Q
LDCTNT(TEST) ; load question/choice content for instrument
 ; loop through "AD" xref in MH INSTRUMENT CONTENT for each question
 ;   loop through "AC" xref in MH CHOICETYPES for each choice
 N SEQ,CTNT,QSTN,X0,X2,NUMS,CTYP,CIDF,CSEQ,CHID,CIEN
 S SEQ=0 F  S SEQ=$O(^YTT(601.76,"AD",TEST,SEQ)) Q:'SEQ  D
 . S CTNT=0 F  S CTNT=$O(^YTT(601.76,"AD",TEST,SEQ,CTNT)) Q:'CTNT  D
 . . S NUMS(1)=$G(NUMS(1))+1
 . . S X0=^YTT(601.76,CTNT,0),QSTN=$P(X0,U,4)
 . . S X2=^YTT(601.72,QSTN,2),CTYP=$P(X2,U,3)
 . . D REC2JSON(601.76,CTNT_",",.NUMS)        ; content entry
 . . D REC2JSON(601.72,QSTN_",",.NUMS)        ; question
 . . D REC2JSON(601.73,$P(X2,U,1)_",",.NUMS)  ; introduction
 . . D REC2JSON(601.74,$P(X2,U,2)_",",.NUMS)  ; response type
 . . Q:'CTYP
 . . S CIDF=$O(^YTT(601.89,"B",CTYP,0))       ; choice identifier ien
 . . D REC2JSON(601.89,CIDF_",",.NUMS)        ; choice identifier
 . . S CSEQ=0 F  S CSEQ=$O(^YTT(601.751,"AC",CTYP,CSEQ)) Q:'CSEQ  D
 . . . S CHID=0 F  S CHID=$O(^YTT(601.751,"AC",CTYP,CSEQ,CHID)) Q:'CHID  D
 . . . . S CIEN=0 F  S CIEN=$O(^YTT(601.751,"AC",CTYP,CSEQ,CHID,CIEN)) Q:'CIEN  D
 . . . . . S NUMS(2)=$G(NUMS(2))+1
 . . . . . D REC2JSON(601.751,CIEN_",",.NUMS) ; choice type entry
 . . . . . D REC2JSON(601.75,CHID_",",.NUMS)  ; choice entry
 . . K NUMS(2)                                ; reset for next set
 Q
LDSCLS(TEST) ; load scale information for instrument
 ; loop thru "AC" xref in MH SCALEGROUPS for each group (testId,seq,groupId)
 ;   loop thru "AC" xref in MH SCALES for each scale (groupId,seq,scaleId)
 ;     loop thru "AC" xref in MH SCORING KEYS for each key (scaleId,keyId)
 N GSEQ,GID,SSEQ,SID,KID,NUMS
 S GSEQ=0 F  S GSEQ=$O(^YTT(601.86,"AC",TEST,GSEQ)) Q:'GSEQ  D
 . S GID=0 F  S GID=$O(^YTT(601.86,"AC",TEST,GSEQ,GID)) Q:'GID  D
 . . S NUMS(1)=$G(NUMS(1))+1
 . . D REC2JSON(601.86,GID_",",.NUMS)
 . . S SSEQ=0 F  S SSEQ=$O(^YTT(601.87,"AC",GID,SSEQ)) Q:'SSEQ  D
 . . . S SID=0 F  S SID=$O(^YTT(601.87,"AC",GID,SSEQ,SID)) Q:'SID  D
 . . . . S NUMS(2)=$G(NUMS(2))+1
 . . . . D REC2JSON(601.87,SID_",",.NUMS)
 . . . . S KID=0 F  S KID=$O(^YTT(601.91,"AC",SID,KID)) Q:'KID  D
 . . . . . S NUMS(3)=$G(NUMS(3))+1
 . . . . . D REC2JSON(601.91,KID_",",.NUMS)
 . . . . K NUMS(3)
 . . K NUMS(2)
 Q
LDRULE(TEST) ; load rule information for instrument
 N NUMS,IEN,RIEN,SIEN
 S IEN=0 F  S IEN=$O(^YTT(601.83,"C",TEST,IEN)) Q:'IEN  D
 . S NUMS(1)=$G(NUMS(1))+1
 . D REC2JSON(601.83,IEN_",",.NUMS)
 . S RIEN=$P(^YTT(601.83,IEN,0),U,4)
 . D REC2JSON(601.82,RIEN_",",.NUMS)
 . S SIEN=0 F  S SIEN=$O(^YTT(601.79,"AE",RIEN,SIEN)) Q:'SIEN  D
 . . S NUMS(2)=$G(NUMS(2))+1
 . . D REC2JSON(601.79,SIEN_",",.NUMS)
 . K RNUMS
 Q
LDREPT(TEST) ; load the report for an instrument
 N IEN
 S IEN=$O(^YTT(601.93,"C",TEST,0))  ; use first IEN if multiple for reports
 D REC2JSON(601.93,IEN_",")
 Q
LDDISP       ; load display information from IEN's in DISPLAY
 ; loop thru IEN's saved in DISPLAY
 N IEN,NUMS
 S IEN=0 F  S IEN=$O(DISPLAY(IEN)) Q:'IEN  D
 . S NUMS(1)=$G(NUMS(1))+1
 . D REC2JSON(601.88,IEN_",",.NUMS)
 Q
LDVER(TEST) ; load the verify values for an instrument
 ; expects DEST
 K ^TMP($J,"local")
 N FILE,IEN,CNT,ROOT
 S ROOT=$E(DEST,1,$L(DEST)-1)_")" ; use closed array 
 D BLDTEST^YTXCHGV(TEST,$NA(^TMP($J,"local")))
 S FILE=0 F  S FILE=$O(^TMP($J,"local",FILE)) Q:'FILE  D
 . S IEN=0 F  S IEN=$O(^TMP($J,"local",FILE,IEN)) Q:'IEN  D
 . . S CNT=+$G(CNT)+1
 . . S @ROOT@("verify",CNT)=FILE_":"_IEN
 K ^TMP($J,"local")
 Q
 ;
REC2JSON(FILE,IENS,NUMS) ; load record into JSON using MAP
 ; expects MAP,DEST
 ; FILE -- mh file number
 ; IENS -- IEN string (with trailing comma)
 ; NUMS -- array numbers for JSON array
 N FLDS,VALS,ERRS,FLD,SUBS,I,TARGET
 S FLDS=$$FILEFLDS(FILE)
 D GETS^DIQ(FILE,IENS,FLDS,"INZ","VALS","ERRS") ;"IN": internal vals, no nulls
 I $D(MAP(FILE,.001)) S VALS(FILE,IENS,.001,"I")=+IENS
 S FLD=0 F  S FLD=$O(MAP(FILE,FLD)) Q:'FLD  D
 . ;  Q:'$D(VALS(FILE,IENS,FLD,"I"))
 . S SUBS=$$MKSUBS^YTXCHGU(FILE,FLD,.NUMS)
 . S TARGET=DEST_SUBS_")"
 . I '$L($G(VALS(FILE,IENS,FLD,"I"))) D  Q  ; empty value
 . . S @TARGET="null"
 . I $G(MAP(FILE,FLD,"type"))["t" D  Q      ; date/time
 . . S @TARGET=$$FM2ISO^YTXCHGU(VALS(FILE,IENS,FLD,"I"))
 . I $G(MAP(FILE,FLD,"type"))["y" D  Q      ; yes/no boolean
 . . S @TARGET=$S(VALS(FILE,IENS,FLD,"I")="Y":"true",1:"false")
 . I $G(MAP(FILE,FLD,"type"))["d" D  Q      ; refs to MH DISPLAY
 . . S @TARGET=VALS(FILE,IENS,FLD,"I")
 . . S DISPLAY(VALS(FILE,IENS,FLD,"I"))=""
 . I $G(MAP(FILE,FLD,"type"))["w" D  Q      ; word processing
 . . D WP2TR^YTXCHGT($NA(VALS(FILE,IENS,FLD)),TARGET)
 . S @TARGET=VALS(FILE,IENS,FLD,"I")        ; all other fields
 D LOG^YTXCHGU("prog",".")
 Q
FILEFLDS(FILE) ; return a string of fields in the file
 ; expects MAP
 N I,X
 S X=""
 S I=0 F  S I=$O(MAP(FILE,I)) Q:'I  I I'=".001" S X=X_I_";"
 Q X
 ;
