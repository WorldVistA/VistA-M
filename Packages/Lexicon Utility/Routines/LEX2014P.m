LEX2014P ; ISA/JPK - Pre/Post Install ; 07/28/1999
 ;;2.0;Lexicon Utility;**14**;Sep 23, 1996
 ;
 Q
 ;                      
POST ; LEX*2.0*14 Post-Install
 D LOAD,MSG
 Q
LOAD ;   Load data
 N LEXB,LEXBUILD,LEXCD,LEXIGHF,LEXLAST,LEXLREV D IMP^LEX2014
 S U="^",LEXB=$G(^LEXM(0,"BUILD")) Q:LEXB=""  Q:LEXBUILD=""
 S LEXCD=0 S LEXCD=+($$CPD^LEX2014)
 I LEXCD,LEXB=LEXBUILD D  Q
 . S X="Data for patch "_LEXBUILD_" has already been installed"
 . W:'$D(XPDNM) !!,X D:$D(XPDNM) BMES^XPDUTL(X)
 . S X="" W:'$D(XPDNM) ! D:$D(XPDNM) MES^XPDUTL(X)
 I 'LEXCD,LEXB=LEXBUILD D EN^LEXXGI
 N LEXRV
 F LEXRV=757,757.001,757.01,757.02,757.1,757.11,757.21 D
 .D PRD^DILFD(LEXRV,"9^2990811")
 Q
MSG ;   Send Installation Message
 Q:+($G(DUZ))=0!($$NOTDEF^LEX2014($G(DUZ)))
 D HOME^%ZIS N DIFROM,LEXLREV,LEXLAST,LEXBUILD,LEXIGHF
 D IMP^LEX2014,SEND^LEXXST Q
 ;                       
CON ; Conversion of data (N/A for patch 14)
 Q
