EDPWS ;SLC/KCM - Worksheet Calls ;3/2/12 10:43am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
LOAD(REQ) ; Load Worksheet with Models
 D PRESERVE(.REQ) ; save previous worksheet state
 N EDPCTXT,WKS,WRKSHT,MODELS,RESULT,NEEDED,SEQ
 S EDPCTXT("area")=$G(REQ("area",1))
 S EDPCTXT("log")=$G(REQ("log",1))
 S EDPCTXT("dfn")=$G(REQ("dfn",1))
 S EDPCTXT("role")=$G(REQ("role",1))
 I DUZ=20011 S EDPCTXT("role")=573 ; CLERK 4
 I DUZ=20014 S EDPCTXT("role")=272 ; NURSE 3
 I DUZ=20013 S EDPCTXT("role")=426 ; RESIDENT 2
 I DUZ=20015 S EDPCTXT("role")=459 ; PHYSICIAN 1
 I 'EDPCTXT("role") S EDPCTXT("role")=459  ; TEMPORARY!!
 S WKS=$G(REQ("worksheet",1))
 I 'WKS S WKS=$$DFLTWKS(EDPCTXT("role"),EDPCTXT("area"))
 I 'WKS D XML^EDPX("<worksheet />") Q  ;TODO -- trigger error?
 ;
 ; load the worksheet specification
 D GETWKS^EDPBWS(WKS,.WRKSHT)
 S WRKSHT("dfn")=EDPCTXT("dfn")
 D ADDST(.WRKSHT)
 ; iterate thru the sections and get their models
 S SEQ=0 F  S SEQ=$O(WRKSHT("section",SEQ)) Q:'SEQ  D
 . S I=0 F  S I=$O(WRKSHT("section",SEQ,"model",I)) Q:'I  D
 . . S NEEDED(WRKSHT("section",SEQ,"model",I,"id"))=""
 D MODELS(.NEEDED,.MODELS)
 M RESULTS=MODELS,RESULTS("worksheet",1)=WRKSHT
 K MODELS,WRKSHT,NEEDED  ; free some memory
 D TOXML^EDPXML(.RESULTS,.EDPXML)
 K RESULTS,SEC
 Q
MODELS(NEEDED,MODELS) ; Build models for section
 N MODEL,X0,EDPDATA,LOADCALL
 S MODEL=0 F  S MODEL=$O(NEEDED(MODEL)) Q:'MODEL  D
 . ; quit here if model already on the client
 . S X0=^EDPB(232.72,MODEL,0)
 . S MODELS("model",MODEL,"name")=$P(X0,U,2)_"::"_$P(X0,U)
 . S MODELS("model",MODEL,"type")=$S($P(X0,U,4)="V":"visit",1:"reference")
 . S EDPCTXT("model")=MODELS("model",MODEL,"name")
 . S LOADCALL=$P($G(^EDPB(232.72,MODEL,1)),U,1,2)
 . Q:'$L(LOADCALL)
 . I $P(^EDPB(232.72,MODEL,1),U,3) D
 . . N EDPXML
 . . D @(LOADCALL_"(.EDPCTXT)")
 . . D TOARR^EDPXML(.EDPXML,.EDPDATA)
 . E  D @(LOADCALL_"(.EDPCTXT,.EDPDATA)")
 . I $D(EDPDATA) M MODELS("model",MODEL,"data",1)=EDPDATA
 . K EDPDATA
 Q
DFLTWKS(ROLE,AREA) ; Return default worksheet for this role
 N IEN S IEN=$O(^EDPB(232.5,"C",EDPSITE,AREA,ROLE,0))
 Q:'IEN 0
 Q $P(^EDPB(232.5,IEN,0),U,4)
 ;
