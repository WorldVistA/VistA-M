YTXCHGT ;SLC/KCM - JSON / Tree Conversions ; 9/15/2015
 ;;5.01;MENTAL HEALTH;**121,123,130**;Dec 30, 1994;Build 62
 ;
 ; Reference to VPRJSON supported by IA #6411
 ;
 ; SRC,DEST are global or local array references
 ;
MHA2TR(TEST,DEST) ; Load MHA test into DEST tree
 D EXPORT^YTXCHGE(TEST,DEST)
 Q
TR2MHA(TREE,YTXDRY) ; Save SRC tree into MHA file entries
 ;   TREE: closed reference to node that represents 1 instrument
 ; YTXDRY: defined and true if this is just a dry run
 N SEQ,PREFIX,TESTNM,NEWDT
 S PREFIX=$S($G(YTXDRY):"Trial install for ",1:"Installing ")
 S SEQ=0 F  S SEQ=$O(@TREE@("test",SEQ)) Q:'SEQ  D
 . N YTXLOG S YTXLOG=1
 . S TESTNM=@TREE@("test",SEQ,"info","name")
 . D LOG^YTXCHGU("info",PREFIX_TESTNM)
 . ; if not a dry run, do a test pass first and look for conflicts
 . I '$G(YTXDRY) D IMPTREE^YTXCHGI($NA(@TREE@("test",SEQ)),2)
 . I $G(YTXLOG("conflict")) D SHOSUMM^YTXCHGP(.YTXLOG,1) QUIT
 . ; do a dry run or actual pass
 . K YTXLOG S YTXLOG=1
 . I '$G(YTXDRY) D BACKUP^YTXCHGU(@TREE@("test",SEQ,"info","name"))
 . D IMPTREE^YTXCHGI($NA(@TREE@("test",SEQ)),YTXDRY)
 . D SHOSUMM^YTXCHGP(.YTXLOG,YTXDRY)
 . D LOG^YTXCHGU("info",$S($G(DRYRUN):"Trial install",1:"Installation")_" complete."_$S($G(DRYRUN):"  (No changes made)",1:""))
 . Q:$G(YTXDRY)
 . S NEWDT=@TREE@("test",SEQ,"info","lastEditDate")
 . I ($G(YTXLOG("added"))+$G(YTXLOG("updated")))>0 D NEWDATE^YTXCHGU(TESTNM,NEWDT)
 . D FILE96^YTWJSONF(@TREE@("test",SEQ,"info","name")) ; move new instrument to 601.96
 Q
