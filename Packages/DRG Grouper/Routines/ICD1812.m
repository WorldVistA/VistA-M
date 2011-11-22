ICD1812 ;SLC/KER - ICD Environment Check       ; 04/18/2004
 ;;18.0;DRG Grouper;**12**;Oct 20, 2000
 ;
 ; External References
 ;   DBIA  10141  $$PATCH^XPDUTL
 ;   DBIA  10141  BMES^XPDUTL   
 ;   DBIA  10141  MES^XPDUTL
 ;                           
ENV ; Environment Check
 N PATCHES,PATCH,BUILD,ABORT,I
 W !," ICD GROUPER Code Text Descriptors (CTD)",! S XPDABORT="",BUILD="ICD*18.0*12" S ABORT=0
 S ABORT=$$PATCHES S:+ABORT'>0 ABORT=$$DATA(BUILD) S:+ABORT'>0 ABORT=$$VAR D:+ABORT>0 ABRT
 I $G(XPDABORT)="" K XPDABORT D OK
 Q
ABRT ;   Abort - All or nothing
 S XPDABORT=1,XPDQUIT=1,XPDQUIT("LEX*2.0*30")=1
 S XPDQUIT("ICD*18.0*12")=1,XPDQUIT("ICPT*6.0*19")=1
 S XPDQUIT("CTD UTIL 1.0")=1
 Q
OK ;   Environment is Ok
 Q:+($G(XPDENV))>0  D BM(("  Environment for patch/build "_BUILD_" is ok")),M(" ")
 Q
 ;                     
 ; Checks
PATCHES(X)      ;   Check Required Patches/Components
 Q:+($G(ABORT))>0 1  N PATCHES,I,INS
 S PATCHES="ICD*18.0*7;ICD*18.0*11"
 F I=1:1 Q:'$L($P($G(PATCHES),";",I))  S PATCH=$P($G(PATCHES),";",I) D  Q:+($G(ABORT))>0
 . W !,"   Checking for ",PATCH S INS=$$PATCH^XPDUTL(PATCH) I +INS>0 H 1 W " - installed"
 . I 'INS D BM(("   >>> "_PATCH_" is required and MUST be installed prior to this patch.")) W ! S ABORT=1
 Q:+($G(ABORT))>0 1  Q 0
 ;
DATA(X) ;   Check Required Data
 Q:+($G(ABORT))>0 1  Q:+($G(XPDENV))=0 0  N BUILD,BUILDI,CPD S BUILDI=$G(^LEXM(80,0,"BUILD")),BUILD=$G(X),CPD=$$CPD
 W !,"   Checking for ICD installed data" H:+CPD>0 1 W:+CPD>0 " - Installed"
 I +CPD'>0 D
 . I $L(BUILD),BUILD=BUILDI H 1 W " - Ready for installation"
 . I $L(BUILD),BUILD'=BUILDI D 
 . . I '$L(BUILDI) D
 . . . D BM("   >>> Global ^LEXM either not found or incomplete.")
 . . . D M(("       Expecting data for "_BUILD_"."))
 . . I $L(BUILDI) D
 . . . D BM("   >>> Global ^LEXM incorrect for this installation.")
 . . . D M(("       Expecting data for "_BUILD_", found "_BUILDI_"."))
 . . W ! S ABORT=1
 . I '$L(BUILD) H 1 W " - Data not required"
 Q:+($G(ABORT))>0 1  Q 0
 ;
VAR(X) ;   Check Variables
 W !,"   Checking required environment variables"
 D HOME^%ZIS S U="^",DT=$$DT^XLFDT Q:+($G(ABORT))>0 1
 I (+($G(DUZ))>0)&($G(DUZ(0))="@") H 1 W " - ok"
 I '$G(DUZ)!($G(DUZ(0))'="@") D
 . D BM("   >>> Programming variables are not set up properly.") W ! S ABORT=1
 Q:+($G(ABORT))>0 1  Q 0
 ;
CPD(X) ;   Check Current Patched Data is installed
 N INS S INS=1
 S:'$D(^ICD9("AST"))!('$D(^ICD9("ADS")))!('$D(^ICD0("AST")))!('$D(^ICD0("ADS")))!('$D(^ICD("ADS"))) INS=0
 S:'$D(^ICD9(1,67,"B"))!('$D(^ICD9(1,68,"B"))) INS=0 S:'$D(^ICD0(1,67,"B"))!('$D(^ICD0(1,68,"B"))) INS=0
 S:'$D(^ICD(1,68,"B")) INS=0 S X=INS
 Q X
 ;                     
 ; Miscellaneous
BM(X) ;   Blank Line with Message
 D BMES^XPDUTL($G(X)) Q
M(X) ;   Message
 D MES^XPDUTL($G(X)) Q
