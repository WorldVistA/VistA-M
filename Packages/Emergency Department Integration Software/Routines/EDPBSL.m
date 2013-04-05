EDPBSL ;SLC/KCM - Selection List Configuration ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
LOAD(AREA) ; Load selection lists for area
 N TOKEN
 D READL^EDPBLK(AREA,"selection",.TOKEN) ; read selection config -- LOCK
 D XML^EDPX("<selectionToken>"_TOKEN_"</selectionToken>")
 ;D LIST("acuity","Acuity")
 D LIST("status","Status")
 D LIST("arrival","Source")
 D LIST("disposition","Disposition")
 D LIST("delay","Delay Reason")
 D READU^EDPBLK(AREA,"selection",.TOKEN) ; read selection config -- UNLOCK
 Q
LIST(NM,TITLE) ; build XML for selection list
 N SETNM S SETNM=EDPSTA_"."_NM
 I '$D(^EDPB(233.2,"B",SETNM)) S SETNM="edp."_NM
 D XML^EDPX("<"_NM_" title='"_TITLE_"'>")
 N IEN,SEQ,DA,X0
 S IEN=$O(^EDPB(233.2,"B",SETNM,0))
 S SEQ=0 F  S SEQ=$O(^EDPB(233.2,IEN,1,"B",SEQ)) Q:'SEQ  D
 . S DA=0 F  S DA=$O(^EDPB(233.2,IEN,1,"B",SEQ,DA)) Q:'DA  D
 . . S X0=^EDPB(233.2,IEN,1,DA,0)
 . . N X
 . . S X("seq")=SEQ
 . . S X("id")=$P(X0,U,2)
 . . S X("inact")=$P(X0,U,3)
 . . S X("show")=$P(X0,U,4)
 . . S X("abbr")=$P(X0,U,5)
 . . ; switch to entry in 233.1 now
 . . S X0=^EDPB(233.1,X("id"),0)
 . . I X("show")="" S X("show")=$P(X0,U,2)
 . . I X("abbr")="" S X("abbr")=$P(X0,U,3)
 . . S X("flag")=$P(X0,U,5)
 . . S X("natl")=$S($E(X0,1,3)="edp":$P(X0,U,2),1:"(local)")
 . . D XML^EDPX($$XMLA^EDPX("code",.X))
 D XML^EDPX("</"_NM_">")
 Q
SAVE(EDPAREA,REQ) ; save the selection changes
 N CTYP,SET,SETNM,CODE,X,EDPERR,TOKEN,LOCKERR
 ;
 S TOKEN=$G(REQ("selectionToken",1))
 D SAVEL^EDPBLK(EDPAREA,"selection",.TOKEN,.LOCKERR) ; save selection config -- LOCK
 I $L(LOCKERR) D SAVERR^EDPX("collide",LOCKERR),LOAD(EDPAREA) Q
 ; 
 S EDPERR=""
 F CTYP="status","disposition","delay","arrival" D
 . I $E($O(REQ(CTYP)),1,$L(CTYP))'=CTYP Q
 . S SETNM=EDPSTA_"."_CTYP,SET=$O(^EDPB(233.2,"B",SETNM,0))
 . I 'SET D NEWSET(SETNM) S SET=$O(^EDPB(233.2,"B",SETNM,0))
 . D CLEARSET(SET)
 . S X=CTYP F  S X=$O(REQ(X)) Q:$E(X,1,$L(CTYP))'=CTYP  D
 . . K CODE S CODE="" D NVPARSE^EDPX(.CODE,REQ(X,1))
 . . ; I CODE("id")>0 D UPDCODE(CTYP,.CODE) -- want to keep codes matched to nat'l --KCM
 . . I CODE("id")<1 D ADDCODE(CTYP,.CODE)
 . . D ADD2SET(SET,.CODE)
 D SAVEU^EDPBLK(EDPAREA,"selection",.TOKEN)          ; save selection config -- UNLOCK
 ; 
 I $L(EDPERR) D SAVERR^EDPX("fail",EDPERR) Q
 D XML^EDPX("<save status='ok' />")
 D LOAD(EDPAREA)
 S ^EDPB(231.9,EDPAREA,231)=$H  ; update choices timestamp
 Q
NEWSET(SETNM) ; Create a new code set for a site
 N FDA,FDAIEN,DIERR,ERR
 S FDA(233.2,"+1,",.01)=SETNM
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 I $D(DIERR) S EDPERR=EDPERR_"new code set failed;"
 Q
CLEARSET(SET) ; Clear the CODES mulitple
 I '$O(^EDPB(233.2,SET,1,0)) Q  ; no child nodes
 N DA,DIK S DA=0,DA(1)=SET,DIK="^EDPB(233.2,"_DA(1)_",1,"
 F  S DA=$O(^EDPB(233.2,SET,1,DA)) Q:'DA  D ^DIK
 Q
UPDCODE(CTYP,X) ; Update an existing code in the TRACKING CODE file
 Q:+$G(X("id"))'>0
 N OLD,DIFF,I
 S OLD=$G(^EDPB(233.1,+$G(X("id")),0)),DIFF=0
 F I="2^show","3^abbr","5^flag" I $P(OLD,U,+I)'=$G(X($P(I,U,2))) S DIFF=1 Q
 Q:'DIFF  ;no change
 I $E(OLD,1,4)="edp." S X("id")=0 D ADDCODE(CTYP,.X) Q
 ; update local code
 N FDA,FDAIEN,DIERR,ERR
 S FDAIEN=+X("id")_","
 S FDA(233.1,FDAIEN,.02)=X("show")
 S FDA(233.1,FDAIEN,.03)=X("abbr")
 S FDA(233.1,FDAIEN,.05)=X("flag")
 D FILE^DIE("","FDA","ERR")
 I $D(DIERR) S EDPERR=EDPERR_"update code "_NAME_"failed;"
 S X("nm")=$P(OLD,U)
 Q
ADDCODE(CTYP,X) ; Add a new code to the TRACKING CODE file
 Q:X("id")'=0
 N NAME,DNAME,I
 S NAME=EDPSTA_"."_CTYP_"."_$TR(X("show")," ","")
 I $O(^EDPB(233.1,"B",NAME,0)) D
 . F I=1:1:99 Q:'$O(^EDPB(233.1,"B",NAME_I,0))
 . S NAME=NAME_I
 N FDA,FDAIEN,DIERR,ERR
 S FDA(233.1,"+1,",.01)=NAME
 S FDA(233.1,"+1,",.02)=X("show")
 S FDA(233.1,"+1,",.03)=X("abbr")
 S FDA(233.1,"+1,",.05)=X("flag")
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 I $D(DIERR) S EDPERR=EDPERR_"add code "_NAME_"failed;"
 S X("id")=FDAIEN(1),X("nm")=NAME
 Q
ADD2SET(SET,X) ; Add a new code to the CODES multiple
 N FDA,FDAIEN,DIERR,ERR
 S FDA(233.21,"+1,"_SET_",",.01)=X("seq")
 S FDA(233.21,"+1,"_SET_",",.02)=X("id")
 S FDA(233.21,"+1,"_SET_",",.03)=X("inact")
 S FDA(233.21,"+1,"_SET_",",.04)=X("show")
 S FDA(233.21,"+1,"_SET_",",.05)=X("abbr")
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 I $D(DIERR) S EDPERR=EDPERR_"add to set "_X("show")_" failed;"
 Q
