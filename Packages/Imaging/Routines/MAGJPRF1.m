MAGJPRF1 ;WIRMFO/JHC - VistARad RPCs-User Prefs ; 16-DEC-2010  1:12 PM
 ;;3.0;IMAGING;**18,115**;Mar 19, 2002;Build 1912;Dec 17, 2010
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
ERR ;
 N ERR S ERR=$$EC^%ZOSV S @MAGGRY@(0)="0^4~"_ERR
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
 ;+++++ VistARad Client Operations on the MAGJ USER DATA file (#2006.68).
 ;
RPCIN(MAGGRY,PARAMS,DATA) ; RPC: MAGJ USER DATA
 ;PARAMS: TXID ^ SYSUPDAT ^ TXDUZ ^ TXDIV
 ;TXID: Req'd--action to take; see below
 ;TXDUZ: Opt; if input, get data for another user
 ;TXDIV: Opt; if input, get data for another div
 ;SYSUPDAT: Opt; if input, save Sys Default data; Sec Key Req'd
 ; DATA--(opt) input array; depends on TXID; see subs by TXID
 ;Pattern for DATA input & reply is:
 ;*LABEL ; Start for one label
 ;Label_Name     ; label name
 ;(1:N lines of XML text follow)
 ;*END           ; end for label
 ;*LABEL ; Start for next label (etc.)
 ;Label_Name_2
 ;*KEY           ; index keys to follow (KEY data is opt)
 ;KeyNam1=nnn    ; 1st key (free-text)
 ;KeyNam2=jjj    ; 2nd key (etc.)
 ;*END_KEY       ; end of keys
 ; (1:N lines of XML text follow)
 ;*END           ; end for label
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGJPRF1"
 N GPREF,MAGLST,PDIV,PREFIEN,READONLY,REPLY,SYSUPDAT,TXDIV,TXDUZ,TXID,TXTYPE
 S TXID=+PARAMS,SYSUPDAT=+$P(PARAMS,U,2),TXDUZ=$P(PARAMS,U,3),TXDIV=+$P(PARAMS,U,4)
 S MAGLST="MAGJRPC" K MAGGRY S MAGGRY=$NA(^TMP($J,MAGLST)) K @MAGGRY
 N DIQUIET S DIQUIET=1 D DT^DICRW
 ; no updates allowed if read another user's data, or get data for another logon division
 I 'TXDUZ,(TXDUZ="sysAdmin") S TXDUZ=$$SYSUSER()
 I 'TXDUZ S TXDUZ=DUZ
 I 'TXDIV S TXDIV=DUZ(2)
 S READONLY=(TXDUZ'=DUZ)
 ; I 'READONLY S READONLY=(TXDIV'=DUZ(2)) ; <*> ?? Put this check inside Div-sensitive operations <*>
 I READONLY,$D(MAGJOB("KEYS","MAGJ SYSTEM USER")),SYSUPDAT,(TXDUZ=$$SYSUSER()) S READONLY=0 ; get/update SysDefault data
 S PREFIEN=$$GETPRIEN(TXDUZ,READONLY)
 I 'PREFIEN S REPLY="0~Unable to get/update user data ("_$$USER(TXDUZ)_") for MAGJ USER DATA rpc call." G RPCINZ
 ; set this level based on the TXID
 S TXID=+$G(TXID)
 ;
 ;--- Workstation settings, user preferences, etc.
 S TXTYPE="VR-WS",GPREF=$NA(^MAG(2006.68,PREFIEN,TXTYPE)),PDIV=""
 I TXID=1 G:'READONLY SAVE S REPLY="Access for updating preferences denied." G RPCINZ  ; Store prefs by label
 I TXID=2 G TAGS    ; Get Labels w/ assoc. Keys
 I TXID=3 G PRFDATA ; Get pref data for labels
 I TXID=4 G:'READONLY TAGDEL S REPLY="Access for deleting preferences denied." G RPCINZ  ; Delete labels
 I TXID=6 G USERS   ; Get list of vrad users, including SysAdmin
 ;
 ;--- Hanging Protocols
 S TXTYPE="VR-HP",GPREF=$NA(^MAG(2006.68,PREFIEN,TXTYPE)),PDIV=""
 I TXID=11 G:'READONLY SAVE S REPLY="Access for updating Hanging Protocols denied." G RPCINZ  ; Store HP by label
 I TXID=12 G TAGS    ; Get HP Labels
 I TXID=13 G PRFDATA ; Get data for HP labels
 I TXID=14 G:'READONLY TAGDEL S REPLY="Access for deleting Hanging Protocol denied." G RPCINZ  ; Delete HP labels
 ;
 ;--- Single call batch delete of either VR-WS or VR-HP tags (MAG*3.0*115).
 I TXID=15 G:'READONLY TAGDEL2 S REPLY="Access for deleting preferences denied." G RPCINZ
 I TXID=16 G:'READONLY TAGDEL2 S REPLY="Access for deleting Hanging Protocols denied." G RPCINZ
 ;
 E  S REPLY="0~Invalid transaction (TX="_TXID_") requested by MAGJ USER DATA rpc call."
RPCINZ ;
 S @MAGGRY@(0)=0_U_REPLY
 Q
 ;
 ;+++++ Get existing or newly created IEN of a MAGJ USER DATA entry for input DUZ.
 ;
 ; Internal utility function called by RPCIN+33.
 ;
GETPRIEN(DUZ,READONLY) ; Lookup/create User Pref entry for input DUZ
 ; READONLY: True for lookup-only (no create)
 N PREFIEN,T,X
 S PREFIEN=$O(^MAG(2006.68,"AC",+DUZ,"")) I 'PREFIEN,'READONLY D
 . L +^MAG(2006.68,0):10
 . E  Q
 . ;
 . ;--- Get next IEN & upd8 overhead node.
 . S X=$G(^MAG(2006.68,0))
 . S PREFIEN=+$P(X,U,3)
 . F  S PREFIEN=PREFIEN+1 I '$D(^MAG(2006.68,PREFIEN)) Q
 . S T=$P(X,U,4)+1,$P(X,U,3)=PREFIEN,$P(X,U,4)=T
 . S ^MAG(2006.68,0)=X
 . ;
 . ;--- Set new entry & cross references.
 . S T=$$USER(+DUZ),^MAG(2006.68,PREFIEN,0)=$P(T,U)_U_+DUZ_U_$P(T,U,3)
 . S ^MAG(2006.68,"B",$P(T,U),PREFIEN)=""
 . S ^MAG(2006.68,"AC",+DUZ,PREFIEN)=""
 . L -^MAG(2006.68,0)
 Q PREFIEN
 ;
 ;+++++ Save User Preference XML data by Label.
 ;
 ; Internal entry point branched to by RPCIN if TXID=1 or TXID=11.
 ;
SAVE ;  Save User Pref data by Label
 N DUMMY,KEYCT,KEYS,LBLCT,LINCT,NEWTAG,STUFF,TAGCT,TAGIEN
 S (DUMMY,KEYCT,KEYS,LBLCT,LINCT,NEWTAG,STUFF,TAGCT,TAGIEN)=0
 N IDATA,LINE S (IDATA,LINE)=""
 F  S IDATA=$O(DATA(IDATA)) Q:IDATA=""  S LINE=DATA(IDATA) I LINE]"" D
 . I LINE="*LABEL" S NEWTAG=1,STUFF=0 Q
 . I LINE="*END" S NEWTAG=0,STUFF=0 Q
 . I NEWTAG S TAG=LINE D TAGINIT(TAG) Q  ; Init the storage for this tag
 . I 'STUFF S TAG="*DUM" D TAGINIT(TAG) ; got text line w/out prior label; init dummy tag
 . S TAGCT=TAGCT+1,@GPREF@(TAGIEN,1,TAGCT,0)=LINE,LINCT=LINCT+1
 . S $P(@GPREF@(TAGIEN,1,0),U,3,4)=TAGCT_U_TAGCT
 . I TAG="*DUM" S LINCT=LINCT-1 ; don't count dummy lines/labels
 . I LINE="*KEY" S KEYS=1
 . I KEYS D
 . . S KEYCT=+$P($G(@GPREF@(TAGIEN,2,0)),U,4)+1,^(0)="^2006.6823^"_KEYCT_U_KEYCT
 . . S @GPREF@(TAGIEN,2,KEYCT,0)=LINE
 . I LINE="*END_KEY" S KEYS=0
 I LINCT S REPLY=1_"~"_LINCT_" Text line"_$S(LINCT-1:"s",1:"")_" were stored for "_LBLCT_" label"_$S(LBLCT-1:"s.",1:".")
 E  S REPLY="0~No data was stored."
 S @MAGGRY@(0)=0_U_REPLY
 Q
 ;
 ;+++++ Initialize a single User Preference tag, and some variables for SAVE.
 ;
 ; Internal entry point called by SAVE+7, SAVE+8.
 ;
