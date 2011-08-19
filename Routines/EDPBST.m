EDPBST ;SLC/KCM - Staff Configuration
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
MATCH(X) ; Return matching providers
 Q
LOAD(AREA) ; Return nurse and provider sources, staff config
 N TOKEN
 D READL^EDPBLK(AREA,"staff",.TOKEN)  ; read staff config -- LOCK
 D XML^EDPX("<staffToken>"_TOKEN_"</staffToken>")
 D XML^EDPX("<providers>"),ACTIVE(AREA,"P"),XML^EDPX("</providers>")
 D XML^EDPX("<residents>"),ACTIVE(AREA,"R"),XML^EDPX("</residents>")
 D XML^EDPX("<nurses>"),ACTIVE(AREA,"N"),XML^EDPX("</nurses>")
 D READU^EDPBLK(AREA,"staff",.TOKEN)  ; read staff config -- UNLOCK
 Q
ACTIVE(AREA,ROLE) ; build list of active for a role
 N IEN,X0,X,EDPNURS
 I ROLE="N" S EDPNURS=$$GET^XPAR("ALL","EDPF NURSE STAFF SCREEN")
 S IEN=0 F  S IEN=$O(^EDPB(231.7,"AC",EDPSITE,AREA,ROLE,IEN)) Q:'IEN  D
 . S X0=^EDPB(231.7,IEN,0)
 . I '$$ALLOW^EDPFPER(+X0,ROLE) Q
 . S X("duz")=$P(X0,U)
 . S X("nm")=$P(^VA(200,X("duz"),0),U)
 . S X("role")=$P(X0,U,6)
 . S X("itl")=$P(^VA(200,X("duz"),0),U,2)
 . S X("clr")=$P(X0,U,8)
 . D XML^EDPX($$XMLA^EDPX("staff",.X))
 Q
SAVE(REQ) ; save updated staff members
 N X,STAFF,ERR,EDPAREA,TOKEN,LOCKERR
 S EDPAREA=$G(REQ("area",1))
 I EDPAREA="" D SAVERR^EDPX("fail","Missing Area") Q
 ;
 S TOKEN=$G(REQ("staffToken",1))
 D SAVEL^EDPBLK(EDPAREA,"staff",.TOKEN,.LOCKERR) ; save staff config -- LOCK
 I $L(LOCKERR) D SAVERR^EDPX("collide",LOCKERR),LOAD(EDPAREA) Q
 ; 
 S X="staff-",ERR=""
 F  S X=$O(REQ(X)) Q:$E(X,1,6)'="staff-"  D
 . K STAFF S STAFF=""
 . D NVPARSE^EDPX(.STAFF,REQ(X,1))
 . I STAFF("chg") D UPD(.STAFF,.ERR)
 D SAVEU^EDPBLK(EDPAREA,"staff",.TOKEN)          ; save staff config -- UNLOCK 
 ;
 I $L(ERR) D SAVERR^EDPX("fail",ERR) Q
 D XML^EDPX("<save status='ok' />")
 D LOAD(EDPAREA)
 S ^EDPB(231.9,EDPAREA,231)=$H  ; update choices timestamp
 Q
UPD(FLD,ERRMSG) ; Add/Update Record (expects EDPAREA, EDPSITE to be defined)
 N EDPIEN
 S EDPIEN=$O(^EDPB(231.7,"AD",EDPSITE,EDPAREA,+FLD("duz"),0))_","
 I 'EDPIEN,FLD("inact") Q  ; don't add inactive selection
 I 'EDPIEN S EDPIEN="+1,"
 ;
 N FDA,FDAIEN,DIERR,ERR
 S FDA(231.7,EDPIEN,.01)=FLD("duz")
 S FDA(231.7,EDPIEN,.02)=EDPSITE
 S FDA(231.7,EDPIEN,.03)=EDPAREA
 S FDA(231.7,EDPIEN,.04)=FLD("inact")
 S FDA(231.7,EDPIEN,.06)=FLD("role")
 ;S FDA(231.7,EDPIEN,.07)=FLD("itl") --NtoL
 S FDA(231.7,EDPIEN,.08)=FLD("clr")
 I EDPIEN="+1," D
 . D UPDATE^DIE("","FDA","FDAIEN","ERR")
 . I $D(DIERR) S ERRMSG=ERRMSG_"Adding "_FLD("name")_" failed.  "
 E  D
 . D FILE^DIE("","FDA","ERR")
 . I $D(DIERR) S ERRMSG=ERRMSG_"Updating "_FLD("name")_" failed.  "
 Q