PRESERVE(REQ) ; Preserve status of previously selected worksheet
 N WXML M WXML=REQ("preserve") K REQ("preserve")
 N WSTS D TOARR^EDPXML(.WXML,.WSTS,"preserve")
 Q:'$D(WSTS("worksheet",1,"dfn"))
 N TREF S TREF="EDPWKS-"_WSTS("worksheet",1,"dfn")_"-"_DUZ
 S ^XTMP(TREF,0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"ED Worksheet State"
 N WKID S WKID=WSTS("worksheet",1,"id")
 K ^XTMP(TREF,"worksheet",WKID)
 S ^XTMP(TREF,"worksheet",WKID)=WSTS("worksheet",1,"scroll")
 N I S I=0
 F  S I=$O(WSTS("worksheet",1,"section",I)) Q:'I  D
 . S SEC=$$SECID(WSTS("worksheet",1,"section",I,"name"))
 . S ^XTMP(TREF,"worksheet",WKID,"section",SEC)=WSTS("worksheet",1,"section",I,"open")
 Q
SECID(NAME) ; return section IEN given name
 Q +$O(^EDPB(232.71,"C",NAME,0))
 ;
ADDST(WRKSHT) ; add state, if any to the worksheet
 N TREF S TREF="EDPWKS-"_WRKSHT("dfn")_"-"_DUZ
 N WKID S WKID=WRKSHT("id")
 Q:'$D(^XTMP(TREF,"worksheet",WKID))
 S WRKSHT("scroll")=+^XTMP(TREF,"worksheet",WKID)
 N I,OPEN S I=0
 F  S I=$O(WRKSHT("section",I)) Q:'I  D
 . S SEC=+$$SECID(WRKSHT("section",I,"detailPlugin")) Q:'SEC
 . S OPEN=$G(^XTMP(TREF,"worksheet",WKID,"section",SEC))
 . I $L(OPEN) S WRKSHT("section",I,"initialOpen")=OPEN
 Q
PREVIEW(CTXT,RESULT) ; Add XML for a model preview
 N MODEL S MODEL=CTXT("model")
 I MODEL'=+MODEL S MODEL=$O(^EDPB(232.72,"C",MODEL,0))
 Q:'$D(^EDPB(232.72,+MODEL,5))
 N XML,I
 S I=0 F  S I=$O(^EDPB(232.72,+MODEL,5,I)) Q:'I  S XML(I)=^(I,0)
 D TOARR^EDPXML(.XML,.RESULT,"data")
 Q
SVSECT(REQ) ; Save models of the worksheet
 N EDPCTXT,EDPDATA
 S EDPCTXT("dfn")=REQ("dfn",1)
 S EDPCTXT("area")=REQ("area",1)
 S EDPCTXT("log")=REQ("log",1)
 ; put in global so the XML can be converted using Kernel tools
 N XMLDATA M XMLDATA=REQ("uncommittedState")
 D TOARR^EDPXML(.XMLDATA,.EDPDATA,"data")
 S MODEL="" F  S MODEL=$O(EDPDATA("model",MODEL)) Q:MODEL=""
 Q
SAVE(XML,CTXT,COMMIT) ; Save the worksheet XML
 ; XML contains all the momentos to be saved
 ; can either stash the XML in ^XTMP (COMMIT=0)
 ; or parse and call out to packages to save their models (COMMIT=1)
 Q
 ;
 ; bwf: 12-19/2011 commenting test code for the time being
 ;TEST ;
 ;S EDPSITE=DUZ(2),EDPSTA=$$STA^XUAF4(DUZ(2))
 ;S REQ("area",1)=1,REQ("log",1)=9,REQ("dfn",1)=229,REQ("role")=459
 ;D LOAD(.REQ)
 ;Q
 ;TESTPASS(AREF) ; Test passing of array
 ;W !,AREF
 ;S X=AREF F  S X=$Q(@X) Q:$E(X,1,$L(AREF)-1)'=$E(AREF,1,$L(AREF)-1)  W !,X
 ;ZW ARY
 ;Q
 ;TV ;
 ;S EDPCTXT("area")=1,EDPCTXT("log")=6,EDPCTXT("dfn")=229
 ;D READ^EDPVIT(.EDPCTXT) ZW EDPXML
 ;Q
 ;T1(EDPCXT) ; TEST
 ;W !,"HI"
 ;Q
 ;TP ; TEST PRESERVE
 ;N REQ M REQ=^KEVIN("REQ")
 ;D PRESERVE(.REQ)
 ;Q
