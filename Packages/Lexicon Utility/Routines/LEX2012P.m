LEX2012P ; ISA/CJE-LEX*2.0*12 Pre/Post Install             ; 11/10/1998
 ;;2.0;Lexicon Utility;**12**;Sept 23, 1996
 ;
 Q
 ;                      
POST ; LEX*2.0*12 Post-Install
 D LOAD,MSG
 Q
LOAD ;   Load data
 N LEXB,LEXBUILD,LEXCD,LEXIGHF,LEXLAST,LEXLREV D IMP^LEX2012
 S U="^",LEXB=$G(^LEXM(0,"BUILD")) Q:LEXB=""  Q:LEXBUILD=""
 S LEXCD=0 S LEXCD=+($$CPD^LEX2012)
 I LEXCD,LEXB=LEXBUILD D  Q
 . S X="Data for patch "_LEXBUILD_" has already been installed"
 . W:'$D(XPDNM) !!,X D:$D(XPDNM) BMES^XPDUTL(X)
 . S X="" W:'$D(XPDNM) ! D:$D(XPDNM) MES^XPDUTL(X)
 I 'LEXCD,LEXB=LEXBUILD D EN^LEXXGI
 Q
MSG ;   Send Installation Message
 Q:+($G(DUZ))=0!('$D(^VA(200,+($G(DUZ)),0)))
 D HOME^%ZIS N DIFROM,LEXLREV,LEXLAST,LEXBUILD,LEXIGHF
 D IMP^LEX2012,SEND^LEXXST Q
 ;                       
CON ; Conversion of data (N/A for patch 12)
 Q
