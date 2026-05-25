XOBSRA ;MJK/ESD/ALB - VistALink Reauthentication Code ; 05/22/2003  07:00
 ;;1.6;VistALink Security;**2,6**;May 08, 2009;Build 4
 ;;Per VA Directive 6402, this routine should not be modified
 ;;BACKUP FROM 3251208
 QUIT
 ;
 ; ------------------------------------------------------------------------
 ;             RPC Server: Reauthentication based on VPID, DUZ, and AV
 ; ------------------------------------------------------------------------
 ;
SAML(XOBID,XOBERR) ; rtw ADDED FOR XOBS*1.6*6
 ;The RTN array must be preserved to return to VistaLink
 S XOBID=0
 S SAML=$G(XOBDATA("XOB RPC","SECURITY","TYPE","SAML"))
 D SETUP^XUSRB
 D SAML^XOBVSAML(.RTN,SAML)
 I $G(RTN(0)) S XOBID=RTN(0)
 E  I $D(RTN(3)),RTN(3)'="" S XOBERR=RTN(3) D
 . D GETDUZ(SAML,.XOBERR)
 . I XOBERR[182308 D FINAL S DUZ=$G(XOBOK) Q
 . I XOBERR["No access allowed for this user" S XOBID=0,XOBERR=182304_"^"_DUZ_"^"_"DISUSERED" D FINAL S DUZ=$G(XOBOK) Q
 K SAML,^TMP("DUZ_XUS",$J)
 Q XOBID
 ;
 ;
SETUPDUZ() ; -- get DUZ context and division
 ;
 NEW XOBERR,XOBID,XOBTYPE
 SET (XOBERR,XOBID)=0
 ;
 ; -- if already authenticated quit
 IF $GET(XOBDATA("XOB RPC","SECURITY","STATE"))="authenticated" D KILL^XOBSRA1 GOTO SUDQ ;*2
 ; -- switch to null device
 DO NULL
 ; -- initialize partition
 DO INIT
 ;
 ; -- check if logons are enabled
 SET XOBERR=$$LOGINH()
 IF XOBERR DO SOCKET GOTO SUDQ
 ;
 ; -- reauthenticate user based on type
 SET XOBTYPE=$GET(XOBDATA("XOB RPC","SECURITY","TYPE")),XOBTYPE=$$UP^XLFSTR(XOBTYPE)
 IF XOBTYPE="DUZ"!(XOBTYPE="AV")!(XOBTYPE="VPID")!(XOBTYPE="CCOW")!(XOBTYPE="APPPROXY")!(XOBTYPE="SAML") DO  ;RTW ADD SAML XOBS*1.6*6
 . DO @(XOBTYPE_"(.XOBID,.XOBERR)")
 ELSE  DO
 . SET XOBERR=182301_U_XOBTYPE_U_"  [Erroneous reauthentication type]"
 ;
 ; -- check division
 IF XOBID SET XOBERR=$$DUZENV(XOBID,XOBTYPE)
 ;
 ; -- switch back to socket device
 DO SOCKET
SUDQ ;
 ;LOG:: Log error in trap or elsewhere if appropriate. May want to log 'no match' event for security reasons.
 IF 'XOBERR DO FINAL
 QUIT XOBERR
 ;
NULL ; switch to null device
 USE XOBNULL
 QUIT
 ;
SOCKET ; -- switch back to socket device
 ; -- empty write buffer of null device
 USE XOBNULL SET DX=0,DY=0 XECUTE ^%ZOSF("XY")
 ; -- reset to use tcp port device to send results
 USE XOBPORT
 QUIT
 ;
AV(XOBID,XOBERR) ; -- AV (SSO/UC KAAJEE) reauth type
 ;
 ; More checks performed here; assume this would be called ONCE when user authenticates
 ; to application via KAAJEE or FatKAAT
 ;
 DO AV^XOBSRAKJ(.XOBID,.XOBERR)
 QUIT
 ;
DUZ(XOBID,XOBERR) ; -- DUZ reauth type
 ;
 NEW XOBCTYPE
 SET XOBCTYPE="DUZ"
 SET XOBID=$GET(XOBDATA("XOB RPC","SECURITY","TYPE","VALUE"))
 ;
 ; Active user status check performed here; assume heavier-duty checks done by application
 ; when user authenticated to application via KAAJEE, FatKAAT or equivalent.
 ;
 DO ACTUSR(.XOBID,.XOBERR,XOBCTYPE)
 QUIT
 ;
VPID(XOBID,XOBERR) ; -- VPID reauth type
 NEW VPID,XOBCTYPE
 SET XOBID=0
 SET XOBCTYPE="VPID"
 ;
 SET VPID=$GET(XOBDATA("XOB RPC","SECURITY","TYPE","VALUE"))
 IF VPID]"" SET XOBID=$$IEN^XUPS(VPID)
 ;
 IF '+XOBID DO  QUIT
 . SET XOBERR=182301_U_XOBTYPE_U_"["_XOBCTYPE_" Value: '"_VPID_"']"
 . SET XOBID=0
 ;
 ; Active user status check performed here; assume heavier-duty checks done by application
 ; when user authenticated to application via KAAJEE, FatKAAT or equivalent.
 ;
 DO ACTUSR(.XOBID,.XOBERR,XOBCTYPE)
 QUIT
 ;
APPPROXY(XOBID,XOBERR) ; -- application proxy reauth type
 ;
 NEW XOBANAME,XOBCTYPE,XOBAPFND
 SET XOBID=0,XOBCTYPE="APPPROXY"
 SET XOBANAME=$GET(XOBDATA("XOB RPC","SECURITY","TYPE","VALUE"))
 ;
 ; APFIND^XUSAP(name) -> returns ien^vpid, or (failure) -int^reason
 IF XOBANAME]"" SET XOBAPFND=$$APFIND^XUSAP(XOBANAME),XOBID=$PIECE(XOBAPFND,U)
 ; file #200 division mult checking not necessary for app proxy user
 IF (+XOBID)<1 DO
 . SET XOBERR=182307_U_XOBANAME_U_"["_$P(XOBAPFND,U,2)_"]",XOBID=0
 QUIT
 ;
