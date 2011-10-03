LEX2028P        ; ISL/KER - Pre/Post Install; 01/01/2004
 ;;2.0;LEXICON UTILITY;**28**;Sep 23, 1996
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
POST ; LEX*2.0*28 Post-Install
 N LEXEDT S LEXEDT=$G(^LEXM(0,"CREATED")) D LOAD,MSG,KLEXM
 Q
LOAD ;   Load data
 N LEXB,LEXBUILD,LEXCD,LEXIGHF,LEXLAST,LEXLREV D IMP^LEX2028
 S U="^",LEXB=$G(^LEXM(0,"BUILD")) Q:LEXB=""  Q:$G(LEXBUILD)=""
 S LEXCD=0 S LEXCD=+($$CPD^LEX2028)
 I LEXCD,LEXB=LEXBUILD D  G RV
 . S X="Data for patch "_LEXBUILD_" has already been installed"
 . W:'$D(XPDNM) !!,X D:$D(XPDNM) BMES^XPDUTL(X)
 . S X="" W:'$D(XPDNM) ! D:$D(XPDNM) MES^XPDUTL(X)
 I 'LEXCD,LEXB=LEXBUILD D EN^LEXXGI
RV ;   Revision Numbers
 N LEXRV F LEXRV=757,757.001,757.01,757.02,757.1,757.9,757.901,757.902,757.903,757.91 D
 . Q:'$D(^LEXM(LEXRV,0))
 . Q:'$D(^LEX(LEXRV,0))&('$D(^LEXT(LEXRV,0)))&('$D(^LEXC(LEXRV,0)))
 . Q:'$L($$GET1^DID(+LEXRV,.01,,"LABEL"))
 . D PRD^DILFD(LEXRV,"28^3040101")
 F LEXRV=81,81.3 D
 . Q:'$D(^LEXM(LEXRV,0))  Q:'$D(^DD(LEXRV,0))  Q:'$L($$GET1^DID(+LEXRV,.01,,"LABEL"))
 . D PRD^DILFD(LEXRV,"17^3040101")
LOADQ ;   Quit Load
 D KLEXM
 Q
MSG ;   Send Installation Message
 Q:+($G(DUZ))=0!($$NOTDEF^LEX2028($G(DUZ)))
 D HOME^%ZIS N DIFROM,LEXLREV,LEXLAST,LEXBUILD,LEXIGHF,LEXSHORT
 S LEXSHORT="" D IMP^LEX2028,SEND^LEXXST Q
 ;                       
PRE ; LEX*2.0*28 Pre-Install
 D KDD,KCH Q
KDD ;   Kill previous copies of DDs - (N/A for patch 28)
 Q
KCH ;   Kill previous changes - (N/A for patch 28)
 Q
 ;                   
KLEXM ; Subscripted Kill of ^LEXM
 N DA S DA=0 F  S DA=$O(^LEXM(DA)) Q:+DA=0  K ^LEXM(DA)
 K ^LEXM(0)
 Q
CON ; Conversion of data (N/A for patch 28)
 Q
