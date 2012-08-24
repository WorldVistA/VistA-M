LEX2081 ;ISL/KER - LEX*2.0*81 Env Check ;08/17/2011
 ;;2.0;LEXICON UTILITY;**81**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    DESC^%ZTLOAD        ICR  10063
 ;    STAT^%ZTLOAD        ICR  10063
 ;    FIND^DIC            ICR   2051
 ;    $$IENS^DILF         ICR   2054
 ;    EN^DIQ1             ICR  10015
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$PATCH^XPDUTL      ICR  10141
 ;    $$VERSION^XPDUTL    ICR  10141
 ;    BMES^XPDUTL         ICR  10141
 ;    MES^XPDUTL          ICR  10141
 ;               
 ; Local Variables Killed by Kernel after Install
 ;     XPDABORT,XPDDIQ,XPDQUIT
 ;               
 ; see Kernel Developer Guide
 ;     Chapter 14, KIDS Developer Tools
 ;     Advanced Build Techniques
 ;               
ENV ; Environment Check
 ;                    
 ;   General
 ;
 N LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXG,LEXE,LEXSTR D IMP
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
 ;       Check Required Patches
 D:'$L($G(LEXREQP)) IMP I $L(LEXREQP) D
 . N LEXPAT,LEXI,LEXPN,LEXP,LEXR,LEXC,LEXO,LEXC1,LEXC2,LEXC3 S (LEXR,LEXC)=0 S LEXC1=5,(LEXC2,LEXC3)=20
 . F LEXI=1:1 Q:'$L($P(LEXREQP,";",LEXI))  S LEXC=LEXC+1,LEXPAT=$P(LEXREQP,";",LEXI) S:$P(LEXPAT,"^",2)?7N LEXR=LEXR+1,LEXC3=LEXC2+13
 . F LEXI=1:1 Q:'$L($P(LEXREQP,";",LEXI))  S LEXPAT=$P(LEXREQP,";",LEXI) D
 . . N LEXREL,LEXINS,LEXINE S LEXREL=$P(LEXPAT,"^",2),LEXPAT=$P(LEXPAT,"^",1)
 . . S LEXPN=$$PATCH^XPDUTL(LEXPAT),LEXINS=$$INS(LEXPAT),LEXINE=$P(LEXINS,"^",2)
 . . W:LEXI=1 !,?3,"Checking for ",?LEXC2,$S(+($G(LEXR))>0:"Released",1:"")
 . . W !,?LEXC1,LEXPAT
 . . I LEXREL?7N W ?LEXC2,$TR($$FMTE^XLFDT(LEXREL,"5DZ"),"@"," ")
 . . I +LEXPN>0 H 1 S LEXO=+($G(LEXO))+1 W ?LEXC3,"Installed " W:$L($G(LEXINE)) LEXINE
 . . I +LEXPN'>0 D ET((" "_LEXPAT_" not found, please install "_LEXPAT_" before continuing"))
 . W:+($G(LEXO))'=LEXC !
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
 N LEXIT S LEXIT=0
 ;       Checking Previous Install Task
 D:+($G(XPDENV))=1 TASK I $D(LEXE) D ABRT Q
 ;       Checking Global "Write" Protection 
 D:+($G(XPDENV))=1 GBLS I $D(LEXE) D ABRT Q
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
ENV2 ; Environment Check (for testing only)
 N XPDENV S XPDENV=1 D ENV
 Q
 ;               
 ; Checks
 ;
GBLS ;   Check Write access on globals
 N LEXB1,LEXB2,LEXE,LEXGBL,LEXRT,LEXT,LEXF,LEXI,LEXX,LEXOK,LEXS,X S LEXOK=1
 D BM("   I will now check the protection for the Lexicon global ^LEX.  If you")
 D M("   get an ERROR, you will need to change the protection on this global")
 D M("   to allow read/write as indicated:")
 D BM("                        Owner     Group    World   Network")
 D M("      Cache systems      RWD       RW       RW      RWD")
 D BM("   Checking:"),M(" ")
 S LEXS="",X=1 F LEXI=1:1 D  Q:'$L(LEXX)
 . S LEXX="" S LEXE="S LEXX=$T(GD+"_LEXI_")" X LEXE S LEXX=$$TRIM(LEXX) Q:'$L(LEXX)  Q:'$L($TR(LEXX,";",""))
 . S LEXGBL=$P(LEXX,";",3) S LEXRT=$P(LEXX,";",4),LEXT=$P(LEXX,";",5),LEXF=$P(LEXX,";",6)
 . S (LEXB1,LEXB2)="",$P(LEXB1," ",(19-$L(LEXRT)))="",$P(LEXB2," ",(28-$L(LEXT)))=""
 . I '$D(@LEXGBL) D RGNF S LEXOK=0 D M(("      <"_LEXRT_" not found>")) Q
 . D M(("      "_LEXRT_LEXB1_LEXT_LEXB2_LEXF)) S @LEXGBL=$G(@LEXGBL) H 1
 D:LEXOK M("    --> ok") D:'LEXOK M("    ??") D M(" ")
 Q
