LEX2059P ;ISL/KER - LEX*2.0*59 Pre/Post Install ;07/16/2008
 ;;2.0;LEXICON UTILITY;**59**;Sep 23, 1996;Build 6
 ;              
 ; Variables NEWed or KILLed Elsewhere
 ;    None
 ;              
 ; Global Variables
 ;    ^LEXM
 ;              
 ; External References
 ;    None
 ;              
 Q
POST ; LEX*2.0*59 Post-Install
 ;            
 ; From IMP^LEX2059
 ;            
 ;      LEXBUILD   Build Name - LEX*2.0*nn
 ;      LEXPTYPE   Patch Type - Remedy or Quarterly
 ;      LEXFY      Fiscal Year - FYnn
 ;      LEXQTR     Quarter - 1st, 2nd, 3rd, or 4th
 ;      LEXIGHF    Name of Host File - LEX_2_nn.GBL
 ;      LEXLREV    Revision - nn
 ;      LEXREQP    Required Builds - build;build;build
 ;            
 N LEXEDT,LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXB,LEXCD,LEXSTR,LEXLAST D IMP^LEX2059
 S LEXEDT=$G(^LEXM(0,"CREATED")) D LOAD
 Q
LOAD ; Load Data
 ;             
 ;      LEXSHORT   Send Short Message
 ;      LEXMSG     Flag to send Message
 ;            
 N LEXSHORT,LEXMSG S LEXSHORT="",LEXMSG=""
 S LEXSTR=$G(LEXPTYPE) S:$L($G(LEXFY))&($L($G(LEXQTR))) LEXSTR=LEXSTR_" for "_$G(LEXFY)_" "_$G(LEXQTR)_" Quarter"
 S U="^",LEXB=$G(^LEXM(0,"BUILD")) Q:LEXB=""  Q:LEXBUILD=""
 D:LEXB=LEXBUILD EN^LEXXGI
LQ ; Load Quit
 D KLEXM
 Q
 ;             
KLEXM ; Subscripted Kill of ^LEXM
 H 2 N DA S DA=0 F  S DA=$O(^LEXM(DA)) Q:+DA=0  K ^LEXM(DA)
 N LEX S LEX=$G(^LEXM(0,"PRO")) K ^LEXM(0)
 Q
 ;            
PRE ; LEX*2.0*59 Pre-Install   (N/A for patch 59)
 Q
 ;            
CON ; Conversion of data       (N/A for patch 59)
 Q
