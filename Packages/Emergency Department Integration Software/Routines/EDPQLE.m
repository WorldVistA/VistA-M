EDPQLE ;SLC/KCM - Retrieve Log Entry ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;**6,2**;Feb 24, 2012;Build 23
 ;
 ; ; DBIA#  SUPPORTED
 ; -----  ---------  ------------------------------------
 ;  1894  Cont Sub   ENCEVENT^PXAPI
 ;
GET(LOG,CHOICES) ; Get a log entry by request
 N CURBED,CURVAL,PERSON,CODED,CHTS,CHLOAD,CLINIC
 S AREA=$P(^EDP(230,LOG,0),U,3)
 S CHTS=$P($G(^EDPB(231.9,AREA,231)),U),CHLOAD=(CHTS'=CHOICES)
 N EDPTIME S EDPTIME=$$NOW^XLFDT
 N EDPNOVAL S EDPNOVAL=+$O(^EDPB(233.1,"B","edp.reserved.novalue",0))
 D LOG(LOG)
 D XML^EDPX("<choices ts='"_CHTS_"' >")
 D BEDS,PERSONS,CODED,CLINICS
 D:CHLOAD CHOICES^EDPQLE1(AREA)
 D CLINLST^EDPQLE1($P(^EDP(230,LOG,0),U,14)) ; time-sensitive, get every time
 D XML^EDPX("</choices>")
 Q
LOG(LOG) ; return the log entry as XML
 N X,X0,X1,X3
 ;
 L +^EDP(230,LOG):3
 S X0=^EDP(230,LOG,0),X1=$G(^(1)),X3=$G(^(3))
 S X("loadTS")=$$NOW^XLFDT
 L -^EDP(230,LOG)
 ;
 ; Set up encounter info into ^TMP if necessary so we can use it later
 ;   see if visit present, if diagnosis coded or missing provider
 I $P(X0,U,12),($P($G(^EDPB(231.9,AREA,1)),U,2)!('$P(X3,U,5))) D
 . K ^TMP("PXKENC",$J)
 . D ENCEVENT^PXAPI($P(X0,U,12))
 ;
 ; Get Provider from PCE if we don't have one
 ;    this is commented out for now since we don't have a way to
 ;    let the user know the provider was pulled in and needed to be saved
 ; I '$P(X3,U,5),$P(X0,U,12) S X("md")=$$PRIMPCE($P(X0,U,12)),PERSON("provider")=X("md")
 ;
 S X("id")=LOG
 S X("site")=$P(X0,U,2)
 S X("area")=$P(X0,U,3)
 S X("name")=$P(X0,U,4)
 S X("dfn")=$P(X0,U,6)
 S X("ssn")=$S(X("dfn"):$P(^DPT(X("dfn"),0),U,9),1:"")
 S X("dob")=$$DOB(X("dfn"))
 S X("closed")=$P(X0,U,7)
 S X("inTS")=$P(X0,U,8)
 S X("outTS")=$P(X0,U,9)
 S X("arrival")=$$CODE($P(X0,U,10)),CODED("arrival")=X("arrival")
 S X("visit")=$P(X0,U,12)
 S X("clinic")=$P(X0,U,14),CLINIC=X("clinic")
 S X("complaint")=$P(X1,U,1)
 S X("compLong")=$G(^EDP(230,LOG,2))
 S X("status")=$$CODE($P(X3,U,2)),CODED("status")=X("status")
 S X("acuity")=$$CODE($P(X3,U,3))
 S X("bed")=+$P(X3,U,4)
 S X("md")=+$P(X3,U,5),PERSON("provider")=X("md")
 S X("nurse")=+$P(X3,U,6),PERSON("nurse")=X("nurse")
 S X("res")=+$P(X3,U,7),PERSON("resident")=X("res")
 S X("comment")=$P(X3,U,8)
 S X("delay")=$$CODE($P(X1,U,5)),CODED("delay")=X("delay")
 S X("disposition")=$$CODE($P(X1,U,2)),CODED("disposition")=X("disposition")
 S X("required")=$$REQ(.X)
 S CURBED=X("bed")_U_$P(X3,U,9)  ; for later use by BEDS
 ;
 D XML^EDPX("<logEntry>")
 D XMLE^EDPX(.X)
 ;
 ; Get diagnosis from PCE if it is coded entry required AND patient has a VISIT
 I $P($G(^EDPB(231.9,AREA,1)),U,2),$P(X0,U,12) D
 . D DIAGPCE($P(X0,U,12))
 E  D
 . D DIAGFREE(LOG)
 ;
 I X("dfn") D PRF^EDPFPTC(X("dfn"))  ; patient record flags
 ;
 D XML^EDPX("</logEntry>")
 Q
PRIMPCE(EDPVISIT) ; return primary provider from PCE
 ;for provider
 ; LST(n)="PRV"^ien^^^name^primary/secondary flag
 N I,X,PRIM
 S PRIM=""
 S I=0 F  S I=$O(^TMP("PXKENC",$J,EDPVISIT,"PRV",I)) Q:'I  D  Q:PRIM
 . S X=^TMP("PXKENC",$J,EDPVISIT,"PRV",I,0)
 . Q:$P(X,U,4)'="P"
 . S PRIM=$P(X,U)
 Q:'PRIM ""
 Q:'$D(^XUSEC("PROVIDER",PRIM)) ""
 Q:'$$ALLOW^EDPFPER(PRIM,"P") ""
 Q PRIM
 ;
DIAGPCE(EDPVISIT) ; add PCE diagnoses
 Q:'EDPVISIT
 ;BEGIN EDP*2.0*2 CHANGES replace line below with one that follows
 N I,X,CODE,EDPLVDT,EDPLCIEN,EDPLCTYPE
 S I=0 F  S I=$O(^TMP("PXKENC",$J,EDPVISIT,"POV",I)) Q:'I  D
 . K X S X=^TMP("PXKENC",$J,EDPVISIT,"POV",I,0)
 . S X("type")="POV",EDPLVDT=$P($G(^TMP("PXKENC",$J,EDPVISIT,"VST",EDPVISIT,0)),U)
 . S EDPLCIEN=$P(X,U),EDPLCTYPE=$$VER^EDPLEX($$CSYS^EDPLEX(EDPLVDT)) ;DRP Added this line
 . S:EDPLCIEN (X("code"),CODE)=$P($$ICDDATA^EDPLEX("DIAG",EDPLCIEN,EDPLVDT),U,2)
 . S X("label")=^AUTNPOV($P(X,U,4),0),X("icdType")=EDPLCTYPE,X("ien")=EDPLCIEN
 . S:X("label")'[EDPLCTYPE X("label")=X("label")_" ("_$G(EDPLCTYPE)_" "_$G(CODE)_")" ; drp added this line
 . ;END EDP*2.0*2 CHANGES
 . S X("primary")=($P(X,U,12)="P")
 . D XML^EDPX($$XMLA^EDPX("diagnosis",.X))
 S I=0 F  S I=$O(^TMP("PXKENC",$J,EDPVISIT,"CPT",I)) Q:'I  D
 . K X S X=^TMP("PXKENC",$J,EDPVISIT,"CPT",I,0)
 . S X("type")="CPT"
 . S CODE=$O(^ICPT("B",$P(X,U),0)) S:CODE CODE=$P(^ICPT(CODE,0),U)
 . S X("code")=CODE
 . S X("label")=^AUTNPOV($P(X,U,4),0)
 . S X("quantity")=$P(X,U,16)
 . D XML^EDPX($$XMLA^EDPX("proc",.X))
 Q
DIAGFREE(LOG) ; add free text diagnoses
 N DIAG,CODE,LABEL,X4
 S DIAG=0 F  S DIAG=$O(^EDP(230,LOG,4,DIAG)) Q:'DIAG  D
 . S EDPLVDT=$P(^EDP(230,LOG,0),U,8) ;drp EDP*2.0*2 added to retrieve Date of Interest
 . S X4=^EDP(230,LOG,4,DIAG,0)
 . ;BEGIN EDP*2.0*2 CHANGES
 . S X4("type")="POV"
 . S EDPLCIEN=$P(X4,U,2) S:EDPLCIEN CODE=$P($$ICDDATA^EDPLEX("DIAG",EDPLCIEN,EDPLVDT),U,2) ;drp
 . S:$G(CODE)'="" X4("code")=CODE,EDPLCTYPE=$$VER^EDPLEX($$CSYS^EDPLEX(EDPLVDT)),X4("ien")=EDPLCIEN
 . S:$G(EDPLCTYPE)'="" X4("icdType")=EDPLCTYPE ; added this line drp
 . S X4("label")=$P(X4,U,1)
 . S:X4("label")'[$G(EDPLCTYPE) X4("label")=X4("label")_" ("_$G(EDPLCTYPE)_" "_$G(CODE)_")" ; drp added this line
 . ;drp END EDP*2.0*2 CHANGES
 . S X4("primary")=+$P(X4,U,3)
 . D XML^EDPX($$XMLA^EDPX("diagnosis",.X4))
 Q
DOB(DFN) ; Return date of birth (external)
 I 'DFN Q ""
 N VA,VADM,X,Y
 D DEM^VADPT
 Q $P(VADM(3),U,2)_"   Age "_VADM(4)
 ;
CODE(IEN) ; set NOVAL code to 0 when returning code
 Q:IEN=EDPNOVAL 0
 Q +IEN
 ;
BEDS ; add a list of available room/beds for this area
 D XML^EDPX("<bedList>")
 D XML^EDPX($$XMLS^EDPX("bed",0,"None"))   ;non-selected
 N BED,X0,MULTI,SEQ,OCCUPIED,MYBED
 S BED=0 F  S BED=$O(^EDPB(231.8,"C",EDPSITE,AREA,BED)) Q:'BED  D
 . S SEQ=$P(^EDPB(231.8,BED,0),U,5) S:'SEQ SEQ=99999
 . ; PATCH 6 (BWF - 4/24/2013) - Additional filter for EDIS_DEFAULT
 . I $$GET1^DIQ(231.8,BED,.01,"E")="EDIS_DEFAULT" Q
 . S SEQ(SEQ,BED)=""
 S SEQ=0 F  S SEQ=$O(SEQ(SEQ)) Q:'SEQ  D
 . S BED=0 F  S BED=$O(SEQ(SEQ,BED)) Q:'BED  D
 .. S X0=^EDPB(231.8,BED,0)
 .. ; QUIT if inactive bed
 .. I $P(X0,U,4) Q
 .. ; QUIT if occupied, unless own bed or multi-assign
 .. S MULTI=+$P(X0,U,9) S:MULTI=3 MULTI=0 ; single non-ed
 .. S OCCUPIED=$D(^EDP(230,"AL",EDPSITE,AREA,BED))!$D(^EDP(230,"AH",EDPSITE,AREA,BED))
 .. S MYBED=(BED=+CURBED)!(BED=$P(CURBED,U,2))
 .. I OCCUPIED,'MYBED,'MULTI Q
 .. ;
 .. S X("data")=BED
 .. S X("label")=$P(X0,U,6)_"  ("_$P(X0,U)_")"
 .. S X("ref")=$P(X0,U,8)
 .. D XML^EDPX($$XMLA^EDPX("bed",.X))
 D XML^EDPX("</bedList>")
 Q
PERSONS ; add the internal/external values for persons
 N ROLE,NAME,LOCID,IEN,X
 D XML^EDPX("<persons>")
 F ROLE="provider","nurse","resident" S LOCID=$G(PERSON(ROLE)) D
 . Q:'LOCID
 . S NAME=$P(^VA(200,LOCID,0),U)
 . S X("data")=LOCID,X("label")=NAME
 . D XML^EDPX($$XMLA^EDPX(ROLE,.X))
 D XML^EDPX("</persons>")
 Q
CODED ; add internal/external values for codes
 N NAME,X
 D XML^EDPX("<selected>")
 S X="" F  S X=$O(CODED(X)) Q:X=""  I CODED(X) D
 . S NAME=$P($G(^EDPB(233.1,CODED(X),0)),U,2) Q:NAME=""
 . D XML^EDPX($$XMLS^EDPX(X,CODED(X),NAME))
 D XML^EDPX("</selected>")
 Q
CLINICS ; add internal/external values for clinic
 Q:'CLINIC
 N NAME,X
 D XML^EDPX("<clinics>")
 S NAME=$P($G(^SC(CLINIC,0)),U)
 S X("data")=CLINIC,X("label")=NAME
 D XML^EDPX($$XMLA^EDPX("clinic",.X))
 D XML^EDPX("</clinics>")
 Q
REQ(VAL) ; return the fields required to close this entry
 ; called from LOG, AREA is assumed to be defined
 N NEED,PARAM
 S PARAM=$G(^EDPB(231.9,AREA,1)),NEED=""
 I $P(PARAM,U,1) S $P(NEED,",",1)="diag"
 I $P(PARAM,U,3) S $P(NEED,",",2)="disp"
 ; bwf - 4/26/13 - per Dr. Gelman, want delay reason no matter whether patient is in observation or not.
 ;               - replaced line below with one that follows
 ;I $$DLYREQ,$$NOTOBS,$$EXCEED S $P(NEED,",",3)="delay"
 I $$DLYREQ,$$EXCEED S $P(NEED,",",3)="delay"
 Q NEED
 ;
DLYREQ() ; return true if delay params set to required
 ; called from REQ, PARAM is assumed to be defined
 Q $P(PARAM,U,4)&$P(PARAM,U,5)
 ;
NOTOBS() ; return true if not in observation status
 ; called from REQ, VAL is assumed to be defined
 N STS S STS=+$G(VAL("status"))
 Q:'STS 1
 Q:$P(^EDPB(233.1,STS,0),U,5)["O" 0
 Q 1
 ;
EXCEED() ; return true if delay time exceeded
 ; called from REQ, VAL and PARAM are assumed to be defined
 N IN S IN=$G(VAL("inTS"))
 N OUT S OUT=$G(VAL("outTS")) S:'OUT OUT=EDPTIME
 N MAX S MAX=$P(PARAM,U,5)
 Q ($$FMDIFF^XLFDT(OUT,IN,2)\60)>MAX
