TIUPUTCP ; SLC/JER,RMO - CP Look-up Method ;4/18/03
 ;;1.0;TEXT INTEGRATION UTILITIES;**109,113**;Jun 20, 1997
 ; This routine is a modified version of TIUPUTCN
LOOKUP ; Look-up code used by router/filer
 ; Required: TIUSSN, TIUVDT, TIUCNNBR
 N DA,DFN,TIU,TIUDAD,TIUDPRM,TIUEDIT,TIUEDT,TIULDT,TIUXCRP,TIUTYPE,TIUNEW,TIUDNB
 I $S('$D(TIUSSN):1,'$D(TIUVDT):1,$G(TIUSSN)?4N:1,$G(TIUSSN)']"":1,1:0) S Y=-1 G LOOKUPX
 I TIUSSN?3N1P2N1P4N.E S TIUSSN=$TR(TIUSSN,"-/","")
 I TIUSSN["?" S Y=-1 G LOOKUPX
 S TIULOC=+$$ILOC(TIULOC)
 I '$D(^SC(+$G(TIULOC),0)) S Y=-1 G LOOKUPX
 S TIUINST=+$$DIVISION^TIULC1(TIULOC)
 S TIUEDT=$$IDATE^TIULC(TIUVDT),TIULDT=$$FMADD^XLFDT(TIUEDT,1)
 I +TIUEDT'>0 S Y=-1 Q
 S TIUTYPE=$$WHATITLE(TIUTITLE)
 I +TIUTYPE'>0 S Y=-1 Q
 I $P($G(^SC(+TIULOC,0)),U,3)="W" D  I 1
 . D MAIN^TIUMOVE(.TIU,.DFN,TIUSSN,TIUEDT,TIULDT,1,"LAST",0,TIULOC)
 E  D MAIN^TIUVSIT(.TIU,.DFN,TIUSSN,TIUEDT,TIULDT,"LAST",0,TIULOC)
 I $S($D(TIU)'>9:1,+$G(DFN)'>0:1,1:0) S Y=-1 G LOOKUPX
 I $P(+$G(TIU("EDT")),".")'=$P($$IDATE^TIULC(TIUVDT),".") S Y=-1 G LOOKUPX
 D DOCPRM^TIULC1(TIUTYPE,.TIUDPRM)
 ;
 ;Check consult associated with document
 I '$$CHKCN($G(TIUCNNBR),DFN,$G(TIUPLDA),.TIUDNB) S Y=-1 G LOOKUPX
 ;
 ;Check status of consult as it relates to CP
 I '$$CHKCP($G(TIUCNNBR),$G(TIUPLDA),.TIUDNB) S Y=-1 G LOOKUPX
 S TIUTYP(1)=1_U_TIUTYPE_U_$$PNAME^TIULC1(TIUTYPE)
 ;
 ;If TIU document IEN is defined use it, otherwise call TIUEDI3
 I $G(TIUPLDA)>0 D
 . S Y=TIUPLDA
 ELSE  D
 . S Y=$$GETRECNW^TIUEDI3(DFN,.TIU,TIUTYP(1),.TIUNEW,.TIUDPRM)
 I +Y'>0 G LOOKUPX
 ; If record is not new, has text and can be edited, then replace
 ; existing text
 I +$G(TIUNEW)'>0 D
 . S TIUEDIT=$$CANEDIT(+Y)
 . I +TIUEDIT>0,$D(^TIU(8925,+Y,"TEXT")) D DELTEXT(+Y)
 . I +TIUEDIT'>0 S TIUDAD=+Y,Y=$$MAKEADD
 I +Y'>0 Q
 D STUFREC(Y,+$G(TIUDAD))
 I +$G(TIUDAD) D SENDADD^TIUALRT(+Y)
 ;Kill elements of TIUHDR so data is not filed twice
 K TIUHDR(.01),TIUHDR(.07),TIUHDR(1301)
 K TIUHDR(.001),TIUHDR(70201),TIUHDR(70202)
LOOKUPX Q
ILOC(LOCATION) ; Get pointer to file 44
 N DIC,X,Y
 S DIC=44,DIC(0)="M",X=LOCATION D ^DIC
 Q Y
CANEDIT(DA) ; Check if document is not released yet
 Q $S(+$P($G(^TIU(8925,+DA,0)),U,5)<4:1,1:0) ;TIU*1*131
 ;
CHKCN(TIUCDA,DFN,TIUDA,TIUDNB) ;Check if Consult is associated with correct patient
 ;and document
 ; Input  -- TIUCDA   Request/Consult file (#123) IEN
 ;           DFN      Patient file (#2) IEN
 ;           TIUDA    TIU Document file (#8925) IEN  (Optional)
 ; Output -- 1=Successful and 0=Failure
 ;           TIUDNB   Dialogue Number for Error Message  (Optional)
 N OKF
 ;
 I $G(TIUCDA)']"" S TIUDNB=89250009 G CHKCNQ
 ;
 ;Check if the patient is associated with the consult
 I '$$CPPAT^GMRCCP(TIUCDA,DFN) S TIUDNB=89250006 G CHKCNQ
 ;
 ;Check 0th node and consult if document IEN is defined
 I $G(TIUDA)>0 D  G CHKCNQ:$G(TIUDNB)
 . ;Check if 0th node of document is defined
 . I $G(^TIU(8925,TIUDA,0))="" S TIUDNB=89250007 Q
 . ;Check if consult is associated with the document
 . I +$P($G(^TIU(8925,TIUDA,14)),U,5)'=TIUCDA S TIUDNB=89250008 Q
 ;
 ;Set success flag
 S OKF=1
 ;
CHKCNQ Q +$G(OKF)
 ;
CHKCP(TIUCDA,TIUDA,TIUDNB) ;Check status of Consult as it relates to CP
 ; Input  -- TIUCDA   Request/Consult file (#123) IEN
 ;           TIUDA    TIU Document file (#8925) IEN  (Optional)
 ; Output -- 1=Successful and 0=Failure
 ;           TIUDNB   Dialogue Number for Error Message  (Optional)
 N OKF,TIUCPACT
 S TIUCPACT=$$CPACTM^GMRCCP(TIUCDA)
 I 'TIUCPACT S TIUDNB=89250010 G CHKCPQ
 I TIUCPACT=2 S TIUDNB=89250011 G CHKCPQ
 I TIUCPACT=3,$G(TIUDA)'>0 S TIUDNB=89250012 G CHKCPQ
 ;
 ;Set success flag
 S OKF=1
 ;
CHKCPQ Q +$G(OKF)
 ;
MAKEADD() ; Create an addendum record
 N DIE,DR,DA,DIC,X,Y,DLAYGO,TIUATYP,TIUFPRIV S TIUFPRIV=1
 S TIUATYP=+$$WHATITLE^TIUPUTU("ADDENDUM")
 S (DIC,DLAYGO)=8925,DIC(0)="L",X=""""_"`"_TIUATYP_""""
 D ^DIC
 S DA=+Y
 I +DA>0 S DIE=DIC,DR=".04////"_$$DOCCLASS^TIULC1(TIUATYP) D ^DIE
 K TIUHDR(.01)
 Q +DA
STUFREC(DA,PARENT) ; Stuff fixed field data
 N FDA,FDARR,IENS,FLAGS,TIUMSG,TIUPSCI,TIUDTPI
 S IENS=""""_DA_",""",FDARR="FDA(8925,"_IENS_")",FLAGS="K"
 I +$G(PARENT)'>0 D
 . I '$G(TIUPLDA) D
 . . S @FDARR@(.02)=$G(DFN),@FDARR@(.03)=$P($G(TIU("VISIT")),U)
 . . S @FDARR@(.07)=$P($G(TIU("EDT")),U)
 . . S @FDARR@(.08)=$P($G(TIU("LDT")),U)
 . . S @FDARR@(1201)=$$NOW^TIULC
 . . S @FDARR@(1205)=$S(+$P($G(TIU("LOC")),U):$P($G(TIU("LOC")),U),1:$P($G(TIU("VLOC")),U))
 . . S @FDARR@(1404)=$P($G(TIU("SVC")),U)
 . I '$G(TIUPLDA)!('$P($G(^TIU(8925,+$G(TIUPLDA),13)),U,4)) S @FDARR@(.05)=3
 I +$G(PARENT)>0 D
 . S @FDARR@(.02)=+$P($G(^TIU(8925,+PARENT,0)),U,2)
 . S @FDARR@(.03)=$P($G(^TIU(8925,+PARENT,0)),U,3)
 . S @FDARR@(.05)=3
 . S @FDARR@(.06)=PARENT
 . S @FDARR@(.07)=$P($G(^TIU(8925,+PARENT,0)),U,7)
 . S @FDARR@(.08)=$P($G(^TIU(8925,+PARENT,0)),U,8)
 . S @FDARR@(1205)=$P($G(^TIU(8925,+PARENT,12)),U,5)
 . S @FDARR@(1404)=$P($G(^TIU(8925,+PARENT,14)),U,4)
 . S @FDARR@(1201)=$$NOW^TIULC
 I '$G(TIUPLDA) S @FDARR@(1205)=$P($G(TIU("LOC")),U)
 S @FDARR@(1212)=$P($G(TIU("INST")),U)
 S @FDARR@(1301)=$S($G(TIUDDT)]"":$$IDATE^TIULC($G(TIUDDT)),1:"")
 I @FDARR@(1301)'>0 S @FDARR@(1301)=$G(@FDARR@(.07))
 S @FDARR@(1303)="U"
 I $G(TIUPSC)]"" D VAL^DIE(8925,DA,70201,,TIUPSC,.TIUPSCI)
 S @FDARR@(70201)=$S($G(TIUPSCI):TIUPSCI,1:"")
 I '$G(TIUPLDA)!($P($G(^TIU(8925,+$G(TIUPLDA),702)),U,2))="" D
 . I $G(TIUDTP)]"" D VAL^DIE(8925,DA,70202,,TIUDTP,.TIUDTPI)
 . S @FDARR@(70202)=$S($G(TIUDTPI):TIUDTPI,1:"")
 D FILE^DIE(FLAGS,"FDA","TIUMSG") ; File record
 Q
DELTEXT(DA) ; Delete existing text in preparation for replacement
 N DIE,DR,X,Y
 S DIE=8925,DR="2///@" D ^DIE
 Q
WHATYPE(X) ; Identify document type
 ; Receives: X=Document Definition Name
 ;  Returns: Y=Document Definition IFN
 N DIC,Y,TIUFPRIV S TIUFPRIV=1
 S DIC=8925.1,DIC(0)="M"
 S DIC("S")="I +$O(^TIU(8925.1,+Y,""HEAD"",0))!+$O(^TIU(8295.1,+Y,""ITEM"",0))"
 D ^DIC K DIC("S")
WHATYPX Q Y
WHATITLE(X) ; Identify document title
 ; Receives: X=Document Definition Name
 ;  Returns: Y=Document Definition IFN
 N DIC,Y,TIUFPRIV,SCREEN,TIUCLASS S TIUFPRIV=1
 S DIC=8925.1,DIC(0)="M",TIUCLASS=+$$CLASS^TIUCP
 S SCREEN="I $P(^TIU(8925.1,+Y,0),U,4)=""DOC"",+$$ISA^TIULX(+Y,"_TIUCLASS_"),+$$CANPICK^TIULP(+Y)"
 S DIC("S")=SCREEN
 D ^DIC K DIC("S")
WHATITX Q Y
FOLLOWUP(TIUDA) ; Post-filing code for CLINICAL PROCEDURES
 N FDA,FDARR,IENS,FLAGS,TIUMSG,TIU,DFN
 S IENS=""""_TIUDA_",""",FDARR="FDA(8925,"_IENS_")",FLAGS="K"
 S @FDARR@(1204)=$$WHOSIGNS^TIULC1(TIUDA)
 I +$P($G(^TIU(8925,TIUDA,12)),U,9),'+$P($G(^(12)),U,8) D
 . S @FDARR@(1208)=$$WHOCOSIG^TIULC1(TIUDA)
 D FILE^DIE(FLAGS,"FDA","TIUMSG")
 I +$P($G(^TIU(8925,+TIUDA,12)),U,8),(+$P($G(^TIU(8925,+TIUDA,12)),U,4)'=+$P($G(^(12)),U,8)) D
 . S @FDARR@(1506)=1 D FILE^DIE(FLAGS,"FDA","TIUMSG")
 D RELEASE^TIUT(TIUDA,1)
 D AUDIT^TIUEDI1(TIUDA,0,$$CHKSUM^TIULC("^TIU(8925,"_+TIUDA_",""TEXT"")"))
 I +$P($G(^TIU(8925,+TIUDA,14)),U,5) D
 . N TIUCDA,DA S TIUCDA=+$P($G(^TIU(8925,+TIUDA,14)),U,5)
 . W !,$$PNAME^TIULC1(+$G(^TIU(8925,+TIUDA,0)))," #: ",TIUDA
 . W " Linked to Consult Request #: ",TIUCDA,".",!
 . ; Post result in CT Pkg
 . D GET^GMRCTIU(TIUCDA,TIUDA,"INCOMPLETE RPT")
 I '$D(TIU("VSTR")) D
 . N TIUD0,TIUD12,TIUVLOC,TIUHLOC,TIUEDT,TIULDT
 . S TIUD0=$G(^TIU(8925,+TIUDA,0)),TIUD12=$G(^(12))
 . S DFN=+$P(TIUD0,U,2),TIUEDT=+$P(TIUD0,U,7)
 . S TIULDT=$$FMADD^XLFDT(TIUEDT,1),TIUHLOC=+$P(TIUD12,U,5)
 . S TIUVLOC=$S(+$P(TIUD12,U,11):+$P(TIUD12,U,11),1:+TIUHLOC)
 . I $S(+DFN'>0:1,+TIUEDT'>0:1,+TIULDT'>0:1,+TIUVLOC'>0:1,1:0) Q
 . D MAIN^TIUVSIT(.TIU,DFN,"",TIUEDT,TIULDT,"LAST",0,+TIUVLOC)
 Q:'$D(TIU("VSTR"))
 D QUE^TIUPXAP1 ; Get/file VISIT
 Q
GETCP ; Help get Fields for CP Dictation/Error Resolution
 N TIU,DFN,TIUY,TITLE,TIUBUF,TIUPLDA,TIUMVN,TIUVSTR
 W ! S DFN=+$$PATIENT^TIULA G GETCPQ:+DFN'>0
 S TIUBUF=$S(+$G(BUFDA):+$G(BUFDA),+$G(XQADATA):+$G(XQADATA),1:"")
 ;If there is a buffer entry with a TIU Document Number, ask for document
 I $G(TIUBUF),$$CHKUPL(TIUBUF) D  G GETCPQ:'$D(TIU)
 . I $$ASKUPL(DFN,.TIUPLDA) D
 . . ;If Patient Movement
 . . I +$G(^TIU(8925,+TIUPLDA,14)) D
 . . . S TIUMVN=+$G(^TIU(8925,+TIUPLDA,14))
 . . ;Else set up Visit string
 . . ELSE  D
 . . . S TIUVSTR=$P($G(^TIU(8925,+TIUPLDA,12)),U,11)_";"_$P($G(^TIU(8925,+TIUPLDA,0)),U,7)_";"_$P($G(^TIU(8925,+TIUPLDA,0)),U,13)
 . . ;Populate demographic and Visit information
 . . D PATVADPT^TIULV(.TIU,DFN,$G(TIUMVN),$G(TIUVSTR))
 ELSE  D  G GETCPQ:'$D(TIU)
 . ;If there is no stub ask for Visit
 . D ENPN^TIUVSIT(.TIU,+DFN,1)
 . I '$D(TIU) Q
 . S TIUY=$$CHEKPN^TIUCHLP(.TIU)
 D MAKE^TIUCPFIX(.SUCCESS,DFN,.TITLE,.TIU,$G(TIUBUF),$G(TIUPLDA))
 I +SUCCESS D
 . S TIUDONE=1
 ELSE  D
 . W !!,"Please correct the buffered upload data.",!,$P(SUCCESS,U,2),!
 . I $$READ^TIUU("FOA","Press RETURN to continue...") W ""
GETCPQ Q
 ;
CHKUPL(TIUBUF) ;Check if Buffer Entry has TIU Document Number
 ; Input  -- TIUBUF   TIU Upload Buffer file (#8925.2) IEN
 ; Output -- 1=Yes and 0=No
 N TIUX,Y
 D LOADTIUX^TIUCPFIX(.TIUX,TIUBUF)
 I $G(TIUX(.001)) S Y=1
 Q +$G(Y)
 ;
ASKUPL(DFN,TIUPLDA) ;Ask TIU Document Number for Error Resolution
 ; Input  -- DFN      Patient file (#2) IEN
 ; Output -- 1=Successful and 0=Failure
 ;           TIUPLDA  TIU Document file (#8925) IEN
 N D,DD,DIC,DINUM,DLAYGO,D0,X,Y
 S DIC="^TIU(8925,",DIC(0)="EUVX",D="C"
 S X=DFN
 S DIC("S")="I $P(^(0),U,5)=1,+$$ISA^TIULX(+$P(^(0),U),+$$CLASS^TIUCP)"
 S DIC("W")="D ID^TIUPUTCP(+Y)"
 D IX^DIC
 I Y>0 S TIUPLDA=+Y
 Q $S($G(TIUPLDA)="":0,1:1)
 ;
ID(TIUDA) ;Display TIU Document Information for Error Resolution
 ; Input  -- TIUDA    TIU Document file (#8925) IEN  (Optional)
 ; Output -- None
 W !?12,"Document #: ",TIUDA
 W ?34,"Dated: ",$$DATE^TIULS(+$G(^TIU(8925,+TIUDA,13)),"MM/DD/CCYY@HR:MIN")
 W ?60,"Consult #: ",+$P($G(^TIU(8925,+TIUDA,14)),U,5)
 Q
