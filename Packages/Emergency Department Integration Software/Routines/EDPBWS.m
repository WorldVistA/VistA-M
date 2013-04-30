EDPBWS ;SLC/KCM - Worksheet Configuration Calls ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
LOADALL(AREA) ; load all worksheet configurations for an area
 N ROLES,SECTIONS,WORKSHTS,RESULTS
 D LSTROLES(AREA,.ROLES) M RESULTS("roles",1)=ROLES
 D LSTSECTS(AREA,.SECTIONS) M RESULTS("sections",1)=SECTIONS
 D LSTWKS(AREA,.WORKSHTS) M RESULTS("worksheets",1)=WORKSHTS
 D TOXML^EDPXML(.RESULTS,.EDPXML)
 Q
LSTROLES(AREA,ARRAY) ; list roles for an area
 N IEN,X0,ROLE,ROLENM,WKS,CNT,EDAC
 S ROLE=0,CNT=0
 F  S ROLE=$O(^EDPB(232.5,"C",EDPSITE,AREA,ROLE)) Q:'ROLE  D
 . S IEN=0  F  S IEN=$O(^EDPB(232.5,"C",EDPSITE,AREA,ROLE,IEN)) Q:'IEN  D
 . . S X0=^EDPB(232.5,IEN,0),WKS=$P(X0,U,4),EDAC=$P(X0,U,6)
 . . S ROLENM=$P(^USR(8930,ROLE,0),U,4)
 . . I ROLENM="" S ROLENM=$P(^USR(8930,ROLE,0),U)
 . . ; will be:  <role id=ROLE name=ROLENM defaultWorksheet=WKS />
 . . S CNT=CNT+1
 . . S ARRAY("role",CNT,"id")=ROLE
 . . S ARRAY("role",CNT,"displayName")=ROLENM
 . . S ARRAY("role",CNT,"defaultWorksheet")=WKS
 . . S ARRAY("role",CNT,"editAcuity")=$S(+EDAC:"true",1:"false")
 Q
LSTSECTS(AREA,ARRAY) ; list sections for an area
 N IEN,IEN1,X0,X1,CNT,MCNT,MODEL
 S IEN=0,CNT=0
 F  S IEN=$O(^EDPB(232.71,IEN)) Q:'IEN  D
 . S X0=^EDPB(232.71,IEN,0),CNT=CNT+1
 . S ARRAY("section",CNT,"id")=IEN
 . S ARRAY("section",CNT,"detailPlugin")=$P(X0,U,2)_"::"_$P(X0,U)
 . S ARRAY("section",CNT,"displayName")=$P(X0,U,4)
 . S ARRAY("section",CNT,"initialOpen")=$P(X0,U,6)
 . S IEN1=0,MCNT=0
 . F  S IEN1=$O(^EDPB(232.71,IEN,1,IEN1)) Q:'IEN1  D
 . . S MODEL=$P(^EDPB(232.71,IEN,1,IEN1,0),U)
 . . S X1=^EDPB(232.72,MODEL,0)
 . . S MCNT=MCNT+1
 . . S ARRAY("section",CNT,"model",MCNT,"name")=$P(X1,U,2)_"::"_$P(X1,U)
 . . S ARRAY("section",CNT,"model",MCNT,"id")=MODEL
 Q
LSTWKS(AREA,ARRAY) ; list worksheet configurations for an area
 N IEN,CNT,WKSSPEC
 S IEN=0,CNT=0
 F  S IEN=$O(^EDPB(232.6,"C",EDPSITE,AREA,IEN)) Q:'IEN  D
 . S CNT=CNT+1
 . I $E($P(^EDPB(232.6,IEN,0),U),1,4)="MOCK" Q  ; !KCM! Temporary!
 . I $P(^EDPB(232.6,IEN,0),U,6) Q  ; disabled
 . D GETWKS(IEN,.WKSSPEC)
 . M ARRAY("worksheet",CNT)=WKSSPEC
 . K WKSSPEC
 Q
