MAGJORD ;WIRMFO/JHC-Display Rad Exam Order info ; 29 Jul 2003  10:02 AM
 ;;3.0;IMAGING;**16,22,18**;Mar 07, 2006
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
ORD(MAGRPTY,DATA) ; Radiology Order Display
 ; RPC Call: MAGJ RADORDERDISP
 ; MAGRPTY holds indirect reference to returned data
 ; 
 S MAGRPTY=$NA(^TMP($J,"WSDAT")) K @MAGRPTY
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGJORD"
 N RARPT,RADFN,RADTI,RACNI,RAPGE,RAX,RAOIFN
 N REPLY,POP,DFN,COMPLIC,XX,HDR,MAGRET,REQONLY
 S REPLY="0^4~Attempting to display order info"
 D OPENDEV
 I POP S REPLY="0^4~Unable to open device 'IMAGING WORKSTATION'" G ORDZ
 S RADFN=$P(DATA,U),RADTI=$P(DATA,U,2),RACNI=$P(DATA,U,3)
 S RARPT=+$P(DATA,U,4),REQONLY=+$P(DATA,U,1,5)
 I RADFN,RADTI,RACNI
 E  S REPLY="0^4~Request Contains Invalid Case Pointer ("_RADFN_" "_RADTI_" "_RACNI_" "_RARPT_")." G ORDZ
 S RAOIFN=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),U,11)
 I RAOIFN,$D(^RAO(75.1,RAOIFN,0))
 E  S REPLY="0^2~Order Information is NOT Available for this exam." G ORDZ
 ; Check for Database integrity problems ONLY if Req was explicitly
 ; requested (No check for Auto_Display of Req, cuz Exam Open does ck)
 D GETEXAM2^MAGJUTL1(RADFN,RADTI,RACNI,"",.MAGRET)
 S RADATA=$G(^TMP($J,"MAGRAEX",1,1)),XX=$G(^(2)),HDR=""
 S COMPLIC=$P(XX,U,4)      ;  Complications text
 F I=4,12,9 S HDR=HDR_$P(RADATA,U,I)_"   " ; PtName, Case #, Procedure
 I REQONLY D CKINTEG^MAGJRPT(.REPLY,RADFN,RADTI,RACNI,RARPT,RADATA) I REPLY]"" S REPLY="0^7~"_REPLY G ORDZ  ; Database integrity problems
 S RAX="",RAPGE=0 D ^RAORD5
 D:IO'=IO(0) ^%ZISC
 S @MAGRPTY@(1)="REQ: "_HDR
 D COMMENTS(RADFN,RADTI,RACNI,MAGRPTY,2,COMPLIC)
 S REPLY="1^OK"
 K ^TMP($J,"MAGRAEX")
ORDZ S @MAGRPTY@(0)=REPLY
 Q
 ;
COMMENTS(RADFN,RADTI,RACNI,MAGRPTY,DNODE,COMPLIC) ; add Complications & Tech Comments to output report
 ;  also called by Rad Report display (magjlst1)
 ;  RADFN, RADTI, & RACNI identify exam
 ;  MAGRPTY is indirect reference wher output lines are to be stored
 ;  DNODE holds reference for starting node for lines of output
 ;  COMPLIC passes in complications data reference
 ;
 I +MAGJOB("USER",1)  ; Radiologist
 E  I $D(^VA(200,"ARC","T",+DUZ))  ; Rad Tech
 E  Q  ; Don't display for any other user type
 N QTMP,CT,XX S CT=0
 S @MAGRPTY@(DNODE)=" ",CT=CT+.01,@MAGRPTY@(DNODE+CT)="Complications: "_$S(COMPLIC:$P($G(^RA(78.1,+COMPLIC,0)),U),1:"")
 S X=$P(COMPLIC,"~",2)
 I X S CT=CT+.01,@MAGRPTY@(DNODE+CT)="   "_$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"COMP")),U)
 K ^TMP($J,"RAE2") D SVTCOM^RAUTL11(RADFN,RADTI,RACNI)
 S QTMP="^TMP($J,""RAE2"")"
 F  S QTMP=$Q(@QTMP) Q:QTMP=""  Q:QTMP'["RAE2"  I QTMP["TCOM" D
 . S XX=@(QTMP) N HI,TXT,LINE1 S LINE1=0
 . F  Q:XX=""  S HI=$L(XX) S:HI>63 HI=63 F I=HI:-1:0 S:'I XX="" I HI<63!($E(XX,I)=" ") D  Q
 .. S TXT=$S('LINE1:"Tech Comments: ",1:"               ")_$E(XX,1,I),XX=$E(XX,I+1,999),LINE1=1
 .. I XX]"" F I=1:1:999 I $E(XX,I)'=" " S XX=$E(XX,I,999) Q
 .. S CT=CT+.01,@MAGRPTY@(DNODE+CT)=TXT
 K ^TMP($J,"RAE2")
 Q
 ;
OPENDEV ;
 S IOP="IMAGING WORKSTATION",%ZIS=0 D ^%ZIS
 I POP
 E  U IO
 Q
ERRA ;
 S @MAGRPTY@(0)="0^ERROR "_$$EC^%ZOSV
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
END ;
