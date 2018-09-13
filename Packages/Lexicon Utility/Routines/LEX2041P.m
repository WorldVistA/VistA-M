LEX2041P ; ISL/FJF - Pre/Post Install ; 09/09/2006
 ;;2.0;LEXICON UTILITY;**41**;Sep 23, 1996;Build 34
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
POST ; LEX*2.0*41 Post-Install
 N LEXEDT,LEXMUMPS
 S LEXEDT=$G(^LEXM(0,"CREATED"))
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
 ;   Re-Index Files - N/A for LEX*2.0*41
 ;   
 ;
 ;-----------------------------
 ;   Send a Install Message
 D MSG
 ;
 Q
 ;-----------------------------
 ;
LOAD ; Load Data from ^LEXM into LEX Files
 N LEXB,LEXBUILD,LEXCD,LEXIGHF,LEXLAST,LEXLREV,LEXSHORT,LEXMSG
 D IMP^LEX2041
 S U="^",LEXB=$G(^LEXM(0,"BUILD"))
 Q:LEXB=""  Q:LEXBUILD=""
 S LEXCD=+$$CPD^LEX2041
 I LEXCD,LEXB=LEXBUILD D  D KLEXM Q
 .S X="Data for patch "_LEXBUILD_" has already been installed"
 .W:'$D(XPDNM) !!,X
 .D:$D(XPDNM) BMES^XPDUTL(X)
 .S X=""
 .W:'$D(XPDNM) !
 .D:$D(XPDNM) MES^XPDUTL(X)
 I 'LEXCD,LEXB=LEXBUILD D
 .S LEXSHORT=1,LEXMSG=1
 .D TASK^LEXXGI
 Q
 ;
MSG ; Send Installation Message to G.LEXICON
 Q:+($G(DUZ))=0!($$NOTDEF^LEX2041($G(DUZ)))
 D HOME^%ZIS
 N DIFROM,LEXLREV,LEXLAST,LEXBUILD,LEXIGHF,LEXSHORT
 S LEXSHORT=1
 D IMP^LEX2041 ;,POST^LEXXFI
 Q
 ;
SCHG ; Save Change File Changes
 N LEXI,LEXFI,LEXFIL,LEXRT
 S LEXFI=0 F  S LEXFI=$O(^LEXM(LEXFI)) Q:+LEXFI=0  D
 .S LEXI=0 F  S LEXI=$O(^LEXM(LEXFI,LEXI)) Q:+LEXI=0  D
 ..N LEXCF,LEXIEN,LEXMUMPS
 ..S LEXMUMPS=$G(^LEXM(LEXFI,LEXI)),LEXRT=$P(LEXMUMPS,"^",2)
 ..S:LEXMUMPS["^LEX("!(LEXMUMPS["^LEXT(") LEXFIL=+($P(LEXRT,"(",2))
 Q
 ;
KLEXM ; Subscripted Kill of ^LEXM
 N DA S DA=0 F  S DA=$O(^LEXM(DA)) Q:+DA=0  K ^LEXM(DA)
 K ^LEXM(0)
 Q
PRE ; LEX*2.0*41 Pre-Install   (N/A for patch 41)
 Q
 ;
CON ; Conversion of data       (N/A for patch 41)
 Q
