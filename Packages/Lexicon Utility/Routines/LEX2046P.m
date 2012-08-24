LEX2046P ; CIO ISL - LEX*2.0*46 Pre/Post Install           ; 01/01/2007
 ;;2.0;LEXICON UTILITY;**46**;Sep 23, 1996
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
POST ; LEX*2.0*46 Post-Install
 N LEXEDT,LEXCHG,LEXSCHG,LEXMUMPS,LEXSHORT S LEXEDT=$G(^LEXM(0,"CREATED")),LEXSHORT=""
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
 ;   Re-Index Files - N/A for LEX*2.0*46
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
 N LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXB,LEXCD,LEXSTR,LEXLAST D IMP^LEX2046
 S LEXSTR=$G(LEXPTYPE) S:$L($G(LEXFY))&($L($G(LEXQTR))) LEXSTR=LEXSTR_" for "_$G(LEXFY)_" "_$G(LEXQTR)_" Quarter"
 S U="^",LEXB=$G(^LEXM(0,"BUILD")) Q:LEXB=""  Q:LEXBUILD=""
 S LEXCD=0 S LEXCD=+($$CPD^LEX2046)
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
 Q:+($G(DUZ))=0!($$NOTDEF^LEX2046($G(DUZ)))
 D HOME^%ZIS N DIFROM,LEXPRO,LEXPRON,LEXLAST,LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXSHORT
 S LEXSHORT="" D IMP^LEX2046,POST^LEXXFI Q
 ;
SCHG ; Save Change File Changes
 N NN,NC,ND K LEXSCHG(0) S LEXCHG=0 S NN="^LEXM",NC="^LEXM(" F  S NN=$Q(@NN) Q:'$L(NN)!(NN'[NC)  D
 . S ND=$G(@NN) I NN["LEXM(80,"&(+($P(NN,",",2))>1)!(NN["LEXM(80.1,"&(+($P(NN,",",2))>1)) D
 . . S:ND["S ^ICD9("!(ND["K ^ICD9(") LEXSCHG(80,0)=+($G(^LEXM(80,0))),LEXSCHG("B",80)="",LEXSCHG("C","ICD",80)="",LEXSCHG("D","PRO")=""
 . . S:ND["S ^ICD0("!(ND["K ^ICD0(") LEXSCHG(80.1,0)=+($G(^LEXM(80.1,0))),LEXSCHG("B",80.1)="",LEXSCHG("C","ICD",80.1)="",LEXSCHG("D","PRO")=""
 . I NN["LEXM(81,"&(+($P(NN,",",2))>1)!(NN["LEXM(81.3,"&(+($P(NN,",",2))>1)) D
 . . S:ND["S ^ICPT("!(ND["K ^ICPT(") LEXSCHG(81,0)=+($G(^LEXM(81,0))),LEXSCHG("B",81)="",LEXSCHG("C","CPT",81)="",LEXSCHG("D","PRO")=""
 . . S:ND["S ^DIC(81.3,"!(ND["K ^DIC(81.3,") LEXSCHG(81.3,0)=+($G(^LEXM(81.3,0))),LEXSCHG("B",81.3)="",LEXSCHG("C","CPT",81.3)="",LEXSCHG("D","PRO")=""
 . I NN["LEXM(81.2," D
 . . S:ND["S ^DIC(81.2,"!(ND["K ^DIC(81.2,") LEXSCHG(81.2,0)=+($G(^LEXM(81.2,0))),LEXSCHG("B",81.2)="",LEXSCHG("C","CPT",81.2)=""
 . I NN["LEXM(757,"&(+($P(NN,",",2))>1)!(NN["LEXM(757."&(+($P(NN,",",2))>1)) D
 . . N FI S FI=+($P(NN,"(",2))
 . . S:ND["S ^LEX("!(ND["K ^LEX(") LEXSCHG(FI,0)=+($G(^LEXM(+FI,0))),LEXSCHG("B",FI)="",LEXSCHG("C","LEX",FI)="",LEXSCHG("D","PRO")=""
 . . S:ND["S ^LEXT("!(ND["K ^LEXT(") LEXSCHG(FI,0)=+($G(^LEXM(+FI,0))),LEXSCHG("B",FI)="",LEXSCHG("C","LEX",FI)="",LEXSCHG("D","PRO")=""
 S:$D(^LEXM(80))!($D(^LEXM(80.1)))!($D(^LEXM(81)))!($D(^LEXM(81.2)))!($D(^LEXM(81.3)))!($D(LEXSCHG("D","PRO"))) LEXCHG=1,LEXSCHG(0)=1
 Q
 ;
KLEXM ; Subscripted Kill of ^LEXM
 N DA S DA=0 F  S DA=$O(^LEXM(DA)) Q:+DA=0  K ^LEXM(DA)
 N LEX S LEX=$G(^LEXM(0,"PRO")) K ^LEXM(0) S:$L(LEX) ^LEXM(0,"PRO")=LEX
 Q
 ;
PRE ; LEX*2.0*46 Pre-Install   (N/A for patch 46)
 Q
 ;
RX ; Reindex files            (N/A for patch 46)
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
CON ; Conversion of data       (N/A for patch 46)
 Q
