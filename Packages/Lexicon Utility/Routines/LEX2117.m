LEX2117 ;ISL/CED - LEX*2.0*117 Env Check ;01/23/2018
 ;;2.0;LEXICON UTILITY;**117**;Sep 23, 1996;Build 5
 ;
 ; Global Variables
 ;    ^LEXM               N/A
 ;               
 ; External References
 ;    FIND^DIC            ICR   2051
 ;    $$IENS^DILF         ICR   2054
 ;    EN^DIQ1             ICR  10015
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$PATCH^XPDUTL      ICR  10141
 ;    $$PKG^XPDUTL        ICR  10141
 ;    $$VER^XPDUTL        ICR  10141
 ;    $$VERSION^XPDUTL    ICR  10141
 ;    BMES^XPDUTL         ICR  10141
 ;    MES^XPDUTL          ICR  10141
 ;               
 ; Local Variables NEWed or KILLed by Kernel Installation
 ; and Distribution System (KIDS):
 ; 
 ;     XPDABORT,XPDDIQ,XPDQUIT
 ;               
 ;     see Kernel Developer Guide, Chapter 14, 
 ;     KIDS Developer Tools, Advanced Build Techniques
 ;               
 ; The following sections must be updated with each quarterly
 ; patch
 ;        
 ;   IMP^LEX2nnn   Import names
 ;     
 ;     This section sets the following variables:
 ;         
 ;     LEXBUILD    Build Name            LEX*2.0*nnn
 ;     LEXPTYPE    Patch Type            Remedy or Quarterly
 ;     LEXIGHF     Name of Host File     LEX_2_nnn.GBL
 ;     LEXLREV     Revision Number       nnn
 ;     LEXFY       Fiscal Year           FYnn
 ;     LEXQTR      Quarter               1st, 2nd, 3rd, or 4th
 ;     LEXREQP(n)  Required Patch Array
 ;
 ;   IPL^LEX2nnnP  Informational Patch List
 ;     
 ;     This is a listing of informational patches that 
 ;     accompany this patch.  It consist of a patch name 
 ;     and a sequence number when available.  It is used
 ;     to update the package file at the site with the 
 ;     informational patches.
 ;               
ENV ; Environment Check
 ;                    
 ;   General
 ;
 N LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXG,LEXB,LEXE,LEXR,LEXSTR,LEXOK D IMP
 K XPDDIQ("XPZ1","B"),XPDDIQ("XPI1","B") S XPDDIQ("XPZ1","B")="NO",XPDDIQ("XPI1","B")="NO"
 S LEXSTR=$G(LEXPTYPE) S:$L($G(LEXFY))&($L($G(LEXQTR))) LEXSTR=LEXSTR_" for "_$G(LEXFY)_" "_$G(LEXQTR)_" Quarter"
 D BM(LEXSTR)
 S U="^"
 ;     No user
 D:+($$UR)'>0 ET("User not defined (DUZ)")
 ;     No IO
 D:+($$SY)'>0 ET("Undefined IO variable(s)")
 I $D(LEXE) D ABRT Q
 ;                    
 ;   Load Distribution
 ;
 ;     XPDENV = 0 Environment Check during Load
 ;
 ;       Check Version (2.0)
 I $$VERSION^XPDUTL("LEX")'="2.0" D  D ABRT Q
 . D ET("Version 2.0 not found.  Please install Lexicon Utility v 2.0")
 N LEXOK,LEXG,LEXR,LEXB
 ;       Check Required Patches
 K LEXE D:$O(LEXREQP(0))'>0 IMP I $O(LEXREQP(0))>0 D
 . W ! N LEXPAT,LEXI,LEXPN,LEXP,LEXR,LEXC,LEXO,LEXC1,LEXC2,LEXC3,LEXC4,LEX
 . S (LEXR,LEXC)=0 S LEXC1=3,LEXC2=24,LEXC3=37,LEXC4=50
 . S LEXI=0  F  S LEXI=$O(LEXREQP(LEXI)) Q:+LEXI'>0  D
 . . S LEXC=LEXC+1,LEXPAT=$G(LEXREQP(LEXI))
 . S LEXI=0  F  S LEXI=$O(LEXREQP(LEXI)) Q:+LEXI'>0  D
 . . N LEXPAT,LEXREL,LEXINS,LEXCOM,LEXINE,LEXREQ,LEXTX S LEXREQ=$G(LEXREQP(LEXI))
 . . S LEXPAT=$P(LEXREQ,"^",1),LEXREL=$P(LEXREQ,"^",2),LEXCOM=$P(LEXREQ,"^",3)
 . . S LEXPN=$$INS(LEXPAT) S LEXINS=$$INSD(LEXPAT),LEXINE=$P(LEXINS,"^",2)
 . . I LEXI=1 D
 . . . W !,?LEXC1,"Checking for ",!
 . . . W !,?LEXC1,"Patch",?LEXC2,"Released",?LEXC3,"Installed",?LEXC4,"Content"
 . . S LEXTX=$J(" ",LEXC1)_LEXPAT
 . . S LEXTX=LEXTX_$J(" ",(LEXC2-$L(LEXTX)))
 . . S:LEXREL?7N LEXTX=LEXTX_$P($$FMTE^XLFDT(LEXREL,"5DZ"),"@",1)
 . . S LEXTX=LEXTX_$J(" ",(LEXC3-$L(LEXTX)))
 . . I +LEXPN>0 D
 . . . S LEXO=+($G(LEXO))+1 S:$L($G(LEXINE)) LEXTX=LEXTX_LEXINE
 . . . S LEXTX=LEXTX_$J(" ",(LEXC4-$L(LEXTX)))
 . . . S:$L(LEXCOM) LEXTX=LEXTX_LEXCOM
 . . D M(LEXTX)
 . . I +LEXPN'>0 D
 . . . N LEXP S LEXP=$G(LEXPAT) S:LEXP[" SEQ"&($L($P(LEXP," SEQ",1))) LEXP=$P(LEXP," SEQ",1)
 . . . D ET((LEXP_" not found, please install "_LEXP_" before continuing"))
 . W:+($G(LEXO))'=LEXC !
 I $D(LEXE) D M(),ABRT Q
 I '$D(LEXFULL)&(+($G(XPDENV))'=1) D QUIT Q
 ;                    
 ;   Install Package(s)
 ;
 ;     XPDENV = 1 Environment Check during Install
 ;
 ;       Check Import Global Checksum 
 I +($G(XPDENV))=1 K LEXE D CS I $D(LEXE) D ABRT Q
 ;                    
 ;   Quit, Exit or Abort
 ;
