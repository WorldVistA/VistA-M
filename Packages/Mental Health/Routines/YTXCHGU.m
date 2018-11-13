YTXCHGU ;SLC/KCM - Instrument Specification Utilities ; 9/15/2015
 ;;5.01;MENTAL HEALTH;**121**;Dec 30, 1994;Build 61
 ;
SPLTDIR(X,DIR,FILE) ; Split entry into directory and filename
 N PATHCHAR
 S X=$RE(X)
 S PATHCHAR="\/]:"
 F I=1:1:$L(X) I PATHCHAR[$E(X,I) Q
 S FILE=$RE($E(X,1,I-1)),DIR=$RE($E(X,I,$L(X)))
 Q
MKSUBS(FILE,FIELD,NUMS) ; return subscript string for file:field
 ; expects: MAP
 ; NUMS(n)=array index for level n
 N SUBSTR
 S SUBSTR=MAP(FILE,FIELD)
 Q $$SUBNUMS(SUBSTR,.NUMS)
 ;
SUBNUMS(SUBSTR,NUMS) ; make substitutions using NUMS array
 N I,REPLACE
 S I=0 F  S I=$O(NUMS(I)) Q:'I  S REPLACE("?"_I)=NUMS(I)
 I $D(REPLACE) S SUBSTR=$$REPLACE^XLFSTR(SUBSTR,.REPLACE)
 Q SUBSTR
 ;
NEWDATE(NAME,DATE) ; Change date for test
 N IEN,REC
 S IEN=$O(^YTT(601.71,"B",NAME,0)) Q:'IEN
 S REC(18)=$S($G(DATE):DATE,1:$$NOW^XLFDT)
 D FMUPD(601.71,.REC,IEN)
 Q
FM2ISO(FMDT) ; Convert Fileman Date/Time to ISO 8601
 N X,Y,M,D,H,N,S,ISODT
 S X=+$$FMTHL7^XLFDT(FMDT) Q:'X ""
 S Y=$E(X,1,4),M=$E(X,5,6),D=$E(X,7,8)
 S ISODT=Y
 I +M S ISODT=ISODT_"-"_M I +D S ISODT=ISODT_"-"_D
 I +$E(X,9,14) D
 . S H=$E(X,9,10),N=$E(X,11,12),S=$E(X,13,14)
 . S ISODT=ISODT_"T"_H
 . I $L(N) S ISODT=ISODT_":"_N I $L(S) S ISODT=ISODT_":"_S
 Q ISODT
 ;
ISO2FM(ISODT) ; Convert ISO 8601 Date/Time to Fileman
 S D=$TR($P(ISODT,"T"),"-","")_"000000"
 S D=$E(D,1,8)-17000000
 S T=$TR($P($P(ISODT,"T",2),"-"),":","")
 Q +(D_$S(+T:"."_T,1:""))
 ;
FMADD(FILE,RECORD,IEN) ; Add new record to FILE
 ; RECORD(field#)=value
 ; RECORD(field#)=global reference to word processing value
 ; IEN=optional IEN to attempt to use
 Q:+$P(FILE,".")'=601  ; restrict to MHA
 N YTIEN,YTFDA,YTWP,YTERR,DIERR
 M YTFDA(FILE,"+1,")=RECORD
 I $G(IEN) S YTIEN(1)=IEN
 D UPDATE^DIE("","YTFDA","YTIEN","YTERR")
 S IEN=YTIEN(1)
 I $D(DIERR) S IEN=-1 D LOG("error","Add "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 Q
FMUPD(FILE,RECORD,IEN) ; Add new record to FILE
 ; RECORD(field#)=value
 ; RECORD(field#)=global reference to word processing value
 ; IEN=record to update
 Q:+$P(FILE,".")'=601  ; restrict to MHA
 N YTIEN,YTFDA,YTWP,YTERR,DIERR
 M YTFDA(FILE,IEN_",")=RECORD
 D FILE^DIE("","YTFDA","YTERR")
 I $D(DIERR) D LOG("error","Upd "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 Q
 ;
FMDEL(FILE,IEN) ; Delete record from FILE
 ; IEN=record to delete
 Q:+$P(FILE,".")'=601  ; restrict to MHA
 Q:IEN<1
 N DIK,DA
 S DIK="^YTT("_FILE_",",DA=IEN
 D ^DIK
 Q
LOG(TYPE,MSG) ; update statistics
 ; optionally expects YTXLOG array -- uses it if defined
 I $G(YTXLOG) S YTXLOG(TYPE)=$G(YTXLOG(TYPE),0)+1
 I TYPE="error" D
 . I $G(YTXLOG) S YTXLOG("error",YTXLOG("error"))=MSG
 . D BMES^XPDUTL("ERROR: "_MSG)
 I TYPE="conflict" S YTXLOG("conflict",YTXLOG("conflict"))=MSG
 I TYPE="info" D MES^XPDUTL(MSG) ; informational, line break
 I TYPE="prog" W MSG             ; progress, no line break
 Q
LOGINST(XCHGIEN) ; log installation
 N YTFDA,YTIEN,YTERR,DIERR
 S YTFDA(601.953,"+1,"_XCHGIEN_",",.01)=$$NOW^XLFDT()
 S YTFDA(601.953,"+1,"_XCHGIEN_",",.02)=DUZ
 D UPDATE^DIE("","YTFDA","YTIEN","YTERR")
 I $D(DIERR) D LOG("error","History "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 Q
BACKUP(TESTNM) ; backup an instrument for later recovery, if necessary
 N TESTS,IEN,REC
 K ^TMP("YTXCHG",$J,"WP",2)
 S TESTS(1)=$O(^YTT(601.71,"B",TESTNM,0)) Q:'TESTS(1)
 S REC(.01)="YTBackup"_TESTNM_"-"_$TR($$HTE^XLFDT($H,"7DZ"),"/","-")
 S REC(.02)=$$NOW^XLFDT
 S REC(.03)="backup copy"
 S REC(2)=$NA(^TMP("YTXCHG",$J,"WP",2))
 S ^TMP("YTXCHG",$J,"WP",2,1,0)="backup copy of "_TESTNM
 S IEN=$$CREATE^YTXCHG(.TESTS,.REC)
 K ^TMP("YTXCHG",$J,"WP",2)
 D QDEL(IEN,REC(.01),REC(.02),3)
 Q
QDEL(XCHGIEN,XCHGNM,XCHGDT,DAYS) ; Queue a task to delete an exchange entry
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK
 S ZTIO=""
 S ZTRTN="DQDEL^YTXCHGU"
 S ZTDESC="Remove "_XCHGNM
 S ZTDTH=$$HADD^XLFDT($H,DAYS)
 S ZTSAVE("XCHGIEN")="",ZTSAVE("XCHGNM")="",ZTSAVE("XCHGDT")=""
 D ^%ZTLOAD
 I '$G(ZTSK) D LOG("error","Unsuccessful queue "_XCHGNM)
 Q
DQDEL ; Dequeue of instrument exchange entry removal
 S ZTREQ="@"
 N X0 S X0=^YTT(601.95,XCHGIEN,0)
 I ($P(X0,U)'=XCHGNM)!($P(X0,U,2)'=XCHGDT) Q  ; no longer same entry
 D FMDEL(601.95,XCHGIEN)
 Q
TREEOUT ; Save tree representation to file
 K ^TMP("YTXCHG",$J,"TREE")
 K ^TMP("YTXCHG",$J,"HFS")
 N XCHGIEN,FULLNM,NUM
 S XCHGIEN=$$LKUP^YTXCHGP(601.95)
 I 'XCHGIEN QUIT
 S FULLNM=$$PRMTNAME^YTXCHGP("Enter file name","Enter full path and filename.",245)
 I '$L(FULLNM) QUIT
 D SPEC2TR^YTXCHGT(XCHGIEN,$NA(^TMP("YTXCHG",$J,"TREE")))
 S NUM=$$PICKTEST^YTXCHGP($NA(^TMP("YTXCHG",$J,"TREE"))) G:'NUM XTREEOUT
 ;
 N X,I,ROOT,LROOT,CNT,SUB,LINE
 S X=$NA(^TMP("YTXCHG",$J,"TREE","test",NUM))
 S ROOT=$E(X,1,$L(X)-1),LROOT=$L(ROOT),CNT=0
 F  S X=$Q(@X) Q:$E(X,1,LROOT)'=ROOT  D
 . S LINE=""
 . F I=6:1:$QL(X) D
 . . S SUB=$QS(X,I)
 . . I +SUB,(+SUB=SUB) S SUB="["_SUB_"]" I 1
 . . E  S:$L(LINE) LINE=LINE_"."
 . . S LINE=LINE_SUB
 . ; W !,LINE_"="_@X
 . S CNT=CNT+1,^TMP("YTXCHG",$J,"HFS",CNT,0)=LINE_"="_@X
 ;
 N PATH,FILE,OK
 D SPLTDIR^YTXCHGU(FULLNM,.PATH,.FILE)
 S OK=$$GTF^%ZISH($NA(^TMP("YTXCHG",$J,"HFS",1,0)),4,PATH,FILE)
 W !,"File "_$S(OK:"",1:"not ")_"saved."
XTREEOUT ; exit TREEOUT
 K ^TMP("YTXCHG",$J,"TREE")
 K ^TMP("YTXCHG",$J,"HFS")
 Q
TFM2ISO ; test Fileman to ISO Date/Time
 W !,$$FM2ISO("3100900")
 W !,$$FM2ISO("3120415")
 W !,$$FM2ISO("3120415.1")
 W !,$$FM2ISO("3120415.102")
 W !,$$FM2ISO("3120415.100001")
 W !,$$FM2ISO("3120415.170001")
 W !,$$FM2ISO("3160620.111")
 Q
TISO2FM ; test ISO to Fileman date/time
 W !,$$ISO2FM("2010-09")
 W !,$$ISO2FM("2012-04-15")
 W !,$$ISO2FM("2012-04-15T10:00")
 W !,$$ISO2FM("2012-04-15T10:20")
 W !,$$ISO2FM("2012-04-15T10:00:01")
 W !,$$ISO2FM("2012-04-15T17:00:01")
 W !,$$ISO2FM("2012-04-15T17:00:01-0600")
 W !,$$ISO2FM("2016-06-20T11:10")
 Q
