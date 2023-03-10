YTQRQAD ;SLC/KCM - RESTful Calls for Instrument Admin ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130,141,158,181,187,199**;Dec 30, 1994;Build 18
 ;
 ; Reference to ^DIC(3.1) in ICR #1234
 ; Reference to ^DIC(49) in ICR #10093
 ; Reference to ^DPT in ICR #10035
 ; Reference to ^VA(200) in ICR #10060
 ; Reference to ^VA(200,"AUSER") in ICR #4868
 ; Reference to DIQ in ICR #2056
 ; Reference to XLFNAME in ICR #3065
 ; Reference to XLFSTR in ICR #10104
 ; Reference to XQCHK in ICR #10078
 ; Reference to TFL^VAFCFTU2 in ICR #4648
 ;
 ;; -- GETs  all return M object that is transformed to JSON
 ;; -- POSTs all return a path to the created/updated object
 ;;
PID(ARGS,RESULTS) ; get patient identifiers
 N DFN
 S DFN=$G(ARGS("dfn"))
 ;
 ; If DFN starts with E, treat as EDIPI and translate to DFN
 ; Look up using TFL^VAFCTFU2. Returns DFN by station number.
 ; Sample return from TFL^VAFCTFU2:
 ; YTTFL(1)="5000000348V286511^NI^USVHA^200M^A" (ICN)
 ; YTTFL(2)="100849^PI^USVHA^999^A" (DFN)
 ; YTTFL(3)="567861^NI^USDOD^200DOD^A" (EDIPI DOD)
 ; YTTFL(4)="567861^PI^USVHA^200CRNR^A" (EDIPI DEDUP VERSION)
 I $E(DFN)="E" D  QUIT:$G(YTQRERRS)
 . ;
 . ; Get EDIPI and get Treating Facilities
 . N EDIPI S EDIPI=$E(DFN,2,99),DFN=""
 . N YTTFL D TFL^VAFCTFU2(.YTTFL,EDIPI_"^PI^USVHA^200CRNR") ; ICR #4648 (private IA)
 . ;
 . ; Did we fail to get any treating facilities?
 . I $P(YTTFL(1),U)=-1 D SETERROR^YTQRUTL(404,"EDIPI Not Found: "_EDIPI) QUIT
 . ;
 . ; Look for DFN
 . ; The call gives us DFNs by Station Numbers. We need the one for this site.
 . ; This explains why we loop through and test each one.
 . N STA S STA=$P($$SITE^VASITE,U,3)
 . N R
 . F R=0:0 S R=$O(YTTFL(R)) Q:'R  D  Q:DFN
 .. N L S L=YTTFL(R)
 .. I $P(L,U,2)="PI",$P(L,U,3)="USVHA",$P(L,U,4)=STA S DFN=$P(L,U)
 . ;
 . I 'DFN D SETERROR^YTQRUTL(404,"EDIPI Not Found: "_EDIPI) QUIT
 ; 
 I '$D(^DPT(DFN,0)) D SETERROR^YTQRUTL(404,"Not Found: "_DFN) QUIT
 S RESULTS("dfn")=DFN
 S RESULTS("name")=$P($G(^DPT(DFN,0)),U)
 S RESULTS("pid")="xxx-xx-"_$E($P($G(^DPT(DFN,0)),U,9),6,10)
 S RESULTS("ssn")=RESULTS("pid") ; TEMPORARY until a switch to PID
 S RESULTS("email")=$P($G(^DPT(DFN,.13)),U,3)
 Q
APPROXY() ; return 1 if this call is via application proxy
 N XQOPT D OP^XQCHK I $P(XQOPT,U)="YTQREST PATIENT ENTRY" Q 1
 Q 0
 ;
LSTALL(ARGS,RESULTS) ; get a list of all instruments
 D GETDOC("YTL ACTIVE",.RESULTS)
 Q
LSTCPRS(ARGS,RESULTS) ; get a list of all instruments
 D GETDOC("YTL CPRS",.RESULTS)
 Q