GETWKS(WKS,ARRAY) ; load a worksheet
 N X0,XS,XM,SEQ,SEC,MIEN,I
 S X0=^EDPB(232.6,WKS,0)
 S ARRAY("name")=$P(X0,U),ARRAY("id")=WKS,ARRAY("role")=$P(X0,U,5)
 S SEQ=0 F  S SEQ=$O(^EDPB(232.6,WKS,2,"B",SEQ)) Q:'SEQ  D
 . S SEC=0 F  S SEC=$O(^EDPB(232.6,WKS,2,"B",SEQ,SEC)) Q:'SEC  D
 . . S X0=^EDPB(232.6,WKS,2,SEC,0),XS=^EDPB(232.71,$P(X0,U,2),0)
 . . S ARRAY("section",SEQ,"id")=$P(X0,U,2)
 . . S ARRAY("section",SEQ,"detailPlugin")=$P(XS,U,2)_"::"_$P(XS,U)
 . . I $L($P(XS,U,3)) S ARRAY("section",SEQ,"summaryPlugin")=$P(XS,U,2)_"::"_$P(XS,U,3)
 . . S ARRAY("section",SEQ,"displayName")=$P(XS,U,4)
 . . S ARRAY("section",SEQ,"taskType")=+$P(XS,U,5)
 . . S ARRAY("section",SEQ,"initialOpen")=$S($P(X0,U,3):"true",1:"false")
 . . S I=0 F  S I=$O(^EDPB(232.6,WKS,2,SEC,1,I)) Q:'I  D
 . . . S ARRAY("section",SEQ,I)=^EDPB(232.6,WKS,2,SEC,1,I,0)
 . . S I=0 F  S I=$O(^EDPB(232.71,$P(X0,U,2),1,I)) Q:'I  D
 . . . S MIEN=+^EDPB(232.71,$P(X0,U,2),1,I,0)
 . . . S XM=^EDPB(232.72,MIEN,0)
 . . . S ARRAY("section",SEQ,"model",I,"id")=MIEN
 . . . S ARRAY("section",SEQ,"model",I,"name")=$P(XM,U,2)_"::"_$P(XM,U)
 Q
 ;
SAVEALL(REQ) ; save all worksheet configurations for an area
 K ^KCM("SAVEREQ") M ^KCM("SAVEREQ")=REQ
 N EDPERR,EDPAREA,EDPWKS,EDPROLES  ; used across subroutines
 N CONFIGXML,CONFIG,RESULTS,ERRMSG
 S ERRMSG="",EDPAREA=REQ("area",1)
 M CONFIGXML=REQ("configXML") K REQ
 D TOARR^EDPXML(.CONFIGXML,.CONFIG)
 M EDPWKS=CONFIG("request",1,"worksheets",1)
 M EDPROLES=CONFIG("request",1,"roles",1)
 K CONFIGXML,CONFIG  ; free memory
 D SAVEWKS
 D SAVEDFLT
 ;
 K EDPWKS,EDPROLES   ; free memory
 I '$L($G(EDPERR)) D
 . S RESULTS("save",1,"status")="ok"
 . D LSTWKS(EDPAREA,.EDPWKS) M RESULTS("worksheets",1)=EDPWKS
 E  D
 . S RESULTS("save",1,"status")="fail"
 . S RESULTS("save",1,0)=$$ESC^EDPX(EDPERR)
 D TOXML^EDPXML(.RESULTS,.EDPXML)
 Q
 ;
SAVEWKS ; save updated worksheets
 N ERR,WKS,WKSNAME,WKSIEN,FLD,SEQ,SECTION
 S WKS=0 F  S WKS=$O(EDPWKS("worksheet",WKS)) Q:'WKS  D
 . K FLD M FLD=EDPWKS("worksheet",WKS)
 . S ERR=0,FLD("area")=EDPAREA
 . I FLD("deleted")="true" D DELWKS(FLD("id")) Q
 . D UPDWKS(.FLD,.ERR) Q:ERR
 . S WKSNAME=FLD("name"),WKSIEN=FLD("id")
 . D DELSEC(WKSIEN)
 . S SEQ=0 F  S SEQ=$O(EDPWKS("worksheet",WKS,"section",SEQ)) Q:'SEQ  D
 . . K SECTION M SECTION=EDPWKS("worksheet",WKS,"section",SEQ)
 . . D ADDSEC(WKSIEN,SEQ,.SECTION)
 Q
SAVEDFLT ; save changes to default worksheet for roles
 N I,ROLE,DFLTWKS,IEN
 S I=0 F  S I=$O(EDPROLES("role",I)) Q:'I  D
 . S ROLE=EDPROLES("role",I,"id"),DFLTWKS=EDPROLES("role",I,"defaultWorksheet")
 . S IEN=$O(^EDPB(232.5,"C",EDPSITE,EDPAREA,ROLE,0)) Q:'IEN
 . I $P(^EDPB(232.5,IEN,0),U,4)'=DFLTWKS D UPDDFLT(IEN,DFLTWKS)
 Q
UPDDFLT(IEN,DFLT) ; update default worksheet for a role
 N FDA,DIERR,MSG
 S FDA(232.5,IEN_",",.04)=DFLT
 D FILE^DIE("","FDA","MSG")
 I $D(DIERR) D ADDERR("updating default worksheet for "_IEN)
 D CLEAN^DILF
 Q