CCOW(XOBID,XOBERR) ; -- CCOW reauth type
 ;
 ; Very few checks performed here; assume heavier duty checks done by application when originally
 ; authenticated and created Kernel CCOW token. User would need to be reauthenticated (and perform
 ; heavier-duty checks) upon Kernel CCOW token expiration.
 ;
 DO CCOW^XOBSRAKJ(.XOBID,.XOBERR)
 QUIT
 ;
ACTUSR(XOBID,XOBERR,XOBCTYPE) ; -- user active status check & error processing
 ;
 NEW XOBACTIV
 SET XOBACTIV=0
 SET XOBID=$GET(XOBID),XOBCTYPE=$GET(XOBCTYPE)
 ;
 ;-- returns active status indicator of user
 SET XOBACTIV=$$ACTIVE^XUSER(XOBID)
 IF +XOBACTIV<1 DO
 . ;
 . ;-- get dialog entry for error
 . SET XOBERR=$$GETERR(XOBACTIV,XOBID,XOBCTYPE)
 . SET XOBID=0
 QUIT
 ;
DUZENV(XOBDUZ,XOBTYPE) ; -- build DUZ and check division
 ;
 ; QUIT 0 if OK, DialogErrorNumber^DialogErrorParameter1^... if bad
 ;
 NEW XOBDVARY,XOBDIV,XOBDIVEX,XOBDIVRQ,XOBDUZSV,XOBERR,XOBI,XOBOK
 SET XOBOK=0,(XOBERR,XOBDIVEX)=""
 ;
 ; -- preserve previous DUZ value, restore if needed
 MERGE XOBDUZSV=DUZ KILL DUZ
 ;
 ; -- set up info on passed in user
 SET DUZ=XOBDUZ
 SET XOBDIVRQ("STATIONNUMBER")=$GET(XOBDATA("XOB RPC","SECURITY","DIV"))
 ;
 DO  ; checks
 .;
 .; -- if no division passed in
 . IF XOBDIVRQ("STATIONNUMBER")']"" DO  QUIT
 . . SET XOBERR=182308_U_"no division passed"_U_XOBTYPE_U_XOBDUZ_U_"null"
 . ;
 . ; -- is division supported at the site?
 . SET XOBDIVRQ("IEN")=$$SITECHK(XOBDIVRQ("STATIONNUMBER"))
 . IF '+XOBDIVRQ("IEN") DO  QUIT
 . . SET XOBERR=182308_U_$P(XOBDIVRQ("IEN"),U,2)_U_XOBTYPE_U_XOBDUZ_U_XOBDIVRQ("STATIONNUMBER")
 . . KILL XOBDIVRQ("IEN")
 .;
 .; -- build DUZ
 . DO DUZ^XUP(DUZ)
 .;
 .; -- don't do user-based checks if reauth type is APPPROXY
 .IF XOBTYPE="APPPROXY" SET XOBOK=1 QUIT
 .;
 .; -- do check for user-permitted divisions
 . DO DIVGET^XUSRB2(.XOBDIV,DUZ)
 .;
 .; -- DIVGET^XUSRB2 return value: if no divisions or one (matching) division, it's good
 . IF '$GET(XOBDIV(0)) DO  QUIT
 .. IF $GET(DUZ(2))=XOBDIVRQ("IEN") SET XOBOK=1 QUIT  ; OK
 ..;
 ..; -- if got here, did not match division
 .. SET XOBERR=182302_U_XOBTYPE_U_XOBDUZ_U_XOBDIVRQ("STATIONNUMBER")
 .;
 .; -- DIVGET^XUSRB2 return value: if >1 divisions to select, attempt to set DUZ(2) to div passed in
 . DO DIVSET^XUSRB2(.XOBOK,"`"_XOBDIVRQ("IEN")) I 'XOBOK DO
 .. SET XOBERR=182302_U_XOBTYPE_U_XOBDUZ_U_XOBDIVRQ("STATIONNUMBER")
 ;
 IF 'XOBOK DO  ; A check failed. Clean up partition.
 .;
 .; -- reset DUZ
 . KILL DUZ
 . MERGE DUZ=XOBDUZSV
 ;
 ; -- send back error
 QUIT $SELECT(XOBOK:0,1:XOBERR)
 ;