QUIT ;     Quit   Passed Environment Check
 K LEXFULL D OK
 Q
EXIT ;     Exit   Failed Environment Check
 D:$D(LEXE) ED S XPDQUIT=2 K LEXE,LEXFULL Q
ABRT ;     Abort  Failed Environment Check, KILL the distribution
 D:$D(LEXE) ED S XPDABORT=1,XPDQUIT=1 S:$L($G(LEXBUILD)) XPDQUIT(LEXBUILD)=1
 K LEXE,LEXFULL
 Q
 ;
T1 ; Environment Check #1 (for testing only)
 K XPDENV D ENV
 Q
T2 ; Environment Check #2 (for testing only)
 N XPDENV S XPDENV=1 D ENV
 Q
 ;               
 ; Checks
 ;
INS(X) ;   Installed
 N LEX,LEXP,LEXV,LEXI,LEXS S LEX=$P($G(X)," ",1) I $L(LEX,"*")=3 S X=$$PATCH^XPDUTL(LEX) Q X
 S LEXP=$$PKG^XPDUTL(LEX),LEXV=$$VER^XPDUTL(LEX),LEXI=$$VERSION^XPDUTL(LEXP)
 Q:+LEXV>0&(LEXV=LEXI) 1
 Q 0
INSD(X)  ;   Installed on
 N DA,LEX,LEXDA,LEXE,LEXI,LEXMSG,LEXNS,LEXOUT,LEXPI,LEXPN,LEXSCR,LEXVI,LEXVD,LEXVI,LEXVR S LEX=$G(X)
 S LEXNS=$$PKG^XPDUTL(LEX),LEXVR=$$VER^XPDUTL(LEX),LEXPN=$P(X,"*",3)
 Q:'$L(LEXNS) ""  S LEXVR=+LEXVR Q:LEXVR'>0 ""  S LEXPN=+LEXPN S:LEXVR'["." LEXVR=LEXVR_".0"
 S LEXSCR="I $G(^DIC(9.4,+($G(Y)),""VERSION""))="""_LEXVR_""""
 D FIND^DIC(9.4,,.01,"O",LEXNS,10,"C",LEXSCR,,"LEXOUT","LEXMSG")
 S LEXPI=$G(LEXOUT("DILIST",2,1)) K LEXOUT,LEXMSG Q:+LEXPI'>0 ""  Q:'$D(@("^DIC(9.4,"_LEXPI_",22)")) ""
 K DA S DA(1)=LEXPI S LEXDA=$$IENS^DILF(.DA)
 D FIND^DIC(9.49,LEXDA,".01;1I;2I","O",LEXVR,10,"B",,,"LEXOUT","LEXMSG")
 S LEXVD=$G(LEXOUT("DILIST","ID",1,2)) I $E(LEXVD,1,7)?7N&(+LEXPN'>0) D  Q X
 . S X=$E(LEXVD,1,7)_"^"_$TR($$FMTE^XLFDT($E(LEXVD,1,7),"5DZ"),"@"," ")
 S:$E(LEXVD,1,7)'?7N LEXVD=$G(LEXOUT("DILIST","ID",1,1)) I $E(LEXVD,1,7)?7N&(+LEXPN'>0) D  Q X
 . S X=$E(LEXVD,1,7)_"^"_$TR($$FMTE^XLFDT($E(LEXVD,1,7),"5DZ"),"@"," ")
 Q:+LEXPN'>0 ""  S LEXVI=$G(LEXOUT("DILIST",2,1)) K LEXOUT,LEXMSG
 Q:+LEXVI'>0 ""  Q:'$D(@("^DIC(9.4,"_LEXPI_",22,"_LEXVI_",""PAH"")")) ""
 K DA S DA(2)=LEXPI,DA(1)=LEXVI S LEXDA=$$IENS^DILF(.DA)
 S LEXSCR="I $G(^DIC(9.4,"_LEXPI_",22,"_LEXVI_",""PAH"",+($G(Y)),0))[""SEQ #"""
 D FIND^DIC(9.4901,LEXDA,".01;.02I",,LEXPN,10,"B",LEXSCR,,"LEXOUT","LEXMSG")
 S LEXI=$G(LEXOUT("DILIST","ID",1,.02)) I '$L(LEXI) D
 . S LEXSCR="" D FIND^DIC(9.4901,LEXDA,".01;.02I",,LEXPN,10,"B",LEXSCR,,"LEXOUT","LEXMSG")
 . S LEXI=$G(LEXOUT("DILIST","ID",1,.02))
 Q:'$L(LEXI) ""  Q:$P(LEXI,".",1)'?7N ""  S LEXE=$TR($$FMTE^XLFDT(LEXI,"5DZ"),"@"," ")
 Q:'$L(LEXE) ""  S X=LEXI_"^"_LEXE
 Q X
 ;                    
 ;   Checksums
