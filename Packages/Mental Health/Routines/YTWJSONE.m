YTWJSONE ;SLC/KCM - Simple Editor for JSON Instrument Spec ; 7/20/2018
 ;;5.01;MENTAL HEALTH;**141,172**;Dec 30, 1994;Build 10
 ;
 ; Usage: D EN^YTWJSONE        edit entry spec JSON & update checksum
 ;        D VALIDATE^YTWJSONE  checks recorded checksum against JSON actual
 ;
EN ; edit instrument Entry Specification
 K ^TMP("YTQ-EDIT",$J)
 N SPEC,TESTNM,DONE,ERRS,CRCOLD,CRCNEW
 S SPEC=$$LOOKUP() Q:'SPEC
 S TESTNM=$P(^YTT(601.71,+^YTT(601.712,SPEC,0),0),U)
 S CRCOLD=$P(^YTT(601.712,SPEC,0),U,3)
 M ^TMP("YTQ-EDIT",$J)=^YTT(601.712,SPEC,1)
 S DONE=0 F  D  Q:DONE
 . K ERRS S DONE=1
 . D EDIT(TESTNM)
 . I '$$HASMODS(SPEC) W !,"Nothing changed" QUIT
 . D CHKSPEC($NA(^TMP("YTQ-EDIT",$J)),.ERRS,.CRCNEW)
 . I $G(ERRS) S DONE=$S($$EOP:0,1:1) QUIT
 . D SAVE712(SPEC,CRCNEW)
 . W !,"Changes saved.  Old Checksum: ",CRCOLD,"  New Checksum: ",CRCNEW
 K ^TMP("YTQ-EDIT",$J)
 Q
LOOKUP() ; return 601.712 IEN for selected instrument
 N DIC,X,Y
 S DIC="^YTT(601.712,",DIC(0)="AEMQ" D ^DIC
 Q +Y
 ;
