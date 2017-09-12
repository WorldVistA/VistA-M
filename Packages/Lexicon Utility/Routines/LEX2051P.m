LEX2051P ;ISL/FJF - Pre/Post Install ; 30 Aug 2011  11:25 PM
 ;;2.0;LEXICON UTILITY;**51**;Sep 23, 1996;Build 77
 ;
 ; External References
 ;   DBIA 10086  HOME^%ZIS
 ;   DBIA  2052  $$GET1^DID
 ;   DBIA  2055  PRD^DILFD
 ;   DBIA 10014  EN^DIU2
 ;   DBIA 10141  BMES^XPDUTL
 ;   DBIA 10141  MES^XPDUTL
 ;   DBIA 10013  ^DIK
 ;                      
 Q
 ;
POST ; LEX*2.0*51 Post-Install
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
 ;   Re-Index Files
 D IND
 ;
 ;-----------------------------
 ;   Send a Install Message
 D MSG
 ;
 Q
 ;-----------------------------
 ;
LOAD ; Load Data
 ;             
 ;      LEXSHORT   Send Short Message
 ;      LEXMSG     Flag to send Message
 ;            
 N LEXSHORT,LEXMSG,LEXB,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF
 S LEXSHORT="",LEXMSG=""
 D IMP^LEX2051
 S U="^",LEXB=$G(^LEXM(0,"BUILD")) Q:LEXB=""  Q:$G(LEXBUILD)=""
 D:LEXB=LEXBUILD EN^LEXXGI
LQ ; Load Quit
 D KLEXM
 Q
 ;
MSG ; Send Installation Message to G.LEXICON
 Q:+($G(DUZ))=0!($$NOTDEF^LEX2051($G(DUZ)))
 D HOME^%ZIS
 N DIFROM,LEXLREV,LEXLAST,LEXBUILD,LEXIGHF,LEXSHORT
 S LEXSHORT=1
 D IMP^LEX2051 ;,POST^LEXXFI
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
PRE ; LEX*2.0*51 Pre-Install
 ; Kill all indexes
 N DIK S DIK="^LEX(757.33," D IXALL2^DIK
 ; Delete the old DD
 N DIU S DIU="^LEX(757.33,",DIU(0)="T" D EN^DIU2
 Q
 ;
CON ; Conversion of data
 N LEXLOUD S LEXLOUD="" D:$L($T(AWRD^LEXXGI4)) AWRD^LEXXGI4
 Q
IND ; Rebuild indices
 ; Rebuild indices for 757.33
 N DIK
 D BMES^XPDUTL("Rebuilding indices")
 D BMES^XPDUTL("")
 S DIK="^LEX(757.33," D IXALL^DIK
 D BMES^XPDUTL("Index rebuild complete")
 Q