LOGINH() ; -- Check if system is currently allowing logins
 ; Return:
 ;   181004 : if logins are disabled
 ;        0 : if logins are allowed
 ;
 NEW XQVOL,XUCI,XUENV,XUVOL,X,Y
 ;
 ; -- Setup XUENV, XUCI,XQVOL,XUVOL
 DO XUVOL^XUS
 ;
 ; -- Check whether logins are disabled
 QUIT $SELECT($$INHIB1^XUSRB():181004,1:0)
 ;
NOACCESS(XOBID) ; -- Determine if user is allowed access via user active status & prohibited times checks
 ;
 NEW XOBERR,XOBNOACC,XOBRANGE
 SET (XOBERR,XOBNOACC)=0
 ;
 ; -- user active status check & error processing
 DO ACTUSR(.XOBID,.XOBERR)
 ;
 ; -- check if sign-on is attempted during prohibited times
 IF 'XOBERR DO
 . SET XOBRANGE=$$GET1^DIQ(200,XOBID,15)
 . IF XOBRANGE DO
 .. SET XOBNOACC=$$PROHIBIT^XUS1A($P($HOROLOG,",",2),XOBRANGE)
 .. IF XOBNOACC SET XOBERR=182304_U_XOBID_U_"Prohibited time: "_$PIECE(XOBNOACC,U,2)
 QUIT XOBERR
 ;
VCHG(XOBID) ; -- Check if verify code needs to be changed
 ; Return:
 ;   182303^XOBID : if verify code is undefined or expired
 ;              0 : verify code is current
 NEW DUZ,I,VCHG,XOPT
 SET DUZ=+$GET(XOBID),VCHG=0
 ;
 ; -- set up XOPT
 DO XOPT^XUS
 ;
 ; -- check if verify code is current
 IF $$VCVALID^XUSRB() DO
 . SET VCHG=182303_U_DUZ
 QUIT VCHG
 ;
