LEX2042 ; ISL/KER - Environment Check/Pre/Post Install ; 04/06/2006
 ;;2.0;LEXICON UTILITY;**42**;Sep 23, 1996
 ;                     
 ; External References
 ;   DBIA 10015  EN^DIQ1
 ;   DBIA 10141  $$PATCH^XPDUTL
 ;   DBIA 10141  $$VERSION^XPDUTL
 ;   DBIA 10141  BMES^XPDUTL
 ;   DBIA 10141  MES^XPDUTL
 ;                            
ENV ; LEX*2.0*42 Environment Check
 ;                    
 ;   General
 W !," Code Set Update for FY06 4th Quarter",!
 ;
 N LEXBUILD,LEXIGHF,LEXREQP,LEXLREV,LEXG,LEXE
 D IMP S U="^"
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
 ;
 ;       Check Required Patches
 D:'$L($G(LEXREQP)) IMP I $L(LEXREQP) D
 . N LEXPAT,LEXI,LEXPN
 . F LEXI=1:1 Q:'$L($P(LEXREQP,";",LEXI))  S LEXPAT=$P(LEXREQP,";",LEXI) D
 . . S LEXPN=$$PATCH^XPDUTL(LEXPAT) W !,"   Checking for ",LEXPAT I +LEXPN>0 H 1 W " - installed"
 . . I +LEXPN'>0 D ET((LEXPAT_" not found, please install "_LEXPAT_" before continuing"))
 I $D(LEXE) D ABRT Q
 S LEXG=$$RGBL
 I $D(LEXE)&(+LEXG=0) D ABRT Q
 I $D(LEXE)&(+LEXG<0) D ABRT Q
 I '$D(LEXFULL)&(+($G(XPDENV))'=1) D QUIT Q
 ;                    
 ;   Install Package(s)
 ;
 ;     XPDENV = 1 Environment Check during Install
 ;
 ;       Check Data "is installed" or "is translated"
 N LEXIT S LEXIT=+($$CPD) I '$D(LEXFULL)&(LEXIT) D QUIT Q
 ;       Checking Global "Write" Protection 
 D:+($G(XPDENV))=1 GBLS I $D(LEXE) D ABRT Q
 ;       Check Import Global Checksum 
 D:+($G(XPDENV))=1 CS I $D(LEXE) D ABRT Q
 ;                    
 ;   Quit, Exit or Abort
 ;
QUIT ;     Quit   Passed Environment Check
 K LEXFULL D OK
 Q
EXIT ;     Exit   Failed Environment Check
 D:$D(LEXE) ED S XPDQUIT=2 K LEXE,LEXFULL Q
ABRT ;     Abort  Failed Environment Check, KILL the distribution
 D:$D(LEXE) ED S XPDABORT=1,XPDQUIT=1,XPDQUIT("LEX*2.0*42")=1
 S XPDQUIT("ICD*18.0*12")=1,XPDQUIT("ICPT*6.0*19")=1
 S XPDQUIT("CTD UTIL 1.0")=1 K LEXE,LEXFULL
 Q
 ;               
 ; Checks
 ;
GBLS ;   Check Write access on globals
 N LEXE,LEXGBL,LEXRT,LEXT,LEXF,LEXI,LEXX,LEXOK,LEXCPD,LEXS,X S LEXOK=1
 D BM("   I will now check the protection on ^LEX, ^ICPT, ^ICD and ^DIC Globals.")
 D M("   If you get an ERROR, you will need to change the protection on these")
 D M("   globals to allow read/write as indicated:")
 D BM("                        Owner     Group    World   Network")
 D M("      Cache systems      RWD       RW       RW      RWD")
 D BM("   Checking:"),M(" ")
 S LEXCPD=$$CPD,LEXS="",X=1 F LEXI=1:1 D  Q:'$L(LEXX)
 . S LEXX="" S LEXE="S LEXX=$T(GD+"_LEXI_")" X LEXE S LEXX=$$TRIM(LEXX) Q:'$L(LEXX)  Q:'$L($TR(LEXX,";",""))
 . S LEXGBL=$P(LEXX,";",3) Q:+LEXCPD>0&(LEXGBL="^LEXM(0)")  S LEXRT=$P(LEXX,";",4),LEXT=$P(LEXX,";",5),LEXF=$P(LEXX,";",6)
 . S (LEXB1,LEXB2)="",$P(LEXB1," ",(19-$L(LEXRT)))="",$P(LEXB2," ",(28-$L(LEXT)))=""
 . I '$D(@LEXGBL) D RGNF S LEXOK=0 D M(("      <"_LEXRT_" not found>")) Q
 . D M(("      "_LEXRT_LEXB1_LEXT_LEXB2_LEXF)) S @LEXGBL=$G(@LEXGBL) H 1
 D:LEXOK M("    --> ok") D:'LEXOK M("    ??") D M(" ")
 Q