TAGINIT(TAG) ; Init storage space for a tag; inits some vars for SAVE
 N TAGCTRL
 I PDIV,(TAG'="*DUM") S TAG=PDIV_"*DIV*"_TAG ; tags tracked by division
 S TAGIEN=$O(@GPREF@("B",TAG,"")) I 'TAGIEN D  ; for new tag, create a new LABEL node,
 . L +@GPREF@(0):10
 . E  Q
 . S X=$G(@GPREF@(0)) S:X="" X="^2006.682A^0^0"
 . S TAGIEN=$P(X,U,3)
 . F  S TAGIEN=TAGIEN+1 I '$D(@GPREF@(TAGIEN)) Q
 . S T=$P(X,U,4)+1,$P(X,U,3)=TAGIEN,$P(X,U,4)=T
 . S @GPREF@(0)=X,@GPREF@("B",TAG,TAGIEN)=""
 . L -@GPREF@(0)
 . S $P(@GPREF@(TAGIEN,0),U)=TAG
 I TAG'="*DUM"!((TAG="*DUM")&'DUMMY) D
 . S TAGCTRL=$G(@GPREF@(TAGIEN,1,0)) K @GPREF@(TAGIEN,1),^(2) ; init Data & Keys
 . S $P(TAGCTRL,U,2)=2006.6821,$P(TAGCTRL,U,3,4)=0_U_0
 . S @GPREF@(TAGIEN,1,0)=TAGCTRL
 . S TAGCT=0,LBLCT=LBLCT+1
 I TAG="*DUM" S TAGCT=+$P(@GPREF@(TAGIEN,1,0),U,3),LBLCT=LBLCT-'DUMMY,DUMMY=1 ; don't count dummy label
 S NEWTAG=0,STUFF=1
 Q
 ;
 ;+++++ Return list of workstation or hanging protocol User Preference tags for a user.
 ;
 ; Internal entry point branched to by RPCIN if TXID=2 or TXID=12.
 ;
