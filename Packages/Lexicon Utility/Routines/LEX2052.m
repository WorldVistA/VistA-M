LEX2052 ;ISL/KER - LEX*2.0*52 Environment Check ;08/18/2007
 ;;2.0;LEXICON UTILITY;**52**;Sep 23, 1996;Build 25
 ;            
 ; Global Variables
 ;    None
 ;            
 ; External References
 ;    EN^DIQ1          DBIA  10015
 ;    $$PATCH^XPDUTL   DBIA  10141
 ;    $$VERSION^XPDUTL DBIA  10141
 ;    BMES^XPDUTL      DBIA  10141
 ;    MES^XPDUTL       DBIA  10141
 ;            
 ; Variables NEWed or KILLed elsewhere
 ;    XPDABORT         Kernel Systems Manual pg 454
 ;    XPDQUIT          Kernel Systems Manual pg 454
 ;            
 ; Special Variables
 ;    XPDDIQ("XPZ1")   Kernel Systems Manual pg 456
 ;    XPDDIQ("XPI1")   FORUM Message #45828644
 ;            
ENV ; LEX*2.0*52 Environment Check
 ;                    
 ;   General
 ;
 N LEXPTYPE,LEXLREV,LEXREQP,LEXBLDS,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXG,LEXE,LEXSTR D IMP
 K XPDDIQ("XPZ1","B"),XPDDIQ("XPI1","B") S XPDDIQ("XPZ1","B")="NO",XPDDIQ("XPI1","B")="NO"
 S LEXSTR=$G(LEXPTYPE) S:$L($G(LEXFY))&($L($G(LEXQTR))) LEXSTR=LEXSTR_" for "_$G(LEXFY)_" "_$G(LEXQTR)_" Quarter"
 D BM(LEXSTR),M("")
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
 ;
 ;       Check Required Patches
 D:'$L($G(LEXREQP)) IMP I $L(LEXREQP) D
 . N LEXPAT,LEXI,LEXPN
 . F LEXI=1:1 Q:'$L($P(LEXREQP,";",LEXI))  S LEXPAT=$P(LEXREQP,";",LEXI) D
 . . S LEXPN=$$PATCH^XPDUTL(LEXPAT) W !,"   Checking for ",LEXPAT H 1 W:+LEXPN>0 ?31,"  installed" W:+LEXPN'>0 ?31,"  missing"
 . . I +LEXPN'>0 D ET((LEXPAT_" not found, please install "_LEXPAT_" before continuing"))
 I $D(LEXE) D ABRT Q
QUIT ;     Quit   Passed Environment Check
 K LEXFULL D OK
 Q
EXIT ;     Exit   Failed Environment Check
 D:$D(LEXE) ED S XPDQUIT=2 K LEXE,LEXFULL Q
ABRT ;     Abort  Failed Environment Check, KILL the distribution
 D:$D(LEXE) ED S XPDABORT=1,XPDQUIT=1
 S (XPDQUIT("LEX*2.0*52"),XPDQUIT("ICPT*6.0*37"))=1
 K LEXE,LEXFULL
 Q
 ;               
 ; Checks
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
 N LEXI S LEXI=+($G(LEXE(0))),LEXI=LEXI+1,LEXE(LEXI)="    "_$G(X),LEXE(0)=LEXI
 Q
ED ;   Error Display
 N LEXI,LEXC S (LEXI,LEXC)=0 F  S LEXI=$O(LEXE(LEXI)) Q:+LEXI=0  S LEXC=LEXC+1 D:LEXC=1 M("  ") D M(LEXE(LEXI))
 D M(" ") K LEXE Q
 ;                   
 ; Miscellaneous
 ;
NOTDEF(IEN) ;   Check to see if user is defined
 N DA,DR,DIQ,LEX,DIC S DA=IEN,DR=.01,DIC=200,DIQ="LEX" D EN^DIQ1 Q '$D(LEX)
OK ;   Environment is OK
 N LEXPTYPE,LEXLREV,LEXREQP,LEXBLDS,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXT
 D IMP S LEXT="  Environment "_$S($L(LEXBLDS):("for patch/build "_LEXBLDS_" "),1:"")_"is ok"
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
IMP ;   Import names
 ;     Patch Type
 S LEXPTYPE="Lexicon/CPT Remedy Ticket Fixes"
 ;     Revision
 S LEXLREV="52"
 ;     Required Builds
 S LEXREQP="LEX*2.0*50"
 ;     This Build Name
 S LEXBLDS="LEX*2.0*52/ICPT*6.0*37",LEXBUILD=$P(LEXBLDS,"/",1)
 ;     This Build's Export Global Host Filename
 S LEXIGHF=""
 ;     Fiscal Year
 S LEXFY=""
 ;     Quarter
 S LEXQTR=""
 Q
