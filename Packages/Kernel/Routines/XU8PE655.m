XU8PE655 ;ISD/HGW Patch XU*8*655 Environment Check Routine ;03/26/15  12:04
 ;;8.0;KERNEL;**655**;Jul 10, 1995;Build 16
 ;Per VA Directive 6402, this routine should not be modified.
 ;
ENV ; Environment Check
 ;
 ;   General
 ;
 N XUXPTYPE,XUXLREV,XUXREQP,XUXBUILD,XUXIGHF,XUXFY,XUXQTR,XUXG,XUXB,XUXE,XUXR,XUXSTR,XUXOK
 D IMP
 K XPDDIQ("XPZ1","B"),XPDDIQ("XPI1","B") S XPDDIQ("XPZ1","B")="NO",XPDDIQ("XPI1","B")="NO"
 S XUXSTR=$G(XUXPTYPE)
 D BM(XUXSTR),M("")
 S U="^"
 ;     No user
 D:+($$UR)'>0 ET("User not defined (DUZ)")
 ;     No IO
 D:+($$SY)'>0 ET("Undefined IO variable(s)")
 I $D(XUXE) D ABRT Q
 ;
 ;   Load Distribution
 ;
 ;     XPDENV = 0 Environment Check during Load
 ;
 N XUXOK,XUXG,XUXR,XUXB
 ;       Check Required Patches
 D:$O(XUXREQP(0))'>0 IMP I $O(XUXREQP(0))>0 D
 . W ! N XUXPAT,XUXI,XUXPN,XUXP,XUXR,XUXC,XUXO,XUXC1,XUXC2,XUXC3,XUXC4,XUX
 . S (XUXR,XUXC)=0 S XUXC1=3,XUXC2=23,XUXC3=35,XUXC4=47
 . S XUXI=0  F  S XUXI=$O(XUXREQP(XUXI)) Q:+XUXI'>0  D
 . . S XUXC=XUXC+1,XUXPAT=$G(XUXREQP(XUXI))
 . S XUXI=0  F  S XUXI=$O(XUXREQP(XUXI)) Q:+XUXI'>0  D
 . . N XUXPAT,XUXREL,XUXINS,XUXCOM,XUXINE,XUXREQ,XUXTX S XUXREQ=$G(XUXREQP(XUXI))
 . . S XUXPAT=$P(XUXREQ,"^",1),XUXREL=$P(XUXREQ,"^",2),XUXCOM=$P(XUXREQ,"^",3)
 . . S XUXPN=$$INS(XUXPAT) S XUXINS=$$INSD(XUXPAT),XUXINE=$P(XUXINS,"^",2)
 . . I XUXI=1 D
 . . . W !,?XUXC1,"Checking for ",!
 . . . W !,?XUXC1,"Patch",?XUXC2,"Released",?XUXC3,"Installed",?XUXC4,"Content"
 . . S XUXTX=$J(" ",XUXC1)_XUXPAT
 . . S XUXTX=XUXTX_$J(" ",(XUXC2-$L(XUXTX)))
 . . S:XUXREL?7N XUXTX=XUXTX_$P($$FMTE^XLFDT(XUXREL,"5DZ"),"@",1)
 . . S XUXTX=XUXTX_$J(" ",(XUXC3-$L(XUXTX)))
 . . I +XUXPN>0 D
 . . . H 1 S XUXO=+($G(XUXO))+1 S:$L($G(XUXINE)) XUXTX=XUXTX_XUXINE
 . . . S XUXTX=XUXTX_$J(" ",(XUXC4-$L(XUXTX)))
 . . . S:$L(XUXCOM) XUXTX=XUXTX_XUXCOM
 . . D M(XUXTX)
 . . I +XUXPN'>0 D ET((" "_XUXPAT_" not found, please install "_XUXPAT_" before continuing"))
 . W:+($G(XUXO))'=XUXC !
 I $D(XUXE) D M(),ABRT Q
 ;
 I '$$PROD^XUPROD D QUIT Q  ;Quit if test account, no need to load global
 ;
 S XUXG=$$RGBL
 I $D(XUXE)&(+XUXG=0) D ABRT Q
 I $D(XUXE)&(+XUXG<0) D ABRT Q
 I '$D(XUXFULL)&(+($G(XPDENV))'=1) D QUIT Q
 ;
 ;   Quit, Exit or Abort
 ;
QUIT ;     Quit   Passed Environment Check
 K XUXFULL D OK
 I $G(XPDENV)=1 S XPDDIQ("XPZ1")=0 ;Do not disable options/protocols
 Q
EXIT ;     Exit   Failed Environment Check
 D:$D(XUXE) ED S XPDQUIT=2 K XUXE,XUXFULL Q
ABRT ;     Abort  Failed Environment Check, KILL the distribution
 D:$D(XUXE) ED S XPDABORT=1,XPDQUIT=1 S:$L($G(XUXBUILD)) XPDQUIT(XUXBUILD)=1
 K XUXE,XUXFULL
 Q