TAGS ; return list of tags stored
 ; don't report *DUM tags
 N CT,OTAG,TAG,TAGCT,TAGIEN
 S (CT,TAG,TAGCT)=0
 F  S TAG=$O(@GPREF@("B",TAG)) Q:TAG=""  S TAGIEN=$O(^(TAG,"")) I TAG'="*DUM" D
 . I PDIV Q:PDIV'=+TAG  S OTAG=$P(TAG,"*DIV*",2,99)
 . E  S OTAG=TAG
 . S CT=CT+1,@MAGGRY@(CT)=OTAG,TAGCT=TAGCT+1
 . I $D(@GPREF@(TAGIEN,2)) D
 . . N KEYCT S KEYCT=0
 . . F  S KEYCT=$O(@GPREF@(TAGIEN,2,KEYCT)) Q:'KEYCT  S X=^(KEYCT,0),CT=CT+1,@MAGGRY@(CT)=X
 I TAGCT S REPLY=1_"~"_TAGCT_" tag"_$S(TAGCT-1:"s",1:"")_" returned."
 E  S REPLY="0~No data found."
 S @MAGGRY@(0)=CT_U_REPLY
 Q
 ;
SYSUSER(X) ; get System user DUZ value
 S X=.5 ; =Postmaster
 Q:$Q X Q
 ;
