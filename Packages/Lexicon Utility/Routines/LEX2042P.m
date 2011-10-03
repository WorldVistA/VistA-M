LEX2042P ; ISL/KER - Pre/Post Install ; 07/01/2006
 ;;2.0;LEXICON UTILITY;**42**;Sep 23, 1996
 ;
 ; External References
 ;   DBIA 10086  HOME^%ZIS
 ;   DBIA  2052  $$GET1^DID
 ;   DBIA  2055  PRD^DILFD
 ;   DBIA 10014  EN^DIU2
 ;   DBIA 10141  BMES^XPDUTL
 ;   DBIA 10141  MES^XPDUTL
 ;                      
 Q
 ;                      
POST ; LEX*2.0*42 Post-Install
 N LEXEDT,LEXCHG,LEXSCHG,LEXMUMPS S LEXEDT=$G(^LEXM(0,"CREATED"))
 S LEXCHG=0 S:$D(^LEXM(80))!($D(^LEXM(80.1)))!($D(^LEXM(81)))!($D(^LEXM(81.2)))!($D(^LEXM(81.3))) LEXCHG=1
 ;
 ;-----------------------------
 ;   Save Changes
 D SCHG
 ;
 ;-----------------------------
 ;   Load Data into Files
 D LOAD
 ;
 ;-----------------------------
 ;   Data Conversion
 D CON
 ;
 ;-----------------------------
 ;   Re-Index Files - N/A for LEX*2.0*42
 ;   Do not use for Annual/Quarterly Updates, it disrupts the Protocol
 ;   D RX
 ;
 ;-----------------------------
 ;   Fire Protocol 
 D NOTIFY^LEXXGI
 ;
 ;-----------------------------
 ;   Send a Install Message
 D MSG
 ;
 ;-----------------------------
 ;   Clean up and Quit
 D KLEXM
 Q
 ;                      
LOAD ; Load Data from ^LEXM into IC*/LEX Files
 N LEXB,LEXBUILD,LEXCD,LEXIGHF,LEXLAST,LEXLREV D IMP^LEX2042
 S U="^",LEXB=$G(^LEXM(0,"BUILD")) Q:LEXB=""  Q:LEXBUILD=""
 S LEXCD=0 S LEXCD=+($$CPD^LEX2042)
 I LEXCD,LEXB=LEXBUILD D  G LQ
 . S X="Data for patch "_LEXBUILD_" has already been installed"
 . W:'$D(XPDNM) !!,X D:$D(XPDNM) BMES^XPDUTL(X)
 . S X="" W:'$D(XPDNM) ! D:$D(XPDNM) MES^XPDUTL(X)
 D:'LEXCD&(LEXB=LEXBUILD) EN^LEXXGI
LQ ; Load Quit
 D KLEXM
 Q
 ;
MSG ; Send Installation Message to G.LEXICON
 Q:+($G(DUZ))=0!($$NOTDEF^LEX2042($G(DUZ)))
 D HOME^%ZIS N DIFROM,LEXLREV,LEXLAST,LEXBUILD,LEXIGHF
 D IMP^LEX2042,POST^LEXXFI Q
 ;