EDIT(TESTNM) ; edit copy of document in ^TMP("YTQ-EDIT",$J,
 N DIC,DDWAUTO,DDWFLAGS,DWLW,DWPK,DIWETXT,DIWESUB
 S DDWAUTO=1,DDWFLAGS="M"
 S DIC="^TMP(""YTQ-EDIT"","_$J_","
 S DWLW=132,DWPK=1,DIWETXT=TESTNM,DIWESUB="Entry Specification"
 D EN^DIWE
 Q
HASMODS(SPEC) ; return 1 if edited version differs from 601.712
 N I,CHANGES,ORIG,EDIT
 S CHANGES=0
 S I=0 F  S I=$O(^YTT(601.712,SPEC,1,I)) Q:'I  D  Q:CHANGES
 . S ORIG=$G(^YTT(601.712,SPEC,1,I,0))
 . S EDIT=$G(^TMP("YTQ-EDIT",$J,I,0))
 . I ORIG'=EDIT S CHANGES=1
 Q CHANGES
 ;
OKSAVE() ; return 1 if OK to save changes
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR("A")="Save changes",DIR(0)="Y",DIR("B")="YES" D ^DIR
 Q +Y
 ;
EOP() ; return 1 if continue, 0 if exit
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="E" D ^DIR
 Q +Y
 ;
CHKSPEC(SRC,ERRS,CRC) ; parses JSON and calculates checksum
 ; .ERRS: returns 1 if JSON parses without errors
 ;  .CRC: returns checksum
 K ^TMP("YTQ-JSON",$J),^TMP("YTQ-TREE",$J),^TMP("YTQ-LIST",$J)
 N JSON,TREE,LIST
 S JSON=$NA(^TMP("YTQ-JSON",$J))
 S TREE=$NA(^TMP("YTQ-TREE",$J))
 S LIST=$NA(^TMP("YTQ-LIST",$J))
 D FIXLF(SRC,JSON)
 D CHKJSON(JSON,TREE,.ERRS) I $G(ERRS) S CRC=0 QUIT
 D NAMEVAL(TREE,LIST)
 S CRC=$$NVCRC(LIST)
 K ^TMP("YTQ-JSON",$J),^TMP("YTQ-TREE",$J),^TMP("YTQ-LIST",$J)
 Q
FIXLF(SRC,DEST) ; Load spec from SRC, cleaning up line feeds
 ; SPEC: reference to global with original JSON
 ; DEST: reference to global root for destination JSON
 N I,J,X,Y
 S (I,J)=0 F  S I=$O(@SRC@(I)) Q:'I  S X=^(I,0) D
 . S J=J+1,@DEST@(J)=X
 . I (($L(X)-$L($TR(X,"""","")))#2) D  ; check for odd number of quotes
 . . F  S I=I+1 Q:'$D(@SRC@(I,0))  D  Q:Y[""""
 . . . S Y=@SRC@(I,0)
 . . . S @DEST@(J)=@DEST@(J)_Y
 Q
CHKJSON(JSON,TREE,ERRS) ; decode JSON and display any errors
 ;    JSON: reference to JSON global
 ;    TREE: reference to TREE global
 ; .ERRORS: return errors found or 0
 N ERRORS
 D DECODE^XLFJSON(JSON,TREE,"ERRORS")
 I $G(ERRORS(0)) D
 . S ERRS=ERRORS(0)
 . W !,"ERRORS found while parsing JSON document"
 . N I S I=0 F  S I=$O(ERRORS(I)) Q:'I  W !,?2,ERRORS(I)
 . W !!,"Returning to editor..."
 Q
 ;
NAMEVAL(TREE,LIST) ; Convert TREE to external object name/value list in LIST
 ; TREE: reference to global containing documents tree structure
 ; LIST: reference to global where @LIST@(name)=value will be saved
 ; NOTE -- resulting names will collate as string, so the order may be odd
 ;         for example, obj[1], obj[10], obj[11], obj[2], etc.
 N ROOT,LROOT,SB,SL,S,X,I,NM,VAL,ADDQ
 S ROOT=$E(TREE,1,$L(TREE)-1),LROOT=$L(ROOT) ; drop last ")" for compare
 S X=TREE,SB=$QL(TREE)+1                     ; begin at subscript after root 
 F  S X=$Q(@X) Q:$E(X,1,LROOT)'=ROOT  D
 . S SL=$QL(X),NM=""                         ; SL is last subscript
 . I $D(@X@("\s"))!$D(@X@("\n")) Q           ; node already evaluated
 . F I=SB:1:SL S S=$QS(X,I) S NM=NM_$S(+S:"["_S_"]",(I>3)&'S:"."_S,1:S)
 . S VAL=@X
 . S ADDQ=$$JSONSTR(VAL)                     ; check if num, str, bool
 . I $D(@X@("\s")) S ADDQ=1                  ; "\s" forces string
 . I $D(@X@("\n")) S ADDQ=0                  ; "\n" forces numeric
 . S @LIST@(NM)=$S(ADDQ:""""_VAL_"""",1:VAL) ; NM=VAL, NM collates as string
 Q
JSONSTR(X) ; return 1 if should be treated as a string
 Q:X="true" 0   ; boolean
 Q:X="false" 0  ; boolean
 Q:X="null" 0   ; null object
 Q:+X=X 0       ; numeric
 Q 1
 ;
NVCRC(LIST) ; return CRC32 for LIST(name)=value
 ; LIST: reference to global containing @LIST@(name)=value pairs
 N X,STR,CRC
 S CRC=0
 S X="" F  S X=$O(@LIST@(X)) Q:'$L(X)  D
 . S STR=X_"="_@LIST@(X)
 . S CRC=$$CRC32^XLFCRC(STR,CRC)
 Q CRC
 ;
TSCRC() ; return CRC32 of all checksums for active instruments
 N IEN,X,CRC
 S (IEN,CRC)=0 F  S IEN=$O(^YTT(601.712,IEN)) Q:'IEN  D
 . S CRC=$$CRC32^XLFCRC($P(^YTT(601.712,IEN,0),U,3),CRC)
 Q CRC
 ;
SHA1ALL() ; return SHA-1 of all checksums for active instruments
 N IEN,X
 S X=""
 S IEN=0 F  S IEN=$O(^YTT(601.712,IEN)) Q:'IEN  S X=X_$P(^(IEN,0),U,3)
 W !,"Length: ",$L(X),"  X=",!,X
 W !,$$SHAHASH^XUSHSH(160,X,"H")
 Q
SAVE712(IEN,CRC) ; save updated specification to 601.712
 ; expects ^TMP("YTQ-EDIT,$J,n,0) to be entry spec text
 N REC
 S REC(.02)=$$NOW^XLFDT
 S REC(.03)=CRC
 S REC(1)=$NA(^TMP("YTQ-EDIT",$J))
 D FMUPD^YTXCHGU(601.712,.REC,IEN)
 Q
 ;
VALIDATE ; compare CRC with actual and check JSON structure
 N SPEC,TEST
 S SPEC=0 F  S SPEC=$O(^YTT(601.712,SPEC)) Q:'SPEC  D
 . S TEST=+$P(^YTT(601.712,SPEC,0),U)
 . I '$D(^YTT(601.71,TEST,0)) D  QUIT
 . . W !,"Missing entry in 601.71: ",TEST,"   ",^YTT(601.712,SPEC,1,1,0)
 . W !,$P(^YTT(601.71,+^YTT(601.712,SPEC,0),0),U)
 . N ERRS,CRCCALC,CRCSAVED
 . S CRCSAVED=$P(^YTT(601.712,SPEC,0),U,3)
 . D CHKSPEC($NA(^YTT(601.712,SPEC,1)),.ERRS,.CRCCALC)
 . I '$G(ERRS),(CRCSAVED=CRCCALC) W ?30,"ok" QUIT
 . I CRCSAVED'=CRCCALC W ?30,"Saved Checksum: ",CRCSAVED,"   Actual: ",CRCCALC
 . I $G(ERRS) W "  JSON errors"
 Q
 ;
FILE(TEST,PATH) ; write JSON from 601.712 to host file in PATH
 N IEN,OK,NAME
 I TEST'=+TEST S TEST=$O(^YTT(601.71,"B",TEST,0)) Q:'TEST
 S IEN=$O(^YTT(601.712,"B",TEST,0)) Q:'IEN
 S NAME=$TR($P(^YTT(601.71,TEST,0),U)," ","_")_"-espec.json"
 ;
 K ^TMP($J)
 M ^TMP($J)=^YTT(601.712,IEN,1) ; so can use $$GTF^%ZISH
 K ^TMP($J,0)                   ; remove count & date node
 S OK=$$GTF^%ZISH($NA(^TMP($J,1,0)),2,PATH,NAME)
 I 'OK W !,"Error writing file: "_NAME
 K ^TMP($J)
 Q
LOAD(TEST,PATH) ; read host file in PATH and load into 601.712
 N TESTNM,SPEC,FILE,OK,CRCOLD,CRCNEW,ERRS
 I TEST'=+TEST S TEST=$O(^YTT(601.71,"B",TEST,0)) QUIT:'TEST
 S TESTNM=$P(^YTT(601.71,TEST,0),U)
 S SPEC=$O(^YTT(601.712,"B",TEST,0)) QUIT:'SPEC
 S FILE=$TR(TESTNM," ","_")_"-espec.json"
 S CRCOLD=$P(^YTT(601.712,SPEC,0),U,3)
 ;
 K ^TMP("YTQ-EDIT",$J)
 S OK=$$FTG^%ZISH(PATH,FILE,$NA(^TMP("YTQ-EDIT",$J,1,0)),3)
 I 'OK W !,"Error reading file: "_FILE QUIT
 I '$$HASMODS(SPEC) W !,"Nothing changed" QUIT
 ;
 D CHKSPEC($NA(^TMP("YTQ-EDIT",$J)),.ERRS,.CRCNEW) QUIT:$G(ERRS)
 D SAVE712(SPEC,CRCNEW)
 W !,TESTNM," entry spec saved.  Old Checksum: ",CRCOLD,"  New Checksum: ",CRCNEW
 K ^TMP("YTQ-EDIT",$J)
 Q
