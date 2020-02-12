YTXCHG ;SLC/KCM - Instrument Exchange Calls ; 9/15/2015
 ;;5.01;MENTAL HEALTH;**121,123,130**;Dec 30, 1994;Build 62
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; %ZISH                 2320
 ; DIC                   2051
 ; DIK                  10013
 ; XPDUTL               10141
 ; XTHC10                5515
 ;
VERSION ;; current Instrument Exchange version
 ;;1.02
 Q
INCLUDE(Y,TAG,RTN) ; return true for Y in list produced by TAG^RTN
 ; Y: IEN of entry currently being checked for inclusion
 ; TAG^RTN(.ARRAY) is called to build list of 601.95 entries in ARRAY
 ;         .ARRAY(n,1): name (.01) value in 601.95
 ;         .ARRAY(n,2): date (.02) value in 601.95
 ;
 N ARRAY,IDX,FOUND,VALS,IEN
 D @(TAG_U_RTN_"(.ARRAY)")
 S FOUND=0
 S IDX=0 F  S IDX=$O(ARRAY(IDX)) Q:'IDX  D  Q:FOUND
 . M VALS=ARRAY(IDX)
 . S IEN=+$$FIND1^DIC(601.95,"","KU",.VALS)
 . I IEN=Y S FOUND=1
 Q FOUND
 ;
CREATE(TESTS,XCHGREC) ; return IEN or error after creating exchange entry
 ; .TESTS(n)=instrumentIEN  ; instruments to include in JSON spec
 ; .XCHGREC(field)=value    ; values used to create exchange entry
 N SEQ,XCHGIEN,OK
 K ^TMP("YTXCHGE",$J,"TREE")
 K ^TMP("YTXCHGE",$J,"JSON")
 S SEQ=0 F  S SEQ=$O(TESTS(SEQ)) Q:'SEQ  D
 . D MHA2TR^YTXCHGT(TESTS(SEQ),$NA(^TMP("YTXCHGE",$J,"TREE","test",SEQ)))
 S ^TMP("YTXCHGE",$J,"TREE","xchg","name")=XCHGREC(.01)
 S ^TMP("YTXCHGE",$J,"TREE","xchg","date")=XCHGREC(.02)
 S ^TMP("YTXCHGE",$J,"TREE","xchg","source")=XCHGREC(.03)
 S ^TMP("YTXCHGE",$J,"TREE","xchg","version")=+$P($T(VERSION+1),";;",2)
 D WP2TR^YTXCHGT(XCHGREC(2),$NA(^TMP("YTXCHGE",$J,"TREE","xchg","description")))
 S OK=$$TR2JSON^YTXCHGT($NA(^TMP("YTXCHGE",$J,"TREE")),$NA(^TMP("YTXCHGE",$J,"JSON")))
 S XCHGREC(1)=$NA(^TMP("YTXCHGE",$J,"JSON"))
 I OK D FMADD^YTXCHGU(601.95,.XCHGREC,.XCHGIEN)
 K ^TMP("YTXCHGE",$J,"TREE")
 K ^TMP("YTXCHGE",$J,"JSON")
 Q $S(OK:XCHGIEN,1:-1)
 ;
INFO(XCHGIEN,INFO) ; put build information into .INFO
 ; .INFO(fld)=value
 ; .INFO("tests",n)=testName
 I $D(^YTT(601.95,XCHGIEN,1))'>1 D LOG^YTXCHGU("error","Spec not found.") Q
 N I,OK
 K ^TMP("YTXCHG",$J,"TREE")
 S OK=$$SPEC2TR^YTXCHGT(XCHGIEN,$NA(^TMP("YTXCHG",$J,"TREE"))) G:'OK XINFO
 I $D(^YTT(601.95,XCHGIEN,4,1,0)) D  ; pull in addendum if it is there
 . D WP2TR^YTXCHGT($NA(^YTT(601.95,XCHGIEN,4)),$NA(^TMP("YTXCHG",$J,"TREE","xchg","addendum")))
 S I=0 F  S I=$O(^TMP("YTXCHG",$J,"TREE","test",I)) Q:'I  D
 . S INFO("tests",I)=^TMP("YTXCHG",$J,"TREE","test",I,"info","name")
 D SETINFO(.INFO,$NA(^TMP("YTXCHG",$J,"TREE")))