RGBL(X) ;   Check Write access on globals
 N LEXS,LEXI,LEXX,LEXEC,LEXGBL,LEXRT,LEXT,LEXF,LEXB1,LEXB2
 S LEXS="",X=1 F LEXI=1:1 D  Q:'$L(LEXX)
 . S LEXX="" S LEXEC="S LEXX=$T(GD+"_LEXI_")" X LEXEC S LEXX=$$TRIM(LEXX) Q:'$L(LEXX)  Q:'$L($TR(LEXX,";",""))
 . S LEXGBL=$P(LEXX,";",3) S LEXRT=$P(LEXX,";",4),LEXT=$P(LEXX,";",5),LEXF=$P(LEXX,";",6)
 . S (LEXB1,LEXB2)="",$P(LEXB1," ",(15-$L(LEXRT)))="",$P(LEXB2," ",(28-$L(LEXT)))=""
 . I '$D(@LEXGBL) S:LEXS'[LEXRT LEXS=LEXS_", "_LEXRT S X=-1
 I $L(LEXS),X'>0 D
 . S:LEXS[", " LEXS=$P(LEXS,", ",1,($L(LEXS,", ")-1))_" and "_$P(LEXS,", ",$L(LEXS,", "))
 . S:$E(LEXS,1,2)=", " LEXS=$E(LEXS,3,$L(LEXS)) S:$E(LEXS,1,7)[" and " LEXS=$P(LEXS," and ",2)
 . D:X=-1 ET(("Global"_$S(LEXS[", "!(LEXS[" and "):"s",1:"")_" "_LEXS_" either not found or incomplete."))
 Q X
RGNF ;   Required global not found
 N LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR D IMP
 D:$G(LEXGBL)["^LEX" ET(""),ET("Required global "_$P($G(LEXGBL),"(",1)_" not found.")
 Q
TASK ;   Check for Task
 D BM("   Checking to see if a previous post-installation is still running")
 N LEXLIST,LEXNAM,LEXRUN,LEXSTA1,LEXSTA2,LEXT1,LEXT2,LEXTSK,ZTSK
 S LEXNAM="Lexicon Rebuild AVA Cross-Reference" K LEXLIST D DESC^%ZTLOAD(LEXNAM,"LEXLIST")
 S LEXRUN=0,(LEXSTA1,LEXSTA2)="" S LEXTSK=0 F  S LEXTSK=$O(LEXLIST(LEXTSK)) Q:+LEXTSK'>0  D  Q:+LEXRUN>0
 . N ZTSK S ZTSK=LEXTSK Q:+($G(ZTSK))'>0  D STAT^%ZTLOAD Q:+($G(ZTSK(0)))'>0
 . I +($G(ZTSK(1)))=1 S LEXRUN=LEXTSK,LEXSTA1="is scheduled",LEXSTA2="Please wait until this task has started and completed"
 . I +($G(ZTSK(1)))=2 S LEXRUN=LEXTSK,LEXSTA1="is running",LEXSTA2="Please wait until this task has completed"
 I +LEXRUN>0 D
 . S:'$L(LEXSTA1) LEXSTA1="is running" S:'$L(LEXSTA2) LEXSTA2="Please wait until this task has completed"
 . N LEXT1,LEXT2 S LEXT1=" Task #"_LEXRUN_" "_$G(LEXSTA1)
 . S:$L($G(LEXNAM)) LEXT1=" Task #"_LEXRUN_" """_LEXNAM_""" "_$G(LEXSTA1)
 . S LEXT2=" "_LEXSTA2 D ET(LEXT1),ET(LEXT2)
 S LEXNAM="Lexicon Rebuild AWRD Cross-Reference" K LEXLIST D DESC^%ZTLOAD(LEXNAM,"LEXLIST")
 S LEXRUN=0,(LEXSTA1,LEXSTA2)="" S LEXTSK=0 F  S LEXTSK=$O(LEXLIST(LEXTSK)) Q:+LEXTSK'>0  D  Q:+LEXRUN>0
 . N ZTSK S ZTSK=LEXTSK Q:+($G(ZTSK))'>0  D STAT^%ZTLOAD Q:+($G(ZTSK(0)))'>0
 . I +($G(ZTSK(1)))=1 S LEXRUN=LEXTSK,LEXSTA1="is scheduled",LEXSTA2="Please wait until this task has started and completed"
 . I +($G(ZTSK(1)))=2 S LEXRUN=LEXTSK,LEXSTA1="is running",LEXSTA2="Please wait until this task has completed"
 I +LEXRUN>0 D
 . S:'$L(LEXSTA1) LEXSTA1="is running" S:'$L(LEXSTA2) LEXSTA2="Please wait until this task has completed"
 . N LEXT1,LEXT2 S LEXT1=" Task #"_LEXRUN_" "_$G(LEXSTA1)
 . S:$L($G(LEXNAM)) LEXT1=" Task #"_LEXRUN_" """_LEXNAM_""" "_$G(LEXSTA1)
 . S LEXT2=" "_LEXSTA2 D:$D(LEXE) ET(" ") D ET(LEXT1),ET(LEXT2)
 I '$D(LEXE) W " - OK"
 Q
INS(X) ;   Installed on
 N DA,LEXDA,LEXE,LEXI,LEXMSG,LEXNS,LEXOUT,LEXPI,LEXPN,LEXSCR,LEXVI,LEXVR S LEXNS=$P(X,"*",1),LEXVR=$P(X,"*",2),LEXPN=$P(X,"*",3)
 Q:'$L(LEXNS) ""  S LEXVR=+LEXVR Q:LEXVR'>0 ""  S LEXPN=+LEXPN Q:+LEXPN'>0 ""  S:LEXVR'["." LEXVR=LEXVR_".0"
 S LEXSCR="I $G(^DIC(9.4,+($G(Y)),""VERSION""))="""_LEXVR_""""
 D FIND^DIC(9.4,,.01,"O",LEXNS,10,"C",LEXSCR,,"LEXOUT","LEXMSG")
 S LEXPI=$G(LEXOUT("DILIST",2,1)) K LEXOUT,LEXMSG Q:+LEXPI'>0 ""  Q:'$D(@("^DIC(9.4,"_LEXPI_",22)")) ""
 K DA S DA(1)=LEXPI S LEXDA=$$IENS^DILF(.DA)
 D FIND^DIC(9.49,LEXDA,.01,"O",LEXVR,10,"B",,,"LEXOUT","LEXMSG")
 S LEXVI=$G(LEXOUT("DILIST",2,1)) K LEXOUT,LEXMSG Q:+LEXVI'>0 ""  Q:'$D(@("^DIC(9.4,"_LEXPI_",22,"_LEXVI_",""PAH"")")) ""
 K DA S DA(2)=LEXPI,DA(1)=LEXVI S LEXDA=$$IENS^DILF(.DA)
 S LEXSCR="I $G(^DIC(9.4,"_LEXPI_",22,"_LEXVI_",""PAH"",+($G(Y)),0))[""SEQ #"""
 D FIND^DIC(9.4901,LEXDA,".01;.02I",,LEXPN,10,"B",LEXSCR,,"LEXOUT","LEXMSG")
 S LEXI=$G(LEXOUT("DILIST","ID",1,.02)) Q:'$L(LEXI) ""  Q:$P(LEXI,".",1)'?7N ""
 S LEXE=$TR($$FMTE^XLFDT(LEXI,"5DZ"),"@"," ") Q:'$L(LEXE) ""  S X=LEXI_"^"_LEXE
 Q X
SY(X) ;   Check System variables
 Q:'$D(IO)!('$D(IOF))!('$D(IOM))!('$D(ION))!('$D(IOSL))!('$D(IOST)) 0
 Q 1
UR(X) ;   Check User variables
 Q:'$L($G(DUZ(0))) 0
 Q:+($G(DUZ))=0!($$NOTDEF(+$G(DUZ))) 0
 Q 1
 ;               
ET(X) ;   Error Text
 N LEXI S LEXI=+($G(LEXE(0))),LEXI=LEXI+1,LEXE(LEXI)="    "_$G(X),LEXE(0)=LEXI
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
 D IMP S LEXT="  Environment "_$S($L(LEXBUILD):("for Emergency patch "_LEXBUILD_" "),1:"")_"is ok"
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
 ;     Patch Type
 S LEXPTYPE="Code Set Update"
 S LEXPTYPE="Emergency Patch (fix Lexicon Cross-References)"
 ;     Revision
 S LEXLREV=81
 ;     Required Builds build^released;build^released;build^released
 S LEXREQP="LEX*2.0*73^3110628"
 ;     This Build Name
 S LEXBUILD="LEX*2.0*81"
 ;     This Build's Export Global Host Filename
 S LEXIGHF=""
 ;     Fiscal Year
 S LEXFY=""
 ;     Quarter
 S LEXQTR=""
 Q
EF ;   Exported Files
 ;;^LEX(757.01);^LEX(*;Lexicon;757-757.41
 ;;^LEXT(757.2);^LEXT(757.2);Lexicon Subsets/Defaults;757.2
 ;;
 ;;^ICPT(0);^ICPT(;CPT/HCPCS;81
 ;;^DIC(81.1,0);^DIC(81.1);CPT Category;81.1
 ;;^DIC(81.2,0);^DIC(81.2);CPT Copyright;81.2
 ;;^DIC(81.3,0);^DIC(81.3);CPT Modifier;81.3
 ;;
 ;;^ICD9(0);^ICD9(;ICD Diagnosis;80
 ;;^ICD0(0);^ICD0(;ICD Operation/Procedure;80.1
 ;;^ICD(0);^ICD(;DRG Grouper;80.2
 ;;^ICM(0);^ICM(;MAJOR DIAGNOSTIC CATEGORY;80.3
 ;;^ICPT(0);^ICPT(;CPT/HCPCS;81
 ;;^DIC(81.1,0);^DIC(81.1);CPT Category;81.1
 Q
GD ;   Global Data
 ;;^LEX(757.01);^LEX(*;Lexicon;757-757.41
