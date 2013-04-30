EDPYPRE ;SLC/KCM - Pre init for facility install ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
 S ^TMP("EDP-LAST-VERSION")=+$P($$VERSRV,"1.0-T",2)
 ;
 D FIXT5,DELFLDS,DELCODES,CHGNAMES,FIX233
 Q
 ;
DELFLDS ; delete obsolete fields
 I $$VERGTE(20) Q  ; only convert if version <20
 ;
 N DIK,DA
 I $D(^DD(230.1,1)) D
 . S DIK="^DD(230.1,",DA=1,DA(1)=230.1
 . D ^DIK
 I $D(^DD(231.9,.04)) D
 . S DIK="^DD(231.9,",DA=.04,DA(1)=231.9
 . D ^DIK
 Q
DELCODES ; delete site code sets
 I $$VERGTE(16) Q  ; only convert if version <16
 ;
 N X,DIK,DA
 S X="" F  S X=$O(^EDPB(233.2,"B",X)) Q:X=""  D
 . I $P(X,".")="edp" Q
 . S DA=$O(^EDPB(233.2,"B",X,0)) Q:'DA
 . S DIK="^EDPB(233.2,"
 . D ^DIK
 Q
CHGNAMES ; change code names
 I $$VERGTE(20) Q  ; only convert if version <20
 ;
 D CHG("edp.source.ambulance","zzedp.source.ambulance")
 D CHG("edp.source.code","zzedp.source.code")
 D CHG("edp.source.walk-in","zzedp.source.walk-in")
 D CHG("edp.source.cboc","edp.source.clinic-offsite")
 D CHG("edp.source.clinic","edp.source.clinic-onsite")
 D CHG("edp.source.nhcu","edp.source.nhcu-onsite")
 D CHG("edp.status.observation","zzedp.status.observation")
 D CHG("edp.status.overflow","zzedp.status.overflow")
 D CHG("edp.status.gone","zzedp.status.gone")
 D CHG("edp.delay.admitorders","edp.delay.admitdispo")
 Q
CHG(OLD,NEW) ; change old to new name
 Q:'$D(^EDPB(233.1,"B",OLD))
 N IEN
 S IEN=$O(^EDPB(233.1,"B",OLD,0)) Q:'IEN
 N FDA,DIERR
 S IEN=IEN_","
 S FDA(233.1,IEN,.01)=NEW
 D FILE^DIE("","FDA","ERR")
 D CLEAN^DILF
 Q
 ;
 ; VERSRV copied from EDPQAR to avoid $T(VERSRV^EDPQAR) error
 ;
VERSRV()   ; Return server version of option name
 N EDPLST,VAL
 D FIND^DIC(19,"",1,"X","EDPF TRACKING SYSTEM",1,,,,"EDPLST")
 S VAL=$G(EDPLST("DILIST","ID",1,1))
 S VAL=$P(VAL,"version ",2)
 I 'VAL Q "1.0T?"
 Q VAL
 ;
FIX233() ;
 N IEN,DISPNM,ABBREV
 S IEN=0 F  S IEN=$O(^EDPB(233.1,IEN)) Q:'IEN  D
 .S DISPNM=$$GET1^DIQ(233.1,IEN,.02)
 .S ABBREV=$$GET1^DIQ(233.1,IEN,.03)
 .I DISPNM=""!(ABBREV="") D
 ..D DISP(IEN)
 ..I DISPNM="" D EDFLD(IEN,.02)
 ..I ABBREV="" D EDFLD(IEN,.03)
 Q
DISP(IEN) ;
 N DATA,ERR,IENS
 S IENS=IEN_","
 D GETS^DIQ(233.1,IENS,".01;.02;.03","IE","DATA","ERR")
 W !,?2,"NAME: ",?20,$G(DATA(233.1,IENS,.01,"E"))
 W !,?2,"DISPLAY NAME:",?20,$G(DATA(233.1,IENS,.02,"E"))
 W !,?2,"ABBREVIATION:",?20,$G(DATA(233.1,IENS,.03,"E")),!
 Q
EDFLD(IEN,FLD) ;
 N DIE,DA,DR
 S DIE("NO^")=""
 W !!,"You must correct the following fields before continuing:",!
 S DIE="^EDPB(233.1,",DA=IEN,DR=FLD
 L +^EDPB(233.1,IEN):0
 I $T D ^DIE L -^EDPB(233.1,IEN) W !!! Q
 W !,?10,"Another user is editing this entry. Please try again later.",!! Q
 Q
VERGTE(HIGH) ; Return 1 if existing version and greater than HIGH
 I $G(^TMP("EDP-LAST-VERSION"))<1 Q 1      ; no prior version
 I $G(^TMP("EDP-LAST-VERSION"))>=HIGH Q 1  ; don't convert
 Q 0                                       ; convert
 ;
FIXT5 ; convert the timezone offset to visit string
 ; (change occurred between T5 and T6)
 I $$VERGTE(6) Q  ; only convert if version <6
 ;
 N LOG,X0
 S LOG=0 F  S LOG=$O(^EDP(230,LOG)) Q:'LOG  D
 . S X0=^EDP(230,LOG,0)
 . I $P(X0,U,12)="0" S $P(^EDP(230,LOG,0),U,12)=""
 Q
 ;. To convert VSTR to VISIT
 ;. I $L($P(X0,U,12),";")=3 D
 ;.. N VSTR,VISIT,DFN,VISITIEN,I
 ;.. S VSTR=$P(X0,U,12),DFN=$P(X0,U,6)
 ;.. Q:'DFN
 ;.. K ^TMP("PXKENC",$J)
 ;.. S VISIT=+$$GETENC^PXAPI(DFN,$P(VSTR,";",2),$P(VSTR,";"))
 ;.. I VISIT<0 S $P(^EDP(230,LOG,0),U,12)="" Q
 ;.. S VISITIEN=""
 ;.. F I=1:1:$L(VISIT,U) I $P(^TMP("PXKENC",$J,$P(VISIT,U,I),"VST",$P(VISIT,U,I),0),U,6)=DUZ(2) S VISITIEN=$P(VISIT,U,I) Q
 ;.. S $P(^EDP(230,LOG,0),U,12)=VISITIEN
 Q