SCHG ; Save Change File Changes
 N LEXI,LEXFI,LEXFIL,LEXRT S LEXFI=0 F  S LEXFI=$O(^LEXM(LEXFI)) Q:+LEXFI=0  D
 . S LEXI=0 F  S LEXI=$O(^LEXM(LEXFI,LEXI)) Q:+LEXI=0  D
 . . N LEXCF,LEXIEN,LEXMUMPS S LEXMUMPS=$G(^LEXM(LEXFI,LEXI)),LEXRT=$P(LEXMUMPS,"^",2)
 . . S:LEXMUMPS["^LEX("!(LEXMUMPS["^LEXT(") LEXFIL=+($P(LEXRT,"(",2))
 . . S:LEXMUMPS["^ICD9(" LEXFIL=80 S:LEXMUMPS["^ICD0(" LEXFIL=80.1 S:LEXMUMPS["^ICPT(" LEXFIL=81
 . . S:LEXMUMPS["^DIC(81.3" LEXFIL=81.3 S:+LEXFIL>0 LEXSCHG(+LEXFIL,0)=""
 Q
 ;
KLEXM ; Subscripted Kill of ^LEXM
 N DA S DA=0 F  S DA=$O(^LEXM(DA)) Q:+DA=0  K ^LEXM(DA)
 K ^LEXM(0)
 Q
 ;
PRE ; LEX*2.0*42 Pre-Install   (N/A for patch 42)
 Q
 ;
RX ; Reindex files            (N/A for patch 42)
 Q
 N LEX,DA,DIK,TH,TM,TD
 D BMES^XPDUTL(" Re-indexing NEW Versioned Text Cross-References")
 ;
 D BMES^XPDUTL("   ICD-9 Diagnosis file                 #80") W !,"   "
 S (LEX,DA)=0 F  S DA=$O(^ICD9(DA)) Q:+DA=0  K ^ICD9(DA,66,"B"),^ICD9(DA,67,"B"),^ICD9(DA,68,"B") S LEX=+($G(LEX))+1 W:LEX#120=0 "."
 K ^ICD9("AB"),^ICD9("ACC"),^ICD9("ACT"),^ICD9("BA"),^ICD9("D"),^ICD9("AST"),^ICD9("ADS") S DIK="^ICD9(" D IXALL^DIK
 ;
 D MES^XPDUTL("   ICD-9 Operations/Procedure file      #80.1") W !,"   "
 S (LEX,DA)=0 F  S DA=$O(^ICD0(DA)) Q:+DA=0  K ^ICD0(DA,66,"B"),^ICD0(DA,67,"B"),^ICD0(DA,68,"B") S LEX=+($G(LEX))+1 W:LEX#120=0 "."
 K ^ICD0("AB"),^ICD0("ACT"),^ICD0("ADS"),^ICD0("AST"),^ICD0("BA"),^ICD0("D"),^ICD0("E") S DIK="^ICD0(" D IXALL^DIK
 ;
 D MES^XPDUTL("   DRG file                             #80.2") W !,"   "
 S (LEX,DA)=0 F  S DA=$O(^ICD(DA)) Q:+DA=0  K ^ICD(DA,1,"B"),^ICD(DA,66,"B"),^ICD(DA,68,"B") S LEX=+($G(LEX))+1 W:LEX#120=0 "."
 K ^ICD("ADS"),^ICD("B") S DIK="^ICD(" D IXALL^DIK
 ;
 D MES^XPDUTL("   CPT/HCPCS Procedure/Services file    #81") W !,"   "
 S (LEX,DA)=0 F  S DA=$O(^ICPT(DA)) Q:+DA=0  D
 . K ^ICPT(DA,60,"B"),^ICPT(DA,61,"B"),^ICPT(DA,62,"B"),^ICPT(DA,"D","B") S LEX=+($G(LEX))+1 W:LEX#120=0 "."
 K ^ICPT("ACT"),^ICPT("ADS"),^ICPT("AST"),^ICPT("B"),^ICPT("BA"),^ICPT("C"),^ICPT("D"),^ICPT("E"),^ICPT("F") S DIK="^ICPT(" D IXALL^DIK
 ;
 D MES^XPDUTL("   CPT Modifier file                    #81.3") W !,"   "
 S (LEX,DA)=0 F  S DA=$O(^DIC(81.3,DA)) Q:+DA=0  D
 . K ^DIC(81.3,DA,60,"B"),^DIC(81.3,DA,61,"B"),^DIC(81.3,DA,62,"B") S LEX=+($G(LEX))+1 W:LEX#120=0 "."
 K ^DIC(81.3,"ACT"),^DIC(81.3,"ADS"),^DIC(81.3,"AST"),^DIC(81.3,"B"),^DIC(81.3,"BA"),^DIC(81.3,"C"),^DIC(81.3,"D"),^DIC(81.3,"M") S DIK="^DIC(81.3," D IXALL^DIK
 Q
 ;
CON ; Conversion of data       (N/A for patch 42)
 Q