USER(DUZ) ; get user name, initials & vrad user type
 N RSL,X S RSL=DUZ
 I DUZ=$$SYSUSER() S RSL="sysAdmin^SYS^9"
 E  I DUZ D
 . S RSL=$$USERINF^MAGJUTL3(DUZ,".01;1")
 . F X="S","R","T" I $D(^VA(200,"ARC",X,DUZ)) Q
 . I  S X=$S(X="S":3,X="R":2,X="T":1,1:0)
 . E  S X=0
 . S RSL=RSL_U_X
 Q:$Q RSL Q
 ;
 ;+++++ List MAGJ USER DATA File (#2006.28) user entries.
 ;
 ; Internal Entry Point branched to from tag RPCIN if TXID=6.
 ;
 ; Returns:
 ; 
 ;   ^(0)
 ;      ^1: Count
 ;      ^2: Reply Message
 ;   ^(1:n)
 ;        ^1: DUZ
 ;        ^2: FULL NAME
 ;        ^3: INITIALS
 ;        ^4: USER TYPE
 ;
 ; Notes
 ; =====
 ;
 ;  Screened off are 1) The current user & 2) terminated or DISUSER'd users.
 ;    If a terminated/DISUSER'd user's profile is still in use as a default
 ;    profile, their entry will only be returned as its default. A terminated
 ;    or DISUSER'd POSTMASTER (System User) is exempted from the screen.
 ;
 ;  Sorting: Default profiles/System User/Radiologists/Non-Rist's.
 ;
USERS ;
 N CT,IEN,INIT,NAME,REPLY,TOUT,USERDUZ,USERTYP
 S (CT,IEN)=0
 F  S IEN=$O(^MAG(2006.68,IEN)) Q:'IEN  S X=^(IEN,0) D
 .  S USERDUZ=$P(X,U,2)
 .  S X=$$USER(USERDUZ),NAME=$P(X,U),INIT=$P(X,U,2),USERTYP=$P(X,U,3)
 .  S:NAME="" NAME="~"
 .  ;
 .  ;--- Filter Terminants & DISUSER'd Users, except System User (MAG*3.0*115).
 .  S:($$ZRUACTIV(USERDUZ)!(USERDUZ=$$SYSUSER())) TOUT(-USERTYP,NAME,USERDUZ)=INIT
 .  ;
 .  ;--- If client => 115, create dummies if profile is a default (MAG*3.0*115)
 .  Q:$P(MAGJOB("VRVERSION"),".",3)<115
 .  N MAGJDUMY S MAGJDUMY=$$ZRUDFALT(IEN) Q:MAGJDUMY=""  S CT=CT+1
 .  S TOUT(-(1000-CT),MAGJDUMY,"D*"_USERDUZ)=INIT
 S CT=0,USERTYP="" F  S USERTYP=$O(TOUT(USERTYP)) Q:USERTYP=""  S NAME="" D
 . F  S NAME=$O(TOUT(USERTYP,NAME)) Q:NAME=""  S USERDUZ="" D
 . . F  S USERDUZ=$O(TOUT(USERTYP,NAME,USERDUZ)) Q:USERDUZ=""  D
 . . . S CT=CT+1,@MAGGRY@(CT)=USERDUZ_U_NAME_U_TOUT(USERTYP,NAME,USERDUZ)_U_-USERTYP
 I CT S REPLY=1_"~"_CT_" user"_$S(CT-1:"s",1:"")_" returned."
 E  S REPLY="0~No data found."
 S @MAGGRY@(0)=CT_U_REPLY
 Q
 ;
 ;+++++ Return XML User Preference data for input Labels.
 ;
 ; Internal entry point branched to by tag RPCIN if TXID=3 or TXID=13.
 ;
