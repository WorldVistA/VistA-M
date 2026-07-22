XUMUCI ;VISS/CEP - Multi-UCI User Status Report ;10/07/25  08:37
 ;;8.0;KERNEL;**825**;Jul 10, 1995;Build 13
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
EN ; -- main entry point for XU MULTI UCI USER
    D EN^VALM("XU MULTI UCI USER")
    Q
    ;
HDR ; -- header code
    N SKIPPED
    S VALMHDR(1)=+$G(@VALMAR@("NAMES"))_" current users on all UCIs"
    S SKIPPED=$G(@VALMAR@("SKIPPED")) S:$E(SKIPPED,$L(SKIPPED))="," SKIPPED=$E(SKIPPED,1,$L(SKIPPED)-1)
    S:SKIPPED="" SKIPPED="None"
    S VALMHDR(2)="Skipped: "_SKIPPED
    Q
    ;
INIT ; -- init variables and list array
    I $D(VALMAR) K @VALMAR
    D GETUSERS
    S OBY="N"
    S ORD="ASC"
    D DIS
    Q
    ;
HELP ; -- help code
    S X="?" D DISP^XQORM1 W !!
    Q
    ;
EXIT ; -- exit code
    K FHI,FLO,OBY,ORD
    S VALMQUIT=1
    D CLEAR^VALM1
    D CLEAN^VALM10
    Q
    ;