GETSPEC(ARGS,RESULTS) ; get an instrument specification
 K ^TMP("YTQ-JSON",$J)
 N TEST,TESTNM,SPEC
 S TESTNM=$G(ARGS("instrumentName")) I '$L(TESTNM) D  QUIT
 . D SETERROR^YTQRUTL(400,"Missing instrument name")
 S TEST=$O(^YTT(601.71,"B",TESTNM,0))
 I 'TEST S TEST=$O(^YTT(601.71,"B",$TR(TESTNM,"_"," "),0))
 I 'TEST D SETERROR^YTQRUTL(404,"Not Found: "_TESTNM) QUIT
 S SPEC=+$O(^YTT(601.712,"B",TEST,0))
 I $D(^YTT(601.712,SPEC,1))<10 D  QUIT
 . D SETERROR^YTQRUTL(404,"Specification missing")
 D MV2TMP(SPEC)
 I TESTNM="AUDC",$G(ARGS("assignmentid")) D VARYAUDC(ARGS("assignmentid"))
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
MV2TMP(SPEC) ; Load spec into ^TMP("YTQ-JSON",$J), cleaning up line feeds
 N I,J,X,Y
 K ^TMP("YTQ-JSON",$J)
 S (I,J)=0 F  S I=$O(^YTT(601.712,SPEC,1,I)) Q:'I  S X=^(I,0) D
 . S J=J+1,^TMP("YTQ-JSON",$J,J,0)=X
 . I (($L(X)-$L($TR(X,"""","")))#2) D  ; check for odd number of quotes
 . . F  S I=I+1 Q:'$D(^YTT(601.712,SPEC,1,I,0))  D  Q:Y[""""
 . . . S Y=^YTT(601.712,SPEC,1,I,0)
 . . . S ^TMP("YTQ-JSON",$J,J,0)=^TMP("YTQ-JSON",$J,J,0)_Y
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
VARYAUDC(ASMT) ; modify the AUDC based on patient sex in ^TMP("YTQ-JSON",$J)
 N DFN,I,DONE,X0,X1,X2
 S DFN=+$G(^XTMP("YTQASMT-SET-"_ASMT,1,"patient","dfn")) QUIT:'DFN
 I $P($G(^DPT(DFN,0)),U,2)'="F" QUIT  ; only need to change for female
 ; looking for the 3rd question, so start checked at about line 25
 S DONE=0,I=25 F  S I=$O(^TMP("YTQ-JSON",$J,I)) Q:'I  D  Q:DONE
 . I ^TMP("YTQ-JSON",$J,I,0)'["six or more" QUIT
 . S X0=^TMP("YTQ-JSON",$J,I,0)
 . S X1=$P(X0,"six or more")
 . S X2=$P(X0,"six or more",2)
 . S ^TMP("YTQ-JSON",$J,I,0)=X1_"4 or more"_X2,DONE=1
 Q
PERSONS(ARGS,RESULTS) ; GET /api/mha/persons/:match
 N ROOT,LROOT,NM,IEN,SEQ,PREVNM,QUAL,REQCSGN
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
GINSTD(ARGS,RESULTS) ;Get Instrument Description
 N YS,YSDATA,YSTESTN,II,YSAR,VAR,VAL,JSONAR,XX
 S YS("CODE")=$G(ARGS("instrumentName"))
 D TSLIST1^YTQAPI(.YSDATA,.YS)
 I '$D(YSDATA) D SETERROR^YTQRUTL(404,"Error retrieving description") Q
 S YSDATA(1)=$G(YSDATA(1)),YSDATA(2)=$G(YSDATA(2))
 I YSDATA(1)["ERROR",(YSDATA(2)="NO code") D SETERROR^YTQRUTL(404,"No instrument name.") Q
 I YSDATA(1)["ERROR",(YSDATA(2)="bad code") D SETERROR^YTQRUTL(404,"Instrument not found.") Q
 S I=0 F  S I=$O(YSDATA(I)) Q:I=""  D
 . S XX=YSDATA(I),VAR=$P(XX,"="),VAL=$P(XX,"=",2)
 . Q:VAR=""
 . S:VAR="LAST EDIT DATE" VAL=$P($$FMTE^XLFDT(VAL,2),"@")
 . I VAR="ENTRY DATE" D
 .. N X,Y,%DT S X=VAL D ^%DT S VAL=$$FMTE^XLFDT(Y,2)
 . S YSAR(VAR)=VAL
 F VAR="PRINT TITLE^Print Title","VERSION^Version","AUTHOR^Author","PUBLISHER^Publisher","COPYRIGHT TEXT^Copyright","PUBLICATION DATE^Publication Date" D
 . D SETVAR("Clinical Features",VAR)
 F VAR="REFERENCE^Reference","PURPOSE^Purpose","NORM SAMPLE^Norm Sample","TARGET POPULATION^Target Population" D
 . D SETVAR("Clinical Features",VAR)
 F VAR="A PRIVILEGE^Administrative Privilege","R PRIVILEGE^Result Privilege","ENTERED BY^Entered By","ENTRY DATE^Entry Date" D
 . D SETVAR("Technical Features",VAR)
 F VAR="LAST EDITED BY^Last Edited By","LAST EDIT DATE^Last Edit Date","IS NATIONAL TEST^National Test","LICENSE CURRENT^Requires License","IS LEGACY^Is Legacy Instrument","SUBMIT TO NATIONAL DB^Submit to National DB" D
 . D SETVAR("Technical Features",VAR)
 ;
 ;F VAR="PRINT TITLE^Print Title","VERSION^Version","AUTHOR^Author","PUBLISHER^Publisher","COPYRIGHT TEXT^Copyright","PUBLICATION DATE^Publication Date" D
 ;. D SETVAR("Clinical Features",VAR)
 ;F VAR="REFERENCE^Reference","PURPOSE^Purpose","NORM SAMPLE^Norm Sample","TARGET POPULATION^Target Population" D
 ;. D SETVAR("Clinical Features",VAR)
 ;F VAR="A PRIVILEGE^Administrative Privilege","LICENSE CURRENT^Requires License" D
 ;. D SETVAR("Technical Features",VAR)
 K RESULTS M RESULTS=JSONAR Q
 Q
SETVAR(XCAT,VAR) ;Set JSON array values for Instrument Description - Requires YSAR to be set
 N XVAR,CAP
 S XVAR=$P(VAR,U),CAP=$P(VAR,U,2)
 S JSONAR("Description",XCAT,XVAR,"value")=YSAR(XVAR)
 S JSONAR("Description",XCAT,XVAR,"caption")=CAP
 Q
RESET ; clear the ^XTMP("YTQASMT") nodes
 ; WARNING -- calling this (at RESET+3) will erase all current assignments
 Q
 N NM
 S NM="YTQASMT" F  S NM=$O(^XTMP(NM)) Q:$E(NM,1,7)'="YTQASMT"  D
 . W !,NM
 . K ^XTMP(NM)
 Q
