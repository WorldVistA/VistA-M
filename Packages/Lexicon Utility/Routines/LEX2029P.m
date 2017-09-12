LEX2029P        ; ISL/KER - Pre/Post Install; 04/07/2004
 ;;2.0;LEXICON UTILITY;**29**;Sep 23, 1996
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
POST ; LEX*2.0*29 Post-Install
 N LEXEDT,LEXCHG,LEXSCHG S LEXEDT=$G(^LEXM(0,"CREATED"))
 S LEXCHG=0 S:$D(^LEXM(80))!($D(^LEXM(80.1)))!($D(^LEXM(81)))!($D(^LEXM(81.2)))!($D(^LEXM(81.3))) LEXCHG=1
 ;   Save Changes
 D SCHG
 ;   Load Data into Files
 D LOAD
 ;   Re-Index Files
 D RX
 ;   Notify Applications that a Change has occurred
 D NOTIFY^LEXXGI
 ;   Send a Install Message
 D MSG
 ;   Clean up and Quit
 D KLEXM
 Q
 ;                     
LOAD ; Load Data from ^LEXM into IC*/LEX Files
 N LEXB,LEXBUILD,LEXCD,LEXIGHF,LEXREQP,LEXLREV D IMP^LEX2029
 S U="^",LEXB=$G(^LEXM(0,"BUILD")) Q:LEXB=""  Q:$G(LEXBUILD)=""
 S LEXCD=0 S LEXCD=+($$CPD^LEX2029)
 I LEXCD,LEXB=LEXBUILD D  G LOADQ
 . S X="Data for patch "_LEXBUILD_" has already been installed"
 . W:'$D(XPDNM) !!,X D:$D(XPDNM) BMES^XPDUTL(X)
 . S X="" W:'$D(XPDNM) ! D:$D(XPDNM) MES^XPDUTL(X)
 D:'LEXCD&(LEXB=LEXBUILD) EN^LEXXGI D KLEXM
LOADQ ; Quit Load
 D KLEXM
 Q
 ;
MSG ; Send Installation Message to G.LEXICON
 Q:+($G(DUZ))=0!($$NOTDEF^LEX2029($G(DUZ)))
 D HOME^%ZIS N DIFROM,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXSHORT
 S LEXSHORT="" D IMP^LEX2029,SEND^LEXXST
 Q
 ;
SCHG ; Save Change File Changes
 N LEXI,LEXFI,LEXFIL S LEXFI=0 F  S LEXFI=$O(^LEXM(LEXFI)) Q:+LEXFI=0  D
 . S LEXI=0 F  S LEXI=$O(^LEXM(LEXFI,LEXI)) Q:+LEXI=0  D
 . . N LEXCF,LEXIEN S LEXMUMPS=$G(^LEXM(LEXFI,LEXI)),LEXRT=$P(LEXMUMPS,"^",2)
 . . S:LEXMUMPS["^LEX("!(LEXMUMPS["^LEXT(")!(LEXMUMPS["^LEXC(") LEXFIL=+($P(LEXRT,"(",2))
 . . S:LEXMUMPS["^ICD9(" LEXFIL=80 S:LEXMUMPS["^ICD0(" LEXFIL=80.1 S:LEXMUMPS["^ICPT(" LEXFIL=81 S:LEXMUMPS["^DIC(81.3" LEXFIL=81.3
 . . S:+LEXFIL>0 LEXSCHG(+LEXFIL,0)="" S LEXCF=+($P(LEXMUMPS,"LEXC(757.9,""AFIL"",",2))
 . . S:$P(LEXCF,".",1)'="757"&("^80^80.1^81^81.3^"'[("^"_LEXCF_"^")) LEXCF=""
 . . S LEXIEN=+($P(LEXMUMPS,("LEXC(757.9,""AFIL"","_+LEXCF_","),2))
 . . I +LEXIEN>0&(+LEXCF)>0&("^80^80.1^81^81.2^81.3)"[LEXCF)&(+LEXFIL=757.9)&(LEXMUMPS["LEXC(757.9") D
 . . . S LEXSCHG(+LEXFIL,LEXIEN)=LEXCF,LEXSCHG(757.9,"B",+LEXCF,LEXIEN)=""
 . . S:$L(LEXMUMPS)&($L(LEXCF)) LEXCHGS(LEXCF)=""
 Q
 ;
KLEXM ; Subscripted Kill of ^LEXM
 N DA S DA=0 F  S DA=$O(^LEXM(DA)) Q:+DA=0  K ^LEXM(DA),^LEXM(0)
 Q
 ;
PRE ; LEX*2.0*29 Pre-Install   (N/A for patch 29)
 Q
 ;
RX ; Re-Index Files           (N/A for patch 29)
 Q
 ;
CON ; Conversion of Data       (N/A for patch 29)
 Q
