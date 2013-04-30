EDPWSLM ;SLC/KCM - Load & Register Models ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
BLDMDL(EDPCTXT,MIENS,MODELS) ; Build models as array to convert to XML
 ; returned XML will be:
 ;
 ; <model name={full class name} type={visit|reference}>
 ;   <data>{xml specific for this model}</data>
 ;   <state>{xml for uncommitted state for this model}</state>
 ; </model>
 ;  ...
 ;
 ; Structures to track which models have been sent to client:
 ;
 ; ^XTMP("EDPWSV-dfn-session",0)=DT+1^DT^EDIS Visit Models
 ; ^XTMP("EDPWSV-dfn-session",IEN)=1 if fresh ^ DUZ
 ; ^XTMP("EDPWSR-area-session",0)=DT+1^DT
 ; ^XTMP("EDPWSR-area-session",IEN)=1 if fresh ^ DUZ
 ;
 ; Structure to keep uncommitted state
 ;
 ; ^XTMP("EDPWS-dfn-duz",IEN,n)={uncommitted data XML}
 ;
 ; Models desired:  MIENS(ptr 232.72)=""
 ;
 N IEN,VROOT,RROOT,WROOT,MTYPE,LOADCALL
 S VROOT="EDPWSV-"_EDPCTXT("dfn")_"-"_EDPCTXT("session")
 S RROOT="EDPWSR-"_EDPCTXT("area")_"-"_EDPCTXT("session")
 S WROOT="EDPWS-"_EDPCTXT("dfn")_"-"_DUZ
 S IEN=0 F  S IEN=$O(MIENS(IEN)) Q:'IEN  D  ; loop thru models req'd by client
 . S MTYPE=$P(^EDPB(232.72,IEN,0),U,4)
 . I MTYPE="V",$G(^XTMP(VROOT,IEN)) Q       ; client visit model still fresh
 . I MTYPE="R",$G(^XTMP(RROOT,IEN)) Q       ; client ref model still fresh
 . S EDPCTXT("model")=IEN
 . S LOADCALL=$P($G(^EDPB(232.72,IEN,1)),U,1,2)
 . Q:'$L(LOADCALL)
 . I $P(^EDPB(232.72,IEN,1),U,3) D
 . . N EDPXML
 . . D @(LOADCALL_"(.EDPCTXT)")
 . . D TOARR^EDPXML(.EDPXML,.EDPDATA)
 . E  D @(LOADCALL_"(.EDPCTXT,.EDPDATA)")
 . I $D(EDPDATA) M MODELS("model",IEN,"data",1)=EDPDATA
 . K EDPDATA
 . ; add any uncommitted state
 . I $D(^XTMP(WROOT,IEN))>1 M MODELS("model",IEN,"state",1)=^XTMP(WROOT,IEN)
 ;
 ; NOTE: when updating the structures that track models
 ; F  S X=$O(^XTMP("EDPWSV-dfn")) Q:$P(X,"-",2)'=DFN  D
 ; . S ^XTMP(X,moniker)=0  ; check DUZ, logID etc.
 Q