PRFDATA ; RETURN data stored for input Labels
 N CT,IDATA,LINCT,NTAGS,OTAG,TAG,TAGCT,TAGIEN,TAGS,X
 S IDATA="",(CT,LINCT,NTAGS)=0
 F  S IDATA=$O(DATA(IDATA)) Q:IDATA=""  S TAG=DATA(IDATA) I TAG]"" D
 . I PDIV,(TAG'="*DUM") S TAG=PDIV_"*DIV*"_TAG ; tags tracked by div
 . S TAGS(TAG)=""
 S TAG=0
 F  S TAG=$O(TAGS(TAG)) Q:TAG=""  D
 . S TAGIEN=$O(@GPREF@("B",TAG,"")),NTAGS=NTAGS+1
 . S OTAG=TAG I PDIV S OTAG=$P(TAG,"*DIV*",2,99)
 . S CT=CT+1,@MAGGRY@(CT)="*LABEL"
 . S CT=CT+1,@MAGGRY@(CT)=OTAG
 . I TAGIEN S TAGCT=0 D
 . . F  S TAGCT=$O(@GPREF@(TAGIEN,1,TAGCT)) Q:'TAGCT  S X=^(TAGCT,0),CT=CT+1,@MAGGRY@(CT)=X,LINCT=LINCT+1
 . S CT=CT+1,@MAGGRY@(CT)="*END"
 I CT S REPLY=1_"~"_LINCT_" Text line"_$S(LINCT-1:"s",1:"")_" returned for "_NTAGS_" tags."
 E  S REPLY="0~No data found."
 S @MAGGRY@(0)=CT_U_REPLY
 Q
 ;
 ;+++++ Delete XML User Preference data for input Labels.
 ;
 ; Internal entry point branched to by tag RPCIN if TXID=4 or TXID=14.
 ;
TAGDEL ; Delete tags and assoc data. RPCIN calls only if 'READONLY.
 N CT,ERR,IDATA,TAG,TAGIEN
 S (CT,TAG)=0,(ERR,IDATA)=""
 F  S IDATA=$O(DATA(IDATA)) Q:IDATA=""  S TAG=DATA(IDATA) I TAG]"" D
 . I PDIV,(TAG'="*DUM") S TAG=PDIV_"*DIV*"_TAG ; tags tracked by div
 . S TAGIEN=$O(@GPREF@("B",TAG,"")) I TAGIEN D
 . . L +@GPREF@(0):10 I $T D
 . . . K @GPREF@(TAGIEN),@GPREF@("B",TAG)
 . . . S X=$G(@GPREF@(0),"^2006.682A^0^0") S T=+$P(X,U,4) S:T T=T-1 S $P(X,U,4)=T,^(0)=X
 . . . S CT=CT+1
 . . . L -@GPREF@(0)
 . . E  D
 . . . S ERR="0~Unable to perform Delete operation."
 I CT S REPLY=1_"~"_CT_" label"_$S(CT-1:"s",1:"")_" deleted."
 E  S REPLY=$S(ERR]"":ERR,1:"0~No label data found.")
 S @MAGGRY@(0)=0_U_REPLY
 Q
 ;
 ;+++++ DELETE ALL SUB-FILE ENTRIES FOR WORKSTATION OR HANGING PROTOCOL DATA
 ;
 ; Internal entry point branched to by tag RPCIN if TXID=15 or TXID=16.
 ;
 ; Expects DUZ,MAGGRY,TXID
 ;
 ; Returns (in @MAGGRY):
 ;
 ;   ^(0)
 ;      ^1: 0 -- normal execution w/ reply string to follow.
 ;      ^2: reply string w/ number/type of nodes deleted, or ...
 ;          ... reason request not processed.
 ;
