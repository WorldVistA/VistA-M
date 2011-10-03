LEX2050P ;ISL/KER - LEX*2.0*50 Pre/Post Install ;06/06/2007
 ;;2.0;LEXICON UTILITY;**50**;Sep 23, 1996
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
POST ; LEX*2.0*50 Post-Install
 ;            
 ; From IMP^LEX2050
 ;            
 ;      LEXBUILD   Build Name - LEX*2.0*nn
 ;      LEXPTYPE   Patch Type - Remedy or Quarterly
 ;      LEXFY      Fiscal Year - FYnn
 ;      LEXQTR     Quarter - 1st, 2nd, 3rd, or 4th
 ;      LEXIGHF    Name of Host File - LEX_2_nn.GBL
 ;      LEXLREV    Revision - nn
 ;      LEXREQP    Required Builds - build;build;build
 ;            
 N LEXEDT,LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXB,LEXCD,LEXSTR,LEXLAST D IMP^LEX2050
 S LEXEDT=$G(^LEXM(0,"CREATED")) D CON,LOAD
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
PRE ; LEX*2.0*50 Pre-Install   (N/A for patch 50)
 Q
 ;            
CON ; Conversion of data       (Remove existing KT/KU Modifiers)
 N DA,DIK S DIK="^DIC(81.3," S DA=0 F  S DA=$O(^DIC(81.3,"B","KT",DA)) Q:+DA'>0  D ^DIK
 S DA=0 F  S DA=$O(^DIC(81.3,"B","KU",DA)) Q:+DA'>0  D ^DIK
 K DA,DIK K ^DIC(81.3,-1)
 Q