T1 ; Environment Check #1 (for testing only)
 K XPDENV D ENV
 Q
T2 ; Environment Check #2 (for testing only)
 N XPDENV S XPDENV=1 D ENV
 Q
 ;
 ; Checks
 ;
RGBL(X) ;   Check for required globals
 N XUXCPD,XUXS,XUXI,XUXX,XUXEC,XUXGBL,XUXRT,XUXT,XUXF,XUXB1,XUXB2
 S XUXCPD=$$CPD,XUXS="",X=1 F XUXI=1:1 D  Q:'$L(XUXX)
 . S XUXX="" S XUXEC="S XUXX=$T(GD+"_XUXI_")" X XUXEC S XUXX=$$TRIM(XUXX) Q:'$L(XUXX)  Q:'$L($TR(XUXX,";",""))
 . S XUXGBL=$P(XUXX,";",3) Q:+XUXCPD>0&(XUXGBL="^XUXM(0)")  S XUXRT=$P(XUXX,";",4),XUXT=$P(XUXX,";",5),XUXF=$P(XUXX,";",6)
 . S (XUXB1,XUXB2)="",$P(XUXB1," ",(15-$L(XUXRT)))="",$P(XUXB2," ",(28-$L(XUXT)))=""
 . I '$D(@XUXGBL) S:XUXS'[XUXRT XUXS=XUXS_", "_XUXRT S X=-1 S:XUXGBL["XUXM("&(X=1) X=0
 I $L(XUXS),X'>0 D
 . S:XUXS[", " XUXS=$P(XUXS,", ",1,($L(XUXS,", ")-1))_" and "_$P(XUXS,", ",$L(XUXS,", "))
 . S:$E(XUXS,1,2)=", " XUXS=$E(XUXS,3,$L(XUXS)) S:$E(XUXS,1,7)[" and " XUXS=$P(XUXS," and ",2)
 . D:X=-1 ET(("Global"_$S(XUXS[", "!(XUXS[" and "):"s",1:"")_" "_XUXS_" either not found or incomplete."))
 . D:X=0 CM
 Q X
INS(X) ;   Installed
 N XUX,XUXP,XUXV,XUXI,XUXS S XUX=$P($G(X)," ",1) I $L(XUX,"*")=3 S X=$$PATCH^XPDUTL(XUX) Q X
 S XUXP=$$PKG^XPDUTL(XUX),XUXV=$$VER^XPDUTL(XUX),XUXI=$$VERSION^XPDUTL(XUXP)
 Q:+XUXV>0&(XUXV=XUXI) 1
 Q 0
INSD(X)  ;   Installed on
 N DA,XUX,XUXDA,XUXE,XUXI,XUXMSG,XUXNS,XUXOUT,XUXPI,XUXPN,XUXSCR,XUXVI,XUXVD,XUXVI,XUXVR S XUX=$G(X)
 S XUXNS=$$PKG^XPDUTL(XUX),XUXVR=$$VER^XPDUTL(XUX),XUXPN=$P(X,"*",3)
 Q:'$L(XUXNS) ""  S XUXVR=+XUXVR Q:XUXVR'>0 ""  S XUXPN=+XUXPN S:XUXVR'["." XUXVR=XUXVR_".0"
 S XUXSCR="I $G(^DIC(9.4,+($G(Y)),""VERSION""))="""_XUXVR_""""
 D FIND^DIC(9.4,,.01,"O",XUXNS,10,"C",XUXSCR,,"XUXOUT","XUXMSG")
 S XUXPI=$G(XUXOUT("DILIST",2,1)) K XUXOUT,XUXMSG Q:+XUXPI'>0 ""  Q:'$D(@("^DIC(9.4,"_XUXPI_",22)")) ""
 K DA S DA(1)=XUXPI S XUXDA=$$IENS^DILF(.DA)
 D FIND^DIC(9.49,XUXDA,".01;1I;2I","O",XUXVR,10,"B",,,"XUXOUT","XUXMSG")
 S XUXVD=$G(XUXOUT("DILIST","ID",1,2)) I $E(XUXVD,1,7)?7N&(+XUXPN'>0) D  Q X
 . S X=$E(XUXVD,1,7)_"^"_$TR($$FMTE^XLFDT($E(XUXVD,1,7),"5DZ"),"@"," ")
 S:$E(XUXVD,1,7)'?7N XUXVD=$G(XUXOUT("DILIST","ID",1,1)) I $E(XUXVD,1,7)?7N&(+XUXPN'>0) D  Q X
 . S X=$E(XUXVD,1,7)_"^"_$TR($$FMTE^XLFDT($E(XUXVD,1,7),"5DZ"),"@"," ")
 Q:+XUXPN'>0 ""  S XUXVI=$G(XUXOUT("DILIST",2,1)) K XUXOUT,XUXMSG
 Q:+XUXVI'>0 ""  Q:'$D(@("^DIC(9.4,"_XUXPI_",22,"_XUXVI_",""PAH"")")) ""
 K DA S DA(2)=XUXPI,DA(1)=XUXVI S XUXDA=$$IENS^DILF(.DA)
 S XUXSCR="I $G(^DIC(9.4,"_XUXPI_",22,"_XUXVI_",""PAH"",+($G(Y)),0))[""SEQ #"""
 D FIND^DIC(9.4901,XUXDA,".01;.02I",,XUXPN,10,"B",XUXSCR,,"XUXOUT","XUXMSG")
 S XUXI=$G(XUXOUT("DILIST","ID",1,.02)) I '$L(XUXI) D
 . S XUXSCR="" D FIND^DIC(9.4901,XUXDA,".01;.02I",,XUXPN,10,"B",XUXSCR,,"XUXOUT","XUXMSG")
 . S XUXI=$G(XUXOUT("DILIST","ID",1,.02))
 Q:'$L(XUXI) ""  Q:$P(XUXI,".",1)'?7N ""  S XUXE=$TR($$FMTE^XLFDT(XUXI,"5DZ"),"@"," ")
 Q:'$L(XUXE) ""  S X=XUXI_"^"_XUXE
 Q X
SY(X) ;   Check System variables
 Q:'$D(IO)!('$D(IOF))!('$D(IOM))!('$D(ION))!('$D(IOSL))!('$D(IOST)) 0
 Q 1
UR(X) ;   Check User variables
 Q:'$L($G(DUZ(0))) 0
 Q:+($G(DUZ))=0!($$NOTDEF(+$G(DUZ))) 0
 Q 1
CPD(X) ;   Check Current Patched Data is installed
 N INS S INS=1
 Q 0
 ;
 ; Error messages
 ;
CM ;   Missing ^XU8P655
 N XUXPTYPE,XUXLREV,XUXREQP,XUXBUILD,XUXIGHF,XUXFY,XUXQTR D IMP D ET(""),ET("Missing import global ^XU8P655.") D CO
 Q
CO ;   Obtain new global
 N XUXPTYPE,XUXLREV,XUXREQP,XUXBUILD,XUXIGHF,XUXFY,XUXQTR D IMP
 D ET(""),ET("    Please obtain a copy of the import global ^XU8P655 contained in the ")
 D ET(("    global host file "_XUXIGHF_" before continuing with the "_XUXBUILD))
 D ET(("    installation."))
 Q
ET(X) ;   Error Text
 N XUXI S XUXI=+($G(XUXE(0))),XUXI=XUXI+1,XUXE(XUXI)="    "_$G(X),XUXE(0)=XUXI
 Q
ED ;   Error Display
 N XUXI S XUXI=0 F  S XUXI=$O(XUXE(XUXI)) Q:+XUXI=0  D M(XUXE(XUXI))
 D M(" ") K XUXE Q
 ;
 ; Miscellaneous
 ;
NOTDEF(IEN) ;   Check to see if user is defined
 N DA,DR,DIQ,XUX,DIC S DA=IEN,DR=.01,DIC=200,DIQ="XUX" D EN^DIQ1 Q '$D(XUX)
OK ;   Environment is OK
 N XUXPTYPE,XUXLREV,XUXREQP,XUXBUILD,XUXIGHF,XUXFY,XUXQTR,XUXT
 D IMP S XUXT="  Environment "_$S($L(XUXBUILD):("for patch/build "_XUXBUILD_" "),1:"")_"is ok"
 D BM(XUXT),M(" ")
 Q
BM(X) ;   Blank Line with Message
 S X=$G(X) S:$E(X,1)'=" " X=" "_X D BMES^XPDUTL(X) Q
M(X) ;   Message
 S X=$G(X) S:$E(X,1)'=" " X=" "_X D MES^XPDUTL(X) Q
TRIM(X) ;   Trim Spaces
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
IMP ;   Import names
 ;ZEXCEPT: XUXBUILD,XUXIGHF,XUXLREV,XUXPTYPE,XUXREQP ;global variables within this routine
 S XUXPTYPE="VistA Kernel Patch XU*8.0*655"
 ;     Revision
 S XUXLREV=655
 ;     Required Builds Array
 ;        XUX(1)=build SEQ #^released date^subject
 ;        XUX(n)=build SEQ #^released date^subject
 S XUXREQP(1)="XU*8.0*240 SEQ #237^3030313^STDNAME~XLFNAME: CHECK FOR SUFFIX"
 S XUXREQP(2)="XU*8.0*325 SEQ #337^3060526^XUPS PERSON QUERY"
 S XUXREQP(3)="XU*8.0*514 SEQ #428^3100113^MISC KERNEL FIXES"
 S XUXREQP(4)="XU*8.0*523 SEQ #433^3100428^BSE FOR IMAGING"
 ;     This Build Name
 S XUXBUILD="XU*8.0*655"
 ;     This Build's Export Global Host Filename
 S XUXIGHF="XU_8_655.GBL"
 Q
EF ;   Exported Files
 ;;^XU8P655("VACAA");^XU8P655("VACAA");Kernel;200
 Q
GD ;   Global Data
 ;;^XU8P655("VACAA");^XU8P655("VACAA");Kernel;200