EXPND ; -- expand code
    N DIR,DIRUT,X,Y
    S DIR(0)="N^1:"_VALMCNT_":0"
    D ^DIR
    I $D(DIRUT)!(Y'>0) S VALMBCK="R" Q 
    D ENDIS(Y)
    Q
    ;
GETUSERS ;
    N RES,DAT,UCINM,XUSUCI,GTG,JNO,XUDUZ,XUNM,XUTO,XUIO,XUIP,XUON,OPTLN,OPTNM
    S:$G(FLO)="" FLO=$$FILTLOW() I $G(FLO)<0 D EXIT Q
    S:$G(FHI)="" FHI=$$FILTHIGH() I $G(FHI)<0 D EXIT Q
    D ##CLASS(%SYS.Namespace).ListAll(.RES)
    S UCINM=""
    F  S UCINM=$O(RES(UCINM)) Q:UCINM=""  D
    .  S XUSUCI=UCINM_","_UCINM
    .  S GTG=1 TRY {N $NAMESPACE S $NAMESPACE=UCINM } CATCH { S GTG=0 } 
    .  I 'GTG D  Q
    ..   S DAT("ERRS",0)=+$G(DAT("ERRS",0))+1
    ..   S DAT("ERRS",$G(DAT("ERRS",0)))=UCINM_" - NO ACCESS."
    ..   S DAT("SKIPPED")=$G(DAT("SKIPPED"))_" "_UCINM_","
    .  N $NAMESPACE S $NAMESPACE=UCINM
    .  I '$$CHKROUTS D  Q  ;Doesn't have needed routine(s)
    ..   S DAT("ERRS",0)=+$G(DAT("ERRS",0))+1
    ..   S DAT("ERRS",$G(DAT("ERRS",0)))=UCINM_" doesn't have needed routines."
    ..   S DAT("SKIPPED")=$G(DAT("SKIPPED"))_" "_UCINM_","
    .  S DAT("NS-LIST",0)=+$G(DAT("NS-LIST",0))+1
    .  S DAT("NS-LIST",$G(DAT("NS-LIST",0)))=UCINM
    .  N JNO S JNO=""
    .  F  S JNO=$O(^XUTL("XQ",JNO)) Q:'JNO  D
    ..   S XUDUZ=$G(^XUTL("XQ",JNO,"DUZ")) Q:'XUDUZ
    ..   Q:$$SKIPDUZ(XUDUZ,$G(FLO),$G(FHI))  ;Don't add if DUZ is out of bounds of filters
    ..   S XUNM=$P($G(^VA(200,XUDUZ,0)),U)
    ..   S XUTO=$P($G(^XUTL("XQ",JNO,0)),U)
    ..   S XUIO=$G(^XUTL("XQ",JNO,"IO"))
    ..   S XUIP=$G(^XUTL("XQ",JNO,"IO(""IP"")"))
    ..   S OPTLN=$O(^XUTL("XQ",JNO,9999),-1)
    ..   S OPTNM=""
    ..   S:OPTLN>0 OPTNM=$P($G(^XUTL("XQ",JNO,OPTLN)),U,2)
    ..   D NOW^%DTC S XUON=$$FMDIFF^XLFDT(%,XUTO)
    ..   Q:'$D(^$Job(JNO))  ; copied from %zosv job validator
    ..   S DAT("NS",UCINM,JNO)=$G(XUDUZ)_U_$G(XUNM)_U_$G(XUTO)_U_$G(OPTNM)_U_$G(XUIO)_U_$G(XUIP)
    ..   I XUNM'="" D
    ...    S DAT("NS-NM",UCINM,XUNM,JNO)=$G(XUDUZ)_U_$G(XUTO)_U_$G(OPTNM)_U_$G(XUIO)_U_$G(XUIP)
    ...    S DAT("NAMES",XUNM,UCINM,JNO)=$G(OPTNM)_U_$G(XUTO)_U_$G(OPTNM)_U_$G(XUIO)_U_$G(XUIP)
    ...    M DAT("NS-NM",UCINM,XUNM,JNO,"VARS")=^XUTL("XQ",JNO)
    ...    M DAT("NAMES",XUNM,UCINM,JNO,"VARS")=^XUTL("XQ",JNO)
    ...    S DAT("NAMES")=+$G(DAT("NAMES"))+1
    ...    S DAT("NS-NM")=+$G(DAT("NS-NM"))+1
    K @VALMAR
    M @VALMAR=DAT
    Q
SKIPDUZ(ADUZ,LT,GT) ;
    I $G(LT)>0,ADUZ<LT Q -1
    I $G(GT)>0,ADUZ>GT Q -1
    Q 0
CHKROUTS() ; check that the uci has needed routine(s)
    Q:'$D(^ROUTINE("%DTC")) 0
    Q 1
DIS ;
    N XWNM,UCINM,JNO,LINEVAR,XUDUZ,REF,O1,O2,XWSTART,XWSTEP
    S REF="NAMES"
    S:$G(OBY)="UCI" REF="NS-NM"
    S VALMCNT=0
    S:ORD="ASC" XWSTEP=1,XWSTART=""
    S:ORD="DSC" XWSTEP=-1,XWSTART="ZZZZZZZZZZZZZZZZZZZZZZZZZZ"
    S O1=XWSTART
    F  S O1=$O(@VALMAR@(REF,O1),XWSTEP) Q:O1=""  D
    .  S O2=""
    .  F  S O2=$O(@VALMAR@(REF,O1,O2)) Q:O2=""  D
    ..   S JNO=0
    ..   F  S JNO=$O(@VALMAR@(REF,O1,O2,JNO)) Q:'JNO  D
    ...    S VALMCNT=VALMCNT+1
    ...    S LINEVAR=""
    ...    S XWNM=$S($G(OBY)="UCI":O2,1:O1)
    ...    S UCINM=$S($G(OBY)="UCI":O1,1:O2)
    ...    S XUDUZ=$P($G(@VALMAR@("NS",UCINM,JNO)),U)
    ...    S LINEVAR=$$SETFLD^VALM1(XWNM,LINEVAR,"NAME")
    ...    S LINEVAR=$$SETFLD^VALM1(UCINM,LINEVAR,"UCINAME")
    ...    S LINEVAR=$$SETFLD^VALM1(XUDUZ,LINEVAR,"DUZ")
    ...    S LINEVAR=$$SETFLD^VALM1(VALMCNT,LINEVAR,"LN")
    ...    S LINEVAR=$$SETFLD^VALM1(JNO,LINEVAR,"JOBNO")
    ...    D SET^VALM10(VALMCNT,LINEVAR,UCINM_JNO)
    ...    S @VALMAR@("IDX",VALMCNT)=UCINM_U_JNO_U_XWNM_U_$P($G(@VALMAR@("NS",UCINM,JNO)),U)_U_$P($G(@VALMAR@("NS",UCINM,JNO)),U,3,8)
    Q
INITD(XUMIEN) ;
    ;UCINM_U_JNO_U_XUNM_U_$G(XUTO)_U_$G(OPTNM)_U_$G(XUIO)_U_$G(XUIP)
    ;  1      2     3        4          5          6             7  
    N XUUCI,XUJNO,FLLN,XULT,XUOPT,TREF,XUNM,XUDUZ,XUIP,XUIO,XUVAR,XULTE
    S TREF="^XTMP(""XUMUCI"_$J_""")"
    S FLLN=$G(@TREF@("IDX",XUMIEN))
    S XUUCI=$P(FLLN,U)
    S XUJNO=$P(FLLN,U,2)
    S XUNM=$P(FLLN,U,3)
    S XUDUZ=$P(FLLN,U,4)
    S XULT=$P(FLLN,U,5) S:XULT XULTE=$$FMTE^XLFDT(XULT,"2PZ")
    S XUOPT=$P(FLLN,U,6)
    S XUIO=$P(FLLN,U,7)
    S XUIP=$P(FLLN,U,8)
    S VALMCNT=0
    S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,"Name:             "_$G(XUNM))
    S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,"DUZ:              "_$G(XUDUZ))
    S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,"UCI:              "_$G(XUUCI))
    S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,"Job #:            "_$G(XUJNO))
    S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,"Logged in at:     "_$G(XULTE))
    S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,"Option:           "_$G(XUOPT))
    S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,"Device:           "_$G(XUIO))
    S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,"IP:               "_$G(XUIP))
    S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,"")
    S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,"----OTHER VARS----")
    S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,"------------------")
    S XUVAR=""
    F  S XUVAR=$O(@TREF@("NAMES",XUNM,XUUCI,XUJNO,"VARS",XUVAR)) Q:XUVAR=""  D
    .  S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,XUVAR_": "_$G(@TREF@("NAMES",XUNM,XUUCI,XUJNO,"VARS",XUVAR)))
    S VALMBCK="R"
    Q
HDRD ;
    N TREF,FLLN,XUUCI,XUJNO
    S TREF="^XTMP(""XUMUCI"_$J_""")"
    S FLLN=$G(@TREF@("IDX",XUMIEN))
    S XUUCI=$P(FLLN,U)
    S XUJNO=$P(FLLN,U,2)
    S VALMHDR(1)="Detail for Job: "_XUJNO_" on UCI: "_XUUCI
    S VALMHDR(2)=""
    Q