TAGDEL2 ;
 N RETMSG
 D
 . N SUBDATA S SUBDATA=$S(TXID=15:"VR-HP",TXID=16:"VR-WS",1:0)
 . I SUBDATA=0 S RETMSG="Invalid request: "_TXID_"." Q
 . ;
 . ;--- Lookup D0 from DUZ via ^DIC from the "AC" x-ref, or return notFound.
 . N XIEN S XIEN=$$FIND1^DIC(2006.68,"","Q",DUZ,"AC","","")
 . I 'XIEN S RETMSG="No user entry in MAGJ USER DATA File." Q
 . ;
 . ;--- Initialize ^DIK call to delete requested tag data.
 . N DA,DIK
 . S DA(1)=XIEN,DIK="^MAG(2006.68,"_DA(1)_","""_SUBDATA_""","
 . ;
 . ;--- Quit and report if "MAGJ USER DATA sub-file not found."
 . N MAGNOD S MAGNOD=DIK_"0)"
 . I '$D(@MAGNOD) S RETMSG="MAGJ USER DATA sub-file not found." Q
 . ;
 . ;--- Lock node, initialize counter & traverse for DA values to KILL.
 . L +^MAG(2006.68,DA(1),SUBDATA):5 I $T D
 . . N MAGCT S MAGCT=0
 . . S DA="A"
 . . F  S DA=$O(^MAG(2006.68,DA(1),SUBDATA,DA),-1) Q:DA=0  D ^DIK S MAGCT=MAGCT+1
 . . ;
 . . ;--- Clean up dangling cross-references, set reply, & unlock.
 . . K:$D(^MAG(2006.68,DA(1),SUBDATA,"B")) ^MAG(2006.68,DA(1),SUBDATA,"B")
 . . S RETMSG=MAGCT_" "_SUBDATA_" nodes deleted."
 . . L -^MAG(2006.68,DA(1),SUBDATA)
 . . Q
 . E  D
 . . S RETMSG="Unable to lock MAGJ USER DATA File."
 . . Q
 . Q
 ;
 S @MAGGRY@(0)=0_U_RETMSG
 Q
 ;
 ;+++++ Check if user terminated, or inactivated by DISUSER flag (MAG*3.0*115).
 ;
 ;  Internal utility function called from USERS+9.
 ;
 ;  Input:  DUZ of user to check.
 ;
 ;  Returns:  0 ... User is inactive.
 ;            1 ... User is active.
 ;
ZRUACTIV(CHKDUZ) ;
 N YNACTIVE
 S YNACTIVE=0 D
 . N VADISUSR,VATERMDT
 . S VADISUSR=$$GET1^DIQ(200,CHKDUZ_",",7,"I") Q:VADISUSR=1
 . S VATERMDT=$$GET1^DIQ(200,CHKDUZ_",",9.2,"I")
 . I $D(VATERMDT) N X,X1,X2 S X1=$$DT^XLFDT(),X2=VATERMDT D ^%DTC Q:X>0
 . S YNACTIVE=1
 Q YNACTIVE
 ;
 ;+++++ Check if a MAGJ USER DATA entry is designated as a default profile.
 ;
 ; Internal utility function called from USERS+12.
 ;
 ; Input:  CHKIEN ... IEN of a MAGJ USER DATA File (#2006.68) entry.
 ;
 ; Returns:  DEFFLAG
 ;                                     null ... not a default
 ;              default radiologist profile ... default
 ;          default non-radiologist profile ... default
 ;
ZRUDFALT(CHKIEN) ;
 ;
 ;--- Set the IMAGING SITE PARAMETERS IEN.
 N ISPIEN S ISPIEN=+$$IMGSIT^MAGJUTL1(DUZ(2),1)
 ;
 ;--- Retrieve default profile pointers from IMAGING SITE PARAMETERS (#2006.1).
 N MAGNOD S MAGNOD=$G(^MAG(2006.1,ISPIEN,5))
 N DEFFLAG,DEFNON,DEFRAD S DEFRAD=$P(MAGNOD,U,7),DEFNON=$P(MAGNOD,U,8)
 ;
 S DEFFLAG=$S(CHKIEN=DEFRAD:"RADIOLOGIST",CHKIEN=DEFNON:"NON-RADIOLOGIST",1:"")
 S:DEFFLAG'="" DEFFLAG="DEFAULT "_DEFFLAG_" PROFILE"
 Q DEFFLAG
 ;
 ;
END ;