UPDWKS(FLD,ERR) ; create/save worksheet
 N EDPIEN
 S EDPIEN=FLD("id")_","
 I FLD("id")<1 S EDPIEN="+1,"
 ;
 N FDA,FDAIEN,DIERR,MSG
 S FDA(232.6,EDPIEN,.01)=FLD("name")
 S FDA(232.6,EDPIEN,.05)=FLD("role")
 I EDPIEN="+1," D
 . S FDA(232.6,EDPIEN,.02)=EDPSITE
 . S FDA(232.6,EDPIEN,.03)=FLD("area")
 . S FDA(232.6,EDPIEN,.04)="V"
 . D UPDATE^DIE("","FDA","FDAIEN","MSG")
 . D CROLID(FLD("id"),FDAIEN(1))
 . S FLD("id")=FDAIEN(1)
 . I $D(DIERR) S ERR=1 D ADDERR("adding "_FLD("name"))
 E  D
 . D FILE^DIE("","FDA","MSG")
 . I $D(DIERR) S ERR=1 D ADDERR("updating "_FLD("name"))
 D CLEAN^DILF
 Q
CROLID(OLDID,NEWIEN) ; change placeholder ID to actual
 N I S I=0
 F  S I=$O(EDPROLES("role",I)) Q:'I  D
 . Q:$G(EDPROLES("role",I,"defaultWorksheet"))'=OLDID
 . S EDPROLES("role",I,"defaultWorksheet")=NEWIEN
 Q
DELSEC(WKSIEN) ; delete section multiple
 I '$O(^EDPB(232.6,WKSIEN,2,0)) Q  ; no child nodes
 N DA,DIK S DA=0,DA(1)=WKSIEN,DIK="^EDPB(232.6,"_DA(1)_",2,"
 F  S DA=$O(^EDPB(232.6,WKSIEN,2,DA)) Q:'DA  D ^DIK
 Q
ADDSEC(WKSIEN,SEQ,SECTION) ; add section to section multiple
 N FDA,FDAIEN,DIERR,MSG
 S FDA(232.62,"+1,"_WKSIEN_",",.01)=SEQ
 S FDA(232.62,"+1,"_WKSIEN_",",.02)=$$LKUPSEC(SECTION("detailPlugin"))
 S FDA(232.62,"+1,"_WKSIEN_",",.03)=(SECTION("initialOpen")="true")!(SECTION("initialOpen")="1")
 D UPDATE^DIE("","FDA","FDAIEN","MSG")
 I $D(DIERR) D ADDERR("adding section "_SECTION("displayName")) Q
 I $D(SECTION("config")) D
 . N EDPIEN,EDPWP,CONFIG
 . M CONFIG("config")=SECTION("config") D TOXML^EDPXML(.CONFIG,.EDPWP)
 . S EDPIEN=+FDAIEN(1)_","_WKSIEN_","
 . D WP^DIE(232.62,EDPIEN,1,"","EDPWP")
 . I $D(DIERR) D ADDERR("adding config XML for "_SECTION("displayName"))
 D CLEAN^DILF
 Q
LKUPSEC(NAME) ; return the IEN for a section name
 Q +$O(^EDPB(232.71,"C",NAME,0))
 ;
DELWKS(WKSIEN) ; mark worksheet for deletion
 N FDA,DIERR,MSG
 S FDA(232.6,WKSIEN_",",.06)=1
 S FDA(232.6,WKSIEN_",",.01)="zz"_$P(^EDPB(232.6,WKSIEN,0),U)
 D FILE^DIE("","FDA","MSG")
 I $D(DIERR) D ADDERR("deleting worksheet "_WKSIEN)
 Q
ADDERR(TEXT) ; add error text
 S EDPERR=$G(EDPERR)_"Error: "_TEXT_"  "
 Q
WKSOUT(WKS) ; Output the worksheet XML
 N I
 S I=0 F  S I=$O(^EDPB(232.6,WKS,1,I)) Q:'I  D XML^EDPX(^EDPB(232.6,WKS,1,I,0))
 Q
 ;
LOADPRVW(AREA) ; Load the preview models for the area
 N WKS
 S WKS=$O(^EDPB(232.6,"B","MOCK PREVIEW MODELS",0)) Q:'WKS
 D WKSOUT(WKS)
 Q
TEST ;
 M REQ=^KCM("SAVEREQ")
 D SAVEALL(.REQ)
 Q
TEMP ;
 M CONFIG=^KCM("CONFIGREQ","configXML")
 S I=0 F  S I=$O(CONFIG(I)) Q:'I  W !,"}}}",$$TRIM^XLFSTR(CONFIG(I))
 Q