RGBL(X) ;   Check Write access on globals
 N LEXCPD,LEXS,LEXI,LEXX,LEXEC,LEXGBL,LEXRT,LEXT,LEXF,LEXB1,LEXB2
 S LEXCPD=$$CPD,LEXS="",X=1 F LEXI=1:1 D  Q:'$L(LEXX)
 . S LEXX="" S LEXEC="S LEXX=$T(GD+"_LEXI_")" X LEXEC S LEXX=$$TRIM(LEXX) Q:'$L(LEXX)  Q:'$L($TR(LEXX,";",""))
 . S LEXGBL=$P(LEXX,";",3) Q:+LEXCPD>0&(LEXGBL="^LEXM(0)")  S LEXRT=$P(LEXX,";",4),LEXT=$P(LEXX,";",5),LEXF=$P(LEXX,";",6)
 . S (LEXB1,LEXB2)="",$P(LEXB1," ",(15-$L(LEXRT)))="",$P(LEXB2," ",(28-$L(LEXT)))=""
 . I '$D(@LEXGBL) S:LEXS'[LEXRT LEXS=LEXS_", "_LEXRT S X=-1 S:LEXGBL["LEXM("&(X=1) X=0
 I $L(LEXS),X'>0 D
 . S:LEXS[", " LEXS=$P(LEXS,", ",1,($L(LEXS,", ")-1))_" and "_$P(LEXS,", ",$L(LEXS,", "))
 . S:$E(LEXS,1,2)=", " LEXS=$E(LEXS,3,$L(LEXS)) S:$E(LEXS,1,7)[" and " LEXS=$P(LEXS," and ",2)
 . D:X=-1 ET(("Global"_$S(LEXS[", "!(LEXS[" and "):"s",1:"")_" "_LEXS_" either not found or incomplete."))
 . D:X=0 CM
 Q X
RGNF ;   Required global not found
 N LEXLREV,LEXREQP,LEXBUILD,LEXIGHF D IMP
 D:$G(LEXGL)["^LEX"&($G(LEXGL)'["^LEXM") ET(""),ET("Required global "_$P($G(LEXGL),"(",1)_" not found.")
 D:$G(LEXGL)["^LEX"&($G(LEXGL)["^LEXM") CM
 Q
CHK ;   Check the Checksum
 D CS I $D(LEXE) D ED Q
 D BM("  OK"),M(" ")
 Q
CS ;   Checksum for import global
 K LEXE
 D BM("   Running checksum routine on the ^LEXM import global, please wait")
 N LEXCHK,LEXNDS,LEXVER S LEXCHK=+($G(^LEXM(0,"CHECKSUM")))
 S LEXNDS=+($G(^LEXM(0,"NODES"))),LEXVER=+($$VC(LEXCHK,LEXNDS))
 D M(" ") D:LEXVER>0 M("     Checksum is ok"),M(" ")
 D:LEXVER=0 CM D:LEXVER=-1 CW D:LEXVER=-2 CU D:LEXVER=-3 CF
 Q
VC(X,Y) ;   Verify Checksum for import global
 N LEXLREV,LEXREQP,LEXBUILD,LEXIGHF Q:'$D(^LEXM) 0
 D IMP I $G(^LEXM(0,"BUILD"))'=$G(LEXBUILD) Q -1
 N LEXCHK,LEXNDS,LEXCNT,LEXLC,LEXL,LEXS,LEXNC,LEXD,LEXN,LEXC,LEXGCS,LEXP,LEXT
 S LEXCHK=+($G(X)),LEXNDS=+($G(Y))
 Q:LEXCHK'>0!(LEXNDS'>0) -2
 S LEXL=64,(LEXCNT,LEXLC)=0,LEXS=(+(LEXNDS\LEXL))
 S:LEXS=0 LEXS=1 D:+($O(^LEXM(0)))>0 M("")
 S (LEXC,LEXN)="^LEXM",(LEXNC,LEXGCS)=0 W "   "
 F  S LEXN=$Q(@LEXN) Q:LEXN=""!(LEXN'[LEXC)  D
 . Q:LEXN="^LEXM(0,""CHECKSUM"")"
 . Q:LEXN="^LEXM(0,""NODES"")"
 . S LEXCNT=LEXCNT+1
 . I LEXCNT'<LEXS S LEXLC=LEXLC+1 W:LEXLC'>LEXL "." S LEXCNT=0
 . S LEXNC=LEXNC+1,LEXD=@LEXN,LEXT=LEXN_"="_LEXD
 . F LEXP=1:1:$L(LEXT) S LEXGCS=$A(LEXT,LEXP)*LEXP+LEXGCS
 Q:LEXNC'=LEXNDS -3
 Q:LEXGCS'=LEXCHK -3
 Q 1
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
CM ;   Missing ^LEXM
 N LEXLREV,LEXREQP,LEXBUILD,LEXIGHF D IMP D ET(""),ET("Missing import global ^LEXM.") D CO
 Q
CW ;   Wrong ^LEXM
 N LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXB D IMP S LEXB=$G(^LEXM(0,"BUILD")) D ET("")
 I $L(LEXBUILD),$L(LEXB),LEXBUILD'=LEXB D  Q
 . D ET(("Incorrect import global ^LEXM found ("_LEXB_" global).")) D CKO
 D ET("Incorrect import global ^LEXM found.") D CKO
 Q
CU ;   Unable to verify
 N LEXLREV,LEXREQP,LEXBUILD,LEXIGHF D IMP D ET(""),ET("Unable to verify checksum for import global ^LEXM (possibly corrupt).") D CKO
 Q
CF ;   Failed checksum
 N LEXLREV,LEXREQP,LEXBUILD,LEXIGHF D IMP D ET("") D ET("Import global ^LEXM failed checksum.") D CKO
 Q
CO ;   Obtain new global
 N LEXLREV,LEXREQP,LEXBUILD,LEXIGHF D IMP
 D ET(""),ET("    Please obtain a copy of the import global ^LEXM contained in the ")
 D ET(("    global host file "_LEXIGHF_" before continuing with the "_LEXBUILD))
 D ET(("    installation."))
 Q
CKO ;   Kill and Obtain new global
 N LEXLREV,LEXREQP,LEXBUILD,LEXIGHF D IMP
 D ET(""),ET("    Please KILL the existing import global ^LEXM from your system")
 D ET(("    and obtain a new copy of ^LEXM contained in the global host file"))
 D ET(("    "_LEXIGHF_" before continuing with the "_LEXBUILD_" installation."))
 Q
ET(X) ;   Error Text
 N LEXI S LEXI=+($G(LEXE(0))),LEXI=LEXI+1,LEXE(LEXI)="    "_$G(X),LEXE(0)=LEXI
 Q
ED ;   Error Display
 N LEXI S LEXI=0 F  S LEXI=$O(LEXE(LEXI)) Q:+LEXI=0  D M(LEXE(LEXI))
 D M(" ") K LEXE Q
 ;                   
 ; Miscellaneous
 ;
IMP ;   Import names
 S LEXLREV=42,LEXREQP="LEX*2.0*44",LEXBUILD="LEX*2.0*42"
 S LEXIGHF="LEX_2_42.GBL"
 Q
NOTDEF(IEN) ;   Check to see if user is defined
 N DA,DR,DIQ,LEX,DIC S DA=IEN,DR=.01,DIC=200,DIQ="LEX" D EN^DIQ1 Q '$D(LEX)
OK ;   Environment is OK
 N LEXBUILD,LEXIGHF,LEXREQP,LEXLREV,LEXT
 D IMP S LEXT="  Environment "_$S($L(LEXBUILD):("for patch/build "_LEXBUILD_" "),1:"")_"is ok"
 D BM(LEXT),M(" ")
 Q
BM(X) ;   Blank Line with Message
 D BMES^XPDUTL($G(X)) Q
M(X) ;   Message
 D MES^XPDUTL($G(X)) Q
TRIM(X) ;   Trim Spaces
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
EF ;   Exported Files
 ;;^LEX(757.01);^LEX(*;Lexicon;757-757.41
 ;;^LEXT(757.2);^LEXT(757.2);Lexicon Subsets/Defaults;757.2
 ;;^LEXC(757.9);^LEXC(*;Lexicon Change File;757.9-757.91
 ;;^LEXM(0);^LEXM(*;Lexicon Export/Import;No File #
 ;;^ICPT(0);^ICPT(;CPT/HCPCS;81
 ;;^DIC(81.1,0);^DIC(81.1);CPT Category;81.1
 ;;^DIC(81.2,0);^DIC(81.2);CPT Copyright;81.2
 ;;^DIC(81.3,0);^DIC(81.3);CPT Modifier;81.3
 ;;^ICD9(0);^ICD9(;ICD Diagnosis;80
 ;;^ICD0(0);^ICD0(;ICD Operation/Procedure;80.1
 ;;^ICD(0);^ICD(;DRG Grouper;80.2
 ;;^ICM(0);^ICM(;MAJOR DIAGNOSTIC CATEGORY;80.3
 ;;^ICD9(0);^ICD9(;ICD Diagnosis;80
 ;;^DIC(81.3,0);^DIC(81.3);CPT Modifier;81.3
 Q
GD ;   Global Data
 ;;^LEX(757.01);^LEX(*;Lexicon;757-757.41
 ;;^ICPT(0);^ICPT(;CPT/HCPCS;81