XINFO ; exit here
 K ^TMP("YTXCHG",$J,"TREE")
 Q
DELETE(XCHGIEN) ; delete instrument exchange entry
 N DIK,DA
 I '$D(^YTT(601.95,XCHGIEN)) D LOG^YTXCHGU("error","Entry not found.") Q
 S DIK="^YTT(601.95,",DA=XCHGIEN
 D ^DIK
 Q
INSTALL(XCHGIEN,DRYRUN) ; install instrument exchange entry locally
 I $D(^YTT(601.95,XCHGIEN,1))'>1 D LOG^YTXCHGU("error","Install entry #"_XCHGIEN_" not found.") QUIT
 ;
 ; set up index across MH files
 I $P($G(^XTMP("YTXIDX",0)),U,2)'=DT D IDXALL^YTXCHGV
 I $P($G(^XTMP("YTXIDX",0)),U,2)'=DT D LOG^YTXCHGU("error","Unable to index") QUIT
 ;
 K ^TMP("YTXCHGI",$J,"TREE")
 N OK
 S OK=$$SPEC2TR^YTXCHGT(XCHGIEN,$NA(^TMP("YTXCHGI",$J,"TREE")))
 I OK D
 . I $$BADVER($G(^TMP("YTXCHGI",$J,"TREE","xchg","version"))) QUIT
 . D TR2MHA^YTXCHGT($NA(^TMP("YTXCHGI",$J,"TREE")),$G(DRYRUN))
 . I '$G(DRYRUN) D
 . . D LOGINST^YTXCHGU(XCHGIEN)
 . . D CHKSCORE^YTXCHGT(XCHGIEN)
 . . D LIST96^YTWJSONF ; rebuild active instrument list
 K ^TMP("YTXCHGI",$J,"TREE")
 Q
INSTALLQ(TAG,RTN) ; install exchange entries listed by TAG^RTN in post-init
 ; TAG^RTN(.ARRAY) is called to build list of 601.95 entries in ARRAY
 ;         .ARRAY(n,1): name (.01) value in 601.95
 ;         .ARRAY(n,2): date (.02) value in 601.95
 N ARRAY,XCHGI,VALS,XCHGIEN
 D @(TAG_U_RTN_"(.ARRAY)")
 S XCHGI=0 F  S XCHGI=$O(ARRAY(XCHGI)) Q:'XCHGI  D
 . M VALS=ARRAY(XCHGI)
 . S XCHGIEN=+$$FIND1^DIC(601.95,"","KU",.VALS)
 . Q:'XCHGIEN
 . D INSTALL(XCHGIEN)
 . ; D FMDEL^YTXCHGU(601.95,XCHGIEN)  ; remove now that install is done
 D BMES^XPDUTL("MH Instrument install complete.")
 Q
BADVER(VERSION) ; return true if version conflict
 I VERSION'=+$P($T(VERSION+1),";;",2) D  QUIT 1
 . D LOG^YTXCHGU("error","Version conflict, unable to continue.")
 Q 0
 ;
BLDVIEW(TREE,DEST) ; create array for BROWSER view
 ; TREE: $NA global reference for the instrument node of the tree
 ; DEST: $NA global reference for the output lines
 N MAP,IDX,CNTLINE,CNTROOT
 S IDX=0,CNTLINE=0,CNTROOT=$QL(TREE)
 D BLDSEQ^YTXCHGM(.MAP)
 D ITER("MAP")
 Q
ITER(MAPREF) ;
 ; expects IDX where IDX(IDX) is current index
 ; MAPREF: $NA for the current reference in the map of JSON labels
 N NODE,SEQ,LABEL
 ;I $QS(MAPREF,4)="choiceIdentifier" B
 I $D(@MAPREF)=1 S NODE=$$TREEREF(MAPREF,.IDX) D LINEOUT(NODE) QUIT
 ;
 S IDX=IDX+1,IDX(IDX)=0
 S SEQ=0 F  S SEQ=$O(@MAPREF@(SEQ)) Q:'SEQ  D
 . S LABEL=$O(@MAPREF@(SEQ,""))
 . I $E(LABEL)="?" D  Q  ; iterate thru tree and call iter with varying ref
 . . S NODE=$$TREEREF($NA(@MAPREF@(SEQ,LABEL)),.IDX)
 . . F  S IDX(IDX)=$O(@NODE@(IDX(IDX))) Q:'IDX(IDX)  D ITER($NA(@MAPREF@(SEQ,LABEL)))
 . E  D ITER($NA(@MAPREF@(SEQ,LABEL))) ; call iter with next label
 S IDX=IDX-1
 Q