CHECKSUM ;     Checksum Check
 D CS I $D(LEXE) D ED Q
 D BM("  OK"),M(" ")
 Q
CS ;     Checksum for import global
 K LEXE D BM("   Running checksum routine on the ^LEXM import global, please wait")
 N LEXCK,LEXND,LEXV S LEXCK=+($G(^LEXM(0,"CHECKSUM")))
 S LEXND=+($G(^LEXM(0,"NODES"))),LEXV=+($$CV(LEXCK,LEXND))
 D:'$D(LEXE) M(" ") D:'$D(LEXE)&(LEXV>0) M("     Checksum is ok"),M(" ")
 D:LEXV=0 CM D:LEXV=-1 CW D:LEXV=-2 CU D:LEXV=-3 CF
 Q
CV(X,Y) ;     Checksum Verify for import global
 N LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR Q:'$D(^LEXM) 0
 D IMP I $G(^LEXM(0,"BUILD"))'=$G(LEXBUILD) Q -1
 N LEXCK,LEXND,LEXCNT,LEXLC,LEXL,LEXS,LEXNC,LEXD,LEXN,LEXC,LEXGCS,LEXP,LEXT
 S LEXCK=+($G(X)),LEXND=+($G(Y))
 Q:LEXCK'>0!(LEXND'>0) -2
 S LEXL=64,(LEXCNT,LEXLC)=0,LEXS=(+(LEXND\LEXL))
 S:LEXS=0 LEXS=1 D:+($O(^LEXM(0)))>0 M("")
 S (LEXC,LEXN)="^LEXM",(LEXNC,LEXGCS)=0 W "   "
 F  S LEXN=$Q(@LEXN) Q:LEXN=""!(LEXN'[LEXC)  D
 . Q:LEXN="^LEXM(0,""CHECKSUM"")"
 . Q:LEXN="^LEXM(0,""NODES"")"
 . S LEXCNT=LEXCNT+1
 . I LEXCNT'<LEXS S LEXLC=LEXLC+1 W:LEXLC'>LEXL "." S LEXCNT=0
 . S LEXNC=LEXNC+1,LEXD=@LEXN,LEXT=LEXN_"="_LEXD
 . F LEXP=1:1:$L(LEXT) S LEXGCS=$A(LEXT,LEXP)*LEXP+LEXGCS
 Q:LEXNC'=LEXND -3
 Q:LEXGCS'=LEXCK -3
 Q 1
CM ;     Checksum Error - Missing ^LEXM
 N LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR D IMP D ET("Missing import global ^LEXM.") D CO
 Q
CW ;     Checksum Error - Wrong ^LEXM
 N LEXB,LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR D IMP S LEXB=$G(^LEXM(0,"BUILD"))
 I $L(LEXBUILD),$L(LEXB),LEXBUILD'=LEXB D  Q
 . D ET(("Incorrect import global ^LEXM found ("_LEXB_" global).")) D CKO
 D ET("Incorrect import global ^LEXM found.") D CKO
 Q
CU ;     Checksum Error - Unable to verify
 N LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR D IMP D ET(""),ET("Unable to verify checksum for import global ^LEXM (possibly corrupt).") D CKO
 Q
CF ;     Checksum Error - Failed checksum
 N LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR D IMP D ET("") D ET("Import global ^LEXM failed checksum.") D CKO
 Q
CO ;     Checksum Failure Fix - Obtain new global
 N LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR D IMP
 D ET(""),ET("    Please obtain a copy of the import global ^LEXM contained in the ")
 D ET(("    global host file "_LEXIGHF_" before continuing with the "_LEXBUILD))
 D ET(("    installation."))
 Q
CKO ;     Checksum Failure Fix - Kill and Obtain new global
 N LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR D IMP D ET("")
 D ET(("    Use the entry point KALL^LEXXGI2 to safely KILL the existing "))
 D ET(("    import global ^LEXM from your system.  Then obtain a new copy"))
 D ET(("    of ^LEXM contained in the global host file "_LEXIGHF_" before"))
 D ET(("    continuing with the "_LEXBUILD_" installation."))
 Q
 ;
SY(X) ;   Check System variables
 Q:'$D(IO)!('$D(IOF))!('$D(IOM))!('$D(ION))!('$D(IOSL))!('$D(IOST)) 0
 Q 1
