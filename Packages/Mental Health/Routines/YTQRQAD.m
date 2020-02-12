YTQRQAD ;SLC/KCM - RESTful Calls for Instrument Admin ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130**;Dec 30, 1994;Build 62
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; ^DIC(3.1)             1234
 ; ^DIC(49)             10093
 ; ^DPT                 10035
 ; ^VA(200)             10060
 ; ^VA(200,"AUSER")      4868
 ; DIQ                   2056
 ; XLFNAME               3065
 ; XLFSTR               10104
 ;
 ;
 ;; -- GETs  all return M object that is transformed to JSON
 ;; -- POSTs all return a path to the created/updated object
 ;;
PID(ARGS,RESULTS) ; get patient identifiers
 N DFN S DFN=+$G(ARGS("dfn"))
 I '$D(^DPT(DFN,0)) D SETERROR^YTQRUTL(404,"Not Found: "_DFN) QUIT
 S RESULTS("dfn")=DFN
 S RESULTS("name")=$P($G(^DPT(DFN,0)),U)
 S RESULTS("pid")="xxx-xx-"_$E($P($G(^DPT(DFN,0)),U,9),6,10)
 S RESULTS("ssn")=RESULTS("pid") ; TEMPORARY until a switch to PID
 Q
LSTALL(ARGS,RESULTS) ; get a list of all instruments
 D GETDOC("YTL ACTIVE",.RESULTS)
 Q
LSTCPRS(ARGS,RESULTS) ; get a list of all instruments
 D GETDOC("YTL CPRS",.RESULTS)
 Q
GETSPEC(ARGS,RESULTS) ; get an instrument specification
 D GETDOC("YTT "_$G(ARGS("instrumentName"),"MISSING NAME"),.RESULTS)
 Q
GETDOC(DOCNAME,RESULTS) ; set ^TMP with contents of the document named
 K ^TMP("YTQ-JSON",$J)
 N IEN S IEN=$O(^YTT(601.96,"B",DOCNAME,0))
 I 'IEN S IEN=$O(^YTT(601.96,"B",$TR(DOCNAME,"_"," "),0)) ; temporary
 I 'IEN D SETERROR^YTQRUTL(404,"Not Found: "_DOCNAME) QUIT
 M ^TMP("YTQ-JSON",$J)=^YTT(601.96,IEN,1)
 K ^TMP("YTQ-JSON",$J,0) ; remove 0 node (wp meta-data)
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
WRCLOSE(ARGS,DATA) ; noop call for closing Delphi wrapper
 Q "/api/wrapper/close/ok"
 ;
PERSONS(ARGS,RESULTS) ; GET /api/mha/persons/:match
 N ROOT,LROOT,NM,IEN,SEQ,PREVNM,QUAL
 S ROOT=$$UP^XLFSTR($G(ARGS("match"))),LROOT=$L(ROOT),SEQ=0,PREVNM=""
 S NM=ROOT F  S NM=$O(^VA(200,"AUSER",NM)) Q:NM=""  Q:$E(NM,1,LROOT)'=ROOT  D
 . S IEN=0 F  S IEN=$O(^VA(200,"AUSER",NM,IEN)) Q:'IEN  D
 . . S SEQ=SEQ+1
 . . S RESULTS("persons",SEQ,"userId")=IEN
 . . S RESULTS("persons",SEQ,"name")=$$NAMEFMT^XLFNAME(NM,"F","DcMPC")
 . . S RESULTS("persons",SEQ,"title")=""
 . . I $P(NM," ")=$P(PREVNM," ") D
 . . . S QUAL=$$GET1^DIQ(200,IEN_",",8)  ; try title first
 . . . I $L(QUAL) S RESULTS("persons",SEQ,"title")=QUAL Q
 . . . S QUAL=$$GET1^DIQ(200,IEN,",",29) ; then try service/section
 . . . S RESULTS("persons",SEQ,"title")=QUAL
 . . S PREVNM=NM
 I '$D(RESULTS) D  ; return empty array in ^TMP so handler knows it is JSON
 . K ^TMP("YTQ-JSON",$J)
 . S ^TMP("YTQ-JSON",$J,1,0)="{""persons"":[]}"
 . S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
USERS(ARGS,RESULTS) ; GET /api/mha/users/:match
 N ROOT,LROOT,NM,IEN,SEQ,PREVNM,PREVLBL,LABEL,QUAL,I
 S ROOT=$$UP^XLFSTR($G(ARGS("match"))),LROOT=$L(ROOT),SEQ=0,PREVNM="",PREVLBL=""
 S NM=ROOT F  S NM=$O(^VA(200,"AUSER",NM)) Q:NM=""  Q:$E(NM,1,LROOT)'=ROOT  D
 . S IEN=0 F  S IEN=$O(^VA(200,"AUSER",NM,IEN)) Q:'IEN  D
 . . S SEQ=SEQ+1
 . . S LABEL=$$NAMEFMT^XLFNAME(NM,"F","DcMPC"),QUAL=""
 . . I $P(NM," ")=$P(PREVNM," ") D
 . . . ; try TITLE as qualifier first
 . . . S $P(QUAL,U)=$$GET1^DIQ(200,IEN_",",8)
 . . . I $P((LABEL_QUAL),U)'=$P(PREVLBL,U) QUIT
 . . . ; try SERVICE/SECTION as qualifier next
 . . . S $P(QUAL,U,2)=$$GET1^DIQ(200,IEN,",",29)
 . . . I $P(LABEL_QUAL,U,1,2)'=$P(PREVLBL,U,1,2) QUIT
 . . . ; try nickname
 . . . S $P(QUAL,U,3)=$$GET1^DIQ(200,IEN_",",13)
 . . S PREVNM=NM,PREVLBL=LABEL_QUAL
 . . I $L(QUAL) D
 . . . N X,I S X=""
 . . . F I=1:1:3 I $L($P(QUAL,U,I)) S X=X_$S($L(X):", ",1:"")_$P(QUAL,U,I)
 . . . S LABEL=LABEL_" ("_X_")"
 . . S RESULTS("persons",SEQ,"id")=IEN
 . . S RESULTS("persons",SEQ,"label")=LABEL
 I '$D(RESULTS) D  ; return empty array in ^TMP so handler knows it is JSON
 . K ^TMP("YTQ-JSON",$J)
 . S ^TMP("YTQ-JSON",$J,1,0)="{""persons"":[]}"
 . S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
RESET ; clear the ^XTMP("YTQASMT") nodes
 ; WARNING -- calling this (at RESET+3) will erase all current assignments
 Q
 N NM
 S NM="YTQASMT" F  S NM=$O(^XTMP(NM)) Q:$E(NM,1,7)'="YTQASMT"  D
 . W !,NM
 . K ^XTMP(NM)
 Q
