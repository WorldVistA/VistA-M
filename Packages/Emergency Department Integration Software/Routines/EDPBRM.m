EDPBRM ;SLC/KCM - Room/Bed Configuration ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
LOAD(AREA) ; Load the list of rooms/beds for this area
 N BED,SEQ,BEDS,X0,TOKEN
 ;
 D READL^EDPBLK(AREA,"bed",.TOKEN) ; read bed config -- LOCK
 D XML^EDPX("<bedToken>"_TOKEN_"</bedToken>")
 ;
 ; Get a list of all the beds in sequence for this area
 S BED=0 F  S BED=$O(^EDPB(231.8,"C",EDPSITE,AREA,BED)) Q:'BED  D
 . S SEQ=$P(^EDPB(231.8,BED,0),U,5) S:'SEQ SEQ=99999
 . S BEDS(SEQ,BED)=""
 ;
 ; Build the XML for each bed in sequence
 D XML^EDPX("<beds>")
 S SEQ=0 F  S SEQ=$O(BEDS(SEQ)) Q:'SEQ  D
 . S BED=0 F  S BED=$O(BEDS(SEQ,BED)) Q:'BED  D
 . . S X0=^EDPB(231.8,BED,0)
 . . N X
 . . S X("id")=BED
 . . S X("name")=$P(X0,U)
 . . S X("site")=$P(X0,U,2)
 . . S X("area")=$P(X0,U,3)
 . . S X("inactive")=$P(X0,U,4)
 . . S X("seq")=$P(X0,U,5)
 . . S X("display")=$P(X0,U,6)
 . . S X("when")=$P(X0,U,7)
 . . S X("status")=$P(X0,U,8)
 . . S X("category")=$P(X0,U,9)
 . . S X("shared")=$P(X0,U,10)
 . . S X("board")=$P(X0,U,11)
 . . S X("color")=$P(X0,U,12)
 . . S X("primary")=$S($P(X0,U,13)=2:2,1:1,1:"")  ; ""=unknown,1=primary,2=secondary
 . . D XML^EDPX($$XMLA^EDPX("bed",.X))
 D XML^EDPX("</beds>")
 ;
 D READU^EDPBLK(AREA,"bed",.TOKEN) ; read bed config -- UNLOCK
 Q
SAVE(REQ,AREA) ; Save the updated bed list
 ; loop thru the records and update where changed
 N X,BED,ERR,TOKEN,LOCKERR
 ;
 S TOKEN=$G(REQ("bedToken",1))
 D SAVEL^EDPBLK(AREA,"bed",.TOKEN,.LOCKERR)  ; save bed config -- LOCK
 I $L(LOCKERR) D SAVERR^EDPX("collide",LOCKERR),LOAD(AREA),DFLTRM(AREA) Q
 ;
 S X="bed-",ERR=""
 F  S X=$O(REQ(X)) Q:$E(X,1,4)'="bed-"  D
 . K BED S BED=""
 . D NVPARSE^EDPX(.BED,REQ(X,1))
 . S BED("name")=$$TRIM^XLFSTR(BED("name"))
 . I '$L(BED("name")) S ERR=ERR_"Name may not be blank.  " Q
 . I BED("changed") D UPD(.BED,.ERR)
 D SAVEU^EDPBLK(AREA,"bed",.TOKEN)           ; save bed config -- UNLOCK
 ;
 I $L(ERR) D SAVERR^EDPX("fail",ERR) Q
 D XML^EDPX("<save status='ok' />")
 D LOAD(AREA)    ; return updated list of beds
 D DFLTRM(AREA)  ; return new default lists of beds
 Q
UPD(FLD,ERRMSG) ; Add/Update Record
 N EDPIEN
 S EDPIEN=FLD("id")_","
 I FLD("id")=0 S EDPIEN="+1,"
 ;
 N FDA,FDAIEN,DIERR,ERR
 S FDA(231.8,EDPIEN,.01)=FLD("name")
 S FDA(231.8,EDPIEN,.02)=EDPSITE
 S FDA(231.8,EDPIEN,.03)=FLD("area")
 S FDA(231.8,EDPIEN,.04)=FLD("inactive")
 S FDA(231.8,EDPIEN,.05)=FLD("seq")
 S FDA(231.8,EDPIEN,.06)=FLD("display")
 S FDA(231.8,EDPIEN,.07)=FLD("when")
 S FDA(231.8,EDPIEN,.08)=FLD("status")
 S FDA(231.8,EDPIEN,.09)=FLD("category")
 S FDA(231.8,EDPIEN,.1)=FLD("shared")
 S FDA(231.8,EDPIEN,.11)=FLD("board")
 S FDA(231.8,EDPIEN,.12)=FLD("color")
 S FDA(231.8,EDPIEN,.13)=$S($G(FLD("primary"))=1:1,2:2,1:"")
 I EDPIEN="+1," D
 . D UPDATE^DIE("","FDA","FDAIEN","ERR")
 . I $D(DIERR) S ERRMSG=ERRMSG_"Adding "_FLD("name")_" failed.  "
 E  D
 . D FILE^DIE("","FDA","ERR")
 . I $D(DIERR) S ERRMSG=ERRMSG_"Updating "_FLD("name")_" failed.  "
 D CLEAN^DILF
 Q
DFLTRM(AREA) ; Load the multi-areas
 N BED,X,X0,ALPHA
 D XML^EDPX("<defaultRoomList>")
 D XML^EDPX($$XMLS^EDPX("item",-1,"(None Selected)"))   ;non-selected (-1 will delete)
 S BED=0 F  S BED=$O(^EDPB(231.8,"C",EDPSITE,AREA,BED)) Q:'BED  D
 . S X0=^EDPB(231.8,BED,0)
 . I $P(X0,U,4) Q  ; inactive
 . I ($P(X0,U,9)=1)!($P(X0,U,9)=2) S ALPHA($P(X0,U)_"  ("_$P(X0,U,6)_")")=BED
 S X="" F  S X=$O(ALPHA(X)) Q:X=""  D XML^EDPX($$XMLS^EDPX("item",ALPHA(X),X))
 D XML^EDPX("</defaultRoomList>")
 Q
CHOICES ; Load the choice lists
 N I,X
 F I=1:1 S X=$P($T(WHEN+I),";",3,99) Q:X="ZZZZZ"  D XML^EDPX(X)
 F I=1:1 S X=$P($T(CATS+I),";",3,99) Q:X="ZZZZZ"  D XML^EDPX(X)
 D CODES^EDPQLE1("status","status")
 Q
WHEN ; Display When Choices
 ;;<displayWhen>
 ;;<when label="Occupied" data="0" />
 ;;<when label="Always" data="1" />
 ;;<when label="Never" data="2" />
 ;;</displayWhen>
 ;;ZZZZZ
CATS ; Category Choices
 ;;<roomCategories>
 ;;<item abbr="Single Pt" data="0" label="Single Pt (one patient assigned)" />
 ;;<item abbr="Multiple Pt" data="1" label="Multiple Pt (multiple patients assigned)" />
 ;;<item abbr="Waiting Area" data="2" label="Waiting Area (multiple patients assigned)" />
 ;;<item abbr="Single Non-ED" data="3" label="Single Non-ED (one patient assigned, outside of ED)" />
 ;;<item abbr="Multiple Non-ED" data="4" label="Multiple Non-ED (multiple patients assigned, outside of ED)" />
 ;;</roomCategories>
 ;;ZZZZZ
