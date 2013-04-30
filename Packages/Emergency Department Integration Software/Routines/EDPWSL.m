EDPWSL ;SLC/KCM - Load Worksheet and Models ;3/1/12 10:43am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
LOAD(REQ) ; Load Worksheet and Models (data)
 ; expected: area, log, role, dfn
 ; optional: worksheet, preserve XML
 ;
 ; -- save the previous worksheet state, if any
 D PRESERVE^EDPWSP(.REQ)
 ; -- set context
 N EDPCTXT,WKS,MIENS,SPEC,MODELS
 D SETCTXT(.EDPCTXT,.REQ)
DB ; -- determine worksheet
 S WKS=$G(REQ("worksheet",1))
 I 'WKS S WKS=$$DFLTWKS(EDPCTXT("role"),EDPCTXT("area"))
 I 'WKS D XML^EDPX("<worksheet />") Q  ;TODO -- trigger error section?
 ;
 D BLDWS(WKS,.SPEC,.MIENS)
 D BLDMDL^EDPWSLM(.EDPCTXT,.MIENS,.MODELS)
 ; put it all together and return the XML
 M MODELS("worksheet",1)=SPEC K SPEC
 D TOXML^EDPXML(.MODELS,.EDPXML) K MODELS
 Q
DFLTWKS(ROLE,AREA) ; Return default worksheet for this role
 N IEN S IEN=$O(^EDPB(232.5,"C",EDPSITE,AREA,ROLE,0))
 Q:'IEN 0
 Q $P(^EDPB(232.5,IEN,0),U,4)
 ;
BLDWS(WSID,SPEC,MIENS) ; build XML for worksheet
 ; 
 ; returned XML:
 ;
 ; <worksheet id={worksheetIEN} name={worksheetName} scroll={lastScrollPos}>
 ;   <section detailPlugin={full class name} displayName={name} id={sectionIEN}
 ;            initialOpen={false|true} summaryPlugin={full class name} taskType={1|2|3} >
 ;     <config>{configuration XML for plugin</config>
 ;     <state>{visual state XML</state>
 ;     <model id={modelIEN} name={full class name for required model}/>
 ;      ...
 ;   </section>
 ;    ...
 ; </worksheet>
 ;
 ; worksheet state saved in:
 ;
 ; ^XTMP("EDPWS-dfn-duz",0)=DT+7^DT^Worksheet State
 ; ^XTMP("EDPWS-dfn-duz",worksheetID)={scroll position}
 ; ^XTMP("EDPWS-dfn-duz",worksheetID,sectionID)={isOpen}
 ; ^XTMP("EDPWS-dfn-duz",worksheetID,sectionID,n)={visual state XML}
 ; ^XTMP("EDPWS-dfn-duz",modelID,n)={uncommitted data XML}
 ;
 N SEQ,SEQ1,SECID,WROOT
 ; -- load the worksheet spec
 D GETWKS^EDPBWS(WSID,.SPEC)
 S WROOT="EDPWS-"_EDPCTXT("dfn")_"-"_DUZ
 S SPEC("scroll")=+$G(^XTMP(WROOT,WSID))
 ; -- iterate thru loaded sections
 S SEQ=0 F  S SEQ=$O(SPEC("section",SEQ)) Q:'SEQ  D
 . S SECID=SPEC("section",SEQ,"id")
 . ; -- apply visual state to section
 . I $D(^XTMP(WROOT,WSID,SECID)) D
 . . S SPEC("section",SEQ,"initialOpen")=$G(^XTMP(WROOT,WSID,SECID),SPEC("section",SEQ,"initialOpen"))
 . . ; TODO: load the XML visual state
 . ; -- build list of unique models
 . S SEQ1=0 F  S SEQ1=$O(SPEC("section",SEQ,"model",SEQ1)) Q:'SEQ1  D
 . . S MIENS(SPEC("section",SEQ,"model",SEQ1,"id"))=""
 Q
SETCTXT(EDPCTXT,REQ) ; Set the context from the request
 S EDPCTXT("area")=$G(REQ("area",1))
 S EDPCTXT("log")=$G(REQ("log",1))
 S EDPCTXT("dfn")=$G(REQ("dfn",1))
 S EDPCTXT("role")=$G(REQ("role",1))
 S EDPCTXT("session")=$G(REQ("session",1))
 Q
TEST ;
 S EDPSITE=DUZ(2)
 S REQ("area",1)=1
 S REQ("log",1)=11
 S REQ("dfn",1)=100642
 S REQ("role",1)=459
 S REQ("session",1)=12345
 D LOAD(.REQ)
 ;ZW EDPXML
 Q