INIT ; -- VL-specific or general partition setup before reauthentication process starts
 ;
 LOCK
 SET:$DATA(IO)[0 IO=$IO SET IO(0)=IO
 KILL ^UTILITY($JOB),^TMP($JOB)
 KILL ^XUTL("XQ",$JOB)
 ; -- clean up partition's local symbol table
 DO KILL^XOBSRA1
 QUIT
 ;
FINAL ; -- Final setup needed after a re-authentication is performed successfully.
 ; -- Save DUZ and IO variables in ^XUTL("XQ",$JOB)
 DO SAVE^XUS1
 ;
 ; Change in XUSRB: calls POST2^XUSRB calls CLRFAC^XUS3 to clear Failed Signon Attempts
 ; file of entry with given IP. Need IO("IP") obtained from ZIO^%ZIS4.
 ; 
 K XQY,XQY0 ;*2
 QUIT
 ;
GETERR(XOBACT,XOBID,XOBCONN) ;-- Get appropriate DIALOG file error
 ;
 NEW XOBERR
 SET XOBERR=0
 SET XOBACT=$GET(XOBACT),XOBID=$GET(XOBID),XOBCONN=$GET(XOBCONN)
 ;
 ;- error indicates that user can't sign on, is DISUSER'd, or is TERMINATED
 IF $PIECE(XOBACT,U)=0 SET XOBERR=182304_U_XOBID_U_$SELECT($PIECE(XOBACT,U,2)'="":$PIECE(XOBACT,U,2),1:"Unable to Sign On")
 ;
 ;- error indicates no user record found
 IF $PIECE(XOBACT,U)="" DO
 . SET:XOBCONN="" XOBCONN="Unknown Reauthentication Type"
 . SET XOBERR=182301_U_XOBCONN_U_"  ["_XOBCONN_" reauthentication type, DUZ Value: '"_XOBID_"']"
 QUIT XOBERR
 ;
SITECHK(XOBSTATN) ; check if valid division for this site
 ; input: station#
 ; output: IEN of station# in institution file (if valid for this site)
 ;         0^error message (if not valid for this site)
 N XOBSTIEN,XOBSTRIP
 SET XOBSTRIP=$$STRPSUFF^XOBSCAV1(XOBSTATN)
 ; note: AAC 200M truncated to 200 in both sides of comparison below
 QUIT:(XOBSTRIP'=XOBSYS("PRIMARY STATION#")) "0^STATION '"_XOBSTATN_"' is not supported by this M system."
 S XOBSTIEN=$$IEN^XUAF4(XOBSTATN)
 QUIT:'+XOBSTIEN "0^STATION '"_XOBSTATN_"' is not a known station number."
 QUIT:'$$ACTIVE^XUAF4(XOBSTIEN) "0^STATION '"_XOBSTATN_"' is not active on this M system."
 QUIT XOBSTIEN
GETDUZ(SAML,XOBERR) ; if new SAML user is disusered give the DUZ to complete the return information
 N I,IEND,ISTART,ISTOP,DOC
 ;K RTN
 K ^TMP("DUZ_XUS",$J)
 S ISTOP=$L(SAML),IEND=0
 F I=1:1  Q:IEND>ISTOP  D
 . S ISTART=IEND+1
 . S IEND=IEND+200
 . S ^TMP("DUZ_XUS",$J,I)=$E(SAML,ISTART,IEND)
 .Q
 D SECID(SAML,.XOBERR,.DUZ)
 I '$G(DUZ) S XOBERR=182308_U_1_U_"SAML"_U_XOBERR_"SECID NOT FOUND IN UCI"
 ;K X,XQVOL,XUCI,XUENV,XUOSVER,Y
 Q XOBERR
SECID(SAML,XOBERR,DUZ) ;TO CHECK IF a SECID exists in the UCI
 N SECID,SECIDL
 S SECIDL=0,DUZ=""
 S ^XTMP("SAML CHECK",$J)=SAML
 S SECID=$P($P(^XTMP("SAML CHECK",$J),"urn:va:vrm:iam:secid"">",2),"<",1) D
 . F  S SECIDL=$O(^VA(200,"ASECID",SECIDL)) Q:'SECIDL  D
 . . I SECID=SECIDL S DUZ=$O(^VA(200,"ASECID",SECID,"")) Q
 Q XOBERR
