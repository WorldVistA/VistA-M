LEX2016P ;ISA/FJF-Pre/Post Install;02-28-00
 ;;2.0;LEXICON UTILITY;**16**;Sep 23, 1996
 ;
 Q
 ;                      
POST ; LEX*2.0*16 Post-Install
 D LOAD,MSG
 Q
LOAD ;   Load data
 N LEXB,LEXBUILD,LEXCD,LEXIGHF,LEXLAST,LEXLREV D IMP^LEX2016
 S U="^",LEXB=$G(^LEXM(0,"BUILD")) Q:LEXB=""  Q:LEXBUILD=""
 S LEXCD=0 S LEXCD=+($$CPD^LEX2016)
 I LEXCD,LEXB=LEXBUILD D  Q
 . S X="Data for patch "_LEXBUILD_" has already been installed"
 . W:'$D(XPDNM) !!,X D:$D(XPDNM) BMES^XPDUTL(X)
 . S X="" W:'$D(XPDNM) ! D:$D(XPDNM) MES^XPDUTL(X)
 I 'LEXCD,LEXB=LEXBUILD D EN^LEXXGI
 N LEXRV
 F LEXRV=757,757.001,757.01,757.02,757.1,757.11,757.21 D
 .D PRD^DILFD(LEXRV,"9^3000311")
 Q
MSG ;   Send Installation Message
 Q:+($G(DUZ))=0!($$NOTDEF^LEX2016($G(DUZ)))
 D HOME^%ZIS N DIFROM,LEXLREV,LEXLAST,LEXBUILD,LEXIGHF
 D IMP^LEX2016,SEND^LEXXST Q
 ;                       
CON ; Conversion of data (N/A for patch 16)
 Q