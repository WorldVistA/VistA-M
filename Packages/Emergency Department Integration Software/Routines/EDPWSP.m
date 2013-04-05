EDPWSP ;SLC/KCM - Preserve Worksheet State ;3/1/12 10:40am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
PRESERVE(REQ) ; loop thru XML and preserve nodes for each model/plugin
 ;
 ; Source (XML passed in via REQ("preserve",n)):
 ;
 ; <worksheet id={worksheetIEN} scroll={scrollPosition}>
 ;   <section id={sectionIEN} open={true|false}>
 ;     <state>{XML for visual state of plugin}</state>
 ;   </section>
 ;   ...
 ; </worksheet>
 ; <models>
 ;   <model name={unique name} >
 ;     <state>{uncommitted data}</state>
 ;   </model>
 ;   ...
 ; </models>
 ;
 ; Destination:
 ;
 ; ^XTMP("EDPWSS-log-duz",0)=DT+7^DT^Worksheet State
 ; ^XTMP("EDPWSS-log-duz",worksheetID)={scroll position}
 ; ^XTMP("EDPWSS-log-duz",worksheetID,sectionID)={isOpen}
 ; ^XTMP("EDPWSS-log-duz",worksheetID,sectionID,...)={visual state XML}
 ; ^XTMP("EDPWSS-log-duz",modelID,...)={uncommitted data XML}
 ;
 N WSXML,STATE,XROOT,LOG
 M WSXML=REQ("preserve") K REQ("preserve")
 D TOARR^EDPXML(.WSXML,.STATE,"preserve") K WSXML
 S LOG=$G(REQ("log",1)) Q:'LOG
 S XROOT="EDPWSS-"_LOG_"-"_DUZ
 S ^XTMP(XROOT,0)=$$FMADD^XLFDT(DT,1)_U_DT_U_"EDIS Worksheet State"
 D PWORKS,PMODEL
 Q
PWORKS ; preserve worksheet state
 ; from: PRESERVE
 ; expects: STATE,XROOT
 N WKS,SCROLL,I,SEC,SECS,OPEN
 S WKS=$G(STATE("worksheet",1,"id")) Q:'WKS
 S SCROLL=$G(STATE("worksheet",1,"scroll"),0)
 S I=0 F  S I=$O(STATE("worksheet",1,"section",I)) Q:'I  D
 . S SEC=$G(STATE("worksheet",1,"section",I,"id")) Q:'SEC
 . S OPEN=$G(STATE("worksheet",1,"section",I,"open"))
 . S SECS(SEC)=OPEN
 . M SECS(SEC)=STATE("worksheet",1,"section",I,"state",1)
 S ^XTMP(XROOT,WKS)=SCROLL
 M ^XTMP(XROOT,WKS)=SECS
 Q
PMODEL ; preserve state for models
 ; from: PRESERVE
 ; expects: STATE,XROOT
 N I,MODEL
 S I=0 F  S I=$O(STATE("models",1,"model",I)) Q:'I  D
 . S MODEL=$G(STATE("models",1,"model",I,"id")) Q:'MODEL
 . M ^XTMP(XROOT,MODEL)=STATE("models",1,"section",I,"state",1)
 Q
SAVE(REQ) ; Save the uncommitted models from the worksheet
 N WSXML,STATE,VROOT,EDPCTXT
 M WSXML=REQ("preserve") K REQ("preserve")
 D TOARR^EDPXML(.WSXML,.STATE,"preserve") K WSXML
 D SETCTXT^EDPWSL(.EDPCTXT,.REQ)
 ;
 N I,MODEL,EDPDATA,SAVECALL
 S I=0 F  S I=$O(STATE("models",1,"model",I)) Q:'I  D
 . S MODEL=$G(STATE("models",1,"model",I,"id")) Q:'MODEL
 . M EDPDATA=STATE("models",1,"section",I,"state",1)
 . S SAVECALL=$P($G(^EDPB(232.72,MODEL,2)),U,1,2) Q:'$L(SAVECALL)
 . D @(SAVECALL_"(.EDPCTXT,.EDPDATA)")
 . I $G(^XTMP(VROOT,EDPCTXT("log"),MODEL)) S ^XTMP(VROOT,EDPCTXT("log"),MODEL)=0
 Q
