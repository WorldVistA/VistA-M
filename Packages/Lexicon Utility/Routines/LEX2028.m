LEX2028 ;ISL/KER - Environment Check/Pre/Post Install ; 01/01/2004
 ;;2.0;LEXICON UTILITY;**28**;Sep 23, 1996
 ;
 ; External References
 ;   DBIA 10141  $$PATCH^XPDUTL
 ;   DBIA 10141  $$VERSION^XPDUTL
 ;   DBIA 10141  BMES^XPDUTL
 ;   DBIA 10141  MES^XPDUTL
 ;   DBIA 10015  EN^DIQ1
 ;                            
ENV ; LEX*2.0*28 Environment Check
 ;           
 ;   General
 ;
 N LEXBUILD,LEXIGHF,LEXLAST,LEXLREV,LEXG
 D IMP S U="^"
 ;     No user
 I '$$UR D ET("User not defined (DUZ)")
 ;     No IO
 D:'$$SY ET("Undefined IO variable(s)") I $D(LEXE) D ABRT Q
 ;                
 ;   Load Distribution
 ;
 ;     Not version 2.0
 I $$VERSION^XPDUTL("LEX")'="2.0" D  D ABRT Q
 . D ET("Version 2.0 not found.  Please install Lexicon Utility v 2.0")
 I $D(LEXE) D ABRT Q
 ;     Missing last data patch
 D:'$L($G(LEXLAST)) IMP I $L(LEXLAST) D
 . N LEXPN S LEXPN=$$PATCH^XPDUTL(LEXLAST)
 . I 'LEXPN D ET((LEXLAST_" not found, please install "_LEXLAST_" before continuing"))
 I $D(LEXE) D ABRT Q
 S LEXG=$$RGBL
 I $D(LEXE)&(+LEXG=0) D ABRT Q
 I $D(LEXE)&(+LEXG<0) D ABRT Q
 I '$D(LEXFULL)&(+($G(XPDENV))'=1) D QUIT Q
 ;                
 ;   Install Package(s)
 ;
 ;     Check Data "is installed" or "is translated"
 N LEXIT S LEXIT=+($$CPD) I '$D(LEXFULL)&(LEXIT) D QUIT Q
 ;     Checking Global "Write" Protection during install
 D:+($G(XPDENV))=1 GBLS I $D(LEXE) D ABRT Q
 ;     Import Global Checksum during install
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
 D:$D(LEXE) ED S XPDABORT=1,XPDQUIT=1,XPDQUIT("LEX*2.0*28")=1
 K LEXE,LEXFULL
 Q
 ;               
 ; Checks
 ;