TR2JSON(SRC,DEST) ; Convert tree representation to JSON
 N JSONERR,INTERIM,OK
 S INTERIM=$NA(^TMP("YTXCHG",$J,"INTERIM"))
 K @INTERIM
 I $E(DEST)=U,($E(DEST,1,4)'="^TMP") K @DEST  ; empty DEST
 D ENCODE^VPRJSON(SRC,INTERIM,"JSONERR")
 I $D(JSONERR) D LOG^YTXCHGU("error","JSON encode, "_$G(JSONERR(1))) Q 0
 D SPLITLN(INTERIM,DEST) ; split into smaller lines for Fileman
 K @INTERIM
 Q 1
 ;
JSON2TR(SRC,DEST) ; Convert JSON to tree representation
 ; returns 1 if converted without error
 ;  SRC contains JSON representation
 ; DEST is $NA value and should be empty
 N JSONERR
 D DECODE^VPRJSON(SRC,DEST,"JSONERR")
 I $D(JSONERR) D LOG^YTXCHGU("error","JSON decode, "_$G(JSONERR(1))) Q 0
 Q 1
 ;
SPEC2TR(XCHGIEN,DEST) ; Convert JSON WP entry in 601.95 to tree representation
 ; returns 1 if converted without error
 ; DEST is $NA value and should be empty
 K ^TMP("YTXCHG",$J,"JSONTMP")
 N I,JSONERR
 ; convert main specification from JSON to TREE
 S I=0 F  S I=$O(^YTT(601.95,XCHGIEN,1,I)) Q:'I  S ^TMP("YTXCHG",$J,"JSONTMP",I)=^YTT(601.95,XCHGIEN,1,I,0)
 D DECODE^VPRJSON($NA(^TMP("YTXCHG",$J,"JSONTMP")),DEST,"JSONERR")
 K ^TMP("YTXCHG",$J,"JSONTMP")
 I $D(JSONERR) D LOG^YTXCHGU("error","JSON decode, "_$G(JSONERR(1))) Q 0
 D ADDEND(XCHGIEN)
 Q 1
 ;
ADDEND(XCHGIEN) ; Process any contents in addendum
 ; example: {"ignoreConflicts": ["601.72:6488","601.72:6491","601.72:6734"]}
 N I,X,ARRAY
 D ADD2TR(XCHGIEN,.ARRAY) Q:'$D(ARRAY)
 K ^XTMP("YTXIDX","ignore")
 S I=0 F  S I=$O(ARRAY("ignoreConflicts",I)) Q:'I  D
 . S X=ARRAY("ignoreConflicts",I)
 . S ^XTMP("YTXIDX","ignore",+$P(X,":"),+$P(X,":",2))=""
 Q
CHKSCORE(XCHGIEN) ; Check addendum for instruments that should be re-scored
 ; example: {"rescoreInstruments":["PCL-5"]}
 N I,X,ARRAY,IEN,REV
 D ADD2TR(XCHGIEN,.ARRAY) Q:'$D(ARRAY)
 S I=0 F  S I=$O(ARRAY("rescoreInstruments",I)) Q:'I  D
 . S X=ARRAY("rescoreInstruments",I)
 . S IEN=$O(^YTT(601.71,"B",X,0)) Q:'IEN
 . S REV=$P($G(^YTT(601.71,IEN,9)),U,3) Q:'REV
 . D QTASK^YTSCOREV(IEN_"~"_REV,($H+1)_",3600") ; queue rescoring (T+1@1am)
 Q
ADD2TR(XCHGIEN,ARRAY) ; Load Addendum JSON into TREE
 N I,JSONTMP,JSONERR
 S I=0 F  S I=$O(^YTT(601.95,XCHGIEN,4,I)) Q:'I  S JSONTMP(I)=^YTT(601.95,XCHGIEN,4,I,0)
 Q:'$D(JSONTMP)
 D DECODE^VPRJSON("JSONTMP","ARRAY","JSONERR")
 I $D(JSONERR) D LOG^YTXCHGU("error","Addendum decode, "_$G(JSONERR(1))) Q
 Q
JSON2WP(SRC,DEST) ; Convert JSON array (n) to WP array (n,0)
 N I
 S I=0 F  S I=$O(@SRC@(I)) Q:'I  S @DEST@(I,0)=@SRC@(I)
 Q
WP2TR(SRC,DEST) ; Convert FM WP field to tree representation
 ;  SRC: glvn of source array
 ; DEST: glvn of destination array
 I $E(DEST)=U,($E(DEST,1,4)'="^TMP") K @DEST  ; empty DEST
 N LN S LN=0
 F  S LN=$O(@SRC@(LN)) Q:'LN  D
 . I LN=1 S @DEST=@SRC@(LN,0) I 1
 . E  S @DEST@("\",LN-1)=$C(13,10)_@SRC@(LN,0)
 Q
TR2WP(SRC,DEST) ; Convert tree representation to FM WP
 ;  SRC: glvn of source array (JSON node with wp text)
 ; DEST: glvn of destination array (will add [line,0] nodes)
 N I,J,X,LN
 S LN=0,X=$G(@SRC)
 F J=1:1:$L(X,$C(13,10)) S LN=LN+1,@DEST@(LN,0)=$P(X,$C(13,10),J)
 S I=0 F  S I=$O(@SRC@("\",I)) Q:'I  D
 . S X=@SRC@("\",I)
 . F J=1:1:$L(X,$C(13,10)) D
 . . I J=1 S @DEST@(LN,0)=@DEST@(LN,0)_$P(X,$C(13,10),1) I 1
 . . E  S LN=LN+1,@DEST@(LN,0)=$P(X,$C(13,10),J)
 Q
SPLITLN(SRC,DEST,MAX) ; Split JSON lines into lines of MAX length
 N I,LN,X
 S MAX=$G(MAX,240) S:MAX'>0 MAX=240 ; MAX default is 240
 S LN=0,I=0 F  S I=$O(@SRC@(I)) Q:'I  D
 . S X=@SRC@(I)
 . F  S LN=LN+1,@DEST@(LN)=$E(X,1,MAX),X=$E(X,MAX+1,99999) Q:'$L(X)
 Q
 ;
TEST2WP ; test TR2WP entry point
 N JSON,TEXT
 S JSON("wp")="This is line 1."_$C(13,10)_"This is line 2."_$C(13,10)_"This is "
 S JSON("wp","\",1)="line 3."_$C(13,10)_"This is line 4."_$C(13,10)_"This is line "
 S JSON("wp","\",2)="5."_$C(13,10)_"This is the last line."
 D TR2WP($NA(JSON("wp")),$NA(TEXT(2)))
 ; ZW TEXT
 Q