EXITD(XUMIEN) ;
    Q
ENDIS(XUMIEN) ;
    D EN^VALM("XU MULTI UCI USER DISPLAY")
    S @VALMAR@("SELECTION")=XUMIEN
    Q
FILTLOW() ;
    N DIR,X,Y,DIRUT
    S DIR(0)="Y"
    S DIR("A")="Skip DUZs less than 1 (eg POSTMASTER)"
    S DIR("B")="Y"
    D ^DIR
    I $D(DIRUT)!(Y'>0) Q -1
    Q Y
FILTHIGH() ;
    N DIR,X,Y,DIRUT
    S DIR(0)="NOU^10:10000000"
    S DIR("A")="Skip DUZs greater than (enter for no upper bound)"
    S DIR("B")=""
    D ^DIR
    S:$G(Y)="^" Y=-1
    S:$G(Y)="" Y=9999999999999999999
    Q Y
REF ;
    K VALMHDR ;FORCE REPAINT OF HEADER
    D GETUSERS S VALMBCK="R" D DIS
    Q
    ;
SINCE(AFMDT) ;
    ;OUTPUT
    ;  "n days ""n hours""n minutes""n seconds" ^ DAYS:HOURS:MINUTES:SECONDS
    ;    SINCE AFMDT
    Q:AFMDT'>0 
    N %,XUDD,RET,XUD,XUH,XUM,XUS
    S RET=""
    D NOW^%DTC
    S XUDD=$$FMDIFF^XLFDT(%,AFMDT,2) ;DIFF IN SECONDS
    S XUD=XUDD\86400
    S:XUD>0 RET=RET_XUD_" days "
    S XUDD=XUDD-(XUD*86400)
    S XUH=XUDD\3600
    S:XUH>0 RET=RET_XUH_" hours "
    S XUDD=XUDD-(XUH*3600)
    S XUM=XUDD\60
    S:XUM>0 RET=RET_XUM_" minutes "
    S XUDD=XUDD-(XUM*60)
    S XUS=XUDD
    S:XUS>0 RET=RET_XUS_" seconds "
    Q RET_U_$G(XUD)_":"_$G(XUH)_":"_$G(XUM)_":"_$G(XUS)
SWORD ;
    N OLDORD
    S OLDORD=$G(OBY)
    S OBY=$$GETOBY(OLDORD)
    S:OBY="" OBY=OLDORD
    D:OBY'=OLDORD SO
    K VALMHDR
    S VALMBCK="R"
    Q
SO ;
    D GETUSERS
    D DIS
    Q
GETOBY(OLDORBY) ;
    N DIR,DIRUT,X,Y
    S DIR("A")="Select field to order on"
    S DIR(0)="SB^UCI:U;Name:N"
    S DIR("B")="N"
    D ^DIR
    Q:$D(DIRUT) OLDORBY
    Q $$UP^XLFSTR(Y)
AORD ; ASC/DSC
    S ORD=$S($G(ORD)="ASC":"DSC",1:"ASC") ;SWITCH ORDER
    D REF
    Q
