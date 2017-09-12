LEX2013P ; ISA/FJF-LEX*2.0*13 Pre/Post Install             ; 02/17/1999
 ;;2.0;Lexicon Utility;**13**;Feb 17, 1999
 ;
 Q
 ;                      
POST ; LEX*2.0*13 Post-Install
 D LOAD,MSG
 Q
LOAD ;   Load data
 N LEXB,LEXBUILD,LEXCD,LEXIGHF,LEXLAST,LEXLREV D IMP^LEX2013
 S U="^",LEXB=$G(^LEXM(0,"BUILD")) Q:LEXB=""  Q:LEXBUILD=""
 S LEXCD=0 S LEXCD=+($$CPD^LEX2013)
 I LEXCD,LEXB=LEXBUILD D  Q
 . S X="Data for patch "_LEXBUILD_" has already been installed"
 . W:'$D(XPDNM) !!,X D:$D(XPDNM) BMES^XPDUTL(X)
 . S X="" W:'$D(XPDNM) ! D:$D(XPDNM) MES^XPDUTL(X)
 I 'LEXCD,LEXB=LEXBUILD D EN^LEXXGI
 Q
MSG ;   Send Installation Message
 Q:+($G(DUZ))=0!($$NOTDEF^LEX2013($G(DUZ)))
 D HOME^%ZIS N DIFROM,LEXLREV,LEXLAST,LEXBUILD,LEXIGHF
 D IMP^LEX2013,SEND^LEXXST Q
 ;                       
CON ; Conversion of data (N/A for patch 13)
 Q