GBLS ;   Check Write access on globals
 N LEXOK S LEXOK=1
 D BM("I will now check the protection on ^LEX, ^LEXT, ^LEXC and ^LEXM Globals.")
 D M("If you get an ERROR, you will need to change the protection on these")
 D M("globals to allow read/write as indicated for the appropriate M system:")
 D BM("                      System    World    Group    UCI")
 D M("    DSM for OpenVMS    RWP       RW       RW      RW")
 D BM("                      System    World    Group    User")
 D M("    MSM-DOS            RWD       RWD      RWD     RWD")
 D BM("                      Owner     Group    World   Network")
 D M("    Cache systems      RWD       RW       RW      RWD")
 D BM("Checking:") N LEXGL,LEXRT
 F LEXGL="^LEX(757.01)","^LEXT(757.2)","^LEXC","^LEXM(0)","^ICD9(0)","^ICD0(0)","^ICPT(0)","^DIC(81.3,0)" D  Q:'LEXOK
 . S LEXRT=$P(LEXGL,"(",1) S:LEXRT["DIC" LEXRT="^DIC(81.3)" S:LEXRT["LEXT" LEXRT="^LEXT(757.2)" S:"^^LEX^^LEXC^^LEXM^^"[("^"_LEXRT_"^") LEXRT=LEXRT_"(*" S:"^^ICD9^^ICD0^^ICPT^^"[("^"_LEXRT_"^") LEXRT=LEXRT_"("
 . I '$D(@LEXGL) D RGNF S LEXOK=0 D  Q
 . . D M(("    <"_LEXRT_" not found>"))
 . D M(("    "_LEXRT)) S @LEXGL=$G(@LEXGL) H 1
 D:LEXOK M("    --> ok") D:'LEXOK M("    ??") D M(" ")
 Q
RGBL(X) ; Look for require globals
 N LEXLREV,LEXLAST,LEXBUILD,LEXIGHF,LEXGL,LEX0,LEXS S LEXS="",X=1
 F LEXGL="^ICD9(0)","^ICD0(0)","^ICPT(0)","^DIC(81.3,0)","^LEX(757,0)","^LEXT(757.2,0)","^LEXM(0)" D
 . I +($$CPD)>0,LEXGL["LEXM" Q
 . N LEXRT S LEXRT=$P(LEXGL,"(",1)
 . S:LEXRT["DIC" LEXRT="^DIC(81.3)"
 . S:LEXRT["LEXT" LEXRT="^LEXT(757.2)"
 . S:"^^LEX^^LEXC^^LEXM^^"[("^"_LEXRT_"^") LEXRT=LEXRT_"(*" S:"^^ICD9^^ICD0^^ICPT^^"[("^"_LEXRT_"^") LEXRT=LEXRT_"("
 . I '$D(@LEXGL) D
 . . S:LEXS'[LEXRT LEXS=LEXS_", "_LEXRT
 . . S X=-1 S:LEXGL["LEXM("&(X=1) X=0
 . I LEXGL'["^LEXC" S LEX0=$G(@LEXGL) I $L(LEX0,"^")'=4 D
 . . S:LEXS'[LEXRT LEXS=LEXS_", "_LEXRT
 . . S:LEXGL["X("!((LEXGL["T(")) X=-1 S:LEXGL["M("&(X=1) X=0
 I $L(LEXS),X'>0 D
 . S:LEXS[", " LEXS=$P(LEXS,", ",1,($L(LEXS,", ")-1))_" and "_$P(LEXS,", ",$L(LEXS,", "))
 . S:$E(LEXS,1,2)=", " LEXS=$E(LEXS,3,$L(LEXS))
 . S:$E(LEXS,1,7)[" and " LEXS=$P(LEXS," and ",2)
 . I X=-1,LEXS="^LEXC(*" D  Q
 . . D ET("Global ^LEXC not found, please create this global and set protection")
 . D:X=-1 ET(("Global"_$S(LEXS[", "!(LEXS[" and "):"s",1:"")_" "_LEXS_" either not found or incomplete."))
 . D:X=0 CM
 Q X
RGNF ; Required global not found
 N LEXLREV,LEXLAST,LEXBUILD,LEXIGHF D IMP
 D:$G(LEXGL)["^LEX"&($G(LEXGL)'["^LEXM") ET(""),ET("Required global "_$P($G(LEXGL),"(",1)_" not found.")
 D:$G(LEXGL)["^LEX"&($G(LEXGL)["^LEXM") CM
 Q
CHK D CS I $D(LEXE) D ED Q
 D BM("  OK"),M(" ")
 Q
CS ;   Checksum for import global
 K LEXE
 D BM("Running checksum routine on the ^LEXM import global, please wait")
 N LEXCHK,LEXNDS,LEXVER S LEXCHK=+($G(^LEXM(0,"CHECKSUM")))
 S LEXNDS=+($G(^LEXM(0,"NODES"))),LEXVER=+($$VC(LEXCHK,LEXNDS))
 D M(" ") D:LEXVER>0 M("  ok"),M(" ")
 D:LEXVER=0 CM D:LEXVER=-1 CW D:LEXVER=-2 CU D:LEXVER=-3 CF
 Q
VC(X,Y) ;   Verify Checksum for import global
 N LEXLREV,LEXLAST,LEXBUILD,LEXIGHF Q:'$D(^LEXM) 0
 D IMP I $G(^LEXM(0,"BUILD"))'=$G(LEXBUILD) Q -1
 N LEXCHK,LEXNDS,LEXCNT,LEXLC,LEXL,LEXS,LEXNC,LEXD,LEXN,LEXC,LEXGCS,LEXP,LEXT
 S LEXCHK=+($G(X)),LEXNDS=+($G(Y))
 Q:LEXCHK'>0!(LEXNDS'>0) -2
 S LEXL=68,(LEXCNT,LEXLC)=0,LEXS=+(LEXNDS\LEXL)
 S:LEXS=0 LEXS=1 D:+($O(^LEXM(0)))>0 M("")
 S (LEXC,LEXN)="^LEXM",(LEXNC,LEXGCS)=0
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
 ;    Check Last Lexicon Set/Kill
 S:'$D(^LEX(757.1,"B",181426,258593)) INS=0
 S:$D(^LEX(757.02,"CODE","780.9 ",316332)) INS=0
 ;    Check Last CPT/HCPCS Procedures Set/Kill
 S:'$D(^ICPT("F","V2797",107622)) INS=0
 S:$D(^ICPT("D",187,104417)) INS=0
 ;    Check Last CPT Modifiers Set
 S:'$D(^DIC(81.3,"C","TWO PATIENTS SERVED",489)) INS=0
 S X=+($G(INS))
 Q X
LPD(X) ;   Check Last Patched Data
 S INS=1 S:'$D(^LEX(757.02,1,4,1,0)) INS=0 S:'$D(^ICD9("ACT")) INS=0 S:'$D(^ICD0("ACT")) INS=0
 S X=INS
 Q X
 ;
 ; Error messages
 ;
CM ;   Missing ^LEXM
 N LEXLREV,LEXLAST,LEXBUILD,LEXIGHF D IMP
 D ET(""),ET("Missing import global ^LEXM.") D CO
 Q
CW ;   Wrong ^LEXM
 N LEXLREV,LEXLAST,LEXBUILD,LEXIGHF,LEXB D IMP
 S LEXB=$G(^LEXM(0,"BUILD")) D ET("")
 I $L(LEXBUILD),$L(LEXB),LEXBUILD'=LEXB D  Q
 . D ET(("Incorrect import global ^LEXM found ("_LEXB_" global)."))
 . D CKO
 D ET("Incorrect import global ^LEXM found.") D CKO
 Q
CU ;   Unable to verify
 N LEXLREV,LEXLAST,LEXBUILD,LEXIGHF D IMP
 D ET(""),ET("Unable to verify checksum for import global ^LEXM (possibly corrupt).") D CKO
 Q
CF ;   Failed checksum
 N LEXLREV,LEXLAST,LEXBUILD,LEXIGHF D IMP D ET("")
 D ET("Import global ^LEXM failed checksum.") D CKO
 Q
CO ;   Obtain new global
 N LEXLREV,LEXLAST,LEXBUILD,LEXIGHF D IMP
 D ET(""),ET("    Please obtain a copy of the import global ^LEXM contained in the ")
 D ET(("    global host file "_LEXIGHF_" before continuing with the "_LEXBUILD))
 D ET(("    installation."))
 Q
CKO ;   Kill and Obtain new global
 N LEXLREV,LEXLAST,LEXBUILD,LEXIGHF D IMP
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
 S LEXLREV=16,LEXLAST="LEX*2.0*25",LEXBUILD="LEX*2.0*28"
 S LEXIGHF="LEX_2_28.GBL"
 Q
NOTDEF(IEN) ; check to see if user is defined
 N DA,DR,DIQ,LEX,DIC S DA=IEN,DR=.01,DIC=200,DIQ="LEX" D EN^DIQ1 Q '$D(LEX)
OK ;
 N LEXBUILD,LEXIGHF,LEXLAST,LEXLREV,LEXT
 D IMP S LEXT="  Environment "_$S($L(LEXBUILD):("for patch/build "_LEXBUILD_" "),1:"")_"is ok"
 D BM(LEXT),M(" ")
 Q
BM(X) ;   Blank Line with Message
 S X=" "_$G(X) Q:$D(LEXQT)  D:$D(XPDNM) BMES^XPDUTL($G(X)) W:'$D(XPDNM) !!,$G(X) Q
M(X) ;   Message
 S X=" "_$G(X) Q:$D(LEXQT)  D:$D(XPDNM) MES^XPDUTL($G(X)) W:'$D(XPDNM) !,$G(X) Q