TREEREF(MAPREF,IDX) ; return reference to data tree given map reference
 ; expects TREE from BLDVIEW for root tree reference
 N LEVEL,RESULT,I,LABEL
 S LEVEL=0,RESULT=""
 F I=2:2:$QL(MAPREF) S LABEL=$QS(MAPREF,I) D
 . S LEVEL=LEVEL+1
 . I $L(RESULT) S RESULT=RESULT_","
 . I $E(LABEL)="?" D  Q
 . . S RESULT=RESULT_""""_$E(LABEL,2,$L(LABEL))_""""
 . . I LEVEL<IDX S RESULT=RESULT_","_IDX(LEVEL)
 . S RESULT=RESULT_""""_LABEL_""""
 S RESULT=$E(TREE,1,$L(TREE)-1)_","_RESULT_")"
 Q RESULT
 ;
LINEOUT(NODE) ; add output line
 ; expects CNTROOT,CNTLINE,DEST from BLDVIEW
 Q:'$L($G(@NODE))
 I $QS(NODE,CNTROOT+2)="template" D TLTOUT(NODE) QUIT
 N LINE,I,SUB
 S LINE=""
 F I=CNTROOT+1:1:($QL(NODE)) S SUB=$QS(NODE,I) D
 . I +SUB,(+SUB=SUB) S SUB="["_SUB_"]" I 1
 . E  S:$L(LINE) LINE=LINE_"."
 . S LINE=LINE_SUB
 S CNTLINE=CNTLINE+1,@DEST@(CNTLINE,0)=LINE_"="_@NODE
 Q
TLTOUT(NODE) ; output the report template
 ; expects CNTLINE,DEST from BLDVIEW
 Q:'$L($G(@NODE))
 ;
 K ^TMP("YTXCHG",$J,"TEMPLATE")
 D TR2WP^YTXCHGT(NODE,$NA(^TMP("YTXCHG",$J,"TEMPLATE")))
 S CNTLINE=CNTLINE+1,@DEST@(CNTLINE,0)="report.template="
 S CNTLINE=CNTLINE+1
 N I,J,X
 S I=0 F  S I=$O(^TMP("YTXCHG",$J,"TEMPLATE",I)) Q:'I  D
 . S X=^TMP("YTXCHG",$J,"TEMPLATE",I,0)
 . F J=1:1:$L(X,"|") D
 . . I J=1 S @DEST@(CNTLINE,0)=$G(@DEST@(CNTLINE,0))_$P(X,"|",1) I 1
 . . E  S CNTLINE=CNTLINE+1,@DEST@(CNTLINE,0)=$P(X,"|",J)
 K ^TMP("YTXCHG",$J,"TEMPLATE")
 Q
SAVEHFS(XCHGIEN,FULLNM) ; save instrument exchange entry to host file
 ; return 1 if successful, otherwise 0
 N SPECLOC,PATH,FILE,OK
 S SPECLOC=$NA(^YTT(601.95,XCHGIEN,1,1,0))
 I $D(^YTT(601.95,XCHGIEN,4,1,0)) D  ; insert addendum into spec
 . K ^TMP("YTXCHG",$J,"TREE"),^TMP("YTXCHG",$J,"JSON")
 . S OK=$$SPEC2TR^YTXCHGT(XCHGIEN,$NA(^TMP("YTXCHG",$J,"TREE")))
 . D WP2TR^YTXCHGT($NA(^YTT(601.95,XCHGIEN,4)),$NA(^TMP("YTXCHG",$J,"TREE","xchg","addendum")))
 . S OK=$$TR2JSON^YTXCHGT($NA(^TMP("YTXCHG",$J,"TREE")),$NA(^TMP("YTXCHG",$J,"JSON")))
 . S SPECLOC=$NA(^TMP("YTXCHG",$J,"JSON",1))
 ;
 D SPLTDIR^YTXCHGU(FULLNM,.PATH,.FILE)
 S OK=$$GTF^%ZISH(SPECLOC,4,PATH,FILE)
 Q OK
 ;
