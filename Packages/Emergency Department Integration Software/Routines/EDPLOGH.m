EDPLOGH ;SLC/KCM - Add History Entry for ED Log
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
 ;TODO:  add transaction processing
 ;
SAVE(IEN,TIME,HIST) ; save a new history entry for changed fields
 Q:$D(HIST)<10
 ;
 N HISTIEN,DIERR
 S HIST(230.1,"+1,",.01)=IEN
 S HIST(230.1,"+1,",.02)=TIME
 S HIST(230.1,"+1,",.03)=EDPUSER
 D UPDATE^DIE("","HIST","HISTIEN","ERR")
 Q
COLLIDE(LOG,LOADTS) ; return true if new updates since load time
 N I,J,TS,IEN,FLDS,MODS
 S TS=LOADTS-0.000001
 F  S TS=$O(^EDP(230.1,"ADF",LOG,TS)) Q:'TS  D
 . S IEN=0 F  S IEN=$O(^EDP(230.1,"ADF",LOG,TS,IEN)) Q:'IEN  D
 .. S MODS=$P($G(^EDP(230.1,IEN,9)),U)
 .. F J=1:1:$L(MODS,";") I $L($P(MODS,";",J)) S FLDS($P(MODS,";",J))=""
 ; no collisions
 I $D(FLDS)<10 Q 0
 ;
 ; handle collisions
 D XML^EDPX("<upd id='"_LOG_"' status='collision' loadTS='"_$$NOW^XLFDT_"'>")
 D XML^EDPX("Since you loaded this entry, changes have been made by someone else:")
 D XML^EDPX(" ")
 N X,X0,X1,X2,X3,PT
 S X0=^EDP(230,LOG,0),X1=$G(^(1)),X2=$G(^(2)),X3=$G(^(3)),PT=0
 S I=0 F  S I=$O(FLDS(I)) Q:'I  D
 . I I=.04 S X=$P(X0,U,4) D MSG(X,"Patient Name") S PT=1
 . I (I=.06),'PT S X=$P(X0,U,6) D MSG($P($G(^DPT(+X,0)),U),"Patient Name")
 . I I=.1 S X=$P(X0,U,10) D MSG($$CODE(X),"Source")
 . I I=1.1 S X=$P(X1,U,1) D MSG(X,"Complaint")
 . I I=1.2 S X=$P(X1,U,2) D MSG($$CODE(X),"Disposition")
 . I I=1.5 S X=$P(X1,U,5) D MSG($$CODE(X),"Delay Reason")
 . I I=2 S X=$P(X2,U,1) D MSG(X,"Long Complaint")
 . I I=3.2 S X=$P(X3,U,2) D MSG($$CODE(X),"Status")
 . I I=3.3 S X=$P(X3,U,3) D MSG($$CODE(X),"Acuity")
 . I I=3.4 S X=$P(X3,U,4) D MSG($P($G(^EDPB(231.8,+X,0)),U),"Room/Area")
 . I I=3.5 S X=$P(X3,U,5) D MSG($$NP(X),"Provider")
 . I I=3.6 S X=$P(X3,U,6) D MSG($$NP(X),"Nurse")
 . I I=3.7 S X=$P(X3,U,7) D MSG($$NP(X),"Resident")
 . I I=3.8 S X=$P(X3,U,8) D MSG(X,"Comment")
 . I I=4 D MSG($$DIAG(LOG),"Diagnosis")
 D XML^EDPX(" ")
 D XML^EDPX("If you wish to overwrite with your changes,")
 D XML^EDPX("close this window and click SAVE again.")
 D XML^EDPX("If you wish to leave this entry as is,")
 D XML^EDPX("close this window and click CANCEL.")
 D XML^EDPX("</upd>")
 Q 1
 ;
BEDGONE(AREA,CURBED,BED) ; return true if bed is no longer available
 I 'BED Q 0
 I BED=CURBED Q 0
 N MULTI S MULTI=$P(^EDPB(231.8,BED,0),U,9) S:MULTI=3 MULTI=0
 I MULTI Q 0
 I '$D(^EDP(230,"AL",EDPSITE,AREA,BED)) Q 0
 Q 1
 ;
MSG(VAL,LBL) ; add to XML message
 D XML^EDPX(LBL_" changed to:  "_VAL)
 Q
CODE(IEN) ; return coded value
 I IEN Q $P(^EDPB(233.1,IEN,0),U,2)
 Q ""
NP(IEN) ; return New Person name
 I IEN Q $P(^VA(200,IEN,0),U)
 Q ""
DIAG(LOG) ; return list of diagnoses
 N I,X
 S I=0,X=""
 F  S I=$O(^EDP(230,LOG,4,I)) Q:'I  S X=X_$S($L(X):",",1:"")_$P($G(^EDP(230,LOG,4,I,0)),U)
 Q X
