LEX2110P ;ISL/KER - LEX*2.0*110 Post Install ;09/06/2016
 ;;2.0;LEXICON UTILITY;**110**;Sep 23, 1996;Build 6
 ;               
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    None
 ;             
 Q
POST ; Post-Install
 N LEXBUILD,LEXFY,LEXIGHF,LEXLREV,LEXMSG,LEXPTYPE,LEXQTR
 N LEXREQP,LEXSHORT,LEXSUBH S LEXPTYPE="Code Set/API Fixes"
 S LEXLREV=110,LEXBUILD="LEX*2.0*110",LEXIGHF="",LEXFY=""
 S LEXQTR="",LEXSHORT="",LEXMSG="",LEXSUBH="Lexicon Fixes"
 D POST^LEXXFI
 Q
