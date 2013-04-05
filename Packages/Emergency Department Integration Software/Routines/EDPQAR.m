EDPQAR ;SLC/KCM - Log Area Information ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
PARAM(AREA) ; return parameters for area
 N X,X1
 S X1=$G(^EDPB(231.9,AREA,1))
 S X("reqDiag")=+$P(X1,U,1)
 S X("codedDiag")=+$P(X1,U,2)
 S X("reqDisp")=+$P(X1,U,3)
 S X("reqDelay")=+$P(X1,U,4)
 S X("minDelay")=+$P(X1,U,5)
 S X("residents")=+$P(X1,U,8)
 S X("clinics")=+$P(X1,U,9)
 S X("emptyIEN")=+$O(^EDPB(233.1,"B","edp.reserved.novalue",0))
 S X("errorIEN")=+$O(^EDPB(233.1,"B","edp.disposition.error",0))
 S X("evalIEN")=+$O(^EDPB(233.1,"B","edp.disposition.nec",0))
 S X("leftIEN")=+$O(^EDPB(233.1,"B","edp.disposition.left",0))
 D XML^EDPX($$XMLA^EDPX("params",.X))
 Q
 ; BYPASS & LSTIENS not implemented yet, perhaps in T25?
 ; This would require changing the params VO to have a list
 ; of IEN's that would be checked when enabling the remove from
 ; board button.  EDPLOG would also need to check the flags of
 ; the disposition when validating in RDY2RMV
BYPASS(AREA) ; list IEN's for bypass dispositions
 N ROOT
 D XML^EDPX("<bypassRemoveChecks>")
 S ROOT="edp.disposition" D LSTIENS(ROOT)
 S ROOT=EDPSTA_".disposition" D LSTIENS(ROOT)
 D XML^EDPX("</bypassRemoveChecks>")
 Q
LSTIENS(ROOT) ; list IEN's that should bypass remove-from-board checks
 N X,IEN,FLAGS
 S X=ROOT F  S X=$O(^EDPB(233.1,"B",X)) Q:$E(X,1,$L(ROOT))'=ROOT  D
 . S IEN=0 F  S IEN=$O(^EDPB(233.1,"B",X,IEN)) Q:'IEN  D
 .. S FLAGS=$P(^EDPB(233.1,IEN,0),U,5) Q:FLAGS'["B"
 .. D XML^EDPX("<ien>"_IEN_"</ien>")
 Q
BRDUSER(AREA) ; set XML for anonymous board user
 N X
 S X("area")=$$DFLTAREA(AREA)
 I X("area") S X("areaNm")=$P(^EDPB(231.9,X("area"),0),U)
 S X("version")=$$VERSRV
 D XML^EDPX($$XMLA^EDPX("user",.X))
 Q 
DFLTAREA(AREA) ; return the default area for a site
 N X,DFLT
 I $L($G(AREA)),(+AREA'=AREA) D
 . S AREA=$O(^EDPB(231.9,"B",AREA,0))
 . ; need to check for matching site!!
 S DFLT=$S($G(AREA):AREA,1:$O(^EDPB(231.9,"C",EDPSITE,0)))
 ;
 I 'DFLT D ADDAREA S DFLT=$O(^EDPB(231.9,"C",EDPSITE,0))
 Q DFLT
ADDAREA ; add area if none is defined for this site
 N FDA,FDAIEN,DIERR,ERR
 S FDA(231.9,"+1,",.01)="Emergency Department"
 S FDA(231.9,"+1,",.02)=EDPSITE
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 Q:$D(DIERR)
 ;
 N AREA S AREA=FDAIEN(1)
 D RESET^EDPBRS(AREA)
 Q
VERSRV()   ; Return server version of option name
 N EDPLST,VAL
 D FIND^DIC(19,"",1,"X","EDPF TRACKING SYSTEM",1,,,,"EDPLST")
 S VAL=$G(EDPLST("DILIST","ID",1,1))
 S VAL=$P(VAL,"version ",2)
 I 'VAL Q "1.0T?"
 Q VAL