LOADFILE(PATH,INFO) ; load file into JSON & tree structures
 ; PATH is full HFS name or URL
 ; .INFO returns the fields for 601.95 entry
 ;       word processing values are in ^TMP("YTXCHG",$J,"WP",field)
 ; Specification ends up in ^TMP("YTXCHG",$J,"WP",1)
 ; Description content ends up in ^TMP("YTXCHG",$J,"WP",2)
 K ^TMP("YTXCHG",$J,"JSON")
 K ^TMP("YTXCHG",$J,"TREE")
 K ^TMP("YTXCHG",$J,"WP",1),^TMP("YTXCHG",$J,"WP",2),^TMP("YTXCHG",$J,"WP",4)
 I $E(PATH,1,5)="http:" D LOADURL(PATH,.INFO) I 1  ; load file from URL
 E  D LOADHFS(PATH,.INFO)                          ; load file from HFS
 Q:$G(INFO)=-1
 N OK
 S OK=$$JSON2TR^YTXCHGT($NA(^TMP("YTXCHG",$J,"JSON")),$NA(^TMP("YTXCHG",$J,"TREE")))
 I 'OK S INFO=-1 G XLOADF
 D SETINFO(.INFO,$NA(^TMP("YTXCHG",$J,"TREE")))
 S INFO(1)=$NA(^TMP("YTXCHG",$J,"WP",1)) ; #1 is specification field
 D JSON2WP^YTXCHGT($NA(^TMP("YTXCHG",$J,"JSON")),$NA(^TMP("YTXCHG",$J,"WP",1)))
XLOADF ; exit LOADFILE here
 ; ^TMP("YTXCHG",$J,"WP) should be cleaned up by caller
 K ^TMP("YTXCHG",$J,"JSON")
 K ^TMP("YTXCHG",$J,"TREE")
 Q
LOADHFS(FULLNM,INFO) ; load file from HFS into JSON & tree structures
 N DIR,FILE,OK
 D SPLTDIR^YTXCHGU(FULLNM,.DIR,.FILE)
 S OK=$$FTG^%ZISH(DIR,FILE,$NA(^TMP("YTXCHG",$J,"JSON",1)),4)
 I 'OK D LOG^YTXCHGU("error","Failed to load "_FULLNM) S INFO=-1 QUIT
 Q
LOADURL(URL,INFO) ; load file from URL into JSON & tree structures
 N RESULT,HEADER
 S RESULT=$$GETURL^XTHC10(URL,10,$NA(^TMP("YTXCHG",$J,"JSON")),.HEADER)
 I $P(RESULT,U,1)'=200 D  QUIT
 . D LOG^YTXCHGU("error","Could not load file: "_$P(RESULT,U,1)_" "_$P(RESULT,U,2))
 . S INFO=-1
 Q
SETINFO(INFO,TREE) ; set .INFO array from specification TREE
 S INFO(.01)=$G(@TREE@("xchg","name"))
 S INFO(.02)=$G(@TREE@("xchg","date"))
 S INFO(.03)=$G(@TREE@("xchg","source"))
 S INFO(2)=$NA(^TMP("YTXCHG",$J,"WP",2)) ; #2 is description field
 D TR2WP^YTXCHGT($NA(@TREE@("xchg","description")),INFO(2))
 I '$D(@TREE@("xchg","addendum")) QUIT
 S INFO(4)=$NA(^TMP("YTXCHG",$J,"WP",4)) ; #4 is addendum field
 D TR2WP^YTXCHGT($NA(@TREE@("xchg","addendum")),INFO(4))
 K @TREE@("xchg","addendum") ; remove so not included in spec
 Q
SENDMAIL ; interactive -- send instrument exchange entry in mail message
 Q
LOADMAIL ; interactive -- load instrument exchange entry from mail message
 Q