UR(X) ;   Check User variables
 Q:'$L($G(DUZ(0))) 0
 Q:+($G(DUZ))=0!($$NOTDEF(+$G(DUZ))) 0
 Q 1
 ;               
 ; Error messages
 ;
ET(X) ;   Error Text
 N LEXI S LEXI=+($G(LEXE(0))),LEXI=LEXI+1,LEXE(LEXI)="   "_$G(X),LEXE(0)=LEXI
 Q
ED ;   Error Display
 N LEXI S LEXI=0 F  S LEXI=$O(LEXE(LEXI)) Q:+LEXI=0  D M(LEXE(LEXI))
 D M(" ") K LEXE Q
 ;                   
 ; Miscellaneous 
 ;
NOTDEF(IEN) ;   Check to see if user is defined
 N DA,DR,DIQ,LEX,DIC S DA=IEN,DR=.01,DIC=200,DIQ="LEX" D EN^DIQ1 Q '$D(LEX)
OK ;   Environment is OK
 N LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXT
 D IMP S LEXT="  Environment "_$S($L(LEXBUILD):("for patch/build "_LEXBUILD_" "),1:"")_"is ok"
 D BM(LEXT),M(" ")
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
 ;S LEXPTYPE="Code Set SDM Ticket Fixes"
 S LEXPTYPE="Code Set Update"
 ;     Revision
 S LEXLREV=117
 ;     Required Builds Array
 ;        LEX(1)=build SEQ #^released date^subject
 ;        LEX(n)=build SEQ #^released date^subject
 S LEXREQP(1)="LEX*2.0*116 SEQ #107^3171227^Code Set FY18 2nd Qtr"
 ;     This Build Name
 S LEXBUILD="LEX*2.0*117"
 ;     This Build's Export Global Host Filename
 S LEXIGHF="LEX_2_117.GBL"
 ;     Fiscal Year
 S LEXFY="FY18"
 ;     Quarter
 S LEXQTR="3rd"
 Q
