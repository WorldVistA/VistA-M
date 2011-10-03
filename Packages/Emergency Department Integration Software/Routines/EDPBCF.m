EDPBCF ;SLC/KCM - Display Board Configuration
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
LOAD(AREA) ; Load General Configuration for an Area
 N I,NODE
 ;
 D XML^EDPX("<colorMaps>")
 D COLORS^EDPBCM
 D XML^EDPX("</colorMaps>")
 D LOAD^EDPBCM(AREA)   ; load the color spec
 ;
 D LOAD^EDPBRM(AREA)   ; load rooms/beds
 D DFLTRM^EDPBRM(AREA) ; load multi rooms
 ;
 D LOAD^EDPBPM(AREA)   ; load parameters
 ;
 D XML^EDPX("<columnList>") ; load available columns
 F I=1:1 S NODE=$P($T(COLUMNS+I),";",3,99) Q:$E(NODE,1,5)="zzzzz"  D
 . N X
 . S X("label")=$P(NODE,U)
 . S X("att")=$P(NODE,U,2)
 . S X("header")=$P(NODE,U,3)
 . S X("width")=50
 . D XML^EDPX($$XMLA^EDPX("col",.X))
 D XML^EDPX("</columnList>")
 ;
 D CHOICES^EDPBRM      ; load 'display when' choices
 ;
 N EDPSCRNS D GETLST^XPAR(.EDPSCRNS,"ALL","EDPF SCREEN SIZES","I")
 D XML^EDPX("<screenSizes>")
 S I=0 F  S I=$O(EDPSCRNS(I)) Q:'I  D
 . S EDPSCRNS(I)=$TR(EDPSCRNS(I),"X","x")
 . N X
 . S X("label")=EDPSCRNS(I)
 . S X("width")=$P(EDPSCRNS(I),"x")
 . S X("height")=$P(EDPSCRNS(I),"x",2)
 . D XML^EDPX($$XMLA^EDPX("size",.X))
 D XML^EDPX("</screenSizes>")
 Q
LOADBRD(AREA,IEN) ; Load Named Board Spec
 N I,X,TOKEN
 S:'IEN IEN=$O(^EDPB(231.9,AREA,4,0)) Q:'IEN
 ;
 D READL^EDPBLK(AREA,"board",.TOKEN)  ; read lock the board config
 D XML^EDPX("<boardToken>"_TOKEN_"</boardToken>")
 D BRDLST(AREA)
 S X("boardID")=IEN,X("boardName")=$P(^EDPB(231.9,AREA,4,IEN,0),U)
 D XML^EDPX($$XMLA^EDPX("spec",.X,""))
 S I=0 F  S I=$O(^EDPB(231.9,AREA,4,IEN,1,I)) Q:'I  D
 . D XML^EDPX(^EDPB(231.9,AREA,4,IEN,1,I,0))
 D XML^EDPX("</spec>")
 D READU^EDPBLK(AREA,"board",.TOKEN)  ; read unlock the board config
 Q
BRDLST(AREA) ; List of boards
 N I,X
 D XML^EDPX("<boards>")
 S I=0 F  S I=$O(^EDPB(231.9,AREA,4,I)) Q:'I  D
 . S X=$P(^EDPB(231.9,AREA,4,I,0),U)
 . D XML^EDPX($$XMLS^EDPX("board",I,X))
 D XML^EDPX("</boards>")
 Q
SAVEBRD(REQ) ; Save Configuration
 N X,AREA,DFLTNM
 S X="col-",AREA=$G(REQ("area",1)),DFLTNM="Main (default)"
 I 'AREA D SAVERR^EDPX("fail","Missing area") Q
 ;
 N NAME,IEN,WP,MSG
 S NAME=$G(REQ("boardName",1)),IEN=+$G(REQ("boardID",1))
 I (IEN>0),($P(^EDPB(231.9,AREA,4,IEN,0),U)=DFLTNM),(NAME'=DFLTNM) D  Q
 . D SAVERR^EDPX("fail","Default name may not be changed.")
 I NAME="" D  Q
 . D SAVERR^EDPX("fail","Missing name")
 I (IEN=0),$O(^EDPB(231.9,AREA,4,"B",NAME,0)) D  Q
 . D SAVERR^EDPX("fail","Board name must be unique")
 ;
 ; save XML spec as word processing
 N TOKEN,LOCKERR
 S TOKEN=$G(REQ("boardToken",1))
 D SAVEL^EDPBLK(AREA,"board",.TOKEN,.LOCKERR) ; save board config -- LOCK
 I $L(LOCKERR) D SAVERR^EDPX("collide",LOCKERR),LOADBRD(AREA,IEN) Q
 ;
 F  S X=$O(REQ(X)) Q:$E(X,1,4)'="col-"  S WP(+$P(X,"-",2))=REQ(X,1)
 D UPDBRD(AREA,.IEN,NAME,.WP,.MSG)
 D SAVEU^EDPBLK(AREA,"board",.TOKEN)          ; save board config -- UNLOCK
 ;
 I $L(MSG) D SAVERR^EDPX("fail",MSG) Q
 D UPDLAST(AREA) ; update last config save date
 ;
 D XML^EDPX("<save status='ok' boardID='"_+IEN_"' />")
 D LOADBRD(AREA,+IEN)
 Q
UPDLAST(AREA) ; update last config save date
 N FDA,FDAIEN,DIERR
 S FDA(231.9,AREA_",",.03)=$$NOW^XLFDT
 D FILE^DIE("","FDA","ERR")
 D CLEAN^DILF
 Q
UPDBRD(AREA,EDPIEN,NAME,SPEC,MSG) ; Add/Update a Spec
 S MSG=""
 S:'EDPIEN EDPIEN="+1" S EDPIEN=EDPIEN_","_AREA_","
 ;
 N FDA,FDAIEN,DIERR,ERR
 S FDA(231.94,EDPIEN,.01)=NAME
 I $E(EDPIEN,1,2)="+1" D
 . D UPDATE^DIE("","FDA","FDAIEN","ERR")
 E  D
 . D FILE^DIE("","FDA","ERR")
 I $D(DIERR) S MSG="save board name failed: "_$G(EDPIEN)
 I '$D(DIERR) D
 . I $E(EDPIEN,1,2)="+1" S EDPIEN=+FDAIEN(1)_","_AREA_","
 . D WP^DIE(231.94,EDPIEN,1,"","SPEC")
 . I $D(DIERR) S MSG="save board spec failed: "_$G(EDPIEN)
 D CLEAN^DILF
 Q
COLUMNS ;; Available Columns
 ;;Room / Bed^@bedNm^Room
 ;;Patient Name^@ptNm^Patient
 ;;Patient X9999^@last4^Patient
 ;;Visit Created^@visit^Visit
 ;;Clinic^@clinicNm^Clinic
 ;;Complaint^@complaint^Complaint
 ;;Comment^@comment^Comment
 ;;Provider Initials^@mdNm^Prv
 ;;Resident Initials^@resNm^Res
 ;;Nurse Initials^@rnNm^RN
 ;;Acuity^@acuityNm^Acuity
 ;;Status^@statusNm^Status
 ;;Lab Active/Complete^@lab^L
 ;;Imaging Active/Complete^@rad^I
 ;;New (Unverified) Orders^@ordNew^New
 ;;Total Minutes^@emins^E Mins
 ;;Minutes at Location^@lmins^Mins
 ;;zzzzz
