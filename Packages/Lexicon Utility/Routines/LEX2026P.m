LEX2026P        ; ISL/KER - Pre/Post Install; 10/15/2003
 ;;2.0;LEXICON UTILITY;**26**;Sep 23, 1996
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
POST ; LEX*2.0*26 Post-Install
 N LEXEDT S LEXEDT=$G(^LEXM(0,"CREATED")) D LOAD,MSG
 Q
LOAD ;   Load data
 N LEXB,LEXBUILD,LEXCD,LEXIGHF,LEXLAST,LEXLREV D IMP^LEX2026
 S U="^",LEXB=$G(^LEXM(0,"BUILD")) Q:LEXB=""  Q:LEXBUILD=""
 S LEXCD=0 S LEXCD=+($$CPD^LEX2026)
 I LEXCD,LEXB=LEXBUILD D  G RV
 . S X="Data for patch "_LEXBUILD_" has already been installed"
 . W:'$D(XPDNM) !!,X D:$D(XPDNM) BMES^XPDUTL(X)
 . S X="" W:'$D(XPDNM) ! D:$D(XPDNM) MES^XPDUTL(X)
 I 'LEXCD,LEXB=LEXBUILD D EN^LEXXGI
RV ;   Revision Numbers
 N LEXRV F LEXRV=757,757.001,757.01,757.02,757.1,757.9,757.901,757.902,757.903,757.91 D
 . Q:'$D(^LEX(LEXRV,0))&('$D(^LEXT(LEXRV,0)))&('$D(^LEXC(LEXRV,0)))
 . Q:'$L($$GET1^DID(+LEXRV,.01,,"LABEL"))
 . D PRD^DILFD(LEXRV,"26^3031001")
 F LEXRV=80,80.1 D
 . Q:'$D(^DD(LEXRV,0))  Q:'$L($$GET1^DID(+LEXRV,.01,,"LABEL"))
 . D PRD^DILFD(LEXRV,"8^3031001")
LOADQ ;   Quit Load
 D KLEXM
 Q
MSG ;   Send Installation Message
 Q:+($G(DUZ))=0!($$NOTDEF^LEX2026($G(DUZ)))
 D HOME^%ZIS N DIFROM,LEXLREV,LEXLAST,LEXBUILD,LEXIGHF
 D IMP^LEX2026,SEND^LEXXST Q
 ;                       
PRE ; LEX*2.0*26 Pre-Install
 D KDD,KCH Q
KDD ;   Kill previous copies of DDs - Only for Patch LEX*2.0*26
 N DIU S DIU=757.91 I $L($$GET1^DID(+DIU,.01,,"LABEL")) S DIU(0)="" D EN^DIU2
 Q
KCH ;   Kill previous changes - Only for Patch LEX*2.0*26
 N X,Y X ^%ZOSF("UCI") Q:$P(Y,",",1)="LEXCSV"
 N DA,DIK S DIK="^LEXC(757.903,",DA=0 F  S DA=$O(^LEXC(757.903,DA)) Q:+DA=0  D ^DIK
 K ^LEXC(757.903,"AB"),^LEXC(757.903,"ADF"),^LEXC(757.903,"AFD"),^LEXC(757.903,"B"),^LEXC(757.903,"C"),^LEXC(757.903,"SF")
 N DA,DIK S DIK="^LEXC(757.91,",DA=0 F  S DA=$O(^LEXC(757.91,DA)) Q:+DA=0  D ^DIK
 K ^LEXC(757.91,"ACHG"),^LEXC(757.91,"ACT"),^LEXC(757.91,"AIN"),^LEXC(757.91,"B"),^LEXC(757.91,"BA")
 N DA,DIK S DIK="^LEXC(757.9,",DA=0 F  S DA=$O(^LEXC(757.9,DA)) Q:+DA=0  D ^DIK
 K ^LEXC(757.9,"B"),^LEXC(757.9,"C"),^LEXC(757.9,"D")
 Q
 ;                   
KLEXM ; Subscripted Kill of ^LEXM
 N DA S DA=0 F  S DA=$O(^LEXM(DA)) Q:+DA=0  K ^LEXM(DA)
 K ^LEXM(0)
 Q
CON ; Conversion of data (N/A for patch 26)
 Q
